module REG_EM
(
	input 			clk,
	input 			nrst, 
	
	// Control Signal
	input 			RegWriteE,
	input [1:0]		ResultSrcE,
	input 			IOREQE,
	input 			MemWriteE,
	input [3:0]		SLControlE,

	// Register Signal
	input [4:0]		RdE,
	input [31:0]	ALUResultE,
	input [31:0]	WriteDataE,
	input [31:0]	ImmExtE,
	input [31:0]	PCPlus4E,

	
	// Control Signal output
	output 			RegWriteM,
	output [1:0]	ResultSrcM,
	output 			IOREQM,
	output 			MemWriteM,
	output [3:0]	SLControlM,	
	
	// Register Signal output
	output [4:0]	RdM,	
	output [31:0]	ALUResultM,
	output [31:0]	WriteDataM,
	output [31:0]	ImmExtM,
	output [31:0]	PCPlus4M
);

	always @(posedge clk) begin
		if (!nrst) begin
			RegWriteM    <= 0;
			ResultSrcM   <= 0;
			IOREQM       <= 0;
			MemWriteM    <= 0;
			SLControlM   <= 0;
			RdM          <= 0;
			ALUResultM   <= 0;
			WriteDataM   <= 0;
			ImmExtM      <= 0;
			PCPlus4M     <= 0;
		end 
		else begin
			RegWriteM    <= RegWriteE;
			ResultSrcM   <= ResultSrcE;
			IOREQM       <= IOREQE;
			MemWriteM    <= MemWriteE;
			SLControlM   <= SLControlE;
			RdM          <= RdE;
			ALUResultM   <= ALUResultE;
			WriteDataM   <= WriteDataE;
			ImmExtM      <= ImmExtE;
			PCPlus4M     <= PCPlus4E;
		end
	end

endmodule
