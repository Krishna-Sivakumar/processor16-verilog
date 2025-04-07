`timescale 1ns / 1ps

module TestALU();
    reg [15:0] a, b;
    reg [3:0] control;
    wire [15:0] ALU_output;
    wire branch_taken;

    ALU alu (
        .a(a),
        .b(b),
        .control(control),
        .result(ALU_output),
        .zero(branch_taken)
    );

    initial begin
        $display("Starting ALU Test\n");

        a = 16'd5; b = 16'd10; control = 4'b0000;
        #10 $display("ADD: %0h + %0h = %0h", a, b, ALU_output);

        a = 16'd15; b = 16'd4; control = 4'b0001;
        #10 $display("SUB: %0h - %0h = %0h", b, a, ALU_output);
        
        a = 16'd4; b = 16'd15; control = 4'b0001;
        #10 $display("SUB: %0h - %0h = %0h", b, a, ALU_output);

        a = 16'd1; b = 16'd4; control = 4'b0010;
        #10 $display("SLL: %0h << %0h = %0h", a, b, ALU_output);

        a = 16'b1010101010101010; b = 16'b1111000011110000; control = 4'b0011;
        #10 $display("AND: %0h & %0h = %0h", a, b, ALU_output);

        a = 16'd30; b = 16'd31; control = 4'b0100;
        #10 $display("NEQ (not equal): %0h != %0h? %b", a, b, branch_taken);
        
        a = 16'd30; b = 16'd30; control = 4'b0100;
        #10 $display("NEQ (not equal): %0h != %0h? %b", a, b, branch_taken);

        $display("\nALU Test Completed");
        $stop;
    end

endmodule
