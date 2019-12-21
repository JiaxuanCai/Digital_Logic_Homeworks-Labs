`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/25 16:41:30
// Design Name: 
// Module Name: check_1101_sim
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


module check_1101_sim;

    reg clk;
    wire dout;
    reg clock_in, reset, clear, load_in;
    reg [7:0] data_in;
    
    initial clk = 0;
    
    always #20 clk = ~clk;
    
    always 
        begin
            #200 clock_in = ~clock_in;   load_in = ~load_in;
        end
    initial 
        begin 
            #10 clock_in = 0; reset = 1; clear = 1; load_in = 0; //clock_in,resetΪ0ʱ����������clearΪ1ʱ����״̬����load_inΪ1ʱ��ʼ��ת��
            #40 clear = 0; reset = 0;
            /*#50 clock_in = 1; reset = 1; clear = 0; load_in = 1;
            #50 clock_in = 0; reset = 1; clear = 0; load_in = 0;*/
        end
    
//    initial 
//        begin        
//            #50  reset = 1; clear = 0; load_in = 1;
//            #
//        end
        
    initial 
        begin
            data_in = 8'b11010101;
        end
        
    check c(
             clk,//ϵͳʱ��
             clock_in,// ��ת����λʹ���ź�
             reset,//��������
             clear,//����״̬��
             load_in,// ��ȡ�������еļ����ź�
             data_in, // �������������
             dout // ������ź�
            );
//    //_________________________________________________________________________
//initial begin
//    clock = 1'b0;
//    reset = 1'b0;
//    rst=1'b1;
//    #50 begin reset = 1'b1; rst=1'b1; end
//    #50 begin reset=1'b0; rst=1'b0; end
//    #50 begin reset=1'b1; rst=1'b1; end
//    end
//    initial
//    para_in = 8'b11010101;
//    always
//    #5 clock = ~clock;

//module check(
//    input clk,//ϵͳʱ��
//    input clock_in,// ��ת����λʹ���ź�
//    input reset,//��������
//    input clear,//����״̬��
//    input load_in,// ��ȡ�������еļ����ź�
//    input [7:0] data_in, // �������������
//    output reg dout // ������ź�
//    );
//    //_________________________________________________________________________

endmodule
