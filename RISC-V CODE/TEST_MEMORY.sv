module TEST_MEMORY (
    input clk,
    input [31:0] A,         // Address input
    input [31:0] WD,        // Data to write
    input WE,               // Write enable
    input [3:0] SLType,     // Store-Load Type
    output reg [31:0] RD    // Data read from memory
);

    // 256 x 8-bit memory
    reg [7:0] mem [0:255];
    logic [7:0] Addr;
    assign Addr = A[7:0];

	 
	 
    // Initialize memory
    initial begin
        for (int i = 0; i < 256; i++) mem[i] = 8'h00;
    end

	 
	 
    // Write operation
    always @(posedge clk) begin
        if (WE) begin
            case (SLType)
                4'b1000: if (Addr < 256) mem[Addr] <= WD[7:0];
                4'b1001: if (Addr < 255) begin
                    mem[Addr] <= WD[7:0];
                    mem[Addr+1] <= WD[15:8];
                end
                4'b1010: if (Addr < 253) begin
                    mem[Addr] <= WD[7:0];
                    mem[Addr+1] <= WD[15:8];
                    mem[Addr+2] <= WD[23:16];
                    mem[Addr+3] <= WD[31:24];
                end
                default: ; // No operation
            endcase
        end
    end

	 
	 
    // Read operation
    always @(*) begin
        case (SLType)
            4'b0000: RD = {24'h0, mem[Addr]};
            4'b0001: RD = {16'h0, mem[Addr+1], mem[Addr]};
            4'b0010: RD = {mem[Addr+3], mem[Addr+2], mem[Addr+1], mem[Addr]};
            default: RD = 32'h0;
        endcase
    end

endmodule 