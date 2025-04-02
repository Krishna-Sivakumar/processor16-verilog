`timescale 1ns / 1ps

module Control(
    input [15:0] instruction,
    input clk,
    output reg reg_write,       // signify that result is written back to rt / rd
    output reg is_immediate,    // signify that the first register is an immediate value
    output reg mem_write,       // signify that the data memory must be written to
    output reg mem_read         // signify that the data memory is being read from
    );
    
    wire [3:0] opcode = instruction[15:12];
    
    initial begin
        reg_write <= 0;
        is_immediate <= 0;
        mem_write <= 0;
        mem_read <= 0;
    end
    
    always @(*) begin
        case (opcode)
            4'h0: begin // r-type
                reg_write <= 1;
                is_immediate <= 0;
                mem_write <= 0;
                mem_read <= 0;
            end
            4'h1: begin // lw
                reg_write <= 1;
                is_immediate <= 1;
                mem_write <= 0;
                mem_read <= 1;  
            end
            4'h2: begin // sw
                reg_write <= 0;
                is_immediate <= 1;
                mem_write <= 1;
                mem_read <= 0;
            end
            4'h3: begin // addi
                reg_write <= 1;
                is_immediate <= 1;
                mem_write <= 0;
                mem_read <= 0;
            end
            4'h4: begin // beq
                reg_write <= 0;
                is_immediate <= 1;
                mem_write <= 0;
                mem_read <= 0;
            end
            4'h5: begin // bne
                reg_write <= 0;
                is_immediate <= 1;
                mem_write <= 0;
                mem_read <= 0;
            end
            4'h6: begin // jmp
                reg_write <= 0;
                is_immediate <= 0;
                mem_write <= 0;
                mem_read <= 0;
            end
            default: begin
                reg_write <= 0;
                is_immediate <= 0;
                mem_write <= 0;
                mem_read <= 0;
            end
        endcase
    end
    
endmodule
