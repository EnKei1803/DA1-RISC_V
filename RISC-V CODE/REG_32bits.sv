module REG_32bits 
(
	input [31:0] R,					
	input Rin_en, clk, nrst,
	output reg [31:0] Q			
);

always @(negedge clk or negedge nrst) begin
	if (!nrst) begin							
			Q <= {32'b0};
		end
		else 
	if (Rin_en == 1'b1) begin						
			Q <= R;								
	end
end

endmodule
