module BinToBCD
(
	input [7:0] A,
	output [11:0] B
);

logic [3:0] C1, C2, C3, C4, C5, C6, C7;
logic zero;
 
assign zero = 1'b0;

ADD3 ADD3_1 (.A({zero, A[7:5]}), .B(C1));

ADD3 ADD3_2 (.A({C1[2:0], A[4]}), .B(C2));

ADD3 ADD3_3 (.A({C2[2:0], A[3]}), .B(C3));

ADD3 ADD3_4 (.A({C3[2:0], A[2]}), .B(C4));

ADD3 ADD3_5 (.A({zero, C1[3], C2[3], C3[3]}), .B(C5));

ADD3 ADD3_6 (.A({C4[2:0], A[1]}), .B(C6));

ADD3 ADD3_7 (.A({C5[2:0], C4[3]}), .B(C7));


assign B = {zero, zero, C5[3], C7[3:0], C6[3:0], A[0]};


endmodule 


//-----------------ADD_3_Conditional------------------

module ADD3
(
	input [3:0] A,
	output [3:0] B
);

logic [3:0] three, four;
logic null1, null2, null3, sel;
logic [3:0] sum;

assign three = 4'b0011;
assign four = 4'b0100;

MUX_ADD3	MUX_ADDCondition (.s(sel), .I0(A), .I1(sum), .Y(B));


COMPARATOR_4bits	Compa (.A(A), .B(four), .E(null1), .G(sel), .L(null2));


ADDER_4bits	ADD3 (.A(A), .B(three), .Sum(sum), .Cout(null3));



endmodule 


//-----------------ADD_3_Conditional------------------

module MUX_ADD3
(
	input s,
	input [3:0] I0, I1,
	output [3:0] Y
);


    always @(*) begin
        case (s)
            1'b0: Y = I0;  
            1'b1: Y = I1;   
            default: Y = 4'b0; // Default (invalid case)
        endcase
    end	
	 
endmodule 