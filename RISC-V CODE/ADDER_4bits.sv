module ADDER_4bits (
    input  [3:0] A, B,
    output [3:0] Sum,
    output       Cout
);

    logic [4:1] G, P;   // Generate & Propagate
    logic [4:1] C;      // Carry

    // Pre-processing
    assign G = A & B;
    assign P = A ^ B;

    // Cin = 0
    assign C[1] = G[1];

    // Level 1
    logic G1_2, P1_2;
    BLACK_CELL BC1_2 (P[1], G[1], P[2], G[2], P1_2, G1_2);
    GRAY_CELL  GC2   (C[1], P1_2, G1_2, C[2]);

    // Level 2
    logic G2_3, P2_3;
    BLACK_CELL BC2_3 (P1_2, G1_2, P[3], G[3], P2_3, G2_3);
    GRAY_CELL  GC3   (C[1], P2_3, G2_3, C[3]);

    logic G3_4, P3_4;
    BLACK_CELL BC2_4 (P2_3, G2_3, P[4], G[4], P3_4, G3_4);
    GRAY_CELL  GC4   (C[1], P3_4, G3_4, C[4]);

    // Post-processing: sum and carry out
    assign Sum[0] = P[1];           // Cin = 0, so Sum[0] = A[0] ^ B[0]
    assign Sum[1] = C[1] ^ P[2];
    assign Sum[2] = C[2] ^ P[3];
    assign Sum[3] = C[3] ^ P[4];
    assign Cout   = C[4];

endmodule
