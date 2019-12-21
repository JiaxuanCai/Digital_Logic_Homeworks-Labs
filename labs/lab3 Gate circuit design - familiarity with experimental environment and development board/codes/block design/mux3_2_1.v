`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/24 19:57:44
// Design Name: 
// Module Name: mux3_2_1
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


module mux2_1(f,in0,in1,cntrl);
input[2:0] in0,in1;
input cntrl;
output reg[2:0] f;
always@ (in0, in1, cntrl)
    f=cntrl?in1:in0;
endmodule
