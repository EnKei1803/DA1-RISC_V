module Top_Pipeline
(
	// Check
	output [2:0]	ImmSrcD,
	
	output 			JumpE,
	output 			BranchE,
	output 			PCTargetSrcE,
	output [2:0]	BrCtrlE,
	output [3:0]	ALUCtrlE,
	output 			ALUSrcBE,
	output 			ALUSrcAE,	
	
	output 			IOREQM,
	output 			MemWriteM,
	output [3:0]	SLControlM,	
	
	output 			RegWriteW,
	output [1:0]	ResultSrcW,
	
	output [31:0] 	InstrF,
	output [31:0] 	InstrD,	
	
	output [31:0] 	PC_Next,
	output [31:0] 	PCF,
	output [31:0] 	PCD,
	output [31:0] 	PCPlus4F,	
	output 			BrEnE,
	output 			PCSrcE,
	
	output [31:0] 	PCTargetE,
	output [31:0] 	ImmExtE,
	output [31:0] 	PCE,
	
	output [31:0] 	RD1D,
	output [31:0] 	RD2D,
	output [31:0]	SrcAE, 
	output [31:0]	SrcBE,
	output [31:0] 	ALUResultE,	
	
	output [31:0] 	WriteDataM,
	output [31:0] 	ReadDataM,	
	
	output [1:0] 	ForwardAE,
	output [1:0] 	ForwardBE,
	
	output			StallF,
	output			StallD,
	
	output			FlushD,
	output			FlushE,


	// CPU
	input 			clk, 
	input 			nrst, 
					
	output [31:0] 	ResultW, 									
						
	// I/O					
	input [7:0] 	SW, 
	output [31:0]	IO_Data,	
	
	output [6:0]	hundreds,	
	output [6:0]	tens, 
	output [6:0]	units,				
	output [31:0]	RD_7SegLed

);

// ===============================================
// 				 		Wire Declaration 	
// ===============================================
	
// ========== Fetch ========== 
	
//	logic [31:0] 	InstrF;
//	logic [31:0] 	PC_Next;
//	logic [31:0] 	PCF;
//	logic [31:0] 	PCPlus4F;
	
	
	
// ========== Decode ==========
	
	logic 			RegWriteD;
	logic [1:0]		ResultSrcD;
	logic 			IOREQD;
	logic 			MemWriteD;
	logic [3:0]		SLControlD;
	logic 			JumpD;
	logic 			BranchD;
	logic 			PCTargetSrcD;
	logic [2:0]		BrCtrlD;
	logic [3:0]		ALUCtrlD;
	logic 			ALUSrcBD;
	logic 			ALUSrcAD;
//	logic [2:0]		ImmSrcD;

	logic [4:0]		Rs1D; 
	logic [4:0]		Rs2D;
	logic [4:0]		RdD;
//	logic [31:0] 	InstrD;
	logic [31:0] 	ImmExtD;
//	logic [31:0] 	PCD;
	logic [31:0] 	PCPlus4D;
//	logic [31:0] 	RD1D;
//	logic [31:0] 	RD2D;
	
	

// ========== Execute ==========	
	
	logic 			RegWriteE;
	logic [1:0]		ResultSrcE;
	logic 			IOREQE;
	logic 			MemWriteE;
	logic [3:0]		SLControlE;
//	logic 			JumpE;
//	logic 			BranchE;
//	logic 			PCTargetSrcE;
//	logic [2:0]		BrCtrlE;
//	logic [3:0]		ALUCtrlE;
//	logic 			ALUSrcBE;
//	logic 			ALUSrcAE;	
	
//	logic 			BrEnE;
//	logic 			PCSrcE;
	logic [4:0]		Rs1E; 
	logic [4:0]		Rs2E;
	logic [4:0]		RdE;
	logic [31:0] 	PCTarget;
//	logic [31:0] 	PCTargetE;
//	logic [31:0] 	ImmExtE;
//	logic [31:0] 	PCE;
	logic [31:0] 	PCPlus4E;
	logic [31:0] 	RD1E;
	logic [31:0] 	RD2E;
