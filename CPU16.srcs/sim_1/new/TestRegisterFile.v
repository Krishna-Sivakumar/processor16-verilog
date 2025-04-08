`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 03:43:21 AM
// Design Name: 
// Module Name: TestRegisterFile
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


module TestRegisterFile;

    reg clk;
    reg write_enable;
    reg [3:0] reg1, reg2, reg_write;
    reg [15:0] write_data;
    wire [15:0] read_data1, read_data2;

    RegisterFile uut (
        .clk(clk),
        .enable_write(write_enable), 
        .reg1(reg1), 
        .reg2(reg2), 
        .reg_write(reg_write), 
        .write_data(write_data), 
        .result_reg1(read_data1), 
        .result_reg2(read_data2)
    );

    always #5 clk = ~clk;

    initial begin
        $display("==== Register File Test Start ====");

        clk = 0;
        write_enable = 0;
        reg1 = 0;
        reg1 = 0;
        reg_write = 0;
        write_data = 16'h0000;

        @(posedge clk);
        write_enable = 1;
        reg_write = 4'd0;
        write_data = 16'h1234;

        @(posedge clk);
        write_enable = 0;
        $display("[WRITE] $s0 <= 0x1234");

        reg1 = 4'd0;
        reg2 = 4'd1;
        #1;
        $display("[READ]  $s0 = 0x%h (Expected: 1234), $s1 = 0x%h (Expected: 0000)", read_data1, read_data2);

        @(posedge clk);
        write_enable = 1;
        reg_write = 4'd1;
        write_data = 16'hABCD;

        @(posedge clk);
        write_enable = 0;
        $display("[WRITE] $s1 <= 0xABCD");

        reg1 = 4'd1;
        reg2 = 4'd0;
        #1;
        $display("[READ]  $s1 = 0x%h (Expected: ABCD), $s0 = 0x%h (Expected: 1234)", read_data1, read_data2);

        $display("==== Register File Test Done ====");
        $stop;
    end
endmodule
