`timescale 1ns / 1ps

module InstructionMemory(
    input clk,
    input [15:0] pc,
    output reg [15:0] instruction
    );

    reg [15:0] mem [64:0];
    reg [15:0] slot;

    initial begin
        // all registers are 0 by default. We use ADDI to initialize them as needed.
        // please uncomment the below programs to run them, one at a time. 

        // this program is a simple demonstration of arithmetic operations.
        mem[0] = 16'h3_1_1_2;   // R[1] = R[1] + 2;
        mem[1] = 16'h3_0_0_1;   // R[0] = R[0] + 1; (R[0]
        mem[2] = 16'h0_2_1_0;   // R[2] = R[2] + R[1] (R[2] should be 2)
        mem[3] = 16'h0_1_0_0;   // R[1] = R[1] + R[0] (R[1] should be 3)
        mem[4] = 16'h0_2_1_1;   // R[2] = R[1] - R[2] (R[2] should be 1)
        mem[5] = 16'h0_1_2_2;   // R[1] = R[1] << R[2] (R[1] should be 6)
        mem[6] = 16'h0_2_1_3;   // R[2] = R[2] & R[1] (R[2] should be 0; 6 & 1 = 0)

        // This is an example program that uses bne to loop, computing 12 within R[2] by the end of the loop.
//        mem[0] = 16'h3_1_1_6;   // R[1] = R[1] + 6
//        mem[1] = 16'h3_1_1_f;   // R[1] = R[1] + (-1)
//        mem[2] = 16'h3_2_2_2;   // R[2] = R[2] + 2
//        mem[3] = 16'h5_1_e_d;   // R[1] != R[15]? PC = PC + 1 - 3 (each addition is a word)
        
        // This program is the same as above, but we use jmp and beq here. I also load and store words.
        // loop until R[1] goes to 0, increment R[2] by 2 for every iteration (so the end result is 12).
//        mem[0] = 16'h3_1_1_6;   // R[1] = R[1] + 6 (R[1] should be 6 now)
//        mem[1] = 16'h4_1_e_4;   // R[1] != R[15]? PC = PC + 1 + 4 (jumps past the end of the loop, past the jmp command)
//        mem[2] = 16'h3_1_1_f;   // R[1] = R[1] + (-1)
//        mem[3] = 16'h3_2_2_2;   // R[2] = R[2] + 2
//        mem[4] = 16'h2_2_e_0;   // DM[0] = R[2] (DM should be 0x0c 0x00 ...)
//        mem[5] = 16'h6_ffb;     // jmp; PC = PC + 1 - 5 (each addition is a word)
//        mem[6] = 16'h2_2_e_1;   // DM[1] = R[2] (DM should be 0x0c 0x0c 0x00 ...)
//        mem[7] = 16'h1_4_e_0;   // R[4] = DM[0] (should be 0x0c 0x0c)
    end

    always @(pc) begin
        slot = pc >> 1;
        instruction = mem[slot];
//        $monitor("IM | time: %0t | slot: %h | instruction: %h", $time, slot, mem[slot]);
    end
endmodule
