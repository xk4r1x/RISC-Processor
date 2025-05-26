module Control_Unit (
   input logic [6:0] opcode,
   input logic [2:0] funct3,
   output logic RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc, Branch, Jump,
   output logic [1:0] ALUop,
   output logic [2:0] ImmSrc
);
   always_comb begin
      RegWrite = 0; MemtoReg = 0; MemRead = 0; MemWrite = 0;
      ALUSrc = 0; Branch = 0; Jump = 0; ALUop = 2'b00; ImmSrc = 3'b000;
      case(opcode)
         7'b0110011: begin RegWrite = 1; ALUop = 2'b10; end // R-type
         7'b0010011: begin RegWrite = 1; ALUop = 2'b11; ALUSrc = 1; ImmSrc = 3'b001; end // I-type
         7'b0000011: begin RegWrite = 1; MemRead = 1; MemtoReg = 1; ALUSrc = 1; ImmSrc = 3'b001; end // Load
         7'b0100011: begin MemWrite = 1; ALUSrc = 1; ImmSrc = 3'b010; end // Store
         7'b1100011: begin Branch = 1; ALUop = 2'b01; ImmSrc = 3'b011; end // Branch
         7'b1101111: begin RegWrite = 1; Jump = 1; ImmSrc = 3'b100; end // JAL
         7'b1100111: begin RegWrite = 1; Jump = 1; ALUSrc = 1; ImmSrc = 3'b001; end // JALR
         7'b0110111, 7'b0010111: begin RegWrite = 1; ALUSrc = 1; ImmSrc = 3'b101; end // LUI / AUIPC
         default: ; // NOP
      endcase
   end
endmodule
