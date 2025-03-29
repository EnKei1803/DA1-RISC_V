module REGISTER_FILE 
(
	input [4:0] A1, A2, A3,		// Select Register 
	input [31:0] WD3,				// Data for write to the Register
	input clk, nrst,				// CLK and RESET LOW
	input WE3,						// Write Enable
	output [31:0] RD1, RD2		// Output data of A1 and A2
);


// Select which REGISTER is taked value
wire [31:0] REG1, REG2, REG_S;

// Decode to know which REGISTER is selected
DECODER_5_to_32 DECODER_5_to_32_REG1 (A1, REG1);
DECODER_5_to_32 DECODER_5_to_32_REG2 (A2, REG2);

DECODER_5_to_32 DECODER_5_to_32_REG_S (A3, decoder_output);
											
// Register ARRAY 0 to 31
// Specially, R0 == 0 <=> ZeroREG

wire [31:1] WE;
wire [31:0] decoder_output;
				 
	assign R0 = 32'b0;			
	assign REG_S = decoder_output & ~32'b1;  	// Always disable R0 selection

	assign WE[31:1] = REG_S[31:1] & {31{WE3}};		// Write enable for writen REGISTER
	
//									  R   Rin_en  clk  nrst  Q	
REG_32bits	REG_32bits_R1  (WD3, WE[1],  clk, nrst, R1);
REG_32bits	REG_32bits_R2  (WD3, WE[2],  clk, nrst, R2);
REG_32bits	REG_32bits_R3  (WD3, WE[3],  clk, nrst, R3);
REG_32bits	REG_32bits_R4  (WD3, WE[4],  clk, nrst, R4);
REG_32bits	REG_32bits_R5  (WD3, WE[5],  clk, nrst, R5);
REG_32bits	REG_32bits_R6  (WD3, WE[6],  clk, nrst, R6);
REG_32bits	REG_32bits_R7  (WD3, WE[7],  clk, nrst, R7);
REG_32bits	REG_32bits_R8  (WD3, WE[8],  clk, nrst, R8);
REG_32bits	REG_32bits_R9  (WD3, WE[9],  clk, nrst, R9);
REG_32bits	REG_32bits_R10 (WD3, WE[10], clk, nrst, R10);
REG_32bits	REG_32bits_R11 (WD3, WE[11], clk, nrst, R11);
REG_32bits	REG_32bits_R12 (WD3, WE[12], clk, nrst, R12);
REG_32bits	REG_32bits_R13 (WD3, WE[13], clk, nrst, R13);
REG_32bits	REG_32bits_R14 (WD3, WE[14], clk, nrst, R14);
REG_32bits	REG_32bits_R15 (WD3, WE[15], clk, nrst, R15);
REG_32bits	REG_32bits_R16 (WD3, WE[16], clk, nrst, R16);
REG_32bits	REG_32bits_R17 (WD3, WE[17], clk, nrst, R17);
REG_32bits	REG_32bits_R18 (WD3, WE[18], clk, nrst, R18);
REG_32bits	REG_32bits_R19 (WD3, WE[19], clk, nrst, R19);
REG_32bits	REG_32bits_R20 (WD3, WE[20], clk, nrst, R20);
REG_32bits	REG_32bits_R21 (WD3, WE[21], clk, nrst, R21);
REG_32bits	REG_32bits_R22 (WD3, WE[22], clk, nrst, R22);
REG_32bits	REG_32bits_R23 (WD3, WE[23], clk, nrst, R23);
REG_32bits	REG_32bits_R24 (WD3, WE[24], clk, nrst, R24);
REG_32bits	REG_32bits_R25 (WD3, WE[25], clk, nrst, R25);
REG_32bits	REG_32bits_R26 (WD3, WE[26], clk, nrst, R26);
REG_32bits	REG_32bits_R27 (WD3, WE[27], clk, nrst, R27);
REG_32bits	REG_32bits_R28 (WD3, WE[28], clk, nrst, R28);
REG_32bits	REG_32bits_R29 (WD3, WE[29], clk, nrst, R29);
REG_32bits	REG_32bits_R30 (WD3, WE[30], clk, nrst, R30);
REG_32bits	REG_32bits_R31 (WD3, WE[31], clk, nrst, R31);

wire [31:0] R0,  R1,  R2,  R3,  R4,  R5,  R6,  R7,
             R8,  R9,  R10, R11, R12, R13, R14, R15,
             R16, R17, R18, R19, R20, R21, R22, R23,
             R24, R25, R26, R27, R28, R29, R30, R31;

// Get data from selected REGISTER
MULT_32X1 MULT_32X1_REG1 (REG1, 	R0,  R1,  R2,  R3,  R4,  R5,  R6,  R7,
											R8,  R9,  R10, R11, R12, R13, R14, R15,
											R16, R17, R18, R19, R20, R21, R22, R23,
											R24, R25, R26, R27, R28, R29, R30, R31, RD1);
											
MULT_32X1 MULT_32X1_REG2 (REG2, 	R0,  R1,  R2,  R3,  R4,  R5,  R6,  R7,
											R8,  R9,  R10, R11, R12, R13, R14, R15,
											R16, R17, R18, R19, R20, R21, R22, R23,
											R24, R25, R26, R27, R28, R29, R30, R31, RD2);


endmodule 

//--------------------------------DECODER 5 to 32------------------------------------

