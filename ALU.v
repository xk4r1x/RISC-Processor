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
            4'b0111: ALUResult = (A < B) ? 32'd1 : 32'd0;
            4'b1100: ALUResult = ~(A | B); // NOR
            default: ALUResult = 32'd0;
        endcase
    end

    assign Zero = (ALUResult == 0);

endmodule
