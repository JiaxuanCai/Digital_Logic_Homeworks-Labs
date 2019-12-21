`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/26 00:17:02
// Design Name: 
// Module Name: top_div_test
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


module top_div_test(
clk, rst
    );
    input clk, rst;
    wire clk_div;
    div_clock test(clk, rst, clk_div);
    
    
endmodule
