module TEST_MEMORY (
    input clk,
    input [31:0] A,					// Aess input
    input [31:0] WD,					// Data to write
	 input [31:0] IO_data,			// Data from external I/O
    input WE, 							// Write enable
	 input [3:0] SLType,				//	Store-Load Type
    output [31:0] RD					// Data read from memory
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

	// 1024 x 8-bit memory
	reg [7:0] mem [0:255];

	
	// Internal wire 
	logic [31:0] WD2;
	logic [7:0] Addr;
   
	assign Addr = A[7:0];
	assign WD2 = WD | IO_data;

	
	// Write operation
	always @(posedge clk) begin
	  if (WE) begin
			case (SLType)
				 4'b1000: if (Addr < 256) 			// sb
						mem[Addr] 	<= WD2[7:0];
				 4'b1001: if (Addr < 255) begin	// sh
						mem[Addr] 	<= WD2[7:0];
						mem[Addr+1] <= WD2[15:8];
				 end
				 4'b1010: if (Addr < 253) begin	// sw
						mem[Addr] 	<= WD2[7:0];
						mem[Addr+1] <= WD2[15:8];
						mem[Addr+2] <= WD2[23:16];
						mem[Addr+3] <= WD2[31:24];
				 end
				 default: ; // No operation
			endcase
	  end
	end



	// Read operation
	always @(*) begin
	  case (SLType)
			4'b0000: RD = {{24{mem[Addr][7]}}, mem[Addr]};							// lb
			4'b0001: RD = {{16{mem[Addr+1][7]}}, mem[Addr+1], mem[Addr]};		// lh
			4'b0010: RD = {mem[Addr+3], mem[Addr+2], mem[Addr+1], mem[Addr]};	// lw
			4'b0100: RD = {24'h0, mem[Addr]};											// lbu
			4'b0110: RD = {16'h0, mem[Addr+1], mem[Addr]};							// lhu
			default: RD = 32'h0;
	  endcase
	end

	
endmodule 
