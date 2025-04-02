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
            4'b0000: result <= a + b; 
            4'b0001: result <= a - b;
            4'b0010: result <= a << b;
            4'b0011: result <= a & b;
            4'b0100: begin
                zero <= a ^ b;
                result <= 0;
            end
            default: result <= 0;
        endcase
    end
    
endmodule
