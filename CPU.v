//Top Level

module CPU (
   input logic clk, reset,
);
   //Program Counter
   logic [31:0] PC, next_PC, instruction;

   //Instruction Memory
   logic [6:0] opcode;
   logic [4:0] rs1, rs2, rd;
   logic [2:0] funct3;
   logic [6:0] funct7;
   logic [31:0] imm;

   //Control Signals
   logic RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc, Branch;
   logic [1:0] ALUop;

   //Register File
   logic [31:0] reg_data1, reg_data2, ALU_result, write_back_data;

   //ALU Control
   logic [3:0] ALUControl;

   //Data Memory
   logic [31:0] memory_data;

   //Program Counter Logic
   PC program_counter (
      .clk(clk),
      .reset(reset),
      .PC_in(next_PC),
      .PC_out(PC)
   );

   //Instruction Memory (Stubbed out, replaces with actual memory)
   Instruction_Memory instruction_memry(
      .address(PC),
      .instruction(instruction),
   );

   //Decode Instructions
   assign opcode = instruction[6:0];
   assign rs1 = instruction[19:15];
   assign rs2 = instruction [24:20];
   assign rd = instruction [11:7];
   assign funct3 = instruction[14:12]
   assign funct7 = instruction[31:25]

   //Control Unit
   Control_Unit control_unit(
      .opcode(opcode),
      .RegWrite(RegWrite),
      .MemtoReg(MemtoReg),
      .MemRead(MemRead),
      .MemWrite(MemWrite),
      .ALUSrc(ALUSrc),
      .Branch(Branch),
      .ALUop(ALUop)
   );

   //Register File
   Register_File register_file(
      .clk(clk),
      .RegWrite(RegWrite),
      .readReg1(rs1),
      .readReg2(rs2),
      .writeReg(rd),
      .writeData(write_back_data),
      .readData1(reg_data1),
      .readData2(reg_data2)
   );

   //ALU Control Unit
   ALU_Control alu_control(
      .funct3(funct3),
      .funct7(funct7),
      .ALUop(ALUop),
      .ALUControl(ALUControl)
   );

   //ALU
   ALU alu(
      .A(reg_data1),
      .B(ALUSrc ? imm : reg_data2),
      .ALUControl(ALUControl),
      .ALUResult(ALU_result),
      .Zero()
   );

   //Data Memory
   Data_Memory data_memory(
      .clk(clk),
      .MemWrite(MemWrite),
      .MemRead(MemRead),
      .address(ALU_result),
      .writeData(reg_data2),
      .readData(memory_data)
   );

   //Write Back
   assign write_back_data = MemtoReg ? memory_data : ALU_result;

   //Branching

   assign next_PC = (Branch && (ALU_result == 0)) ? (PC +imm) : (PC + 4);
   
endmodule