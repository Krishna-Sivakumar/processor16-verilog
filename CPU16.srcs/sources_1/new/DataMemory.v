`timescale 1ns / 1ps

module DataMemory(
    input clk,
    input [7:0] location,
    input [15:0] write_data,
    input mem_write,             // if mem_write is set, write data to location.
    input mem_read,              // if mem_read is set, read data from location.
    output reg [15:0] read_data
    );

    integer i;
    reg [7:0] mem [31:0];
    
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            mem[i] = 8'h0;
        end
        mem[6] = 8'h3;
        mem[7] = 8'h0;
    end
    
    always @(negedge clk) begin
        if (mem_write) begin
            // little-endian:   0x ff 0a (example value)
            // big-endian:      0x 0a ff
            mem[location] <= write_data[15:8];
            mem[location+1] <= write_data[7:0];
            read_data <= 0;
        end
    end
    
    always @(*) begin
        if (mem_read) begin
            // little-endian:   0x ff 0a (example value)
            // big-endian:      0x 0a ff
            read_data[7:0] = mem[location];
            read_data[15:8] = mem[location+1];
        end
    end
endmodule
