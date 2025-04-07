`timescale 1ns / 1ps

// Module to display a register value to the 7-segment display.
// Reference: https://www.fpga4student.com/2017/09/seven-segment-led-display-controller-basys3-fpga.html

module Display(
    input clock_100Mhz,         // a connection to the basys 3's 100Mhz clock
    input reset,                // a reset line, coming from the LED
    input [15:0] value,         // the value to display
    output reg [6:0] led_out,   // lines to display a single segment 
    output reg [3:0] anode      // line to select a 7-segment out of 4 7-segments
    );
    
    // timing portion begin
    reg [19:0] refresh_counter;
    wire [1:0] refresh_activate;
    reg [3:0] byte;
    
    initial begin
        refresh_counter = 0;
    end
    
    always @(posedge clock_100Mhz or posedge reset) begin
        if (reset == 1) refresh_counter <= 0;
        else refresh_counter <= refresh_counter + 1;
    end
    assign refresh_activate = refresh_counter[19:18];
    // timing portion end
    
    // activate a 7-segment display based on the refresh counter
    always @(*) begin
        case (refresh_activate)
            2'h0: begin
                anode = 4'b0111;        // activate led 1 alone, others are off
                byte= value[15:12];
            end
            2'h1: begin
                anode = 4'b1011;        // activate led 2 alone, others are off
                byte = value[11:8];
            end
            2'h2: begin
                anode = 4'b1101;
                byte = value[7:4];
            end
            2'h3: begin
                anode = 4'b1110;
                byte = value[3:0];
            end
            default: begin
                anode = 4'b0111;
                byte = value[15:12];
            end
        endcase
    end
    
    // abcdefg - high is off, low is on
    // render the value on the display
    always @(*) begin
        case (byte)
            'h0: led_out = 7'b0000001;
            'h1: led_out = 7'b1001111;
            'h2: led_out = 7'b0010010;
            'h3: led_out = 7'b0000110;
            'h4: led_out = 7'b1001100;
            'h5: led_out = 7'b0100100;
            'h6: led_out = 7'b0100000;
            'h7: led_out = 7'b0001111;
            'h8: led_out = 7'b0000000;
            'h9: led_out = 7'b0000100;
            'ha: led_out = 7'b0001000;
            'hb: led_out = 7'b0000000;
            'hc: led_out = 7'b0110001;
            'hd: led_out = 7'b0000001;
            'he: led_out = 7'b0110000;
            'hf: led_out = 7'b0111000;
        endcase
    end
    
endmodule
