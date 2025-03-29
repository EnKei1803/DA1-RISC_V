module ALU_UNIT
(
	input [31:0] SrcA, SrcB,
	input [2:0] ALU_Ctrl,
	output [31:0] ALU_Results, ADD_out,
	output CF, ZF, SF, OF
);
/*
						|--------------------|-----------|-----------|-----------|
						|	 OPERATING MODE	|		S2		|		s1		|		S0		|
						|--------------------|-----------|-----------|-----------|
						|			 ADD			|		0		|		0		|		0		|
						|--------------------|-----------|-----------|-----------|
						|			 SUB			|		0		|		0		|		1		|
						|--------------------|-----------|-----------|-----------|
						|			 AND			|		0		|		1		|		0		|
						|--------------------|-----------|-----------|-----------|
						|			 OR			|		0		|		1		|		1		|
						|--------------------|-----------|-----------|-----------|
						|			 NULL			|		1		|		0		|		0		|
						|--------------------|-----------|-----------|-----------|
						|			 SLT			|		1		|		0		|		1		|
						|--------------------|-----------|-----------|-----------|
						|	 		 NULL			|		1		|		1		|		0		|
						|--------------------|-----------|-----------|-----------|
						|	 		 SLTU			|		1		|		1		|		1		|
						|--------------------|-----------|-----------|-----------|
						
	-NOte that, ALU_Ctrl[0] is use to control ADDER (0) and SUBTRATOR (1)
						
*/



logic [31:0] AND_out, OR_out, SLT_out, SLTU_out;
logic Cout;

// SUB
logic [31:0] AB, nSrcB;
assign nSrcB = ~SrcB;
MUX_2x1_32Bits	SUBTRATOR (.s(ALU_Ctrl[0]), .I0(SrcB[31:0]), .I1(nSrcB[31:0]), .Y(AB[31:0]));

// ADD
ADDER_32bits	ADDER_32bits_ALU (.A(SrcA[31:0]), .B(AB[31:0]), .Cin(ALU_Ctrl[0]), .Sum(ADD_out[31:0]), .Cout(Cout));

// LOGIC
assign AND_out = SrcA & SrcB;
assign OR_out	= SrcA | SrcB;

// EFLAGS
/*

		CF ; Carry Flag
		ZF : Zero Flag
		SF ; Sign Flag
		OF : Overflow Flag

*/
assign CF = ~ALU_Ctrl[1] & Cout;
assign ZF = &(~ALU_Results); 
assign SF = ALU_Results[31];
assign OF = ~(SrcA[31]^SrcB[31]^ALU_Ctrl[0]) & (SrcA[31]^ADD_out[31]) & ~ALU_Ctrl[1];

// SLT
logic Pre_SLT_out;
assign Pre_SLT_out = OF ^ ADD_out;
assign SLT_out = {31'b0,Pre_SLT_out};		// Zero_Ext
// SLTU
assign SLTU_out = {31'b0,ADD_out[31]};		// Zero_Ext


// ALU_MUX
ALU_MUX ALU_MUX_1 (.ALU_Ctrl(ALU_Ctrl[2:0]), 
						.I0(ADD_out[31:0]), .I1(ADD_out[31:0]), .I2(AND_out[31:0]), .I3(OR_out[31:0]), .I4(SLT_out[31:0]), .I5(SLT_out[31:0]), 
						.ALU_Results(ALU_Results[31:0]));


endmodule 

//--------------------------------MUX 4x1------------------------------------

module ALU_MUX
(
	input [2:0] ALU_Ctrl,
	input [31:0] I0, I1, I2, I3, I4, I5, 
	output [31:0] ALU_Results
);

    always @(*) begin
        case (ALU_Ctrl)
            3'b000: ALU_Results = I0;  // ADD
            3'b001: ALU_Results = I1;  // SUB
            3'b010: ALU_Results = I2;  // AND
				3'b011: ALU_Results = I3;  // OR
				3'b101: ALU_Results = I4;  // SLT  (Set if Less Than)
				3'b111: ALU_Results = I4;  // SLTU (Set if Less Than, Unsigned)
            default: ALU_Results = 32'b0; // Default (invalid case)
        endcase
    end	
endmodule
