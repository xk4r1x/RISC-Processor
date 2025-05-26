module CPU (
    input logic clk, reset,
    output logic [31:0] current_PC,
    output logic [31:0] instruction_out,
    output logic [31:0] ALU_result_out
);

    logic [31:0] PC, next_PC, instruction;

    // Instruction Fields
    logic [6:0] opcode, funct7;
    logic [4:0] rs1, rs2, rd;
    logic [2:0] funct3;
    logic [31:0] imm; // You need to implement an Immediate Generator for this

    // Control Signals
    logic RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc, Branch;
    logic [1:0] ALUop;

    // Register File & ALU Wires
    logic [31:0] reg_data1, reg_data2, ALU_result, write_back_data;
    logic [3:0] ALUControl;
    logic [31:0] memory_data;
    logic [31:0] ALU_operand2;

    assign opcode  = instruction[6:0];
    assign rd      = instruction[11:7];
    assign funct3  = instruction[14:12];
    assign rs1     = instruction[19:15];
    assign rs2     = instruction[24:20];
    assign funct7  = instruction[31:25];

    // PC logic
    PC program_counter (
        .clk(clk),
        .reset(reset),
        .next_pc(next_PC),
        .pc(PC)
    );

    Instruction_Memory instruction_mem (
        .address(PC),
        .instruction(instruction)
    );

    Control_Unit control_unit (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .MemtoReg(MemtoReg),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .Branch(Branch),
        .ALUop(ALUop)
    );

    Register_File register_file (
        .clk(clk),
        .RegWrite(RegWrite),
        .readReg1(rs1),
        .readReg2(rs2),
        .writeReg(rd),
        .writeData(write_back_data),
        .readData1(reg_data1),
        .readData2(reg_data2)
    );

    ALU_Control alu_control (
        .funct3(funct3),
        .funct7(funct7),
        .ALUop(ALUop),
        .ALUControl(ALUControl)
    );

    assign ALU_operand2 = ALUSrc ? imm : reg_data2;

    ALU alu (
        .A(reg_data1),
        .B(ALU_operand2),
        .ALUControl(ALUControl),
        .ALUResult(ALU_result),
        .Zero()
    );

    Data_Memory data_memory (
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .address(ALU_result),
        .writeData(reg_data2),
        .readData(memory_data)
    );

    assign write_back_data = MemtoReg ? memory_data : ALU_result;
    assign next_PC = (Branch && (ALU_result == 0)) ? (PC + imm) : (PC + 4);

    // Outputs for debugging
    assign current_PC = PC;
    assign instruction_out = instruction;
    assign ALU_result_out = ALU_result;

endmodule
