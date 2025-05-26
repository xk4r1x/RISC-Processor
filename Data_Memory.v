module Data_Memory (
    input logic clk, MemWrite, MemRead,
    input logic [31:0] address, writeData,
    output logic [31:0] readData
);
    logic [31:0] mem [0:255];

    always_ff @(posedge clk) begin
        if (MemWrite)
            mem[address >> 2] <= writeData;
    end

    always_comb begin
        if (MemRead)
            readData = mem[address >> 2];
        else
            readData = 32'b0;
    end
endmodule
