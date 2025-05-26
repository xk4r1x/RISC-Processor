`timescale 1ns / 1ps

module CPU_tb;

    logic clk;
    logic reset;
    logic [31:0] current_PC, instruction_out, ALU_result_out;

    CPU uut (
        .clk(clk),
        .reset(reset),
        .current_PC(current_PC),
        .instruction_out(instruction_out),
        .ALU_result_out(ALU_result_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
        
        repeat (100) begin
            #10;
            $display("PC: %0d | Instruction: %h | ALU Result: %d", current_PC, instruction_out, ALU_result_out);
        end

        $finish;
    end
endmodule
