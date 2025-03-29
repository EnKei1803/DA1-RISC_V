module INSTRUCTION_MEMORY
(
	input clk,
	input [31:0] A,				// Address input, from PC
	output reg [31:0] RD			// Instruction output
);

	// Memory array: 256 entries of 32-bit words (adjust size as needed)
	reg [31:0] mem [0:255];			// 256 x 32-bit memory

	// Initialize memory with a program (optional)
	initial begin
		$readmemh("Instruction_Mem.bin", mem);		// Load from a txt file
		end

	// Synchronous read
	always @(posedge clk) begin
		RD <= mem[A[9:2]];			// Use bits [9:2] for 256 entries (word-aligned)
	end

endmodule
