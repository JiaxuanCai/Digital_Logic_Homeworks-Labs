`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/25 17:48:16
// Design Name: 
// Module Name: par2ser_sim
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


module par2ser_sim;
    reg clk;
    wire q;
    reg set;
    reg [7:0] d;
    
    initial clk = 0;
    always #20 clk = ~clk;
    
    initial
    begin
        set = 1;    //set为1将数据全部读入，为0开始并转串
        d = 8'b11010101;
        #20 set = 0;
    end
    
    par2ser p2s(clk,set,d,q);
endmodule
