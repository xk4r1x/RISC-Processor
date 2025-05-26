module Data_Memory (
   input logic clk, MemWrite, MemRead,
   input logic [31:0] address, writeData,
   output logic [31:0] readData
);
   logic [31:0] mem [0:1023];
   logic [31:0] word_addr;

   assign word_addr = address >> 2;

   initial begin
      for (int i = 0; i < 1024; i++) begin
         mem[i] = 32'h00000000;
      end
      mem[0] = 32'h12345678;
      mem[1] = 32'hABCDEF00;
      mem[2] = 32'h11111111;
   end

   always_ff @(posedge clk) begin
      if (MemWrite && word_addr < 1024)
         mem[word_addr] <= writeData;
   end

   always_comb begin
      if (MemRead && word_addr < 1024)
         readData = mem[word_addr];
      else
         readData = 32'b0;
   end
endmodule
