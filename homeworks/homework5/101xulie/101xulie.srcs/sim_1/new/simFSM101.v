`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/31 16:18:41
// Design Name: 
// Module Name: simFSM101
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


module simFSM101(
    );
    reg a, clk, rst;
    wire z;
    FSM101 meal(.z(z),.clk(clk),.rst(rst),.a(a));
    initial begin
        clk = 0;
        rst = 1;
        #5 rst = 0;
        #3 rst = 1;
        #100 a = 0;
        #100 a = 0;
        #100 a = 1;
        #100 a = 0;
        #100 a = 1;
        #100 a = 0;
        #100 a = 1;
        #100 a = 1;
        #100 a = 0;
        #100 a = 1;
        #100 a = 0;
        #100 a = 0;
        #100 a = 1;
        #100 a = 0;
        #100 a = 1;
        #100 a = 1;
        #100 a = 0;
        #100 a = 1;
        #100 a = 0;
    end
    always #50 clk = ~clk;
endmodule