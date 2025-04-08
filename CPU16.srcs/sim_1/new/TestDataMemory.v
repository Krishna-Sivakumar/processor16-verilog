`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 03:32:41 AM
// Design Name: 
// Module Name: TestDataMemory
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


module TestDataMemory;

    reg clk;
    reg mem_read;
    reg mem_write;
    reg [7:0] location;
    reg [15:0] write_data;
    wire [15:0] read_data;

    DataMemory dmu (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .location(location),
        .write_data(write_data),
        .read_data(read_data)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("==== FPGA-Accurate Data Memory Test ====");
        mem_read = 0; mem_write = 0; location = 16'd10;
        write_data = 16'hABCD;

        
        @(posedge clk);
        mem_write = 1;
        @(posedge clk);
        mem_write = 0;

        @(posedge clk);
        mem_read = 1;
        @(posedge clk);
        $display("Read @ addr %0d: 0x%h (Expected: 0xABCD)", location, read_data);
        mem_read = 0;

        $display("Data Memory Test Done");
        $stop;
    end
endmodule
