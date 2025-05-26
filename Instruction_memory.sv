module Instruction_Memory (
   input logic [31:0] address,
   output logic [31:0] instruction
);
   logic [31:0] mem [0:255];
   logic [7:0] word_addr;

   assign word_addr = address[9:2];

   initial begin
      for (int i = 0; i < 256; i++) mem[i] = 32'h00000013; // NOP

      mem[0] = 32'h00100093; // ADDI x1, x0, 1
      mem[1] = 32'h00200113; // ADDI x2, x0, 2
      mem[2] = 32'h002081B3; // ADD x3, x1, x2
      mem[3] = 32'h40208233; // SUB x4, x1, x2
      mem[4] = 32'h0020F2B3; // AND x5, x1, x2
      mem[5] = 32'h0020E333; // OR x6, x1, x2
      mem[6] = 32'h00012623; // SW x0, 12(x2)
      mem[7] = 32'h00C12383; // LW x7, 12(x2)
      mem[8] = 32'h00118463; // BEQ x3, x1, +8
      mem[9] = 32'h00100393; // ADDI x7, x0, 1
      mem[10] = 32'h00000013; // NOP
      mem[11] = 32'h00100493; // ADDI x9, x0, 1
      mem[12] = 32'hFE1482E3; // BEQ x9, x1, -12
   end

   always_comb begin
      instruction = (word_addr < 256) ? mem[word_addr] : 32'h00000013;
   end
endmodule
