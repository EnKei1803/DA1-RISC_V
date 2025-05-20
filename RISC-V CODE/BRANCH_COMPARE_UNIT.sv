module BRANCH_COMPARE_UNIT
(
	input [2:0]Br_Ctrl,
	input [31:0] SrcA, SrcB,
	output BrOut,EQ, NE, LT, GE
);

/*

			|-----------------------------|-----|-----|-----|
			|				BRANCH				|	s2	|	s1	|	s0	|
			|-----------------------------|-----|-----|-----|
			|EQUAL 							=	|	0	|	0	|	0	|
			|-----------------------------|-----|-----|-----|
			|NOT EQUAL						≠	|	0	|	0	|	1	|
			|-----------------------------|-----|-----|-----|
			|LESS THAN						<	|	1	|	0	|	0	|
			|-----------------------------|-----|-----|-----|
			|GREATER or EQUAL				≥	|	1	|	0	|	1	|
			|-----------------------------|-----|-----|-----|
			|LESS THAN UNSIGNED			<	|	1	|	1	|	0	|
			|-----------------------------|-----|-----|-----|
			|GREATER or EQUAL UNSIGNED	≥	|	1	|	1	|	1	|
			|-----------------------------|-----|-----|-----|
			
*/
   logic GT;
	logic LT_U, GT_U; 
// Calculate condition
COMPARATOR_32bits	COMPARATOR	(SrcA, SrcB, EQ, LT_U, GT_U);

	logic zero;
	assign zero = 1'b0;
	
	logic sel, AxB, SG, SL;
	assign AxB = SrcA[31] ^ SrcB[31];		// A[31] xor B[31] if A==B = 0
														//							 A~=B = 1
	assign SG = (~SrcA[31] & SrcB[31]);		// (A positive, B negative) => A > B
	assign SL = (SrcA[31] & ~SrcB[31]);		// (A negative, B positive) => A < B										  
	
/*



																 AxB	0  
																_|____|_
																\ 0  1 /__Br_Ctrl[1] ( 0: Signed, 1: UnSigned )
																 \____/
																	|
																   |
								GT_U  SG		  LT_U  SL		|
								_|____|_			_|____|_		|
					Sel[0]___\ 0  1 /_______\ 0  1 /__ sel
								 \____/			 \____/
									 |				 	|
									GT					LT

*/

	
MUX_2x1	MUX_SEL1	(Br_Ctrl[1], AxB, zero, sel); 
MUX_2x1	MUX_LT1	(sel, LT_U, SL, LT);
MUX_2x1	MUX_GT1	(sel, GT_U, SG, GT);

	assign NE = ~EQ;
	assign GE = ~LT;

// Select which BRANCH condition
	logic [1:0]BrSel;
	assign BrSel = {Br_Ctrl[2], Br_Ctrl[0]};
	
MUX_4x1_BR	BRANCH_OUT ( BrSel, 	EQ, NE, LT, GE, BrOut);
											
endmodule


//----------------------------MUX 4x1-----------------------
module MUX_4x1_BR
(
	input [1:0]s,
	input I0, I1, I2, I3,
	output Y
);

    always @(*) begin
        case (s)
            2'b00: Y = I0;		// EQ
            2'b01: Y = I1;		// NE
				2'b10: Y = I2;		// LT
				2'b11: Y = I3;		// GE
            default: Y = 1'b0; 
        endcase
    end	
	 
endmodule 