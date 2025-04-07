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
    end
    
    always @(negedge clk) begin
        if (mem_write) begin
            mem[location] <= write_data[15:8];
            mem[location+1] <= write_data[7:0];
            read_data <= 0;
            $monitor("DMU | Stored %h to location %h", write_data, location);
        end
    end
    
    always @(*) begin
        if (mem_read) begin
            read_data[15:8] = mem[location];
            read_data[7:0]  = mem[location+1];
            $monitor("DMU | Loaded %h from location %h", read_data, location);
        end
    end
endmodule
