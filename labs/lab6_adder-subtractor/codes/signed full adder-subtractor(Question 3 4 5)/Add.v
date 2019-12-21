`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/20 00:26:24
// Design Name: 
// Module Name: Add
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

//32λ�ӷ���
module Add(
    cin, x, y, sum, cout, overflow
);
    parameter n = 5;
    input cin;  //��λ�����ź�
    input [n-1:0] x, y; //�����뱻����
    output [n-1:0] sum; //�ӷ����
    output cout, overflow;  //��λ����źź�����ź�
    wire [n:0] tout;    //��λ�źŹ���n+1λ

    assign tout[0] = cin;   //��λ�����źŸ�ֵ����λ�źŵĵ�һλ
    assign cout = tout[n];  //��λ�źŵ�ĩλΪ��λ����ź�
    
    //ʹ������������ʵ����5��ȫ�������õ�4λ�ļӷ����sum    
    genvar i;
    generate
        for(i = 0; i <= n-1; i = i + 1)
        begin
            fullAdder stage(x[i], y[i], tout[i], sum[i], tout[i+1]);
        end
    endgenerate
    
    //���λ����������ͱ��������λ������λ����ͬ�ɶ���������λ������λ����֮��ͬ���������
    assign overflow = (x[n-1] & y[n-1] & ~sum[n-1] | (~x[n-1] & ~y[n-1] & sum[n-1]));

endmodule // Add


