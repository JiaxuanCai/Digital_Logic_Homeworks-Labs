`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/25 15:37:27
// Design Name: 
// Module Name: div_clock
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


module div_clock(
input clk,
input rst_clk,
output div_clk_w
    );
reg div_clk;
assign div_clk_w = div_clk;
reg [21:0] cnt;
always@(posedge clk or negedge rst_clk) begin
    if(rst_clk == 1) begin
        cnt = 0;
        div_clk = 0;
    end
    else if(cnt == 22'd50000) begin
        div_clk = ~div_clk;
        cnt = 0;
    end
    else begin
        cnt = cnt + 1;
    end
end

endmodule
