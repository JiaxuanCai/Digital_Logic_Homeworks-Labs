`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/26 14:09:21
// Design Name: 
// Module Name: fifo_sim
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


module fifo_sim;
    parameter N = 8; //���ݿ��
    parameter M = 4; //fifo�ĵ�ַ���
    reg clko; //����ʱ��
    reg clk; //ϵͳʱ�ӣ���������
    reg reset; //������λ�ź�
    reg rst_n; //���븴λ�ź�
    reg wr; //����дʹ��
    reg[N-1:0] w_data; //��������
    reg rd; //�����ʹ��
    wire empty; //���fifo�ձ�־
    wire full; //���fifo����־
    wire[N-1:0] r_data; //�����ȡ������
    
    initial begin
        clk = 0;
        clko = 0;
    end
    
    initial begin
        reset = 1; rst_n = 1; wr = 0; rd = 0;
        #10 reset = 0; rst_n = 0; wr = 1;
        #100 rd = 1;      
    end
    
    initial begin 
        #10 w_data = 8'b11010101;
        #500 w_data = 8'b00010001;
        #1000 w_data = 8'b01011001;
        #1500 w_data = 8'b00000000;  end
        
    always begin
        #2 clk = ~clk;
    end
    
    always begin
        #10 clko = ~clko;
    end
fifo_cus f(
     clko, //����ʱ��
     clk, //ϵͳʱ�ӣ���������
     reset, //������λ�ź�
     rst_n, //���븴λ�ź�
     wr, //����дʹ��
     w_data, //��������
     rd, //�����ʹ��
     empty, //���fifo�ձ�־
     full, //���fifo����־
     r_data //�����ȡ������
);
endmodule
