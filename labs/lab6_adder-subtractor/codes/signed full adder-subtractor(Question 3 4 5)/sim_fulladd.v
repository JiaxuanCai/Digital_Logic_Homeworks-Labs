`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/17 15:36:44
// Design Name: 
// Module Name: sim_fulladd
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


module sim_fulladd;
reg  [4:0] x, y;
reg subFlag;
wire [4:0] sum;
wire cout, overflow;
reg clk;

initial clk = 0;
always # 10 clk = ~clk;
initial begin
x = 5'b0;
y = 5'b0;
subFlag = 0;

end

initial begin
    
    #50 subFlag = 0;
    #50 x = 5'd3;
    #50 y = 5'd5;
    
    
    #50 x = 0;
    #50 y = 0;
    
    
    #50 subFlag = 1;
    #50 x = 5'd3;
    #50 y = 5'd5;
    
    #50 x = 0;
    #50 y = 0;
    

    #50 subFlag = 1;
    #50 x = 5'd0;
    #50 y = 5'd0;
    
    #50 subFlag = 0;
    #50 x = 5'd7;
    #50 y = 5'd9;
    
    #50 x = 0;
    #50 y = 0;
    
    #50 subFlag = 0;
    #50 x = 5'd3;
    #50 y = 5'd3;
    
    #50 subFlag = 1;
    #50 x = 5'b11111;
    #50 y = 5'b10001;
    
    
    #50 x = 0;
    #50 y = 0;   
end

FullAddSub addsub(x, y, subFlag, sum, cout, overflow);
endmodule
