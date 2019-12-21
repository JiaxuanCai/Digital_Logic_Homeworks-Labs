`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/01 10:47:06
// Design Name: 
// Module Name: MUX41
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


module MUX41(
    input a,
    input b,
    input c,
    input d,
    input sel1,
    input sel2,
    output ot
    );
    reg ot;
    always@(a or b or c or d or sel1 or sel2)
        case({sel1,sel2})
        2'b00:ot=a;
        2'b01:ot=b;
        2'b10:ot=c;
        2'b11:ot=d;
        endcase
endmodule
