module ADDER_4bits (
    input  [3:0] A, B,
    output [3:0] Sum,
    output Cout
);
    logic [3:0] G, P;   // Generate and Propagate signals
    logic [3:1] C;      // Carry signals

    // **Pre-processing stage:** Compute Generate & Propagate
    assign G = A & B;    // Generate
    assign P = A ^ B;    // Propagate

	 
	 
    // **Prefix Computation Stage (Carry Calculation)**
    logic [3:2] G1, P1; 

    // Compute carry bits using Gray and Black Cells
    assign C[1] = G[0];  // First carry-out comes directly from G[0]

    GRAY_CELL 	GRAY_CELL_02	(C[1], P[1], G[1], C[2]);	 
    BLACK_CELL  BLACK_CELL_1_03  (P[1], G[1], P[2], G[2], P1[2], G1[2]);
    BLACK_CELL  BLACK_CELL_1_04  (P[2], G[2], P[3], G[3], P1[3], G1[3]);

    // Level 2 (Final Carry)
    GRAY_CELL 	GRAY_CELL_03	(C[1], P1[2], G1[2], C[3]);
    GRAY_CELL 	GRAY_CELL_04	(C[2], P1[3], G1[3], Cout);  // Final Carry-out

	 
	 
    // **Post-processing stage:** Compute Sum
    assign Sum[0] = P[0];          
    assign Sum[3:1] = C[3:1] ^ P[3:1];  
endmodule
