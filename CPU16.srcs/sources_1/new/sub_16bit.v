`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2025 09:25:12 PM
// Design Name: 
// Module Name: sub_16bit
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


module sub_16bit(
    input [15:0] A,
    input [15:0] B,
    output [15:0] Diff
    );
    assign Diff = A - B;
endmodule
