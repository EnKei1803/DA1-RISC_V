module PC_COUNTER
(
  input logic [31:0] PCNext,
  input logic run,
  input logic clk,
  input logic nrst,
  output logic [31:0] PC
);
  
  always_ff @(posedge clk)
    if (!nrst)
      PC <= 32'd0;
    else if (run)
      PC <= PCNext;
	else
      PC <= PC;

endmodule 