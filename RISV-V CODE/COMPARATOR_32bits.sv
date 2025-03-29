module COMPARATOR_32bits
(
	input [31:0] A,B,
	output EQ, NE, GT, LE, LT, GE
);

/*
		EQ : EQUAL					=
		NE : NOT EQUAL				≠
		GT : GREATER THAN			>
		LE : LESS or EQUAL		≤
		LT : LESS THAN				<	
		GE : GREATER or EQUAL	≥

*/

logic null1, null2, null3, null4;

logic   [19:0] temp1, temp2 ;		
assign temp1[9:1] = A[18:10];
assign temp1[19:11] = B[18:10];
assign temp2[9:1] = A[27:19];
assign temp2[19:11] = B[27:19];

logic   [7:0] temp3 ;			 
assign temp3[3:1] = A[30:28];
assign temp3[7:5] = B[30:28];

logic 	[3:0] temp4;		
assign temp4[1] = A[31];
assign temp4[3] = B[31];



COMPARATOR_10bits COMPARATOR_10bits_1 (A[9:0], B[9:0], null1, temp1[0], temp1[10]);
COMPARATOR_10bits COMPARATOR_10bits_2 (temp1 [9:0], temp1 [19:10], null2, temp2[0], temp2[10]);
COMPARATOR_10bits COMPARATOR_10bits_3 (temp2 [9:0], temp2 [19:10], null3, temp3[0], temp3[4]);

COMPARATOR_4bits COMPARATOR_4bits_1 (temp3 [3:0], temp3 [7:4], null4, temp4[0], temp4[2]);

COMPARATOR_2bits COMPARATOR_2bits_1 (temp4 [1:0], temp4 [3:2], EQ, GT, LT);

assign NE = ~EQ;
assign LE = ~GT;
assign GE = ~LT;

endmodule 

//--------------------------------2 Bits Comparator----------------------------

module COMPARATOR_2bits
(
	input [1:0] A,B,
	output E,G,L
);


assign E = ~(A[0]^B[0]) & ~(A[1]^B[1]);								// A = B

assign G = (~(A[1]^B[1]) & A[0] & ~B[0]) | (A[1] & ~(B[1]));	// A > B

assign L = (~(A[1]^B[1]) & ~A[0] & B[0]) | (~A[1] & (B[1]));	// A < B

endmodule 

//--------------------------------4 Bits Comparator----------------------------

module COMPARATOR_4bits
(
	input [3:0] A,B,
	output E,G,L
);
logic null1, null2;

logic [3:0] temp1, temp2 ;		// [0:1] = A0.A1 ; [2:3] = B0.B1

assign temp1[1] = A[2];
assign temp1[3] = B[2];
assign temp2[1] = A[3];
assign temp2[3] = B[3];

COMPARATOR_2bits COMPARATOR_2bits_1 (A[1:0], B[1:0], null1, temp1[0], temp1[2]);

COMPARATOR_2bits COMPARATOR_2bits_2 (temp1 [1:0], temp1 [3:2], null2, temp2[0], temp2[2]);

COMPARATOR_2bits COMPARATOR_2bits_3 (temp2 [1:0], temp2 [3:2],E, G, L);

endmodule 

//--------------------------------10 Bits Comparator----------------------------

module COMPARATOR_10bits
(
	input [9:0] A,B,
	output E,G,L
);

logic null1, null2;

logic [7:0] temp1,temp2;		// [0:3] = A0:A3 ; [4:7] = B0:B3

assign temp1[3:1] = A[6:4];
assign temp1[7:5] = B[6:4];
assign temp2[3:1] = A[9:7];
assign temp2[7:5] = B[9:7];

COMPARATOR_4bits COMPARATOR_4bits_1 (A[3:0], B[3:0], null1, temp1[0], temp1[4]);

COMPARATOR_4bits COMPARATOR_4bits_2 (temp1 [3:0], temp1 [7:4], null2, temp2[0], temp2[4]);

COMPARATOR_4bits COMPARATOR_4bits_3 (temp2 [3:0], temp2 [7:4],E, G, L);
	
endmodule 



