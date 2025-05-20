module wrapper
(
	input nrst, run, clk,		// Signal from SW
	input [7:0] SW, 				// SW input
	output [6:0]	hundreds,	// Value send to 7SegLed
						tens, 
						units,
	output [9:0] LEDR	
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
						.PC(),
						.WE1(),
						.RD_7SegLed(),
						.RS2(), 
						.IO_Data(),
						.WD2()
						
);									
						
assign LEDR[9:0] = {SW[7:0], run, nrst};						
						
						
						
endmodule 