`timescale 1ns / 1ps

// This module handles updating the program counter during normal execution, branches and jumps.

module ProgramCounterUpdate(
    output reg [15:0] pc_next,
    input [15:0] pc,
    input [15:0] instruction,   // instruction; contains immediate address, and the opcode.
    input branch_zero           // should be 0 for beq, and 1 for bne
    );
    
    wire [3:0] opcode = instruction[15:12];
    reg [15:0] immediate;
    reg [15:0] jmp_address;
    
    always @(*) begin
        immediate = { {12{instruction[3]}}, instruction[3:0]};      // first sign-extend the immediate value
        immediate = immediate << 1;                                 // then multiply it by 2
        
        jmp_address = { {4{instruction[11]}}, instruction[11:0] };  // first sign-extend the immediate value
        jmp_address = jmp_address << 1;                             // then multiply it by 2
        
        if (opcode == 4 && branch_zero == 0) begin          // beq
            pc_next = pc + immediate + 2;
        end else if (opcode == 5 && branch_zero == 1) begin // bne
            pc_next = pc + immediate + 2;
        end else if (opcode == 6) begin                     // jmp
            pc_next = pc + jmp_address + 2;
        end else begin                                      // advance program counter; regular case
            pc_next = pc + 2;
        end
    end
endmodule