//	logic [31:0]	SrcAE; 
//	logic [31:0]	SrcBE;
//	logic [31:0] 	ALUResultE;
	logic [31:0] 	WriteDataE;
	
	
// ========== Memory ==========
	
	logic 			RegWriteM;
	logic [1:0]		ResultSrcM;
//	logic 			IOREQM;
//	logic 			MemWriteM;
//	logic [3:0]		SLControlM;
	
	logic [4:0]		RdM;
	logic [31:0] 	ImmExtM;
	logic [31:0] 	PCPlus4M;
	logic [31:0] 	ALUResultM;
//	logic [31:0] 	WriteDataM;
//	logic [31:0] 	ReadDataM;
	
	
// ========== WriteBack ==========
	
//	logic 			RegWriteW;
//	logic [1:0]		ResultSrcW;	
	
	logic [4:0]		RdW;
	logic [31:0] 	ImmExtW;
	logic [31:0] 	PCPlus4W;
	logic [31:0] 	ALUResultW;
	logic [31:0] 	ReadDataW;
	
// ========== Hazard ==========
	
//	logic [1:0] 	ForwardAE;
//	logic [1:0] 	ForwardBE;
//	
//	logic				StallF;
//	logic				StallD;
//	
//	logic				FlushD;
//	logic				FlushE;
	
	
	
// ========== Temp ==========
	
	logic 			CF, ZF, SF, OF;
	logic [31:0]	four;
	logic [31:0]	SrcAE1, SrcBE1;

	assign four = 32'h0004;
	assign Rs1D = InstrD[19:15];
	assign Rs2D = InstrD[24:20];
	assign RdD  = InstrD[11:7];
	

// ===============================================
// 				 		Module Connector 	
// ===============================================			
						
assign PCSrcE = (BrEnE & BranchE) | JumpE;

