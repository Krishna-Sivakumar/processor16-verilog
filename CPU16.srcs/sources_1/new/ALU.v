`timescale 1ns / 1ps

// TODO balance output

module ALU(
    input [3:0] control,
    input [15:0] a,
    input [15:0] b,
    input clk,
    output reg [15:0] result,
    output reg zero
    );
    
    /*
    Table:
    
    Control | Function
    0000    | ADD
    0001    | SUB
    0010    | SLL; Shift Register Left by a certain amount
    0011    | AND
    0100    | XOR
    */
    always @(*) begin
        $monitor("ALU Params: %h, %h, op: %h", a, b, control);
        case (control)
            4'b0000: begin
                result = a + b;
                zero = 0;
            end
            4'b0001: begin
                result = a - b;
                zero = 0;
            end
            4'b0010: begin
                result = a << b;
                zero = 0;
            end
            4'b0011: begin
                result = a & b;
                zero = 0;
            end
            4'b0100: begin
                result = 0;
                zero = a ^ b;
            end
            default: begin
                result = 0;
                zero = 0;
            end
        endcase
    end
    
endmodule
