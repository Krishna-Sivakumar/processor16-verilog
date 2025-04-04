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
    input [15:0] instruction,   // instruction; needed to check the opcode, so that we don't output the immediate value for bne and beq
    input is_imm,               // is_imm differentiates the output
    output reg [15:0] reg1
);

    wire [3:0] opcode = instruction[15:12];

    always @(*) begin
        // if the instruction is beq or bne, don't output the immediate value
        if (opcode == 4'h4 || opcode == 4'h5) begin
            reg1 <= in_reg1;
        end else if (is_imm) begin
            reg1 <= { {12{immediate[3]}}, immediate }; // sign extension
        end
        else
            reg1 <= in_reg1;
    end
endmodule