// ========== Fetch ========== 

	// Select PC
	MUX_2x1_32Bits					PC_SELECT	(
	.s(PCSrcE), 
	.I0(PCPlus4F), 
	.I1(PCTargetE), 
	.Y(PC_Next)
	);

	// PC Counter
	PC_COUNTER						PC_Counter	(
	.PCNext(PC_Next),
	.run(~StallF), 
	.clk(clk), 
	.nrst(nrst), 
	.PC(PCF)
	);

	// INSTRUCTION MEMORY
	INSTRUCTION_MEMORY			Instruction_MEM	(
	.A(PCF), 
	.RD(InstrF)
	);
	
	// PC Plus 4	
	ADDER_32bits					PC_PLUS_4	(
	.A(PCF), 
	.B(four), 
	.Cin(1'b0), 
	.Sum(PCPlus4F), 
	.Cout()
	);
	
	// Fetch To Decode
	REG_FD							FetchToDecode	(
	.clk(clk),
	.nrst,
	.en(~StallD), 
	.clr(FlushD),
	
	.PCF(PCF),
	.InstrF(InstrF),
	.PCPlus4F(PCPlus4F),

	.PCD(PCD),
	.InstrD(InstrD),
	.PCPlus4D(PCPlus4D)
	);

// ========== Decode ==========

	// CONTROL UNIT		
	CONTROL_UNIT					Control_Unit	(
	.op(InstrD[6:0]),
	.funct3(InstrD[14:12]), 
	.funct7(InstrD[30]),

	.RegWrite(RegWriteD),	
	.ResultSrc(ResultSrcD), 
	.IOREQ(IOREQD),
	.MemWrite(MemWriteD), 
	.SLControl(SLControlD),
	.Jump(JumpD),
	.Branch(BranchD), 
	.PCTargetSrc(PCTargetSrcD),
	.BrCtrl(BrCtrlD),
	.ALUControl(ALUCtrlD), 
	.ALUSrcB(ALUSrcBD),
	.ALUSrcA(ALUSrcAD), 
	.ImmSrc(ImmSrcD)
	);
	
	
	// REGISTER FILE
	REGISTER_FILE					Register_FILE		( 
	.clk(clk), 
	.nrst(nrst), 
	.A1(InstrD[19:15]), 
	.A2(InstrD[24:20]), 
	.A3(RdW),   
	.WE3(RegWriteW), 
	.WD3(ResultW),
	.RD1(RD1D), 
	.RD2(RD2D)
	);
		
	// EXTEND UNIT
	EXTEND_UNIT						Extend_Unit		(
	.Instr(InstrD[31:7]), 
	.ImmSrc(ImmSrcD), 
	.ImmExt(ImmExtD)
	);
	
	// Decode To Execute
	REG_DE							DecodeToExecute	(
	.clk(clk), 
	.nrst(nrst),
	.clr(FlushE),
	
	// Control Signal
	.RegWriteD(RegWriteD),
	.ResultSrcD(ResultSrcD),
	.IOREQD(IOREQD),
	.MemWriteD(MemWriteD),
	.SLControlD(SLControlD),
	.JumpD(JumpD),
	.BranchD(BranchD),
	.PCTargetSrcD(PCTargetSrcD),
	.BrCtrlD(BrCtrlD),
	.ALUCtrlD(ALUCtrlD),
	.ALUSrcBD(ALUSrcBD),
	.ALUSrcAD(ALUSrcAD),


	// Register Signal
	.Rs1D(Rs1D),
	.Rs2D(Rs2D),
	.RdD(RdD),
	.PCD(PCD),
	.ImmExtD(ImmExtD),
	.PCPlus4D(PCPlus4D),
	.RD1D(RD1D), 
	.RD2D(RD2D),

	
	// Control Signal output
	.RegWriteE(RegWriteE),
	.ResultSrcE(ResultSrcE),
	.IOREQE(IOREQE),
	.MemWriteE(MemWriteE),
	.SLControlE(SLControlE),
	.JumpE(JumpE),
	.BranchE(BranchE),
	.PCTargetSrcE(PCTargetSrcE),
	.BrCtrlE(BrCtrlE),
	.ALUCtrlE(ALUCtrlE),
	.ALUSrcBE(ALUSrcBE),
	.ALUSrcAE(ALUSrcAE),
	
	
	// Register Signal output
	.Rs1E(Rs1E),
	.Rs2E(Rs2E),
	.RdE(RdE),	
	.PCE(PCE),
	.ImmExtE(ImmExtE),
	.PCPlus4E(PCPlus4E),
	.RD1E(RD1E), 
	.RD2E(RD2E)
	);

// ========== Execute ==========	

	MUX_3x1_32Bits					ForwardA	(
	.s(ForwardAE), 
	.I0(RD1E), 
	.I1(ResultW), 
	.I2(ALUResultM), 
	.Y(SrcAE1)
	);
	
	MUX_3x1_32Bits					ForwardB	(
	.s(ForwardBE), 
	.I0(RD2E), 
	.I1(ResultW), 
	.I2(ALUResultM),  
	.Y(WriteDataE)
	);	
	
	MUX_2x1_32Bits					ALU_SrcA		(
	.s(ALUSrcAE), 
	.I0(SrcAE1), 
	.I1(PCE), 
	.Y(SrcAE)
	);

	MUX_2x1_32Bits					ALU_SrcB		(
	.s(ALUSrcBE), 
	.I0(WriteDataE), 
	.I1(ImmExtE), 
	.Y(SrcBE)
	);

	// BRANCH UNIT
	BRANCH_COMPARE_UNIT			Branch_Compare_Unit	(
	.Br_Ctrl(BrCtrlE), 
	.SrcA(SrcAE), 
	.SrcB(SrcBE), 
	.BrOut(BrEnE)
	);

	// ALU UNIT	
	ALU_UNIT							ALU1			(
	.SrcA(SrcAE), 
	.SrcB(SrcBE), 
	.ALU_Ctrl(ALUCtrlE),
	
	.ALU_Results(ALUResultE),
	.CF(CF), 
	.ZF(ZF), 
	.SF(SF), 
	.OF(OF)
	);
	
	// PC Target 
	ADDER_32bits					PC_Target	(
	.A(PCE), 
	.B(ImmExtE), 
	.Cin(1'b0), 
	.Sum(PCTarget), 
	.Cout()
	);

	MUX_2x1_32Bits					PCTargetSrc		(
	.s(PCTargetSrcE), 
	.I0(PCTarget), 
	.I1(ALUResultE), 
	.Y(PCTargetE)
	);
	
	// Execute To Memory
	REG_EM							ExecuteToMemory	(
	.clk(clk),
	.nrst(nrst), 
	
	// Control Signal
	.RegWriteE(RegWriteE),
	.ResultSrcE(ResultSrcE),
	.IOREQE(IOREQE),
	.MemWriteE(MemWriteE),
	.SLControlE(SLControlE),

	// Register Signal
	.RdE(RdE),
	.ALUResultE(ALUResultE),
	.WriteDataE(WriteDataE),
	.ImmExtE(ImmExtE),
	.PCPlus4E(PCPlus4E),

	
	// Control Signal output
	.RegWriteM(RegWriteM),
	.ResultSrcM(ResultSrcM),
	.IOREQM(IOREQM),
	.MemWriteM(MemWriteM),
	.SLControlM(SLControlM),	
	
	// Register Signal output
	.RdM(RdM),	
	.ALUResultM(ALUResultM),
	.WriteDataM(WriteDataM),
	.ImmExtM(ImmExtM),
	.PCPlus4M(PCPlus4M)
	);
	
	
	
// ========== Memory ==========

	// I/O Block
	IO_Block							IO_Device	(
	.clk(clk),
	.nrst(nrst),
	
	.IOREQ(IOREQM),
	.WE(MemWriteM),
	.A(ALUResultM),
	.IO_Data(IO_Data),
	
	.SW(SW),
	.RD(ReadDataM),	
	
	.RD_7SegLed(RD_7SegLed),
	.hundreds(hundreds),			
	.tens(tens),
	.units(units)
	);


	// DATA MEMORY
	DATA_MEMORY						DATA_MEM			(
	.clk(clk), 
	
	.WE(MemWriteM), 
	.SLType(SLControlM),
	.A(ALUResultM), 
	.WD(WriteDataM), 
	.IO_data(IO_Data),	
	
	.RD(ReadDataM)

	);

	// Memory To WriteBack
	REG_MW							MemoryToWriteBack	(
	.clk(clk),
	.nrst(nrst), 
	
	// Control Signal
	.RegWriteM(RegWriteM),
	.ResultSrcM(ResultSrcM),

	// Register Signal
	.RdM(RdM),
	.ALUResultM(ALUResultM),
	.ReadDataM(ReadDataM),
	.ImmExtM(ImmExtM),
	.PCPlus4M(PCPlus4M),

	
	// Control Signal output
	.RegWriteW(RegWriteW),
	.ResultSrcW(ResultSrcW),
	
	// Register Signal output
	.RdW(RdW),	
	.ALUResultW(ALUResultW),
	.ReadDataW(ReadDataW),
	.ImmExtW(ImmExtW),
	.PCPlus4W(PCPlus4W)
	);
	
	
	
	
	
// ========== WriteBack ==========

	MUX_4x1_32Bits					RESULTout	(
	.s(ResultSrcW), 
	.I0(ALUResultW), 
	.I1(ReadDataW), 
	.I2(PCPlus4W), 
	.I3(ImmExtW),  
	.Y(ResultW)
	);

	
	
// ========== Hazard ==========	

	HAZARD_CONTROL_UNIT	HazardControlUnit	(
	.Rs1E,
	.Rs2E,
	.RdM,
	.RdW,
	.ResultSrcE,
	.RegWriteM,
	.RegWriteW,
	.PCSrcE,

	.ForwardAE,
	.ForwardBE,
	
	.StallF,
	.StallD,
	
	.FlushD,
	.FlushE
	);




endmodule 