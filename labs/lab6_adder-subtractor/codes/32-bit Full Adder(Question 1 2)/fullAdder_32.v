`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/16 17:17:47
// Design Name: 
// Module Name: fullAdder_32
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


//
// module fullAdder(
//     input x, y, cin,
//     output sum, cout
// );

module fullAdder_32(
    input [32:0] x, y,
    input cin,
    output cout,
    output [32:0] sum
);
wire [30:0] tout;
fullAdder add0(x[0], y[0], cin, sum[0], tout[0]);
fullAdder add1(x[1], y[1], tout[0], sum[1], tout[1]);
fullAdder add2(x[2], y[2], tout[1], sum[2], tout[2]);
fullAdder add3(x[3], y[3], tout[2], sum[3], tout[3]);
fullAdder add4(x[4], y[4], tout[3], sum[4], tout[4]);
fullAdder add5(x[5], y[5], tout[4], sum[5], tout[5]);
fullAdder add6(x[6], y[6], tout[5], sum[6], tout[6]);
fullAdder add7(x[7], y[7], tout[6], sum[7], tout[7]);
fullAdder add8(x[8], y[8], tout[7], sum[8], tout[8]);
fullAdder add9(x[9], y[9], tout[8], sum[9], tout[9]);
fullAdder add10(x[10], y[10], tout[9], sum[10], tout[10]);
fullAdder add11(x[11], y[11], tout[10], sum[11], tout[11]);
fullAdder add12(x[12], y[12], tout[11], sum[12], tout[12]);
fullAdder add13(x[13], y[13], tout[12], sum[13], tout[13]);
fullAdder add14(x[14], y[14], tout[13], sum[14], tout[14]);
fullAdder add15(x[15], y[15], tout[14], sum[15], tout[15]);
fullAdder add16(x[16], y[16], tout[15], sum[16], tout[16]);
fullAdder add17(x[17], y[17], tout[16], sum[17], tout[17]);
fullAdder add18(x[18], y[18], tout[17], sum[18], tout[18]);
fullAdder add19(x[19], y[19], tout[18], sum[19], tout[19]);
fullAdder add20(x[20], y[20], tout[19], sum[20], tout[20]);
fullAdder add21(x[21], y[21], tout[20], sum[21], tout[21]);
fullAdder add22(x[22], y[22], tout[21], sum[22], tout[22]);
fullAdder add23(x[23], y[23], tout[22], sum[23], tout[23]);
fullAdder add24(x[24], y[24], tout[23], sum[24], tout[24]);
fullAdder add25(x[25], y[25], tout[24], sum[25], tout[25]);
fullAdder add26(x[26], y[26], tout[25], sum[26], tout[26]);
fullAdder add27(x[27], y[27], tout[26], sum[27], tout[27]);
fullAdder add28(x[28], y[28], tout[27], sum[28], tout[28]);
fullAdder add29(x[29], y[29], tout[28], sum[29], tout[29]);
fullAdder add30(x[30], y[30], tout[29], sum[30], tout[30]);
fullAdder add32(x[31], y[31], tout[30], sum[31], cout);

endmodule // input [31:0] x, [31:0] y
