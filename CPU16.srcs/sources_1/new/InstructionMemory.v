`timescale 1ns / 1ps

module InstructionMemory(
    input clk,
    input [15:0] pc,
    output reg [15:0] instruction
    );

    reg [15:0] mem [15:0];
    reg [15:0] slot;

    initial begin
        // initialization area
        mem[0] = 16'h1_0_1_0;   // R[0] = DM[R[1]+0]
        mem[1] = 16'h0_0_2_0;   // R[0] = R[0] + R[2]
        mem[3] = 16'h2_0_1_0;   // DM[R[1]+0] = R[0]
    end

    always @(posedge clk) begin
        instruction = mem[pc >> 2]; // each instruction is 16 bits. The address is byte-wise, hence we divide by 4 to get the current instruction.
        $monitor("time: %0t, slot: %h, item at slot: %h", $time, slot, mem[slot]);
    end
endmodule
