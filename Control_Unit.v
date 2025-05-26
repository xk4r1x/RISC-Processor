module Control_Unit (
    input logic [6:0] opcode,
    output logic RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc, Branch,
    output logic [1:0] ALUop
);
    always_comb begin
        case(opcode)
            7'b0110011: begin // R-type
                RegWrite = 1; ALUop = 2'b10; ALUSrc = 0;
                Branch = 0; MemWrite = 0; MemRead = 0; MemtoReg = 0;
            end
            7'b0000011: begin // Load
                RegWrite = 1; ALUop = 2'b00; ALUSrc = 1;
                Branch = 0; MemWrite = 0; MemRead = 1; MemtoReg = 1;
            end
            7'b0100011: begin // Store
                RegWrite = 0; ALUop = 2'b00; ALUSrc = 1;
                Branch = 0; MemWrite = 1; MemRead = 0; MemtoReg = 0;
            end
            7'b1100011: begin // Branch
                RegWrite = 0; ALUop = 2'b01; ALUSrc = 0;
                Branch = 1; MemWrite = 0; MemRead = 0; MemtoReg = 0;
            end
            default: begin
                RegWrite = 0; ALUop = 2'b00; ALUSrc = 0;
                Branch = 0; MemWrite = 0; MemRead = 0; MemtoReg = 0;
            end
        endcase
    end
endmodule
