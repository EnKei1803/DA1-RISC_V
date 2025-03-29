//--------------------------------MUX 2x1------------------------------------

module MUX_2x1
(
	input s,
	input I0, I1,
	output Y
);

assign Y =	 s & I1 |			
				~s & I0 ;			
				
endmodule 