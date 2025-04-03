`timescale 1ns / 1ps

module ProgramCounterUpdate(
    output reg [15:0] pc_next,
    input [15:0] pc,
    input [15:0] instruction,   // instruction; contains immediate address, and the opcode.
    input branch_zero           // should be 0 for beq, and 1 for bne
    );

    // TODO test this module
    
    wire [3:0] opcode = instruction[15:12];
    reg [15:0] immediate;
    reg [11:0] jmp_address;
    
    always @(*) begin
        immediate <= {{11{instruction[3]}}, instruction[3:0] << 1};     // sign-extended immediate value
        jmp_address <= {3'h0, instruction[11:0] << 1};
        if (opcode == 4 && branch_zero == 0) begin          // beq
            pc_next <= pc + immediate + 2;
        end else if (opcode == 5 && branch_zero == 1) begin // bne
            pc_next <= pc + immediate + 2;
        end else if (opcode == 6) begin                     // jmp
            pc_next <= pc + { {4{jmp_address[11]}}, jmp_address} + 2;   // sign-extended jump address
        end else begin                                      // advance program counter; regular case
            pc_next <= pc + 2;
        end
    end
endmodule
