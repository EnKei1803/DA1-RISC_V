module DATA_MEMORY (
    input clk,
    input [31:0] A,					// Address input
    input [31:0] WD,					// Data to write
	 input [31:0] IO_data,			// Data from external I/O
    input WE, 							// Write enable
	 input [3:0] SLType,				//	Store-Load Type
    output [31:0] RD, WD2			// Data read from memory
);

/*
	SLType| function
	------|-----------
	 0000 |	lb
	 0001 | 	lh
	 0010 | 	lw
	 0100 | 	lbu
	 0110 | 	lhu
	 1000 | 	sb
	 1001 | 	sh
	 1010 | 	sw

*/


// Internal wire 
logic [31:0]RD1, RD2, WD1;

assign WD2 = WD | IO_data;


// Memory Zone
MEMORY	MEM_Value	(
				.clk(clk), 
				.A(A), 
				.WD(RD2), 
				.WE(WE), 
				.RD(RD1)
);		

// Extend to 32bits
EXTEND_SL EXT	(
				.sel(SLType[2:0]),
				.Data_in(WD1),
				.Data_out(RD2)
);
assign RD = RD2 & {32{~SLType[3]}};		// if "store", RD = 0

// SLType[3] = 1 => Store
// SLType[3] = 0 => Load
MUX_2x1_32Bits	StoreOrLoad	(
				.s(SLType[3]),
				.I0(RD1),
				.I1(WD2),
				.Y(WD1)
);

	 
endmodule

//--------------------------Mem------------------------

module MEMORY (
    input clk,
    input [31:0] A,					// Address input
    input [31:0] WD,					// Data to write
    input WE,							// Write enable
    output [31:0] RD					// Data read from memory
);

	// 256 x 32-bit memory
	reg [31:0] mem [0:255] = '{default:8'h00};     

	 logic [7:0]B;
	 assign B = A[7:0] << 2;
	 //assign B = A[7:0];
	 
		// MEM
	always @(posedge clk) begin
		if (WE)
			mem[B[7:0]] <= WD;
			
		end
	
assign RD = mem[B[7:0]];  
	 
endmodule 

//-----------------------EXtend SL----------------------

module EXTEND_SL(
	input [2:0]		sel,
	input [31:0]	Data_in,
	output [31:0]	Data_out
);


always @(*) begin
    case (sel)
        3'b000: Data_out = {{24{Data_in[7]}}, Data_in[7:0]};		// b
        3'b001: Data_out = {{16{Data_in[15]}}, Data_in[15:0]};		// h
        3'b010: Data_out = Data_in;											// w
        3'b100: Data_out = {24'b0, Data_in[7:0]};						// bu
        3'b101: Data_out = {16'b0, Data_in[15:0]};						// hu
        default: Data_out = 32'b0;
    endcase
end


endmodule 


