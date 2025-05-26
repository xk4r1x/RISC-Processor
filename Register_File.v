module Register_File (
   input logic clk, RegWrite,
   input logic [4:0] readReg1, readReg2, writeReg,
   input logic [31:0] writeData,
   output logic [31:0] readData1, readData2
);
   logic [31:0] registers [0:31];

   initial begin
      for (int i = 0; i < 32; i++) registers[i] = 32'h0;
      registers[1] = 32'h10;
      registers[2] = 32'h5;
      registers[3] = 32'hA;
   end

   always_ff @(posedge clk) begin
      if (RegWrite && writeReg != 5'd0)
         registers[writeReg] <= writeData;
   end

   assign readData1 = (readReg1 == 5'd0) ? 32'h0 : registers[readReg1];
   assign readData2 = (readReg2 == 5'd0) ? 32'h0 : registers[readReg2];
endmodule
