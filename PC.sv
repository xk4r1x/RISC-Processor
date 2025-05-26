module PC (
   input logic clk, reset,
   input logic [31:0] next_pc,
   output logic [31:0] pc
);
   always_ff @(posedge clk or posedge reset) begin
      if (reset)
         pc <= 32'h00000000;
      else
         pc <= {next_pc[31:2], 2'b00};  // Word-aligned
   end
endmodule
