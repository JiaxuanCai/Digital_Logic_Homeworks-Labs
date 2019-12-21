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
//��Ƶ������Ƶ��Ϊ100Hz
integer clk_cnt;    //��Ƶ���ڼ���
reg clk_100Hz;
always @(posedge clk)
if(rst == 1) begin  //��������ܷ�Ƶ��ʾ
    clk_cnt <= 1'b0;
    clk_100Hz <= 1'b0;
end
else if(clk_cnt == 32'd25000)   
begin 
    clk_cnt <= 1'b0;  //������ڽ��������¼���
    clk_100Hz <= ~clk_100Hz;    //ʱ�ӷ�ת
end
else clk_cnt <= clk_cnt + 1'b1;  //��Ƶ���ڼ���+1���ֹ�ȥһ��ʱ������
//----------------------------------------------------------
//λ����
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

//���������ÿ����Ƶ�˵�ʱ��������4��λ������˸
//���������Ӿ����������˿����ĸ��������ʾ�Ĳ�ͬ����
reg [3:0] wei_ctrl=4'b1110; 
always @(posedge clk_100Hz)
    wei_ctrl <= {wei_ctrl[2:0],wei_ctrl[3]};

//�ο��ƣ�ÿһλ������ܵ�8��led�Ƶ�����
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
//����ģ�飺8��led�Ƶ�����Ľ��룬��led�ƶ�Ӧ��λ��˸���͵�ƽ���ƣ�
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
output [3:0] sm_wei;    //λ�����ź�
output [7:0] sm_duan;   //�ο����ź�
//----------------------------------------------------------
wire [15:0]data;    //��ʾ��ÿһλ�����ݣ�ÿ��λdata��Ӧÿһλ�����
wire [3:0]sm_wei;
wire [7:0]sm_duan;
//----------------------------------------------------------
input [4:0] x, y;   //����Ĵ��������ݣ���Ҫ���4λ�Ӽ�������x��y�趨Ϊ5λ�����һλΪ����λ
input subFlag;  //������־

wire [4:0] sum; //������
output cout;    //��λ�ź�
output overflow;    //����ź�
output symbolX, symbolY, symbolResult;

//ƴ�������ź�Ϊ16λ��data��Ȼ��������smgʵ������U1�У��ٿ��߶�����ܷ���
assign data[15:12] = x[3:0];
assign data[11:8] = y[3:0];
assign data[7:4] = 4'b0000; //����Ҫ�ļ���λ��������Ϊ0
assign data[3:0] = sum[3:0];

//������
assign symbolX = x[4];
assign symbolY = y[4];
assign symbolResult = (overflow == 1) ? ~sum[4] : sum[4];

FullAddSub fuladdsub(x, y, subFlag, sum, cout, overflow);

smg U1 (.clk(clk),.data(data),.sm_wei(sm_wei),.sm_duan(sm_duan),.rst(rst));
endmodule

