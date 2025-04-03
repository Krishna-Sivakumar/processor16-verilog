`timescale 1ns / 1ps

// TODO balance output
// TODO initialize all memory locations to 0

module RegisterFile(
    input [3:0] reg1,
    input [3:0] reg2,
    input [3:0] reg_write,
    input [15:0] write_data,
    input clk,
    input enable_write,                 // Flag that enables writes to registers
    output reg [15:0] result_reg1,      // Rt/Rd
    output reg [15:0] result_reg2       // Rs
    );
    
    reg [15:0] file [4:0];
    
    initial begin
        file[4'h0] = 0;
        file[4'h1] = 0;
        file[4'h2] = 0;
        file[4'h3] = 0;
    end
    
    always @(*) begin
        result_reg1 <= file[reg1];
        result_reg2 <= file[reg2];
    end
    
    always @(negedge clk) begin
        // at a negative edge, if writes are enabled, write some data to a target register.
        // writes are done while the instruction and control signals of the current instruction are still present, before the next positive edge
        $monitor("Time: %0t | Target Register: %h | Data To Write: %h", $time, reg_write, write_data);
        if (enable_write) begin
            file[reg_write] = write_data;
        end
    end
endmodule
