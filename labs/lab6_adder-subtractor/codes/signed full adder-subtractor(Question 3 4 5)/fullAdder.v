`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/20 00:36:40
// Design Name: 
// Module Name: fullAdder
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

//È«¼ÓÆ÷Ä£¿é
module fullAdder(
    input x, y, cin,
    output sum, cout
);
assign sum = x ^ y ^ cin;
assign cout = (x & y) | (x & cin) | (y & cin);
endmodule // fullAdder