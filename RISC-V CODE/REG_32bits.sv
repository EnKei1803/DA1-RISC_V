module REG_32bits 
#(parameter n = 32)
(
	input [n-1:0] R,					// IN
	input Rin_en, clk, resetn,
	output reg [n-1:0] Q				// OUT
);

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin								// resetn = 0, REG = 0x00
			Q <= {n{1'b0}};
		end
		else 
	if (Rin_en == 1'b1) begin						// if Rin_en = 1, allow to write DATA
			Q <= R;										// Update data in Q = R
	end
end

endmodule
