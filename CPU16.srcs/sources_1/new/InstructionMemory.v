`timescale 1ns / 1ps

module InstructionMemory(
    input clk,
    input [15:0] pc,
    output reg [15:0] instruction
    );

    reg [15:0] mem [64:0];
    reg [15:0] slot;

    initial begin
        // initialization area
        //mem[0] = 16'h3_1_1_6;   // R[1] = R[1] + 6
        //mem[1] = 16'h3_1_1_f;   // R[1] = R[1] + (-1)
        //mem[2] = 16'h3_2_2_2;   // R[2] = R[2] + 2
        //mem[3] = 16'h5_1_e_d;   // R[1] != R[15]? PC = PC + 2 - 3
        
        // R[15] is 0
        // loop until R[1] goes to 0.
        mem[0] = 16'h3_1_1_6;   // R[1] = R[1] + 6
        mem[1] = 16'h3_1_1_f;   // R[1] = R[1] + (-1)
        mem[2] = 16'h4_1_e_3;   // R[1] != R[15]? PC = PC + 1 + 3 (jumps past the end of the loop, past the jmp command)
        mem[3] = 16'h3_2_2_2;   // R[2] = R[2] + 2
        mem[4] = 16'h2_2_e_0;   // DM[0] = R[2] (should be 0x0c 0x00)
        mem[5] = 16'h6_ffb;     // jmp; PC = PC + 1 - 5
        mem[6] = 16'h1_4_e_0;   // R[4] = DM[0]
    end

    always @(posedge clk) begin
        slot = pc >> 1;
        instruction = mem[slot];
        $monitor("IM | time: %0t | slot: %h | instruction: %h", $time, slot, mem[slot]);
    end
endmodule
