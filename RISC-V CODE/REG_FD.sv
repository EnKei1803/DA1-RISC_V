module REG_FD
(
	input clk,
	input nrst,
	input en, 
	input clr,
	
	input [31:0] PCF,
	input [31:0] InstrF,
	input [31:0] PCPlus4F,

	output [31:0] PCD,
	output [31:0] InstrD,
	output [31:0] PCPlus4D
);

logic reset;
	
assign reset = ~clr & nrst;

	always @(posedge clk) begin
		if (!reset) begin
			PCD		<= 0;
			InstrD	<= 0;
			PCPlus4D	<= 0;

		end 
		else if (en) begin
			PCD		<= PCF;
			InstrD	<= InstrF;
			PCPlus4D	<= PCPlus4F;
		end
		else begin
			PCD		<= PCD;
			InstrD	<= InstrD;
			PCPlus4D	<= PCPlus4D;
			end
		end


endmodule
