module DATA_MEMORY (
    input clk,
    input [31:0] A,					// Address input
    input [31:0] WD,					// Data to write
    input WE,							// Write enable
	 input [3:0] SLType,				//	Store-Load Type
    output [31:0] RD					// Data read from memory
);

// Internal wire 
logic [31:0]RD1, RD2, WD1;
logic WE1;

// Memory Zone
assign WE1 = WE & SLType[3];
MEMORY	MEM_Value	(
				.clk(clk), 
				.A(A), 
				.WD(RD2), 
				.WE(WE1), 
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
				.I1(WD),
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