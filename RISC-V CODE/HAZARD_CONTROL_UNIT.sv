module HAZARD_CONTROL_UNIT
(
	input [4:0] 	Rs1E,
	input [4:0] 	Rs2E,
	input [4:0] 	RdM,
	input [4:0] 	RdW,
	input [1:0] 	ResultSrcE,
	input 			RegWriteM,
	input 			RegWriteW,
	input 			PCSrcE,

	output logic [1:0] 	ForwardAE,
	output logic [1:0] 	ForwardBE,
	
	output			StallF,
	output			StallD,
	
	output			FlushD,
	output			FlushE
);

	// ======== Forwarding ========
 
 
	// Forwarding for operand A (Rs1E)
	always_comb begin
	
		// Forward ALUResultM from MEM stage
		if (((Rs1E == RdM) && RegWriteM) && (Rs1E != 5'd0))
			  ForwardAE = 2'b10;
			  
		// Forward ResultW from WB stage
		else if (((Rs1E == RdW) && RegWriteW) && (Rs1E != 5'd0))
			  ForwardAE = 2'b01;	
			  
		// No forwarding			  
		else
			  ForwardAE = 2'b00;												
	end

	// Forwarding for operand B (Rs2E)
	always_comb begin
		 if (((Rs2E == RdM) && RegWriteM) && (Rs2E != 5'd0))
			  ForwardBE = 2'b10;
		 else if (((Rs2E == RdW) && RegWriteW) && (Rs2E != 5'd0))
			  ForwardBE = 2'b01;
		 else
			  ForwardBE = 2'b00;
	end

	
	// ======== Load Stall ======== 
	
	logic lwStall;

	assign lwStall = ~ResultSrcE[1] & ResultSrcE[0];
	assign StallF = lwStall;		// Stall Fetch stage
	assign StallD = lwStall;		// Stall Decode stage


	
	// ======== Control Hazard ======== 
	
	// Flush Decode stage if branch taken
	assign FlushD = PCSrcE;

	// Flush Execute stage if branch or load hazard
	assign FlushE = PCSrcE | lwStall;


endmodule 