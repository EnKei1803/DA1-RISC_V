module Top
(
	// CPU
	input clk, nrst, run,
					
	output [31:0] 	ALUResult, Result, SrcA, SrcB, 		// Check Result
						PC, WD2,										// Relate to PC value
						
	// I/O					
	input [7:0] SW, 				// SW input
	output [6:0]	hundreds,	// Value send to 7SegLed
						tens, 
						units,
	output WE1,						
	output [31:0] RD_7SegLed, RS2, IO_Data
);
// Wire
	logic [31:0] 	PCTarget, Instr, ImmExt;							// TEMP

	logic [31:0] 	RS1, PCNext, PCPlus4,							//	ALU input related
						RD; 														// Value from Data Memory

	logic [31:0] regfile [31:0]; 	// 32 registers in one array
	
	//logic [31:0] IO_Data;

// CONTROL UNIT	
	logic BrEn;
	logic [1:0]ResultSrc;
	logic [2:0]ImmSrc;
	logic MemWrite, ALUSrcA, ALUSrcB, RegWrite, PCSrc, PCTargetSrc, MREQ;
	logic [3:0]ALUControl, SLControl;
	logic [2:0]BrCtrl;
	
CONTROL_UNIT	CONTROL1	(.op(Instr[6:0]), 
								 .BrEn(BrEn), 
								 .funct3(Instr[14:12]), 
								 .funct7(Instr[30]),
								 .ResultSrc(ResultSrc), 
								 .ImmSrc(ImmSrc), 
								 .MemWrite(MemWrite), 
								 .ALUSrcA(ALUSrcA), 
								 .ALUSrcB(ALUSrcB), 
								 .RegWrite(RegWrite), 
								 .PCSrc(PCSrc),
								 .PCTargetSrc(PCTargetSrc),
								 .ALUControl(ALUControl), 
								 .BrCtrl(BrCtrl),
								 .SLControl(SLControl),
								 .MREQ(MREQ)
);
		
// PC CLK
PC_COUNTER	PC_UPDATE	(.PCNext(PCNext),.run(run), .clk(clk), .nrst(nrst), .PC(PC));


// INSTRUCTION MEMORY

INSTRUCTION_MEMORY INS_MEM	(.A(PC), .RD(Instr[31:0]));


// REGISTER FILE

REGISTER_FILE REG_UNIT		( .A1(Instr[19:15]), 
									  .A2(Instr[24:20]), 
									  .A3(Instr[11:7]),   
									  .clk(clk), 
									  .nrst(nrst), 
									  .WE3(RegWrite), 
									  .WD3(Result),
									  .RD1(RS1), 
									  .RD2(RS2)
);


// BRANCH UNIT
BRANCH_COMPARE_UNIT	BR1	(.Br_Ctrl(BrCtrl), .SrcA(SrcA), .SrcB(SrcB), .BrOut(BrEn));


// ALU UNIT
	logic CF, ZF, SF, OF;
ALU_UNIT		ALU1			(.SrcA(SrcA), .SrcB(SrcB), .ALU_Ctrl(ALUControl), .ALU_Results(ALUResult),
								 .CF(CF), .ZF(ZF), .SF(SF), .OF(OF));


// EXTEND UNIT
EXTEND_UNIT	EXT_UNIT		(.Instr(Instr[31:7]), .ImmSrc(ImmSrc), .ImmExt(ImmExt));


// ADDER 32-Bits
	logic [31:0]four, null1, null2, null3, PCTarget1;
	assign four = 32'h0004;
	assign null1 = 32'b0;
ADDER_32bits	PCPLUS	(.A(PC), .B(four), .Cin(null1), .Sum(PCPlus4), .Cout(null2));

ADDER_32bits	PC_TARGET(.A(PC), .B(ImmExt), .Cin(null1), .Sum(PCTarget1), .Cout(null3));

// I/O Block
IO_Block	IO_Device	(
							 .clk(clk),
							 .nrst(nrst),
							 .A(ALUResult),
							 .RD(RD),
							 .WE(MemWrite),
							 .IO_Data(IO_Data),
							 .SW(SW),						// SW input 
							 .RD_7SegLed(RD_7SegLed),
							 .hundreds(hundreds),		// Send to 7SegLed
							 .tens(tens),
							 .units(units),
							 .WE1(WE1),
							 .MREQ(MREQ)
);


// DATA MEMORY
DATA_MEMORY	DATA_MEM			(.clk(clk), 
									 .A(ALUResult), 
									 .WD(RS2), 
									 .WE(MemWrite), 
									 .SLType(SLControl), 
									 .RD(RD),
									 .IO_data(IO_Data),
									 .WD2(WD2)
);


// MUX

MUX_2x1_32Bits		PC_SELECT	(.s(PCSrc), .I0(PCPlus4), .I1(PCTarget), .Y(PCNext));

MUX_2x1_32Bits		ALU_SRCA		(.s(ALUSrcA), .I0(RS1), .I1(PC), .Y(SrcA));

MUX_2x1_32Bits		ALU_SRCB		(.s(ALUSrcB), .I0(RS2), .I1(ImmExt), .Y(SrcB));

MUX_2x1_32Bits		PCTarSrc		(.s(PCTargetSrc), .I0(PCTarget1), .I1(ALUResult), .Y(PCTarget));

MUX_3x1_32Bits		RESULTout	(.s(ResultSrc), .I0(ALUResult), .I1(RD), .I2(PCPlus4), .I3(ImmExt),  .Y(Result));


endmodule 