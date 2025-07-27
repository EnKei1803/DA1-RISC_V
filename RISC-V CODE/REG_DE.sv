module REG_DE
(
	input 			clk,
	input 			nrst, 
	input 			clr,
	
	// Control Signal
	input 			RegWriteD,
	input [1:0]		ResultSrcD,
	input 			IOREQD,
	input 			MemWriteD,
	input [3:0]		SLControlD,
	input 			JumpD,
	input 			BranchD,
	input 			PCTargetSrcD,
	input [2:0]		BrCtrlD,
	input [3:0]		ALUCtrlD,
	input 			ALUSrcBD,
	input 			ALUSrcAD,


	// Register Signal
	input [4:0]		Rs1D,
	input [4:0]		Rs2D,
	input [4:0]		RdD,
	input [31:0]	PCD,
	input [31:0]	ImmExtD,
	input [31:0]	PCPlus4D,
	input [31:0]	RD1D,
	input [31:0]	RD2D,

	
	// Control Signal output
	output 			RegWriteE,
	output [1:0]	ResultSrcE,
	output 			IOREQE,
	output 			MemWriteE,
	output [3:0]	SLControlE,
	output 			JumpE,
	output 			BranchE,
	output 			PCTargetSrcE,
	output [2:0]	BrCtrlE,
	output [3:0]	ALUCtrlE,
	output 			ALUSrcBE,
	output 			ALUSrcAE,
	
	
	// Register Signal output
	output [4:0]	Rs1E,
	output [4:0]	Rs2E,
	output [4:0]	RdE,	
	output [31:0]	PCE,
	output [31:0]	ImmExtE,
	output [31:0]	PCPlus4E,
	output [31:0]	RD1E,
	output [31:0]	RD2E
);

	logic reset;
		
	assign reset = ~clr & nrst;
	
	always @(posedge clk) begin
		if (!reset) begin
			// Control Signals
			RegWriteE      <= 0;
			ResultSrcE     <= 0;
			IOREQE         <= 0;
			MemWriteE      <= 0;
			SLControlE     <= 0;
			JumpE          <= 0;
			BranchE        <= 0;
			PCTargetSrcE   <= 0;
			BrCtrlE        <= 0;
			ALUCtrlE       <= 0;
			ALUSrcBE       <= 0;
			ALUSrcAE       <= 0;

			// Register Signals
			Rs1E           <= 0;
			Rs2E           <= 0;
			RdE            <= 0;
			PCE            <= 0;
			ImmExtE        <= 0;
			PCPlus4E       <= 0;
			RD1E           <= 0;
			RD2E           <= 0;
		end 
		else begin
			// Pass control signals
			RegWriteE      <= RegWriteD;
			ResultSrcE     <= ResultSrcD;
			IOREQE         <= IOREQD;
			MemWriteE      <= MemWriteD;
			SLControlE     <= SLControlD;
			JumpE          <= JumpD;
			BranchE        <= BranchD;
			PCTargetSrcE   <= PCTargetSrcD;
			BrCtrlE        <= BrCtrlD;
			ALUCtrlE       <= ALUCtrlD;
			ALUSrcBE       <= ALUSrcBD;
			ALUSrcAE       <= ALUSrcAD;

			// Pass register signals
			Rs1E           <= Rs1D;
			Rs2E           <= Rs2D;
			RdE            <= RdD;
			PCE            <= PCD;
			ImmExtE        <= ImmExtD;
			PCPlus4E       <= PCPlus4D;
			RD1E           <= RD1D;
			RD2E           <= RD2D;
		end
	end

endmodule

