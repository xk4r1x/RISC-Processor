`timescale 1ns / 1ps

module CPU_tb;
    // Testbench Signals
    logic clk;
    logic reset;

    // Instantiate the CPU
    CPU uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock Generation
    always #5 clk = ~clk;  // Generate a clock with 10 ns period (100 MHz)

    // Test Procedure
    initial begin
        // Initialize Signals
        clk = 0;
        reset = 1;

        // Hold Reset for a Few Cycles
        #10;
        reset = 0;
        #10;
        
        // Run for 100 clock cycles
        repeat (100) begin
            #10;  // Wait for next clock cycle
            $display("PC: %d | Instruction: %h | ALU Result: %d | MemRead: %b | MemWrite: %b | RegWrite: %b", 
                     uut.PC, uut.instruction, uut.ALU_result, uut.MemRead, uut.MemWrite, uut.RegWrite);
        end

        // End simulation
        $finish;
    end
endmodule
