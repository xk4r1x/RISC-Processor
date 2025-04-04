module ALU (
   input logic[31:0] A, B,
   input logic[3:0] ALUControl,
   output logic[31:0] ALUResult,
   output logic Zero
);

   always_comb begin
      case(ALUControl)
         4'b0000: ALUResult = A & B; // AND
         4'b0001: ALUResult = A | B; // OR
         4'b0010: ALUResult = A + B; // ADD
         4'b0110: ALUResult = A - B; // SUB
         4'b0111: ALUResult = (A < B) ? 1: 0; // SLT
         4'b0000: ALUResult = ~(A | B); // NOR
      endcase
   end
   assign Zero = (ALUResult == 0);   
endmodule