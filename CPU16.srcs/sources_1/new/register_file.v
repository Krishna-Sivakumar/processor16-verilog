`timescale 1ns / 1ps

// TODO balance output

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
    
    integer i;
    reg [15:0] file [15:0];
    
    initial begin
        for (i = 0; i < 16; i = i + 1) begin
            file[i] = 0;
        end
    end
    
    // was @(*)
    always @(reg1, reg2, posedge clk) begin
        result_reg1 <= file[reg1];
        result_reg2 <= file[reg2];
    end
    
    always @(negedge clk) begin
        // at a negative edge, if writes are enabled, write some data to a target register.
        // writes are done while the instruction and control signals of the current instruction are still present, before the next positive edge
//        $monitor("REGISTER FILE: Time: %0t | Target Register: %h | Data To Write: %h", $time, reg_write, write_data);
        if (enable_write) begin
            $monitor("REGISTER FILE | wrote %h at location %h", write_data, reg_write); 
            file[reg_write] <= write_data;
        end
    end
endmodule
