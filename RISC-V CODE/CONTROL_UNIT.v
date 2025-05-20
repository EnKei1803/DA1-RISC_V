module CONTROL_UNIT
(
	// Main Decoder
	input [6:0]op,
	input BrEn,
	output [1:0]ResultSrc,
	output [2:0]ImmSrc,
	output MemWrite, ALUSrcA, ALUSrcB, RegWrite, PCSrc, PCTargetSrc, MREQ,

	// ALU Decoder
	input [2:0]funct3,
	input funct7,
	output [3:0]ALUControl, SLControl,
	output [2:0]BrCtrl
);

wire [1:0]ALUOp;
wire Branch, Jump;

Main_Decoder Main_Decode_out	(	.op(op),
											.ResultSrc(ResultSrc),
											.ImmSrc(ImmSrc),
											.Branch(Branch),
											.Jump(Jump),
											.PCTargetSrc(PCTargetSrc),
											.MemWrite(MemWrite),
											.ALUSrcA(ALUSrcA),
											.ALUSrcB(ALUSrcB),
											.RegWrite(RegWrite),	
											.ALUOp(ALUOp),
											.MREQ(MREQ)
											);


ALU_Decoder ALU_Decoder_out	(	.ALUOp(ALUOp),
											.funct3(funct3),
											.op5(op[5]),
											.funct7(funct7),
											.ALUControl(ALUControl),
											.BrCtrl(BrCtrl),
											.SLControl(SLControl)
);

assign PCSrc = (BrEn & Branch) | Jump;


endmodule


//--------------------------------Main_Decoder------------------------------------

module Main_Decoder 
(
	input [6:0]op,
	output reg [1:0]ResultSrc, ALUOp,
	output reg [2:0]ImmSrc,
	output reg Branch, Jump, MemWrite, ALUSrcA, ALUSrcB, RegWrite, PCTargetSrc, MREQ
);

always @(*) begin
    case (op)
        7'b0000011: begin // lb, lh, lw, lbu, lhu
            RegWrite		= 1'b1;
            ImmSrc    	= 3'b000;
            ALUSrcB   	= 1'b1;
            ALUSrcA   	= 1'b0;
            MemWrite  	= 1'b0;
            ResultSrc 	= 2'b01;
            Branch    	= 1'b0;
            Jump      	= 1'b0;
				PCTargetSrc	= 1'b0;
            ALUOp			= 2'b00;
				MREQ			= 1'b1;
        end
        7'b0010011: begin // I-type imm (e.g., addi, ori)
            RegWrite  	= 1'b1;
            ImmSrc    	= 3'b000;
            ALUSrcB   	= 1'b1;
            ALUSrcA   	= 1'b0;
            MemWrite  	= 1'b0;
            ResultSrc 	= 2'b00;
            Branch    	= 1'b0;
            Jump      	= 1'b0;
				PCTargetSrc	= 1'b0;
            ALUOp     	= 2'b10;
				MREQ			= 1'b0;
        end
		  7'b0010111: begin // auipc
            RegWrite  	= 1'b1;
            ImmSrc    	= 3'b100;
            ALUSrcB   	= 1'b1;
            ALUSrcA   	= 1'b1;
            MemWrite  	= 1'b0;
            ResultSrc 	= 2'b00;
            Branch    	= 1'b0;
            Jump      	= 1'b0;
				PCTargetSrc	= 1'b0;
            ALUOp     	= 2'b11;
				MREQ			= 1'b0;
        end
		  7'b0100011: begin // sb, sh, sw
            RegWrite  	= 1'b0;
            ImmSrc    	= 3'b001;
            ALUSrcB   	= 1'b1;
            ALUSrcA   	= 1'b0;
            MemWrite  	= 1'b1;
            ResultSrc 	= 2'bxx;
            Branch    	= 1'b0;
            Jump      	= 1'b0;
				PCTargetSrc	= 1'b0;
            ALUOp     	= 2'b00;
				MREQ			= 1'b1;
        end
		  7'b0110011: begin // R-type (e.g., add, or, sll)
            RegWrite  	= 1'b1;
            ImmSrc    	= 3'bxxx;
            ALUSrcB   	= 1'b0;
            ALUSrcA   	= 1'b0;
            MemWrite  	= 1'b1;
            ResultSrc 	= 2'b00;
            Branch    	= 1'b0;
            Jump      	= 1'b0;
				PCTargetSrc	= 1'b0;
            ALUOp     	= 2'b10;
				MREQ			= 1'b0;
        end
		  7'b0110111: begin // lui
            RegWrite  	= 1'b1;
            ImmSrc    	= 3'b100;
            ALUSrcB   	= 1'b0;
            ALUSrcA   	= 1'b0;
            MemWrite  	= 1'b0;
            ResultSrc 	= 2'b11;
            Branch    	= 1'b0;
            Jump      	= 1'b0;
				PCTargetSrc	= 1'b0;
            ALUOp     	= 2'b11;
				MREQ			= 1'b0;
        end
		  7'b1100011: begin // B-type
            RegWrite  	= 1'b0;
            ImmSrc    	= 3'b010;
            ALUSrcB   	= 1'b0;
            ALUSrcA   	= 1'b0;
            MemWrite  	= 1'b0;
            ResultSrc 	= 2'bxx;
            Branch    	= 1'b1;
            Jump      	= 1'b0;
				PCTargetSrc	= 1'b0;
            ALUOp     	= 2'b01;
				MREQ			= 1'b0;
        end
		  7'b1100111: begin // jalr
            RegWrite  	= 1'b1;
            ImmSrc    	= 3'b000;
            ALUSrcB   	= 1'b1;
            ALUSrcA   	= 1'b0;
            MemWrite  	= 1'b0;
            ResultSrc 	= 2'b10;
            Branch    	= 1'b0;
            Jump      	= 1'b1;
				PCTargetSrc	= 1'b1;
            ALUOp     	= 2'b01;
				MREQ			= 1'b0;
        end
		  7'b1101111: begin // jal
            RegWrite  	= 1'b1;
            ImmSrc    	= 3'b011;
            ALUSrcB   	= 1'bx;
            ALUSrcA   	= 1'b0;
            MemWrite  	= 1'b0;
            ResultSrc 	= 2'b10;
            Branch    	= 1'b0;
            Jump      	= 1'b1;
				PCTargetSrc	= 1'b0;
            ALUOp     	= 2'bxx;
				MREQ			= 1'b0;
        end		  
        default: begin
            RegWrite  	= 1'b0;
            ImmSrc    	= 3'b000;
            ALUSrcB   	= 1'b0;
            ALUSrcA   	= 1'b0;
            MemWrite  	= 1'b0;
            ResultSrc 	= 2'b00;
            Branch    	= 1'b0;
            Jump      	= 1'b0;
				PCTargetSrc	= 1'b0;
            ALUOp     	= 2'b00;
				MREQ			= 1'b0;
        end
    endcase
