module MUX_2x1_32Bits
(
	input s,
	input [31:0] I0, I1,
	output [31:0] Y
);

    always @(*) begin
        case (s)
            1'b0: Y = I0;  
            1'b1: Y = I1;   
            default: Y = 32'b0; // Default (invalid case)
        endcase
    end	
	 
endmodule 