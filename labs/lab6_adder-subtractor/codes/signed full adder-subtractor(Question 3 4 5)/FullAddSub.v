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
input [n-1:0] x, y; //�����������Ӽ�������
input subFlag;  //�Ӽ�����־

output [n-1:0] sum; //������
output cout;    //��λλ
output overflow;  //��� 

// �������x��y���д�������
wire[n-1:0] proy; 
wire [n-1:0] prox;


assign prox = (x[n-1] == 1) ? (~{2'b0, x[n-2:0]} + 2'b1): x; // x ����

wire [n-1:0] compFlag; // �Ƿ��y��������ı�־
wire negativeY; // ��ʾyΪ����

wire cin; // ��ʾ������תΪ����ʱ�ļ�1
assign negativeY = (y[n-1] == 1) ? 1 : 0; // y�Ƿ�Ϊ����
//�Ƿ����룬���а�λ��򣺵�Ҫ����������YΪ������ʱ������
assign compFlag = (subFlag ^ negativeY) ? 5'b11111 : 5'b0; 
assign cin = (subFlag ^ negativeY) ? 1 : 0; 

assign proy[n-2:0] = y[n-2:0] ^ compFlag; // ���룺�����λ ���
assign proy[n-1] = subFlag ^ y[n-1]; // ���λ��������

wire [n-1:0] compSum;   //�Խ����ԭ��
Add myadd(.cin(cin), .x(prox), .y(proy), .sum(compSum), .cout(cout), .overflow(overflow));
// ����λ���䣬����λȡ����+1
assign sum[n-1] = compSum[n-1];
assign sum[n-2:0] = (compSum[n-1] == 1) ? ~compSum[n-2:0]+1 : compSum[n-2:0];

endmodule // FullAddSub