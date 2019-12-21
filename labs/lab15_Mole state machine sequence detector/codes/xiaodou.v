`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/25 16:37:50
// Design Name: 
// Module Name: xiaodou
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

//module xiaodou(
//    input clk, // ϵͳʱ��
//    input reset, // �����ź�
//    input load_in, // ��ʼ��ȡ�����ź�
//    input clock_in, // ��λʹ���ź�
//    output load_out, // �����ļ����ź�
//    output clock_out, // ������ʹ���ź�
//    output key_rrr,
//    output key_rr,
//    output key_r
//    );
//    reg key_rrr,key_rr,key_r;
//    reg load_rrr,load_rr,load_r;
//    always @(posedge clk or negedge reset)
//       if(!reset) 
//          begin // key �� load��Ϊ�ߵ�ƽ��Ч���ʳ�ʼ��Ϊ0
//             key_rrr <=0;
//             key_rr <=0;
//             key_r <=0;
//             load_rrr <=0;
//             load_rr <=0;
//             load_r <=0;
//          end
//        else
//          begin // ������ʱ�������ڽ���ȡ�������ڲ��÷�����ʽ��ֵ�����±˴���һ��ʱ�����ڵ��ӳ�
//              key_rrr <= key_rr;
//              key_rr <= key_r;
//              key_r <= clock_in;
//              load_rrr <= load_rr;
//              load_rr <= load_r;
//              load_r <= load_in;
//          end 
//    assign clock_out = key_rrr & key_rr & key_r; // ����ʱ�������ڵ�����ȡ����Ϊ�ߵ�ƽ��˵���ȶ�
//    assign load_out = load_rrr & load_rr & load_r;
//endmodule
module xiaodou(
    input clk, // ϵͳʱ��
    input reset, // �����ź�
    input load_in, // ��ʼ��ȡ�����ź�
    input clock_in, // ��λʹ���ź�
    output load_out, // �����ļ����ź�
    output clock_out // ������ʹ���ź�
    );
    reg key_rrr,key_rr,key_r;
    reg load_rrr,load_rr,load_r;
    always @(posedge clk or negedge reset)
       if(!reset) 
          begin // key �� load��Ϊ�ߵ�ƽ��Ч���ʳ�ʼ��Ϊ0
             key_rrr <=0;
             key_rr <=0;
             key_r <=0;
             load_rrr <=0;
             load_rr <=0;
             load_r <=0;
          end
        else
          begin // ������ʱ�������ڽ���ȡ�������ڲ��÷�����ʽ��ֵ�����±˴���һ��ʱ�����ڵ��ӳ�
              key_rrr <= key_rr;
              key_rr <= key_r;
              key_r <= clock_in;
              load_rrr <= load_rr;
              load_rr <= load_r;
              load_r <= load_in;
          end 
    assign clock_out = key_rrr & key_rr & key_r; // ����ʱ�������ڵ�����ȡ����Ϊ�ߵ�ƽ��˵���ȶ�
    assign load_out = load_rrr & load_rr & load_r;
endmodule

