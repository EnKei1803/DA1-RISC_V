module wrapper
(
	input nrst, run, clk,		// Signal from SW
	input [7:0] SW, 				// SW input
	output [7:0]	hundreds,	// Value send to 7SegLed
						tens, 
						units
);
	
Top wrapper_top (
						// Use
						.run(run),
						.clk(clk),
						.nrst(nrst),
						.SW(SW),
						.hundreds(hundreds),
						.tens(tens),
						.units(units),	
						
						// Un_use
						.ALUResult(), 
						.Result(), 
						.SrcA(), 
						.SrcB(), 
						.PC()
);									
						
endmodule 