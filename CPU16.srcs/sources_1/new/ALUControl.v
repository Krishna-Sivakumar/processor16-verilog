`timescale 1ns / 1ps

module ALUControl(
    input [15:0] instruction,
    output reg [3:0] alu_operation
    );
    
    wire [3:0] opcode = instruction[15:12];
    wire [3:0] functimm = instruction[3:0];
    
    always @(*) begin
        case (opcode)
            4'h0: alu_operation <= functimm; // function code is the operation required for R-Type instructions
            4'h1: alu_operation <= 4'b0000; //lw;   ALU must add Rs + Imm for the target address
            4'h2: alu_operation <= 4'b0000; //sw;   ALU must add Rs + Imm for the target address
            4'h3: alu_operation <= 4'b0000; //addi; ALU must add Rs + Imm to be written to Rt / Rd
            4'h4: alu_operation <= 4'b0001; //beq;  ALU must check if Rt/Rd ^ Rs == 0 (they're the same)
            4'h5: alu_operation <= 4'b0100; //bne;  ALU must check if Rt/Rd ^ Rs != 0 (they're different)
            4'h6: alu_operation <= 4'b0010; //jmp:  Shift address (instruction[11:0]) by 1.
            default: alu_operation <= 0;    // add by defaultH
        endcase
    end
endmodule
