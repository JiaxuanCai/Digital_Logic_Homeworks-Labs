`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/25 15:13:59
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
    input cs,
    input rst,
    input rst_clk,
    input load,
    output cs_o,
    output rst_o,
    output rst_clk_o,
    output load_o
    );
    reg cs_rrr, cs_rr, cs_r;
    reg rst_rrr, rst_rr, rst_r;
    reg rst_clk_rrr, rst_clk_rr, rst_clk_r;
    reg load_rrr, load_rr, load_r;
    always @(posedge clk)
    begin
        cs_rrr = cs_rr;
        cs_rr = cs_r;
        cs_r = cs;
        
        rst_rrr = rst_rr;
        rst_rr = rst_r;
        rst_r = rst;
        
        rst_clk_rrr = rst_clk_rr;
        rst_clk_rr = rst_clk_r;
        rst_clk_r = rst_clk;
        
        load_rrr = load_rr;
        load_rr = load_r;
        load_r = load;
    end 
    assign cs_o = cs_rrr && cs_rr && cs_r;
    assign rst_o = rst_rrr && rst_rr && rst_r;
    assign rst_clk_o = rst_clk_rrr && rst_clk_rr & rst_clk_r;
    assign load_o = load_rrr && load_rr && load_r;
endmodule
