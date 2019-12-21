`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/25 18:16:31
// Design Name: 
// Module Name: xiaodou_sim
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


module xiaodou_sim;
    reg clk; // 系统时钟
    reg reset; // 重置信号
    reg load_in; // 开始读取加载信号
    reg clock_in; // 移位使能信号
    wire load_out; // 处理后的加载信号
    wire clock_out; // 处理后的使能信号
    
    initial 
        begin 
            clk = 1; reset = 1;
            clock_in = 0; load_in = 0; 
            #50 reset = 0;
        end
        
    always #20 clk = ~clk;
        
    always 
        begin
            #200 clock_in = ~clock_in;   load_in = ~load_in;
        end
    
    xiaodou x(
     clk, // 系统时钟
     reset, // 重置信号
     load_in, // 开始读取加载信号
     clock_in, // 移位使能信号
     load_out, // 处理后的加载信号
     clock_out // 处理后的使能信号
    );
endmodule
