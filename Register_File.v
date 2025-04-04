module Register_File (
   input logic clk, RegWrite,
   input logic [4:0] readReg1, readReg2, writeReg
   input logic [31:0] writeData,
   output logic [31:0] readData1, readData2
);
   logic [31:0] registers [0:31];

   always_ff @(posedge clk) begin
      if (RegWrite)
         registers[writeReg] <= writeData;
   end

   assign readData1 = registers[readReg1];
   assign readData2 = registers[readReg2] 
endmodule