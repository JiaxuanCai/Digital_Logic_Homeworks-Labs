`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/26 12:24:42
// Design Name: 
// Module Name: FullAddSub
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



module FullAddSub(
    x, y, subFlag, sum, cout, overflow
);
parameter n = 5;
input [n-1:0] x, y; //输入两个做加减法的数
input subFlag;  //加减法标志

output [n-1:0] sum; //运算结果
output cout;    //进位位
output overflow;  //溢出 

// 对输入的x，y进行处理求补码
wire[n-1:0] proy; 
wire [n-1:0] prox;


assign prox = (x[n-1] == 1) ? (~{2'b0, x[n-2:0]} + 2'b1): x; // x 补码

wire [n-1:0] compFlag; // 是否对y进行求补码的标志
wire negativeY; // 表示y为负数

wire cin; // 表示被减数转为补码时的加1
assign negativeY = (y[n-1] == 1) ? 1 : 0; // y是否为负数
//是否求补码，进行按位异或：当要做减法或是Y为负数的时候求补码
assign compFlag = (subFlag ^ negativeY) ? 5'b11111 : 5'b0; 
assign cin = (subFlag ^ negativeY) ? 1 : 0; 

assign proy[n-2:0] = y[n-2:0] ^ compFlag; // 求补码：除最高位 异或
assign proy[n-1] = subFlag ^ y[n-1]; // 最高位单独处理

wire [n-1:0] compSum;   //对结果求原码
Add myadd(.cin(cin), .x(prox), .y(proy), .sum(compSum), .cout(cout), .overflow(overflow));
// 符号位不变，其余位取反、+1
assign sum[n-1] = compSum[n-1];
assign sum[n-2:0] = (compSum[n-1] == 1) ? ~compSum[n-2:0]+1 : compSum[n-2:0];

endmodule // FullAddSub