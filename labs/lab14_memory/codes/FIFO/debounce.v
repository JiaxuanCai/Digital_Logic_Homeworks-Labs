`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/24 23:59:05
// Design Name: 
// Module Name: debounce
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


module debounce(
    input clk,
    input in,
    input reset,
    output out
    );
    reg key_rrr,key_rr,key_r;
    
        always @(posedge clk or negedge reset)
            if(!reset)
                begin
                    key_rrr <=0;
                    key_rr <=0;
                    key_r <=0;
                end
            else
                begin
                    key_rrr <= key_rr;
                    key_rr <= key_r;
                    key_r <= in;
                end 
        assign out = key_rrr & key_rr & key_r;
endmodule
