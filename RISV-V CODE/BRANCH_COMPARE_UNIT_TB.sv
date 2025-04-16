`timescale 1ps/1ps
module BRANCH_COMPARE_UNIT_TB;

    // Declare input and output signals
    logic [2:0] Br_Ctrl;
    logic [31:0] SrcA, SrcB;
    logic EQ, NE, LT, GE, BrOut;

    // Instantiate the Device Under Test (DUT)
    BRANCH_COMPARE_UNIT dut (
        .Br_Ctrl(Br_Ctrl),
        .SrcA(SrcA),
        .SrcB(SrcB),
        .EQ(EQ),
        .NE(NE),
        .LT(LT),
        .GE(GE),
        .BrOut(BrOut)
    );

    integer i, j;
    integer pass_count = 0;
    integer fail_count = 0;

    // Task to check outputs against expected values
    task check_outputs;
        input [2:0] ctrl_in;
        input [31:0] A_in, B_in;
        input exp_EQ, exp_NE, exp_LT, exp_GE, exp_BrOut;
        begin
            if (EQ !== exp_EQ || NE !== exp_NE || LT !== exp_LT || 
                GE !== exp_GE || BrOut !== exp_BrOut) begin
                $display("Incorrect result at Br_Ctrl = %b, SrcA = %h, SrcB = %h", 
                         ctrl_in, A_in, B_in);
                $display("Expected: EQ=%b, NE=%b, LT=%b, GE=%b, BrOut=%b", 
                         exp_EQ, exp_NE, exp_LT, exp_GE, exp_BrOut);
                $display("Got:      EQ=%b, NE=%b, LT=%b, GE=%b, BrOut=%b", 
                         EQ, NE, LT, GE, BrOut);
                fail_count = fail_count + 1;
            end else begin
                pass_count = pass_count + 1;
            end
        end
    endtask

    initial begin
        // Test with random inputs across all modes
        $display("Testing with random inputs across all modes...");

        for (i = 0; i < 100000; i = i + 1) begin				// 100000 case
            // Generate random SrcA and SrcB
            SrcA = $random;
            SrcB = $random;

            // Cycle through all Br_Ctrl modes for this A/B pair
            for (j = 0; j < 6; j = j + 1) begin
                case (j)
                    0: Br_Ctrl = 3'b000; // EQ
                    1: Br_Ctrl = 3'b001; // NE
                    2: Br_Ctrl = 3'b100; // LT signed
                    3: Br_Ctrl = 3'b101; // GE signed
                    4: Br_Ctrl = 3'b110; // LT unsigned
                    5: Br_Ctrl = 3'b111; // GE unsigned
                endcase
                #10; // Wait for outputs to settle

                // Check outputs based on Br_Ctrl mode
                case (Br_Ctrl)
                    3'b000: check_outputs(Br_Ctrl, SrcA, SrcB,
                                          (SrcA == SrcB), ~(SrcA == SrcB), 
                                          ($signed(SrcA) < $signed(SrcB)), ($signed(SrcA) >= $signed(SrcB)),
                                          (SrcA == SrcB)); // EQ
                    3'b001: check_outputs(Br_Ctrl, SrcA, SrcB,
                                          (SrcA == SrcB), ~(SrcA == SrcB), 
                                          ($signed(SrcA) < $signed(SrcB)), ($signed(SrcA) >= $signed(SrcB)),
                                          (SrcA != SrcB)); // NE
                    3'b100: check_outputs(Br_Ctrl, SrcA, SrcB,
                                          (SrcA == SrcB), ~(SrcA == SrcB), 
                                          ($signed(SrcA) < $signed(SrcB)), ($signed(SrcA) >= $signed(SrcB)),
                                          ($signed(SrcA) < $signed(SrcB))); // LT signed
                    3'b101: check_outputs(Br_Ctrl, SrcA, SrcB,
                                          (SrcA == SrcB), ~(SrcA == SrcB), 
                                          ($signed(SrcA) < $signed(SrcB)), ($signed(SrcA) >= $signed(SrcB)),
                                          ($signed(SrcA) >= $signed(SrcB))); // GE signed
                    3'b110: check_outputs(Br_Ctrl, SrcA, SrcB,
                                          (SrcA == SrcB), ~(SrcA == SrcB), 
                                          (SrcA < SrcB), (SrcA >= SrcB),
                                          (SrcA < SrcB)); // LT unsigned
                    3'b111: check_outputs(Br_Ctrl, SrcA, SrcB,
                                          (SrcA == SrcB), ~(SrcA == SrcB), 
                                          (SrcA < SrcB), (SrcA >= SrcB),
                                          (SrcA >= SrcB)); // GE unsigned
                endcase
            end
        end

        // Summary
        $display("Test Summary: %0d tests passed, %0d tests failed", pass_count, fail_count);
        if (fail_count == 0) begin
            $display("[%t] --------------- SIMULATION PASS ---------------", $time);
        end else begin
            $display("[%t] --------------- SIMULATION FAIL ---------------", $time);
        end

        $stop;
    end

endmodule

