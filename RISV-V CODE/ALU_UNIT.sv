module ALU_UNIT
(
	input [31:0] SrcA, SrcB,
	input [3:0] ALU_Ctrl,
	output [31:0] ALU_Results,
	output CF, ZF, SF, OF
);
/*
			|--------------------|-----------|-----------|-----------|-----------|
			|	 OPERATING MODE	|		S3		|		S2		|		S1		|		S0		|
			|--------------------|-----------|-----------|-----------|-----------|
			|			 ADD			|		0		|		0		|		0		|		0		|
			|--------------------|-----------|-----------|-----------|-----------|
			|			 SUB			|		0		|		0		|		0		|		1		|
			|--------------------|-----------|-----------|-----------|-----------|
			|			 AND			|		0		|		0		|		1		|		0		|
			|--------------------|-----------|-----------|-----------|-----------|
			|			 OR			|		0		|		0		|		1		|		1		|
			|--------------------|-----------|-----------|-----------|-----------|
			|			 SLTU			|		0		|		1		|		0		|		0		|
			|--------------------|-----------|-----------|-----------|-----------|
			|			 SLT			|		0		|		1		|		0		|		1		|
			|--------------------|-----------|-----------|-----------|-----------|
			|	 		 NULL			|		0		|		1		|		1		|		0		|
			|--------------------|-----------|-----------|-----------|-----------|
			|	 		 XOR			|		0		|		1		|		1		|		1		|
			|--------------------|-----------|-----------|-----------|-----------|
			|	 		 SRL			|		1		|		0		|		0		|		1		|
			|--------------------|-----------|-----------|-----------|-----------|
			|	 		 SAR			|		1		|		0		|		1		|		1		|
			|--------------------|-----------|-----------|-----------|-----------|			
			|	 		 SLL			|		1		|		1		|		0		|		1		|
			|--------------------|-----------|-----------|-----------|-----------|
			
						
	-NOte that, ALU_Ctrl[0] is use to control ADDER (0) and SUBTRATOR (1)
						
*/



logic [31:0] AND_out, OR_out, XOR_out, SLT_out, SLTU_out, SHIFT_out, ADD_out;
logic Cout;

// SUB
logic [31:0] AB, nSrcB;
assign nSrcB = ~SrcB;
MUX_2x1_32Bits	SUBTRATOR (.s(s_sub), .I0(SrcB[31:0]), .I1(nSrcB[31:0]), .Y(AB[31:0]));

// ADD
ADDER_32bits	ADDER_32bits_ALU (.A(SrcA[31:0]), .B(AB[31:0]), .Cin(s_sub), .Sum(ADD_out[31:0]), .Cout(Cout));

// LOGIC
assign AND_out = SrcA & SrcB;
assign OR_out	= SrcA | SrcB;
assign XOR_out = SrcA ^ SrcB;

// Shifter
logic [1:0] sel_shift;
assign sel_shift = ALU_Ctrl[2:1];
SHIFTER_32bits Barrel_shifter (.A(SrcA[31:0]), .B(SrcB[4:0]), .Sel(sel_shift[1:0]), .Y(SHIFT_out[31:0]));

// SLT
logic Pre_SLT_out, AS, s_sub, shift_ins, sltu_ins, zero, one;
assign Pre_SLT_out = OF ^ ADD_out[31];
assign SLT_out = {31'b0,Pre_SLT_out};		// Zero_Ext

// SLTU
assign sltu_ins = ~ALU_Ctrl[3] & ALU_Ctrl[2] & ~ALU_Ctrl[1] & ~ALU_Ctrl[0];	// ALU_Ctrl = 0100
assign s_sub = ALU_Ctrl[0] | sltu_ins;  													// SUB, SLTU, SLT all use subtraction
assign SLTU_out = {31'b0, ~Cout};															// Zero_Ext

// EFLAGS
/*

					CF ; Carry Flag
					ZF : Zero Flag
					SF ; Sign Flag
					OF : Overflow Flag

*/
assign zero = 1'b0;
assign shift_ins = ALU_Ctrl[3] & ~ALU_Ctrl[2] & ALU_Ctrl[1] & ALU_Ctrl[0];		// ALU_Ctrl = 1011

MUX_2x1 selectCtrl2 (.s(shift_ins), .I0(ALU_Ctrl[1]), .I1(zero), .Y(AS));

assign CF = ~AS & Cout;
assign ZF = &(~ALU_Results); 
assign SF = ALU_Results[31];
assign OF = ~(SrcA[31] ^ SrcB[31] ^ s_sub) & (SrcA[31] ^ ADD_out[31]) & ~AS;

// ALU_MUX
ALU_MUX ALU_MUX_1 (.ALU_Ctrl(ALU_Ctrl[3:0]), 
						.I0(ADD_out[31:0]), .I1(ADD_out[31:0]), .I2(AND_out[31:0]), .I3(OR_out[31:0]), .I4(SLTU_out[31:0]),
						.I5(SLT_out[31:0]), .I6(XOR_out[31:0]), .I7(SHIFT_out[31:0]), .I8(SHIFT_out[31:0]), .I9(SHIFT_out[31:0]), 
						.ALU_Results(ALU_Results[31:0]));


endmodule 

//--------------------------------MUX 9x1------------------------------------

module ALU_MUX
(
	input [3:0] ALU_Ctrl,
	input [31:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9,
	output [31:0] ALU_Results
);

    always @(*) begin
        case (ALU_Ctrl)
            4'b0000: ALU_Results = I0;  // ADD
            4'b0001: ALU_Results = I1;  // SUB
            4'b0010: ALU_Results = I2;  // AND
				4'b0011: ALU_Results = I3;  // OR
				4'b0100: ALU_Results = I4;  // SLTU (Set if Less Than, Unsigned)
				4'b0101: ALU_Results = I5;  // SLT  (Set if Less Than)
				4'b0111: ALU_Results = I6;  // XOR
				4'b1001: ALU_Results = I7;  // SRL
				4'b1011: ALU_Results = I8;  // SAR
				4'b1101: ALU_Results = I9;  // SLL
            default: ALU_Results = 32'b0; // Default (invalid case)
        endcase
    end	
endmodule
