`timescale 1ns / 1ps

module ProgramCounter(
    input [15:0] next,
    input clk,
    output reg [15:0] pc
    );
    
    initial begin
        pc = -2;
    end

    always @(posedge clk) begin
        pc = next;
    end
endmodule
