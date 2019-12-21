`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/26 12:25:30
// Design Name: 
// Module Name: smg
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


module smg(clk,data,sm_wei,sm_duan,rst);
input clk,rst;
input [15:0] data;
output [3:0] sm_wei;
output [7:0] sm_duan;
//----------------------------------------------------------
//分频：更新频率为100Hz
integer clk_cnt;    //分频周期计数
reg clk_100Hz;
always @(posedge clk)
if(rst == 1) begin  //重置数码管分频显示
    clk_cnt <= 1'b0;
    clk_100Hz <= 1'b0;
end
else if(clk_cnt == 32'd25000)   
begin 
    clk_cnt <= 1'b0;  //半个周期结束，重新计数
    clk_100Hz <= ~clk_100Hz;    //时钟翻转
end
else clk_cnt <= clk_cnt + 1'b1;  //分频周期计数+1，又过去一个时钟周期
//----------------------------------------------------------
//位控制
//reg [2:0]wei_ctrl;

//always @(posedge clk_100Hz)
//begin
//    if(rst == 1) begin
//        wei_ctrl <= 0;
//    end
//    else begin 
//    wei_ctrl <= wei_ctrl + 1;
//    if(wei_ctrl == 3'b100) wei_ctrl <= 3'b0;
//    end
//end 

//让数码管于每个分频了的时钟周期在4个位交替闪烁
//利用人眼视觉暂留，让人看到四个数码管显示的不同内容
reg [3:0] wei_ctrl=4'b1110; 
always @(posedge clk_100Hz)
    wei_ctrl <= {wei_ctrl[2:0],wei_ctrl[3]};

//段控制：每一位的数码管的8个led灯的输入
reg [3:0]duan_ctrl;
always @(wei_ctrl)
    case(wei_ctrl)
        4'b1110:duan_ctrl=data[3:0];
        4'b1101:duan_ctrl=data[7:4];
        4'b1011:duan_ctrl=data[11:8];
        4'b0111:duan_ctrl=data[15:12];
        default:duan_ctrl=4'hf;
        
    endcase


//----------------------------------------------------------
//解码模块：8个led灯的输入的解码，让led灯对应的位闪烁（低电平亮灯）
reg [7:0]duan;
always @(duan_ctrl)
    case(duan_ctrl)
        4'h0:duan=8'b1100_0000;//0
        4'h1:duan=8'b1111_1001;//1
        4'h2:duan=8'b1010_0100;//2
        4'h3:duan=8'b1011_0000;//3
        4'h4:duan=8'b1001_1001;//4
        4'h5:duan=8'b1001_0010;//5
        4'h6:duan=8'b1000_0010;//6
        4'h7:duan=8'b1111_1000;//7
        4'h8:duan=8'b1000_0000;//8
        4'h9:duan=8'b1001_0000;//9
        4'ha:duan=8'b1000_1000;//a
        4'hb:duan=8'b1000_0011;//b
        4'hc:duan=8'b1100_0110;//c
        4'hd:duan=8'b1010_0001;//d
        4'he:duan=8'b1000_0110;//e
        4'hf:duan=8'b1000_1110;//f 
        default : duan = 8'b1100_0000;//0
    endcase
//----------------------------------------------------------
assign sm_wei = wei_ctrl;
assign sm_duan = duan;
endmodule

module smg_ip(x, y, rst, subFlag, clk, sm_wei, sm_duan, symbolX, symbolY, symbolResult, cout, overflow);
input clk, rst;
//output [3:0]sm_wei;
output [3:0] sm_wei;    //位控制信号
output [7:0] sm_duan;   //段控制信号
//----------------------------------------------------------
wire [15:0]data;    //显示在每一位的数据：每四位data对应每一位数码管
wire [3:0]sm_wei;
wire [7:0]sm_duan;
//----------------------------------------------------------
input [4:0] x, y;   //输入的待计算数据，需要完成4位加减法，故x、y设定为5位，最后一位为符号位
input subFlag;  //减法标志

wire [4:0] sum; //计算结果
output cout;    //进位信号
output overflow;    //溢出信号
output symbolX, symbolY, symbolResult;

//拼接输入信号为16位的data，然后将其输入smg实例化的U1中，操控七段数码管发光
assign data[15:12] = x[3:0];
assign data[11:8] = y[3:0];
assign data[7:4] = 4'b0000; //不需要的计算位，将其置为0
assign data[3:0] = sum[3:0];

//输出结果
assign symbolX = x[4];
assign symbolY = y[4];
assign symbolResult = (overflow == 1) ? ~sum[4] : sum[4];

FullAddSub fuladdsub(x, y, subFlag, sum, cout, overflow);

smg U1 (.clk(clk),.data(data),.sm_wei(sm_wei),.sm_duan(sm_duan),.rst(rst));
endmodule

