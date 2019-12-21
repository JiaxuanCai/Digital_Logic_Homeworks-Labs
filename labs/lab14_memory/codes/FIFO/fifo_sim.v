`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/26 14:09:21
// Design Name: 
// Module Name: fifo_sim
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


module fifo_sim;
    parameter N = 8; //数据宽度
    parameter M = 4; //fifo的地址宽度
    reg clko; //输入时钟
    reg clk; //系统时钟，用于消抖
    reg reset; //消抖复位信号
    reg rst_n; //输入复位信号
    reg wr; //输入写使能
    reg[N-1:0] w_data; //输入输入
    reg rd; //输入读使能
    wire empty; //输出fifo空标志
    wire full; //输出fifo满标志
    wire[N-1:0] r_data; //输出读取的数据
    
    initial begin
        clk = 0;
        clko = 0;
    end
    
    initial begin
        reset = 1; rst_n = 1; wr = 0; rd = 0;
        #10 reset = 0; rst_n = 0; wr = 1;
        #100 rd = 1;      
    end
    
    initial begin 
        #10 w_data = 8'b11010101;
        #500 w_data = 8'b00010001;
        #1000 w_data = 8'b01011001;
        #1500 w_data = 8'b00000000;  end
        
    always begin
        #2 clk = ~clk;
    end
    
    always begin
        #10 clko = ~clko;
    end
fifo_cus f(
     clko, //输入时钟
     clk, //系统时钟，用于消抖
     reset, //消抖复位信号
     rst_n, //输入复位信号
     wr, //输入写使能
     w_data, //输入输入
     rd, //输入读使能
     empty, //输出fifo空标志
     full, //输出fifo满标志
     r_data //输出读取的数据
);
endmodule
