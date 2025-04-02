`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 01:19:20 AM
// Design Name: 
// Module Name: RegisterDmuMux
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


module RegisterDmuMux(
    input mem_read,             // Flag from the Control Unit; Data Memory is being read from.
    input [15:0] dmu_data,
    input [15:0] alu_data,
    output reg [15:0] reg_out
    );
    
    always @(*) begin
        if (mem_read)
            reg_out <= dmu_data;
        else
            reg_out <= alu_data;
    end
    
endmodule
