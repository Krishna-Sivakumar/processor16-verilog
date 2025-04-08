`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 03:57:21 AM
// Design Name: 
// Module Name: TestControl
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


module TestControl;
    reg [15:0] instruction;
    wire reg_write, mem_read, mem_write, immediate, branch, jump;
    wire [3:0] alu_op;
    wire clk;

    Control uut (
        .instruction(instruction),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .is_immediate(immediate),
        .clk(clk)
    );
    
    ALUControl alu_ctl (
        .instruction(instruction),
        .alu_operation(alu_op)
    );

    task test_instruction;
        input [15:0] instr;
        begin
            instruction = instr;
            #1;
            $display("Instr = %h | reg_write=%b, mem_read=%b, mem_write=%b, is_immediate=%b, alu_op=%b",
                     instr, reg_write, mem_read, mem_write, immediate, alu_op);
        end
    endtask

    initial begin
        $display("==== Control Unit Test Start ====");

        test_instruction(16'b0000_0001_0010_0000); // ADD
        test_instruction(16'b0000_0001_0010_0001); // SUB
        test_instruction(16'b0000_0001_0010_0010); // AND
        test_instruction(16'b0000_0001_0010_0011); // SLL
        test_instruction(16'b0001_0001_0010_0011); // LW
        test_instruction(16'b0010_0001_0010_0011); // SW
        test_instruction(16'b0011_0001_0010_0011); // ADDI
        test_instruction(16'b0100_0001_0010_0000); // BEQ
        test_instruction(16'b0101_0001_0010_0000); // BLT
        test_instruction(16'b0110_0000_0000_0001); // JMP

        $display("==== Control Unit Test Done ====");
        $stop;
    end
endmodule
