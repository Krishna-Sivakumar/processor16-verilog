`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 03:53:18 AM
// Design Name: 
// Module Name: TestProgramCounter
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


module TestProgramCounter;

    reg clk;
    reg reset;
    reg [15:0] pc_next;
    wire [15:0] pc;

    ProgramCounter uut (
        .clk(clk),
        .next(pc_next), 
        .pc(pc)
    );

    always #5 clk = ~clk;

    initial begin
        $display("==== Program Counter Test Start ====");

        clk = 0;
        pc_next = 16'h0000;

        pc_next = 16'h0020;
        @(posedge clk);
        $display("[SET]   PC = %h (Expected: fffe)", pc); // we start the program at a positive clock edge, which bumps the PC up to 0. Hence, the starting position is -2.

        pc_next = 16'h0022;
        @(posedge clk);
        $display("[SET]   PC = %h (Expected: 0022)", pc);

        pc_next = 16'h0024;
        @(posedge clk);
        $display("[SET]   PC = %h (Expected: 0024)", pc);

        pc_next = 16'h0100;
        @(posedge clk);
        $display("[SET]   PC = %h (Expected: 0100)", pc);

        $display("==== Program Counter Test Complete ====");
        $stop;
    end
endmodule
