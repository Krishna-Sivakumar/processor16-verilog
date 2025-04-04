`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2025 06:35:57 PM
// Design Name: 
// Module Name: Complete
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


module Complete;

    reg clk;
    initial begin
        // oscillate the clock every 5ns
        clk = 1;
        forever
            #5 clk = ~clk;
    end
    
    wire [15:0] PC, PCNext, Instruction;
    reg [15:0] PCNext;
    ProgramCounter pc (
        .next(PCNext),
        .pc(PC),
        .clk(clk)
    );
    
    ProgramCounterUpdate pcu (
        .pc(PC),
        .instruction(Instruction),
        .branch_zero(AluZeroOut),
        .pc_next(PCNext)
    );
    
    InstructionMemory im (
        .pc(PC),
        .instruction(Instruction),
        .clk(clk)
    );
    
    wire [15:0] RegA, RegB, AluOut, DMUOut, RegDmuMuxOut;
    wire [3:0] AluControlOut;
    wire AluZeroOut;
    
    wire EnableWrite, RegAIsImmediate, WriteToDMU, ReadFromDMU;
    
    Control ctl(
        .instruction(Instruction),
        .reg_write(EnableWrite),
        .is_immediate(RegAIsImmediate),
        .mem_write(WriteToDMU),
        .mem_read(ReadFromDMU),
        .clk(clk)
    );
    
    
    wire [3:0] RtRd     = Instruction[11:8];
    wire [3:0] Rs       = Instruction[7:4];
    wire [3:0] FunctImm = Instruction[3:0];     // A common wire for R-Type and I-Type instructions
    wire [11:0] Address = Instruction[11:0];    // for J-type Instructions
    
    RegisterDmuMux reg_dmu_mux(
        .mem_read(ReadFromDMU),
        .dmu_data(DMUOut),
        .alu_data(AluOut),
        .reg_out(RegDmuMuxOut)
    );
    
    RegisterFile reg_file(
        .reg1(RtRd),
        .reg2(Rs),
        .reg_write(RtRd),
        .write_data(RegDmuMuxOut),
        .clk(clk),
        .enable_write(EnableWrite),
        .result_reg1(RegA),
        .result_reg2(RegB)
    );
            
    ALUControl alu_ctl (
        .instruction(Instruction),
        .alu_operation(AluControlOut)
    );
    
    wire [15:0] RegAMuxed;
    ALURegisterMux alu_mux (
        .in_reg1(RegA),
        .instruction(Instruction),
        .immediate(FunctImm),
        .is_imm(RegAIsImmediate),
        .reg1(RegAMuxed) 
    );
    
    ALU alu (
        .a(RegAMuxed),
        .b(RegB),
        .control(AluControlOut),
        .result(AluOut),
        .zero(AluZeroOut),
        .clk(clk)
    );
    
    DataMemory dmu (
        .location(AluOut),
        .write_data(RegA),
        .mem_write(WriteToDMU),
        .mem_read(ReadFromDMU),
        .read_data(DMUOut),
        .clk(clk)
    );

    
    initial begin
        // NOTE TO INSTRUCTORS: please set the number below to (the amount of instructions in your program) * 10 + 5
        #420;
        $finish;
    end
    
endmodule
