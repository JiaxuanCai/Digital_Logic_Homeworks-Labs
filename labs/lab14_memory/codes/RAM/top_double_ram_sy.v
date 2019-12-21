`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/25 15:15:34
// Design Name: 
// Module Name: top_double_ram_sy
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


module top_double_ram_sy(
clk, rst, cs, 
din_a_0, addr_a_0, dout_a, we_a, oe_a,
din_b_0, addr_b_0, dout_b, we_b, oe_b,
rst_clk,
load
    );
    
parameter DATA_WIDTH = 3;
parameter ADDR_WIDTH = 3;
parameter RAM_DEPTH = DATA_WIDTH;

input clk, rst, cs;
input [ADDR_WIDTH-1:0] addr_a_0, addr_b_0;
input [DATA_WIDTH-1:0]  din_a_0, din_b_0;
output [DATA_WIDTH-1:0]  dout_a, dout_b;
input we_a, oe_a, we_b, oe_b;
input rst_clk;
input load;
wire rst_o, cs_o, rst_clk_o, load_o; // 经过消抖后的

wire clk_div;
div_clock my_div_clk(clk, rst_clk, clk_div);

debounce mydebounce(clk, cs, rst, rst_clk, load, cs_o, rst_o, rst_clk_o, load_o);



fpga_double_ram_sy my_double_ram_sy(
    clk, rst_o, cs_o,
    din_a_0, addr_a_0, dout_a, we_a, oe_a,
    din_b_0, addr_b_0, dout_b, we_b, oe_b,
    load_o
);

endmodule
