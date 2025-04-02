`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2025 09:50:22 PM
// Design Name: 
// Module Name: and_16bit
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


module and_16bit(
    input [15:0] A,
    input [15:0] B,
    output [15:0] Out
    );
    assign Out = A & B;
endmodule
