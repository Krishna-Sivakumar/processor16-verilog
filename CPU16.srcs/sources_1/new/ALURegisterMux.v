`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2025 06:33:53 PM
// Design Name: 
// Module Name: ALURegisterMux
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


module ALURegisterMux(
    input [15:0] in_reg1,
    input [3:0] immediate,
    input is_imm,          // is_imm differentiates the output
    output reg [15:0] reg1
);
    always @(*) begin
        if (is_imm) begin
            reg1 <= {12'h0, immediate};
        end
        else
            reg1 <= in_reg1;
    end
endmodule
