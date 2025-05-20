module IO_Block
(
	// Default IN-OUT 
	input clk, nrst,
	input [31:0] A,			// Address 
	input [31:0] RD,			// Write Data (IN)
	input WE, MREQ, 			// Write Enbale
	output [31:0] IO_Data,	// Read Data (OUT)
	
	// IN-OUT from device
	input [7:0] SW,			// SW input
	output [6:0] hundreds,	// Value send to 7SegLed
					 tens, 
					 units,
	output WE1,
	output [31:0] RD_7SegLed
);

// Wire
logic Select_SW, Select_SW1;
logic Select_7SegLed, Select_7SegLed1;
logic [31:0] RD_SW, RD_7Seg;

// CSE
Select_SW		IO_SW1		(.addr_in(A), .Select_SW(Select_SW1));
assign Select_SW = Select_SW1 & MREQ;

Select_7SegLed	IO_7SegLed1	(.addr_in(A), .Select_7SegLed(Select_7SegLed1));
assign Select_7SegLed = Select_7SegLed1 & MREQ;

// I/O
IO_SW	IN_OUT_SW	(
						.CSE(Select_SW),
						.SW(SW),
						.RD(RD_SW)
						
);

IO_7SegLed	IN_OUT_7SegLed(
									.CSE(Select_7SegLed),
									.WE(WE),
									.WD(RD),
									.RD(RD_7Seg),
									.RD_7SegLed(RD_7SegLed),
									.hundreds(hundreds),
									.tens(tens),
									.units(units),
									.WE1(WE1),
									.clk(clk),
									.nrst(nrst)
									
);

assign IO_Data = RD_SW | RD_7Seg;

endmodule 

//===========================Select SWITCH===========================

module Select_SW
(
	input [31:0] addr_in,	// Address for MEM
	output Select_SW
);


assign Select_SW =  (addr_in == 32'hFFFF_FFF0);

endmodule 

//===========================I/O SWITCH===========================

module IO_SW
(
	input CSE, 					// Chip Set Enable 
	input [7:0] SW,			// SW value 
	output [31:0] RD			// Data out (use for store in memory)
);

logic [31:0] RD1;

assign RD1 = {24'b0, SW[7:0]};

// CSE = 0 (Not select device) => No output data
// CSE = 1 (Select device) => output data = RD1
assign RD = RD1 & {32{CSE}};

endmodule 

//===========================Select 7SegLed===========================

module Select_7SegLed
(
	input [31:0] addr_in,	// Address for MEM
	output Select_7SegLed
);

assign Select_7SegLed =  (addr_in == 32'hFFFF_FFF8);

endmodule 

//===========================I/O 7SegLed===========================

module IO_7SegLed
(
	input CSE, 							// Chip Set Enable 
	input clk, nrst, WE,
	input [31:0] WD,					// Value use for calculate before display
	output [31:0] RD,					// Data out (use for store in memory)
	output [31:0] RD_7SegLed,
	output [6:0] hundreds,			// Value send to 7SegLed
					 tens, 
					 units,
	output WE1
);

// Wire 
// logic [31:0] RD_7SegLed;
logic [11:0] BCD;
//logic WE1;


// Calculate WE1
// WE = 1 : Store	=> Store to Memory
// WE = 0 : Load	=> Load to Register of 7SegLed
assign WE1 = ~WE & CSE;



// Temporary Register to Store data for display
always @(posedge clk or negedge nrst) begin
	if (!nrst) begin							
			RD_7SegLed <= {32'b0};
		end
		else 
	if (WE1 == 1'b1) begin						
			RD_7SegLed <= WD;										
	end
end


// CSE = 0 (Not select device) => No output data
// CSE = 1 (Select device) => output data = RD_7SegLed
assign RD = RD_7SegLed & {32{WE1}};


// Convert Binary to BCD 
BinToBCD	BinConvert (
							.A(RD_7SegLed[7:0]),		// input Binary value
							.B(BCD)				// BCD output
);

// BCD to 7SegLed
BCDto7SegLED	BCD_7SegLed (
									.BCD(BCD),
									.hundreds(hundreds),
									.tens(tens),
									.units(units)
);


endmodule 

