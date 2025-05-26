module ALU (
   input logic [31:0] A, B,
   input logic [3:0] ALUControl,
   output logic [31:0] ALUResult,
   output logic Zero
);
   always_comb begin
      case(ALUControl)
         4'b0000: ALUResult = A & B;
         4'b0001: ALUResult = A | B;
         4'b0010: ALUResult = A + B;
         4'b0110: ALUResult = A - B;
         4'b0111: ALUResult = ($signed(A) < $signed(B)) ? 32'h1 : 32'h0;
         4'b1000: ALUResult = (A < B) ? 32'h1 : 32'h0;
         4'b1001: ALUResult = A ^ B;
         4'b1010: ALUResult = A << B[4:0];
         4'b1011: ALUResult = A >> B[4:0];
         4'b1100: ALUResult = $signed(A) >>> B[4:0];
         4'b1101: ALUResult = ~(A | B);
         default: ALUResult = 32'b0;
      endcase
   end
   assign Zero = (ALUResult == 32'b0);
endmodule
