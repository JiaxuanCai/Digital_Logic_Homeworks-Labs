`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/25 16:41:30
// Design Name: 
// Module Name: check_1101_sim
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


module check_1101_sim;

    reg clk;
    wire dout;
    reg clock_in, reset, clear, load_in;
    reg [7:0] data_in;
    
    initial clk = 0;
    
    always #20 clk = ~clk;
    
    always 
        begin
            #200 clock_in = ~clock_in;   load_in = ~load_in;
        end
    initial 
        begin 
            #10 clock_in = 0; reset = 1; clear = 1; load_in = 0; //clock_in,reset为0时重置消抖，clear为1时重置状态机，load_in为1时开始并转串
            #40 clear = 0; reset = 0;
            /*#50 clock_in = 1; reset = 1; clear = 0; load_in = 1;
            #50 clock_in = 0; reset = 1; clear = 0; load_in = 0;*/
        end
    
//    initial 
//        begin        
//            #50  reset = 1; clear = 0; load_in = 1;
//            #
//        end
        
    initial 
        begin
            data_in = 8'b11010101;
        end
        
    check c(
             clk,//系统时钟
             clock_in,// 并转串移位使能信号
             reset,//重置消抖
             clear,//重置状态机
             load_in,// 读取并行序列的加载信号
             data_in, // 并行输入的序列
             dout // 检测结果信号
            );
//    //_________________________________________________________________________
//initial begin
//    clock = 1'b0;
//    reset = 1'b0;
//    rst=1'b1;
//    #50 begin reset = 1'b1; rst=1'b1; end
//    #50 begin reset=1'b0; rst=1'b0; end
//    #50 begin reset=1'b1; rst=1'b1; end
//    end
//    initial
//    para_in = 8'b11010101;
//    always
//    #5 clock = ~clock;

//module check(
//    input clk,//系统时钟
//    input clock_in,// 并转串移位使能信号
//    input reset,//重置消抖
//    input clear,//重置状态机
//    input load_in,// 读取并行序列的加载信号
//    input [7:0] data_in, // 并行输入的序列
//    output reg dout // 检测结果信号
//    );
//    //_________________________________________________________________________

endmodule
