`timescale 1ns / 1ps

module CPU_tb;

   logic clk;
   logic reset;

   // Instantiate the CPU
   CPU uut (
      .clk(clk),
      .reset(reset)
   );

   // Clock generation: 10 ns period (100 MHz)
   always #5 clk = ~clk;

   // Simulation procedure
   initial begin
      clk = 0;
      reset = 1;

      $display("=== RISC-V CPU Simulation Start ===");

      // Apply reset
      #10;
      reset = 0;

      // Run for 50 cycles
      repeat (50) begin
         @(posedge clk);
         #1;  // Allow signals to settle

         // Print debug info (you can modify this to match your internal signal names if needed)
         $display("Time=%0t | PC=%0d | Instruction=%h | ALU_Result=%0d", 
                  $time, uut.PC, uut.instruction, uut.ALU_result);
      end

      $display("=== Simulation Complete ===");
      $finish;
   end

endmodule
