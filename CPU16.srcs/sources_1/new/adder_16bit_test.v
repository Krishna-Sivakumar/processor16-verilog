`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2025 05:41:55 PM
// Design Name: 
// Module Name: adder_16bit_test
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


module adder_16bit_test;
    reg [15:0] A, B;
    wire [15:0] Sum, Diff, And;
    
    adder_16bit outSum (
        .A(A),
        .B(B),
        .Sum(Sum)
    );
    
    sub_16bit outSub (
        .A(A),
        .B(B),
        .Diff(Diff)
    );
    
    and_16bit outAnd (
        .A(A),
        .B(B),
        .Out(And)
    );
    
    reg [15:0] SllA, SllB;
    wire [15:0] SllOut;
    
    sll OutSll (
        .A(SllA),
        .B(SllB),
        .O(SllOut)
    );
    
    initial begin
        $monitor("Time = %0t | A = %h | B = %h | Sum = %h", $time, A, B, Sum);
        
        A = 16'h0001; B = 16'h0001; #10; // 1 + 1 = 2
        A = 16'h0010; B = 16'h0005; #10; // 16 + 5 = 21
        A = 16'hFFFF; B = 16'h0001; #10; // Overflow case: 65535 + 1 = 0 (ignores carry)
        A = 16'h1234; B = 16'h5678; #10; // Random case
        A = 16'hABCD; B = 16'h1234; #10; // Another random case

        // End simulation
        $finish;
    end
    
    initial begin
        $monitor("Time = %0t | A = %h | B = %h | Diff = %h", $time, A, B, Diff);
        
        A = 16'h0001; B = 16'h0001; #10; // 1 - 1 = 0
        A = 16'h0010; B = 16'h0005; #10; // 16 - 5 = 11
        A = 16'h0000; B = 16'h0001; #10; // Underflow case: 0 - 1 = 65535
        A = 16'h1234; B = 16'h5678; #10; // Random case
        A = 16'hABCD; B = 16'h1234; #10; // Another random case

        // End simulation
        $finish;
    end
    
    initial begin
        $monitor("Time = %0t | A = %h | B = %h | And = %h", $time, A, B, And);
        
        A = 16'h0001; B = 16'h0001; #10; // 1 & 1 = 1
        A = 16'h0010; B = 16'h0005; #10; // 16 & 5 = 0
        A = 16'h0000; B = 16'h0001; #10; // 0 & 1 = 0
        A = 16'h000f; B = 16'h0003; #10; // 15 & 3 = 3
        A = 16'h00ff; B = 16'h0f0f; #10; // 00ff & 0f0f = 000f

        // End simulation
        $finish;
    end
    
    initial begin
        $monitor("Time = %0t | A = %h | B = %h | SLL = %h", $time, SllA, SllB, SllOut);
        
        SllA = 16'h0001; SllB = 16'h0001; #10; // 1 << 1 = 2
        SllA = 16'h0002; SllB = 16'h0001; #10; // 2 << 1 = 4
        SllA = 16'h0001; SllB = 16'h0003; #10; // 1 << 3 = 8
        SllA = 16'h0000; SllB = 16'h0100; #10; // 0 << 5 = 0
        SllA = 16'h0004; SllB = 16'h0004; #10; // 4 << 4 = 64

        // End simulation
        $finish;
    end

endmodule
