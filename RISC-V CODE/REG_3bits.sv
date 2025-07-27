module REG_3bits 
(
	input [2:0] R,						// IN
	input Rin_en, clk, nrst,
	output reg [2:0] Q				// OUT
);

always @(posedge clk or negedge nrst) begin
	if (!nrst) begin								// nrst = 0, REG = 0x00
			Q <= {3'd0};
		end
		else 
	if (Rin_en) begin						// if Rin_en = 1, allow to write DATA
			Q <= R;										// Update data in Q = R
	end
end

endmodule
