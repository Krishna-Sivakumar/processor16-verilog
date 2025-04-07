`timescale 1ns / 1ps

module CompleteDemo(
    input clk,
    input clock_100Mhz,
    input LedReset,
    output [15:0] RegA,
    output [6:0]  LedOut,
    output [3:0]  Anode
);

    /*
    reg clk;        // TODO should be bound to an external input
    initial begin
        // oscillate the clock every 2ns
        clk = 1;
        forever
            #2 clk = ~clk;
    end
    */
    
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
    
    wire [15:0] RegB, AluOut, DMUOut, RegDmuMuxOut; // TODO RegA should be an external output
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
    
    Display display (
        .clock_100Mhz(clock_100Mhz),
        .reset(LedReset),
        .value(RegA),
        .led_out(LedOut),
        .anode(Anode)
    );
    
    initial begin
        // NOTE FOR INSTRUCTORS: please set the timestamp below to a long enough number so that the program can finish executing.
        #200 $finish;
    end
    
endmodule
