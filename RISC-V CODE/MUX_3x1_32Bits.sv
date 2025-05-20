module MUX_3x1_32Bits
(
	input [1:0]s,
	input [31:0] I0, I1, I2, I3,
	output [31:0] Y
);

    always @(*) begin
        case (s)
            2'b00: Y = I0;  
            2'b01: Y = I1;   
				2'b10: Y = I2;
				2'b11: Y = I3;
            default: Y = 32'b0; // Default (invalid case)
        endcase
    end	
	 
endmodule 