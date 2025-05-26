module CPU (
   input logic clk, reset
);

   // Program Counter and Instruction
   logic [31:0] PC, next_PC, instruction;

   // Decoded Instruction Fields
   logic [6:0] opcode, funct7;
   logic [4:0] rs1, rs2, rd;
   logic [2:0] funct3;

   // Control Signals
   logic RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc, Branch, Jump;
   logic [1:0] ALUop;
   logic [2:0] ImmSrc;

   // Register File & Data Path Signals
   logic [31:0] reg_data1, reg_data2, write_back_data;
   logic [31:0] ALU_result, memory_data;
   logic [31:0] imm;
   logic [3:0] ALUControl;
   logic ALU_Zero;
   logic branch_taken;

   //===========================
   // Module Instantiations
   //===========================

   // Program Counter
   PC program_counter (
      .clk(clk),
      .reset(reset),
      .next_pc(next_PC),
      .pc(PC)
   );

   // Instruction Memory
   Instruction_Memory instruction_memory (
      .address(PC),
      .instruction(instruction)
   );

   // Decode Fields
   assign opcode = instruction[6:0];
   assign rd     = instruction[11:7];
   assign funct3 = instruction[14:12];
   assign rs1    = instruction[19:15];
   assign rs2    = instruction[24:20];
   assign funct7 = instruction[31:25];

   // Immediate Generator
   Immediate_Generator imm_gen (
      .instruction(instruction),
      .ImmSrc(ImmSrc),
      .immediate(imm)
   );

   // Control Unit
   Control_Unit control_unit (
      .opcode(opcode),
      .funct3(funct3),
      .RegWrite(RegWrite),
      .MemtoReg(MemtoReg),
      .MemRead(MemRead),
      .MemWrite(MemWrite),
      .ALUSrc(ALUSrc),
      .Branch(Branch),
      .Jump(Jump),
      .ALUop(ALUop),
      .ImmSrc(ImmSrc)
   );

   // Register File
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

   // ALU Control
   ALU_Control alu_control (
      .funct3(funct3),
      .funct7(funct7),
      .ALUop(ALUop),
      .ALUControl(ALUControl)
   );

   // ALU
   ALU alu (
      .A(reg_data1),
      .B(ALUSrc ? imm : reg_data2),
      .ALUControl(ALUControl),
      .ALUResult(ALU_result),
      .Zero(ALU_Zero)
   );

   // Data Memory
   Data_Memory data_memory (
      .clk(clk),
      .MemWrite(MemWrite),
      .MemRead(MemRead),
      .address(ALU_result),
      .writeData(reg_data2),
      .readData(memory_data)
   );

   // Writeback Multiplexer
   assign write_back_data = MemtoReg ? memory_data : ALU_result;

   // Branch Decision Logic
   assign branch_taken = Branch & (
      (funct3 == 3'b000) ?  ALU_Zero     :  // BEQ
      (funct3 == 3'b001) ? ~ALU_Zero     :  // BNE
      (funct3 == 3'b100) ?  ALU_result[0]:  // BLT (signed)
      (funct3 == 3'b101) ? ~ALU_result[0]:  // BGE (signed)
      1'b0
   );

   // Next PC Logic
   assign next_PC = Jump         ? (PC + imm) :
                    branch_taken ? (PC + imm) :
                                   (PC + 4);

endmodule