end




endmodule

//--------------------------------ALU_Decoder------------------------------------


module ALU_Decoder 
(
	input [1:0]ALUOp,
	input [2:0]funct3,
	input op5, funct7,
	output reg [3:0]ALUControl, SLControl,
	output reg  [2:0]BrCtrl
);


always @(*) begin
    // Default values
    ALUControl	= 4'b0000; // default to ADD
    BrCtrl 		= 3'b000;
	 SLControl  = 4'b1111;

    case (ALUOp)
        2'b00: begin	
				// ADD for ins load/store: lb, lh, lw, sb, sh, sw,...
				ALUControl = 4'b0000; 
            case (funct3)
                3'b000: SLControl = (~op5) ? 4'b0000 : 4'b1000; // lb vs sb
                3'b001: SLControl = (~op5) ? 4'b0001 : 4'b1001; // lh vs sh
                3'b010: SLControl = (~op5) ? 4'b0010 : 4'b1010; // lw vs sw
                3'b100: SLControl = 4'b0100; // lbu
                3'b101: SLControl = 4'b0101; // lhu
                default: SLControl = 4'b1111; // undefined
            endcase
        end
		  
        2'b01: begin								// Branches
            case (funct3)
                3'b000: BrCtrl = 3'b000; 	// beq
                3'b001: BrCtrl = 3'b001; 	// bne
                3'b100: BrCtrl = 3'b100; 	// blt
                3'b101: BrCtrl = 3'b101; 	// bge
                3'b110: BrCtrl = 3'b110; 	// bltu
                3'b111: BrCtrl = 3'b111; 	// bgeu
                default: BrCtrl = 3'b000;
            endcase
        end
		  
        2'b10: begin								
				if (op5 == 1'b1) begin // R-type (op[5] = 1)
                case (funct3)
						3'b000: ALUControl = (funct7 == 1'b1) ? 4'b0001 : 4'b0000; 	// sub / add
						3'b111: ALUControl = 4'b0010; 										// and
						3'b110: ALUControl = 4'b0011; 										// or
						3'b100: ALUControl = 4'b0111; 										// xor
						3'b001: ALUControl = 4'b1101; 										// sll
						3'b101: ALUControl = (funct7 == 1'b1) ? 4'b1011 : 4'b1001;	// sra/srl
						3'b010: ALUControl = 4'b0101; 										// slt
						3'b011: ALUControl = 4'b0100; 										// sltu
						default: ALUControl = 4'b0000;
					endcase
            end else begin // I-type (op[5] = 0)
					case (funct3)
						3'b000: ALUControl = 4'b0000; 										// addi
						3'b111: ALUControl = 4'b0010; 										// andi
						3'b110: ALUControl = 4'b0011; 										// ori
						3'b100: ALUControl = 4'b0111; 										// xori
						3'b010: ALUControl = 4'b0101; 										// slti
						3'b011: ALUControl = 4'b0100; 										// sltiu
						3'b001: ALUControl = 4'b1101; 										// slli (funct7 = 0000000)
						3'b101: ALUControl = (funct7 == 1'b1) ? 4'b1011 : 4'b1001;	// srai / srli
						default: ALUControl = 4'b0000;
					endcase
				end
			end
			
        2'b11: begin
            ALUControl = 4'b0000; // Default to ADD (e.g., jalr or others)
        end
		  
		  default: begin
            // Already set above in default assignments
        end
		  
    endcase
end


endmodule










