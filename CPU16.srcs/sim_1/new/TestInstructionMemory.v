`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 03:38:02 AM
// Design Name: 
// Module Name: TestInstructionMemory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TestInstructionMemory;

    reg clk;
    reg [15:0] address;
    wire [15:0] instruction;

    InstructionMemory uut (
        .clk(clk),
        .pc(address),
        .instruction(instruction)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        uut.mem[0] = 16'h0040;
        uut.mem[1] = 16'h3102;
        uut.mem[2] = 16'h2211;
        uut.mem[3] = 16'h1311;
        uut.mem[4] = 16'h0312;
    end

    initial begin
        $display("==== FPGA-Accurate Instruction Memory Test ====");

        address = 0; @(posedge clk); @(posedge clk);
        $display("Instruction @ 0: 0x%h (Expected: 0x0040)", instruction);

        address = 2; @(posedge clk); @(posedge clk);
        $display("Instruction @ 2: 0x%h (Expected: 0x3102)", instruction);

        address = 4; @(posedge clk); @(posedge clk);
        $display("Instruction @ 4: 0x%h (Expected: 0x2211)", instruction);

        address = 6; @(posedge clk); @(posedge clk);
        $display("Instruction @ 6: 0x%h (Expected: 0x1311)", instruction);

        address = 8; @(posedge clk); @(posedge clk);
        $display("Instruction @ 8: 0x%h (Expected: 0x0312)", instruction);

        $display("Instruction Memory Test Done");
        $stop;
    end
endmodule
