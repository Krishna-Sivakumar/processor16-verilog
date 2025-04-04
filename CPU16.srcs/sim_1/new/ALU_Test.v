`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2025 02:14:13 PM
// Design Name: 
// Module Name: ALU_Test
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


module ALU_Test;
    
    reg [15:0] A, B;
    wire [15:0] result;
    reg [3:0] control;
    reg clk;
    
    initial begin
        // oscillate the clock every 5ns
        clk = 0;
        forever
            #5 clk = ~clk;
    end
    
    ALU aluTest (
        .a(A),
        .b(B),
        .control(control),
        .result(result),
        .clk(clk)
    );

    initial begin
//        $monitor("Time = %0t | A = %h | B = %h | control = %h | result = %h", $time, A, B, control, result);
        A = 16'h000f; B = 16'h0006; control = 4'b0000; #10;     // AND Test; 0xf & 0x6 = 0x6 
        A = 16'h000f; B = 16'h0000; control = 4'b0001; #20;     // OR Test; 0xf | 0x0 = 0xf 
        A = 16'h000f; B = 16'h0001; control = 4'b0010; #30;     // ADD Test; 0xf + 0x1 = 0x10
        A = 16'h000f; B = 16'h0000; control = 4'b0111; #40;     // A > B; set 0
        A = 16'h0000; B = 16'h000f; control = 4'b0111; #50;     // A < B; set 1
        #20;
        // End simulation
        $finish;
    end

endmodule
