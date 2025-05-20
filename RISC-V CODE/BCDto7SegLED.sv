module BCDto7SegLED
(
	input [11:0] BCD,
	output [6:0] hundreds, tens, units
);

// Extract each BCD digit
logic [3:0] BCD_hundreds;
logic [3:0] BCD_tens;
logic [3:0] BCD_units;

assign BCD_hundreds = BCD[11:8];
assign BCD_tens     = BCD[7:4];
assign BCD_units    = BCD[3:0];

// Instantiate 3 decoders for each digit
BCD_Decode	decoder_h	(.BCD(BCD_hundreds), .seg(hundreds));
BCD_Decode	decoder_t	(.BCD(BCD_tens), 		.seg(tens));
BCD_Decode	decoder_u	(.BCD(BCD_units), 	.seg(units));

endmodule

//=========================Deode BCD to SegLed value=========================


module BCD_Decode
(
	input  [3:0] BCD,
	output reg [6:0] seg
);

    always @(*) begin
        case (BCD)
            4'b0000: seg = 7'b1000000;	// 0
            4'b0001: seg = 7'b1111001;	// 1
            4'b0010: seg = 7'b0100100;	// 2
            4'b0011: seg = 7'b0110000;	// 3
            4'b0100: seg = 7'b0011001;	// 4
            4'b0101: seg = 7'b0010010;	// 5
            4'b0110: seg = 7'b0000010;	// 6
            4'b0111: seg = 7'b1111000;	// 7
            4'b1000: seg = 7'b0000000;	// 8
            4'b1001: seg = 7'b0010000;	// 9
            default: seg = 7'b1111111;  // blank (all segments off)
        endcase
    end

endmodule

