module INSTRUCTION_MEMORY
(
	input [31:0] A,				// Address input, from PC
	output reg [31:0] RD			// Instruction output
);

	// Memory array: 256 entries of 32-bit words  
	reg [31:0] mem [0:255];		// 256 x 32-bit memory
	
	// Initialize memory
	initial begin
		$readmemh("Instruction_Mem.txt", mem);					// Load from a txt file
	end

	// RD changes as A changes
	assign RD = mem[A[9:2]];										// Use bits [9:2] for 256 entries (word-aligned)
					
endmodule
