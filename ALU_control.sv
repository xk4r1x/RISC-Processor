module ALU_Control (
   input logic [2:0] funct3,
   input logic [6:0] funct7,
   input logic [1:0] ALUop,
   output logic [3:0] ALUControl
);
   always_comb begin
      case (ALUop)
         2'b00: ALUControl = 4'b0010;
         2'b01: ALUControl = 4'b0110;
         2'b10: begin
            case(funct3)
               3'b000: ALUControl = (funct7[5]) ? 4'b0110 : 4'b0010;
               3'b001: ALUControl = 4'b1010;
               3'b010: ALUControl = 4'b0111;
               3'b011: ALUControl = 4'b1000;
               3'b100: ALUControl = 4'b1001;
               3'b101: ALUControl = (funct7[5]) ? 4'b1100 : 4'b1011;
               3'b110: ALUControl = 4'b0001;
               3'b111: ALUControl = 4'b0000;
               default: ALUControl = 4'b0010;
            endcase
         end
         2'b11: begin
            case(funct3)
               3'b000: ALUControl = 4'b0010;
               3'b001: ALUControl = 4'b1010;
               3'b010: ALUControl = 4'b0111;
               3'b011: ALUControl = 4'b1000;
               3'b100: ALUControl = 4'b1001;
               3'b101: ALUControl = (funct7[5]) ? 4'b1100 : 4'b1011;
               3'b110: ALUControl = 4'b0001;
               3'b111: ALUControl = 4'b0000;
               default: ALUControl = 4'b0010;
            endcase
         end
         default: ALUControl = 4'b0010;
      endcase
   end
endmodule
