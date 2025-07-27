module REG_MW
(
	input 			clk,
	input 			nrst, 
	
	// Control Signal
	input 			RegWriteM,
	input [1:0]		ResultSrcM,

	// Register Signal
	input [4:0]		RdM,
	input [31:0]	ALUResultM,
	input [31:0]	ReadDataM,
	input [31:0]	ImmExtM,
	input [31:0]	PCPlus4M,

	
	// Control Signal output
	output 			RegWriteW,
	output [1:0]	ResultSrcW,
	
	// Register Signal output
	output [4:0]	RdW,	
	output [31:0]	ALUResultW,
	output [31:0]	ReadDataW,
	output [31:0]	ImmExtW,
	output [31:0]	PCPlus4W
);

	always @(posedge clk) begin
		if (!nrst) begin
			// Reset all outputs to 0
			RegWriteW    <= 0;
			ResultSrcW   <= 0;
			RdW          <= 0;
			ALUResultW   <= 0;
			ReadDataW    <= 0;
			ImmExtW      <= 0;
			PCPlus4W     <= 0;
		end 
		else begin
			// Transfer values from Memory stage to Writeback stage
			RegWriteW    <= RegWriteM;
			ResultSrcW   <= ResultSrcM;
			RdW          <= RdM;
			ALUResultW   <= ALUResultM;
			ReadDataW    <= ReadDataM;
			ImmExtW      <= ImmExtM;
			PCPlus4W     <= PCPlus4M;
		end
	end

endmodule