module DECODER_5_to_32 (
    input  [4:0] A,  // 5-bit input
    output [31:0] Y  // 32-bit output
); 

always @(*) begin 
    case (A) 
        5'b00000: Y = 32'b00000000000000000000000000000001; // R0
        5'b00001: Y = 32'b00000000000000000000000000000010; // R1
        5'b00010: Y = 32'b00000000000000000000000000000100; // R2
        5'b00011: Y = 32'b00000000000000000000000000001000; // R3
        5'b00100: Y = 32'b00000000000000000000000000010000; // R4
        5'b00101: Y = 32'b00000000000000000000000000100000; // R5
        5'b00110: Y = 32'b00000000000000000000000001000000; // R6
        5'b00111: Y = 32'b00000000000000000000000010000000; // R7
        5'b01000: Y = 32'b00000000000000000000000100000000; // R8
        5'b01001: Y = 32'b00000000000000000000001000000000; // R9
        5'b01010: Y = 32'b00000000000000000000010000000000; // R10
        5'b01011: Y = 32'b00000000000000000000100000000000; // R11
        5'b01100: Y = 32'b00000000000000000001000000000000; // R12
        5'b01101: Y = 32'b00000000000000000010000000000000; // R13
        5'b01110: Y = 32'b00000000000000000100000000000000; // R14
        5'b01111: Y = 32'b00000000000000001000000000000000; // R15
        5'b10000: Y = 32'b00000000000000010000000000000000; // R16
        5'b10001: Y = 32'b00000000000000100000000000000000; // R17
        5'b10010: Y = 32'b00000000000001000000000000000000; // R18
        5'b10011: Y = 32'b00000000000010000000000000000000; // R19
        5'b10100: Y = 32'b00000000000100000000000000000000; // R20
        5'b10101: Y = 32'b00000000001000000000000000000000; // R21
        5'b10110: Y = 32'b00000000010000000000000000000000; // R22
        5'b10111: Y = 32'b00000000100000000000000000000000; // R23
        5'b11000: Y = 32'b00000001000000000000000000000000; // R24
        5'b11001: Y = 32'b00000010000000000000000000000000; // R25
        5'b11010: Y = 32'b00000100000000000000000000000000; // R26
        5'b11011: Y = 32'b00001000000000000000000000000000; // R27
        5'b11100: Y = 32'b00010000000000000000000000000000; // R28
        5'b11101: Y = 32'b00100000000000000000000000000000; // R29
        5'b11110: Y = 32'b01000000000000000000000000000000; // R30
        5'b11111: Y = 32'b10000000000000000000000000000000; // R31
        default:  Y = 32'b0; // Default case (should never happen)
    endcase 
end 

endmodule  

//--------------------------------Multiplexer------------------------------------

module MULT_32X1 
(
input [31:0] sel,
input [31:0] R0,  R1,  R2,  R3,  R4,  R5,  R6,  R7,
             R8,  R9,  R10, R11, R12, R13, R14, R15,
             R16, R17, R18, R19, R20, R21, R22, R23,
             R24, R25, R26, R27, R28, R29, R30, R31,
output [31:0] bus		// Value of Register 
);

always_comb begin
	case (sel)
        32'b00000000000000000000000000000001: bus = R0;  // R0
        32'b00000000000000000000000000000010: bus = R1;  // R1
        32'b00000000000000000000000000000100: bus = R2;  // R2
        32'b00000000000000000000000000001000: bus = R3;  // R3
        32'b00000000000000000000000000010000: bus = R4;  // R4
        32'b00000000000000000000000000100000: bus = R5;  // R5
        32'b00000000000000000000000001000000: bus = R6;  // R6
        32'b00000000000000000000000010000000: bus = R7;  // R7
        32'b00000000000000000000000100000000: bus = R8;  // R8
        32'b00000000000000000000001000000000: bus = R9;  // R9
        32'b00000000000000000000010000000000: bus = R10; // R10
        32'b00000000000000000000100000000000: bus = R11; // R11
        32'b00000000000000000001000000000000: bus = R12; // R12
        32'b00000000000000000010000000000000: bus = R13; // R13
        32'b00000000000000000100000000000000: bus = R14; // R14
        32'b00000000000000001000000000000000: bus = R15; // R15
        32'b00000000000000010000000000000000: bus = R16; // R16
        32'b00000000000000100000000000000000: bus = R17; // R17
        32'b00000000000001000000000000000000: bus = R18; // R18
        32'b00000000000010000000000000000000: bus = R19; // R19
        32'b00000000000100000000000000000000: bus = R20; // R20
        32'b00000000001000000000000000000000: bus = R21; // R21
        32'b00000000010000000000000000000000: bus = R22; // R22
        32'b00000000100000000000000000000000: bus = R23; // R23
        32'b00000001000000000000000000000000: bus = R24; // R24
        32'b00000010000000000000000000000000: bus = R25; // R25
        32'b00000100000000000000000000000000: bus = R26; // R26
        32'b00001000000000000000000000000000: bus = R27; // R27
        32'b00010000000000000000000000000000: bus = R28; // R28
        32'b00100000000000000000000000000000: bus = R29; // R29
        32'b01000000000000000000000000000000: bus = R30; // R30
        32'b10000000000000000000000000000000: bus = R31; // R31
        default:  bus = 32'b0; // Default value
    endcase 
end 


endmodule













