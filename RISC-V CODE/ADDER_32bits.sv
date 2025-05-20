module ADDER_32bits 			// Kogge Stone ADDER
(
    input [31:0] A, B,
    input Cin,
    output [31:0] Sum,
    output Cout
);
    logic [32:1] G,P; 
	 logic [32:1] C;
    
    // Pre-processing stage: Generate & Propagate
    assign G = A & B;    // Generate
    assign P = A ^ B;    // Propagate
    
    // Prefix Computation Stage: (Using Gray & Black Cells)
	 
	 logic [32:3] G1, P1;		// Level 1 - Level 2
	 logic [32:5] G2, P2;		// Level 2 - Level 3
	 logic [32:9] G3, P3;		// Level 3 - Level 4
	 logic [32:17] G4, P4;		// Level 4 - Level 5
	 
	 
	 // Level 1
	 assign C[1] = G[1] | (P[1] & Cin);
	 
	 GRAY_CELL 	GRAY_CELL_02	(C[1], P[2], G[2], C[2]);
	 
	 //								 |P_pre-1|G_pre-1|P_cur| G_cur| P_n  |  G_n
    BLACK_CELL BLACK_CELL_1_03  ( P[2],  G[2],  P[3],  G[3],  P1[3],  G1[3]);
    BLACK_CELL BLACK_CELL_1_04  ( P[3],  G[3],  P[4],  G[4],  P1[4],  G1[4]);
	 
    BLACK_CELL BLACK_CELL_1_05  ( P[4],  G[4],  P[5],  G[5],  P1[5],  G1[5]);
    BLACK_CELL BLACK_CELL_1_06  ( P[5],  G[5],  P[6],  G[6],  P1[6],  G1[6]);
    BLACK_CELL BLACK_CELL_1_07  ( P[6],  G[6],  P[7],  G[7],  P1[7],  G1[7]);
    BLACK_CELL BLACK_CELL_1_08  ( P[7],  G[7],  P[8],  G[8],  P1[8],  G1[8]);
	 
    BLACK_CELL BLACK_CELL_1_09  ( P[8],  G[8],  P[9],  G[9],  P1[9],  G1[9]);
    BLACK_CELL BLACK_CELL_1_10  ( P[9],  G[9],  P[10], G[10], P1[10], G1[10]);
    BLACK_CELL BLACK_CELL_1_11  ( P[10], G[10], P[11], G[11], P1[11], G1[11]);
    BLACK_CELL BLACK_CELL_1_12  ( P[11], G[11], P[12], G[12], P1[12], G1[12]);
	 
    BLACK_CELL BLACK_CELL_1_13  ( P[12], G[12], P[13], G[13], P1[13], G1[13]);
    BLACK_CELL BLACK_CELL_1_14  ( P[13], G[13], P[14], G[14], P1[14], G1[14]);
    BLACK_CELL BLACK_CELL_1_15  ( P[14], G[14], P[15], G[15], P1[15], G1[15]);
    BLACK_CELL BLACK_CELL_1_16  ( P[15], G[15], P[16], G[16], P1[16], G1[16]);
	 
    BLACK_CELL BLACK_CELL_1_17  ( P[16], G[16], P[17], G[17], P1[17], G1[17]);
    BLACK_CELL BLACK_CELL_1_18  ( P[17], G[17], P[18], G[18], P1[18], G1[18]);
    BLACK_CELL BLACK_CELL_1_19  ( P[18], G[18], P[19], G[19], P1[19], G1[19]);
    BLACK_CELL BLACK_CELL_1_20  ( P[19], G[19], P[20], G[20], P1[20], G1[20]);
	 
    BLACK_CELL BLACK_CELL_1_21  ( P[20], G[20], P[21], G[21], P1[21], G1[21]);
    BLACK_CELL BLACK_CELL_1_22  ( P[21], G[21], P[22], G[22], P1[22], G1[22]);
    BLACK_CELL BLACK_CELL_1_23  ( P[22], G[22], P[23], G[23], P1[23], G1[23]);
    BLACK_CELL BLACK_CELL_1_24  ( P[23], G[23], P[24], G[24], P1[24], G1[24]);
	 
    BLACK_CELL BLACK_CELL_1_25  ( P[24], G[24], P[25], G[25], P1[25], G1[25]);
    BLACK_CELL BLACK_CELL_1_26  ( P[25], G[25], P[26], G[26], P1[26], G1[26]);
    BLACK_CELL BLACK_CELL_1_27  ( P[26], G[26], P[27], G[27], P1[27], G1[27]);
    BLACK_CELL BLACK_CELL_1_28  ( P[27], G[27], P[28], G[28], P1[28], G1[28]);
	 
    BLACK_CELL BLACK_CELL_1_29  ( P[28], G[28], P[29], G[29], P1[29], G1[29]);
    BLACK_CELL BLACK_CELL_1_30  ( P[29], G[29], P[30], G[30], P1[30], G1[30]);
    BLACK_CELL BLACK_CELL_1_31  ( P[30], G[30], P[31], G[31], P1[31], G1[31]);
	 BLACK_CELL BLACK_CELL_1_32  ( P[31], G[31], P[32], G[32], P1[32], G1[32]);


	 
	 // Level 2
	 GRAY_CELL 	GRAY_CELL_03	(C[1], P1[3], G1[3], C[3]);
	 GRAY_CELL 	GRAY_CELL_04	(C[2], P1[4], G1[4], C[4]);
	 
	 //								  |P_pre-2| G_pre-2|P_cur | G_cur | P_n  |  G_n 
    BLACK_CELL BLACK_CELL_2_05  ( P1[3],  G1[3],  P1[5],  G1[5],  P2[5],  G2[5]);
    BLACK_CELL BLACK_CELL_2_06  ( P1[4],  G1[4],  P1[6],  G1[6],  P2[6],  G2[6]);
    BLACK_CELL BLACK_CELL_2_07  ( P1[5],  G1[5],  P1[7],  G1[7],  P2[7],  G2[7]);
    BLACK_CELL BLACK_CELL_2_08  ( P1[6],  G1[6],  P1[8],  G1[8],  P2[8],  G2[8]);
	 
    BLACK_CELL BLACK_CELL_2_09  ( P1[7], G1[7], P1[9],  G1[9],  P2[9],  G2[9]);
    BLACK_CELL BLACK_CELL_2_10  ( P1[8], G1[8], P1[10], G1[10], P2[10], G2[10]);
    BLACK_CELL BLACK_CELL_2_11  ( P1[9], G1[9], P1[11], G1[11], P2[11], G2[11]);
    BLACK_CELL BLACK_CELL_2_12  ( P1[10], G1[10], P1[12], G1[12], P2[12], G2[12]);
	 
    BLACK_CELL BLACK_CELL_2_13  ( P1[11], G1[11], P1[13], G1[13], P2[13], G2[13]);
    BLACK_CELL BLACK_CELL_2_14  ( P1[12], G1[12], P1[14], G1[14], P2[14], G2[14]);
    BLACK_CELL BLACK_CELL_2_15  ( P1[13], G1[13], P1[15], G1[15], P2[15], G2[15]);
    BLACK_CELL BLACK_CELL_2_16  ( P1[14], G1[14], P1[16], G1[16], P2[16], G2[16]);

    BLACK_CELL BLACK_CELL_2_17  ( P1[15], G1[15], P1[17], G1[17], P2[17], G2[17]);
    BLACK_CELL BLACK_CELL_2_18  ( P1[16], G1[16], P1[18], G1[18], P2[18], G2[18]);
    BLACK_CELL BLACK_CELL_2_19  ( P1[17], G1[17], P1[19], G1[19], P2[19], G2[19]);
    BLACK_CELL BLACK_CELL_2_20  ( P1[18], G1[18], P1[20], G1[20], P2[20], G2[20]);
	 
    BLACK_CELL BLACK_CELL_2_21  ( P1[19], G1[19], P1[21], G1[21], P2[21], G2[21]);
    BLACK_CELL BLACK_CELL_2_22  ( P1[20], G1[20], P1[22], G1[22], P2[22], G2[22]);
    BLACK_CELL BLACK_CELL_2_23  ( P1[21], G1[21], P1[23], G1[23], P2[23], G2[23]);
    BLACK_CELL BLACK_CELL_2_24  ( P1[22], G1[22], P1[24], G1[24], P2[24], G2[24]);
	
    BLACK_CELL BLACK_CELL_2_25  ( P1[23], G1[23], P1[25], G1[25], P2[25], G2[25]);
    BLACK_CELL BLACK_CELL_2_26  ( P1[24], G1[24], P1[26], G1[26], P2[26], G2[26]);
    BLACK_CELL BLACK_CELL_2_27  ( P1[25], G1[25], P1[27], G1[27], P2[27], G2[27]);
    BLACK_CELL BLACK_CELL_2_28  ( P1[26], G1[26], P1[28], G1[28], P2[28], G2[28]);

    BLACK_CELL BLACK_CELL_2_29  ( P1[27], G1[27], P1[29], G1[29], P2[29], G2[29]);
    BLACK_CELL BLACK_CELL_2_30  ( P1[28], G1[28], P1[30], G1[30], P2[30], G2[30]);
    BLACK_CELL BLACK_CELL_2_31  ( P1[29], G1[29], P1[31], G1[31], P2[31], G2[31]);
	 BLACK_CELL BLACK_CELL_2_32  ( P1[30], G1[30], P1[32], G1[32], P2[32], G2[32]);

	 
	 // Level 3 
	 
	 GRAY_CELL 	GRAY_CELL_05	(C[1] , P2[5], G2[5], C[5]);
	 GRAY_CELL 	GRAY_CELL_06	(C[2] , P2[6], G2[6], C[6]);
	 GRAY_CELL 	GRAY_CELL_07	(C[3] , P2[7], G2[7], C[7]);
	 GRAY_CELL 	GRAY_CELL_08	(C[4] , P2[8], G2[8], C[8]);
	 //								 |P_pre-4|G_pre-4|P_cur| G_cur| P_n  |  G_n	 
    BLACK_CELL BLACK_CELL_3_09  ( P2[5], G2[5], P2[9],  G2[9],  P3[9],  G3[9]);
    BLACK_CELL BLACK_CELL_3_10  ( P2[6], G2[6], P2[10], G2[10], P3[10], G3[10]);
    BLACK_CELL BLACK_CELL_3_11  ( P2[7], G2[7], P2[11], G2[11], P3[11], G3[11]);
    BLACK_CELL BLACK_CELL_3_12  ( P2[8], G2[8], P2[12], G2[12], P3[12], G3[12]);
	 
    BLACK_CELL BLACK_CELL_3_13  ( P2[9] , G2[9] , P2[13], G2[13], P3[13], G3[13]);
    BLACK_CELL BLACK_CELL_3_14  ( P2[10], G2[10], P2[14], G2[14], P3[14], G3[14]);
    BLACK_CELL BLACK_CELL_3_15  ( P2[11], G2[11], P2[15], G2[15], P3[15], G3[15]);
    BLACK_CELL BLACK_CELL_3_16  ( P2[12], G2[12], P2[16], G2[16], P3[16], G3[16]);
	
    BLACK_CELL BLACK_CELL_3_17  ( P2[13], G2[13], P2[17], G2[17], P3[17], G3[17]);
    BLACK_CELL BLACK_CELL_3_18  ( P2[14], G2[14], P2[18], G2[18], P3[18], G3[18]);
    BLACK_CELL BLACK_CELL_3_19  ( P2[15], G2[15], P2[19], G2[19], P3[19], G3[19]);
    BLACK_CELL BLACK_CELL_3_20  ( P2[16], G2[16], P2[20], G2[20], P3[20], G3[20]);
	
    BLACK_CELL BLACK_CELL_3_21  ( P2[17], G2[17], P2[21], G2[21], P3[21], G3[21]);
    BLACK_CELL BLACK_CELL_3_22  ( P2[18], G2[18], P2[22], G2[22], P3[22], G3[22]);
    BLACK_CELL BLACK_CELL_3_23  ( P2[19], G2[19], P2[23], G2[23], P3[23], G3[23]);
    BLACK_CELL BLACK_CELL_3_24  ( P2[20], G2[20], P2[24], G2[24], P3[24], G3[24]);
	 
    BLACK_CELL BLACK_CELL_3_25  ( P2[21], G2[21], P2[25], G2[25], P3[25], G3[25]);
    BLACK_CELL BLACK_CELL_3_26  ( P2[22], G2[22], P2[26], G2[26], P3[26], G3[26]);
    BLACK_CELL BLACK_CELL_3_27  ( P2[23], G2[23], P2[27], G2[27], P3[27], G3[27]);
    BLACK_CELL BLACK_CELL_3_28  ( P2[24], G2[24], P2[28], G2[28], P3[28], G3[28]); 
	 
    BLACK_CELL BLACK_CELL_3_29  ( P2[25], G2[25], P2[29], G2[29], P3[29], G3[29]);
    BLACK_CELL BLACK_CELL_3_30  ( P2[26], G2[26], P2[30], G2[30], P3[30], G3[30]);
    BLACK_CELL BLACK_CELL_3_31  ( P2[27], G2[27], P2[31], G2[31], P3[31], G3[31]);
	 BLACK_CELL BLACK_CELL_3_32  ( P2[28], G2[28], P2[32], G2[32], P3[32], G3[32]);

	 
	 // Level 4
	 
    GRAY_CELL 	GRAY_CELL_09	(C[1], P3[9],  G3[9],  C[9]);
    GRAY_CELL 	GRAY_CELL_10	(C[2], P3[10], G3[10], C[10]);
    GRAY_CELL 	GRAY_CELL_11	(C[3], P3[11], G3[11], C[11]);
    GRAY_CELL 	GRAY_CELL_12	(C[4], P3[12], G3[12], C[12]);
    GRAY_CELL 	GRAY_CELL_13	(C[5], P3[13], G3[13], C[13]);
    GRAY_CELL 	GRAY_CELL_14	(C[6], P3[14], G3[14], C[14]);
    GRAY_CELL 	GRAY_CELL_15	(C[7], P3[15], G3[15], C[15]);
    GRAY_CELL 	GRAY_CELL_16	(C[8], P3[16], G3[16], C[16]);
	 //								 |P_pre-8|G_pre-8|P_cur| G_cur| P_n  |  G_n 
    BLACK_CELL BLACK_CELL_4_17  ( P3[9] , G3[9] , P3[17], G3[17], P4[17], G4[17]);
    BLACK_CELL BLACK_CELL_4_18  ( P3[10], G3[10], P3[18], G3[18], P4[18], G4[18]);
    BLACK_CELL BLACK_CELL_4_19  ( P3[11], G3[11], P3[19], G3[19], P4[19], G4[19]);
    BLACK_CELL BLACK_CELL_4_20  ( P3[12], G3[12], P3[20], G3[20], P4[20], G4[20]);
	 
    BLACK_CELL BLACK_CELL_4_21  ( P3[13], G3[13], P3[21], G3[21], P4[21], G4[21]);
    BLACK_CELL BLACK_CELL_4_22  ( P3[14], G3[14], P3[22], G3[22], P4[22], G4[22]);
    BLACK_CELL BLACK_CELL_4_23  ( P3[15], G3[15], P3[23], G3[23], P4[23], G4[23]);
    BLACK_CELL BLACK_CELL_4_24  ( P3[16], G3[16], P3[24], G3[24], P4[24], G4[24]);
	 
    BLACK_CELL BLACK_CELL_4_25  ( P3[17], G3[17], P3[25], G3[25], P4[25], G4[25]);
    BLACK_CELL BLACK_CELL_4_26  ( P3[18], G3[18], P3[26], G3[26], P4[26], G4[26]);
    BLACK_CELL BLACK_CELL_4_27  ( P3[19], G3[19], P3[27], G3[27], P4[27], G4[27]);
    BLACK_CELL BLACK_CELL_4_28  ( P3[20], G3[20], P3[28], G3[28], P4[28], G4[28]);
	 
    BLACK_CELL BLACK_CELL_4_29  ( P3[21], G3[21], P3[29], G3[29], P4[29], G4[29]);
    BLACK_CELL BLACK_CELL_4_30  ( P3[22], G3[22], P3[30], G3[30], P4[30], G4[30]);
    BLACK_CELL BLACK_CELL_4_31  ( P3[23], G3[23], P3[31], G3[31], P4[31], G4[31]);
	 BLACK_CELL BLACK_CELL_4_32  ( P3[24], G3[24], P3[32], G3[32], P4[32], G4[32]);

	 
	 // Level 5
	 //							   |G_pre-16|P_cur| G_cur|  G_n 
	 GRAY_CELL 	GRAY_CELL_17	(C[1],  P4[17], G4[17], C[17]);
    GRAY_CELL 	GRAY_CELL_18	(C[2],  P4[18], G4[18], C[18]);
    GRAY_CELL 	GRAY_CELL_19	(C[3],  P4[19], G4[19], C[19]);
    GRAY_CELL 	GRAY_CELL_20	(C[4],  P4[20], G4[20], C[20]);
	 
    GRAY_CELL 	GRAY_CELL_21	(C[5],  P4[21], G4[21], C[21]);
    GRAY_CELL 	GRAY_CELL_22	(C[6],  P4[22], G4[22], C[22]);
    GRAY_CELL 	GRAY_CELL_23	(C[7],  P4[23], G4[23], C[23]);
    GRAY_CELL 	GRAY_CELL_24	(C[8],  P4[24], G4[24], C[24]);
	 
    GRAY_CELL 	GRAY_CELL_25	(C[9],  P4[25], G4[25], C[25]);
    GRAY_CELL 	GRAY_CELL_26	(C[10], P4[26], G4[26], C[26]);
    GRAY_CELL 	GRAY_CELL_27	(C[11], P4[27], G4[27], C[27]);
    GRAY_CELL 	GRAY_CELL_28	(C[12], P4[28], G4[28], C[28]); 
	
    GRAY_CELL 	GRAY_CELL_29	(C[13], P4[29], G4[29], C[29]);
    GRAY_CELL 	GRAY_CELL_30	(C[14], P4[30], G4[30], C[30]);
    GRAY_CELL 	GRAY_CELL_31	(C[15], P4[31], G4[31], C[31]);
    GRAY_CELL 	GRAY_CELL_32	(C[16], P4[32], G4[32], C[32]);

	 
    // Post-processing stage: Compute Sum
	 
	 // Calculate Sum[31:0]
	 assign Sum[0] = Cin ^ P[1];
    assign Sum[31:1] = C[31:1] ^ P[32:2];
	 
	 // Calculate Cout
	 assign Cout = C[32];
	 

endmodule

//--------------------------------Black Cell---------------------------

module BLACK_CELL
(
	input P_pre, G_pre,
	input P_cur, G_cur,
	output P_n, G_n
);

assign G_n = G_cur | ( P_cur & G_pre) ; 
assign P_n = P_pre & P_cur ;

endmodule

//--------------------------------Gray Cell---------------------------

module GRAY_CELL
(
	input G_pre,
	input P_cur, G_cur,
	output G_n
);

assign G_n = G_cur | ( P_cur & G_pre) ; 

endmodule




