`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/25 18:16:31
// Design Name: 
// Module Name: xiaodou_sim
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


module xiaodou_sim;
    reg clk; // ϵͳʱ��
    reg reset; // �����ź�
    reg load_in; // ��ʼ��ȡ�����ź�
    reg clock_in; // ��λʹ���ź�
    wire load_out; // �����ļ����ź�
    wire clock_out; // ������ʹ���ź�
    
    initial 
        begin 
            clk = 1; reset = 1;
            clock_in = 0; load_in = 0; 
            #50 reset = 0;
        end
        
    always #20 clk = ~clk;
        
    always 
        begin
            #200 clock_in = ~clock_in;   load_in = ~load_in;
        end
    
    xiaodou x(
     clk, // ϵͳʱ��
     reset, // �����ź�
     load_in, // ��ʼ��ȡ�����ź�
     clock_in, // ��λʹ���ź�
     load_out, // �����ļ����ź�
     clock_out // ������ʹ���ź�
    );
endmodule
