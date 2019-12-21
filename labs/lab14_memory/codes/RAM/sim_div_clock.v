`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/25 23:47:29
// Design Name: 
// Module Name: sim_div_clock
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


module sim_div_clock(

    );
        
reg clk, cs, rst;
reg [2:0] din_a;
reg [2:0] addr_a;
reg we_a, oe_a;
wire [2:0] dout_a;

reg [2:0] din_b;
reg [2:0] addr_b;
reg we_b, oe_b;
wire [2:0] dout_b;
wire [2:0] memout;
reg clk_rst;
reg load;

    initial begin
        clk  = 0;
        clk_rst = 0;
        #5 clk_rst = 1;
        #5 clk_rst = 0;
    end
    
    always #5 clk = ~clk;
    // top_div_test test_div(clk, clk_rst);
    top_double_ram_sy test(
    clk, rst, cs,
    din_a, addr_a, dout_a, we_a, oe_a,
    din_b, addr_b, dout_b, we_b, oe_b,
    clk_rst,
    load
    );
endmodule
