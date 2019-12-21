`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/25 16:37:50
// Design Name: 
// Module Name: xiaodou
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

//module xiaodou(
//    input clk, // 系统时钟
//    input reset, // 重置信号
//    input load_in, // 开始读取加载信号
//    input clock_in, // 移位使能信号
//    output load_out, // 处理后的加载信号
//    output clock_out, // 处理后的使能信号
//    output key_rrr,
//    output key_rr,
//    output key_r
//    );
//    reg key_rrr,key_rr,key_r;
//    reg load_rrr,load_rr,load_r;
//    always @(posedge clk or negedge reset)
//       if(!reset) 
//          begin // key 和 load均为高电平有效，故初始化为0
//             key_rrr <=0;
//             key_rr <=0;
//             key_r <=0;
//             load_rrr <=0;
//             load_rr <=0;
//             load_r <=0;
//          end
//        else
//          begin // 在三个时钟周期内进行取样，由于采用非阻塞式赋值，更新彼此有一个时钟周期的延迟
//              key_rrr <= key_rr;
//              key_rr <= key_r;
//              key_r <= clock_in;
//              load_rrr <= load_rr;
//              load_rr <= load_r;
//              load_r <= load_in;
//          end 
//    assign clock_out = key_rrr & key_rr & key_r; // 三个时钟周期内的三次取样均为高电平，说明稳定
//    assign load_out = load_rrr & load_rr & load_r;
//endmodule
module xiaodou(
    input clk, // 系统时钟
    input reset, // 重置信号
    input load_in, // 开始读取加载信号
    input clock_in, // 移位使能信号
    output load_out, // 处理后的加载信号
    output clock_out // 处理后的使能信号
    );
    reg key_rrr,key_rr,key_r;
    reg load_rrr,load_rr,load_r;
    always @(posedge clk or negedge reset)
       if(!reset) 
          begin // key 和 load均为高电平有效，故初始化为0
             key_rrr <=0;
             key_rr <=0;
             key_r <=0;
             load_rrr <=0;
             load_rr <=0;
             load_r <=0;
          end
        else
          begin // 在三个时钟周期内进行取样，由于采用非阻塞式赋值，更新彼此有一个时钟周期的延迟
              key_rrr <= key_rr;
              key_rr <= key_r;
              key_r <= clock_in;
              load_rrr <= load_rr;
              load_rr <= load_r;
              load_r <= load_in;
          end 
    assign clock_out = key_rrr & key_rr & key_r; // 三个时钟周期内的三次取样均为高电平，说明稳定
    assign load_out = load_rrr & load_rr & load_r;
endmodule

