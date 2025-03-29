module DATA_MEMORY
(
    input clk,
    input [31:0] A,				// Address input
    input [31:0] WD,				// Data to write
    input WE,						// Write enable
    input RE,						// Read enable
    output reg [31:0] RD				// Data read from memory
);

	reg [31:0] mem [0:255];				// 256 x 32-bit memory

	initial begin
		integer i;
		for (i = 0; i < 256; i = i + 1) begin
			mem[i] = 32'h00000000;
		end
	end

	always @(posedge clk) begin
		if (WE) begin
			mem[A[9:2]] <= WD;  			// Write on clock edge
		end
		if (RE) begin
			RD <= mem[A[9:2]];			// Read on clock edge
		end else begin
			RD <= 32'hzzzzzzzz;			// High-impedance when not reading
		end
	end
	
endmodule


