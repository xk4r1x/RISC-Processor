module Pipeline_Registers (
   input logic clk, reset,
   input logic [31:0] inData,
   output logic [31:0] outData
);
   always_ff@(posedge clk or posedge reset) begin
      if (reset)
         outData <= 0;
      else
         outData <= inData
   end
endmodule