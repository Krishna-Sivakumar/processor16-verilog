`timescale 1ns / 1ps

// TODO initialize all memory locations to 0

module DataMemory(
    input clk,
    input [15:0] location,
    input [15:0] write_data,
    input mem_write,             // if mem_write is set, write data to location.
    input mem_read,              // if mem_read is set, read data from location.
    output reg [15:0] read_data
    );

    reg [15:0] mem [15:0];
    reg [15:0] slot;
    
    initial begin
        mem[6] = 16'h3;
    end
   
    // TODO memory should be byte addressable. Fix this.
    // TODO read memory in big-endian mode and swap the bytes around
    // TODO write memory in big-endian mode and swap the bytes into the memory
    
    always @(negedge clk) begin
        if (mem_write) begin
            mem[location] <= write_data;
            read_data <= 0;
        end
    end
    
    always @(*) begin
        if (mem_read) begin
            read_data <= mem[location];
        end
    end
endmodule
