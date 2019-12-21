`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/20 00:26:24
// Design Name: 
// Module Name: Add
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

//32位加法器
module Add(
    cin, x, y, sum, cout, overflow
);
    parameter n = 5;
    input cin;  //进位输入信号
    input [n-1:0] x, y; //加数与被加数
    output [n-1:0] sum; //加法结果
    output cout, overflow;  //进位输出信号和溢出信号
    wire [n:0] tout;    //进位信号共有n+1位

    assign tout[0] = cin;   //进位输入信号赋值给进位信号的第一位
    assign cout = tout[n];  //进位信号的末位为进位输出信号
    
    //使用生成能力，实例化5个全加器，得到4位的加法结果sum    
    genvar i;
    generate
        for(i = 0; i <= n-1; i = i + 1)
        begin
            fullAdder stage(x[i], y[i], tout[i], sum[i], tout[i+1]);
        end
    endgenerate
    
    //溢出位：如果加数和被加数最高位（符号位）相同可而结果的最高位（符号位）与之不同，则有溢出
    assign overflow = (x[n-1] & y[n-1] & ~sum[n-1] | (~x[n-1] & ~y[n-1] & sum[n-1]));

endmodule // Add


