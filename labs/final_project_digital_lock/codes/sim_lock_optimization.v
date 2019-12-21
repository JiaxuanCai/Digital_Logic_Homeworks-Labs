`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/27 14:59:03
// Design Name: 
// Module Name: sim_lock
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


module sim_lock;
reg clk, rst_in, rst_code, rst_open, load, change, open, rst, rst_timer;
reg [9:0] din;
reg sure;
wire succ, fail, locked, open_now, change_now;
wire change_succ;
wire [2:0] rest_times;
initial begin
    clk = 0;
    rst_timer = 0;
    rst = 0;
    rst_code = 0;
    rst_in = 0;
    rst_open = 0;
    load = 0;
    change = 0;
    
    sure = 0;
    open = 0;
    #10 rst_code = 1; rst_in = 1; rst_open = 1; rst_timer = 1;
    #10 rst_code = 0; rst_in = 0; rst_open = 0; rst_timer = 1;
    #10 rst_code = 1; rst_in = 1; rst_open = 1; rst_timer = 1;
    #50
    // #10 rst_code = 1; rst_in = 1;
    
    // Ĭ������Ϊ0000
    #10 change = 1;
    // ��ʼ������

    #10 rst_code = 0;
    #10 rst_code = 1;
    #10 din = 10'b00_0000_0000;
    #10 load = 1;
    #10  load = 0;
        #10 din = 10'b00_0000_0000;
    #10 load = 1;
    #10  load = 0;
        #10 din = 10'b00_0000_0000;
    #10 load = 1;
    #10  load = 0;
        #10 din = 10'b00_0000_0000;
    #10 load = 1;
    #10  load = 0;
    
    // 1
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;

    // 2
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // set password 
//    #20 change = 1;
//    #10 change = 0;
    #20 sure = 1;
    #20 sure = 0;
    #10 change = 0;
    #20 rst = 1;
    #20 rst = 0;

    #100
    // -------------------------------- open
     // 1

    
  #10 rst_open = 0;
  #10 rst_open = 1;
    #10 open = 1;

   #10 rst_in = 0;
    #10 rst_in = 1;
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 2
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // open 
//    #20 open = 1;
//    #10 open = 0;
    #20 sure = 1;
    #20 sure = 0;

    #50 rst_open = 0;
    #50 rst_open = 1;
    #10 open = 0;
    #100
    
    // wrong password
     // 1
    #10 open = 1;

    #10 rst_in = 0;
    #10 rst_in = 1;
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 2
    #10 din = 10'b00_0010_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;

    #20 sure = 1;
    #20 sure = 0;
    #100
    #10 rst_in = 0;
    #10 rst_in = 1;
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 2
    #10 din = 10'b00_0010_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // open 
//    #20 open = 1;
//    #10 open = 0;
    #20 sure = 1;
    #20 sure = 0;
        
    #100
    #10 rst_in = 0;
    #10 rst_in = 1;
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 2
    #10 din = 10'b00_0010_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // open 
//    #20 open = 1;
//    #10 open = 0;
    #20 sure = 1;
    #20 sure = 0;
    
    #100
    #10 rst_in = 0;
    #10 rst_in = 1;
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 2
    #10 din = 10'b00_0010_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // open 
//    #20 open = 1;
//    #10 open = 0;
    #20 sure = 1;
    #20 sure = 0;
    
    #100
    #10 rst_in = 0;
    #10 rst_in = 1;
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 2
    #10 din = 10'b00_0010_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // open 
//    #20 open = 1;
//    #10 open = 0;
    #20 sure = 1;
    #20 sure = 0;
    
    #100
    #10 rst_in = 0;
    #10 rst_in = 1;
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 2
    #10 din = 10'b00_0010_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // open 
//    #20 open = 1;
//    #10 open = 0;
    #20 sure = 1;
    #20 sure = 0;
    
    #100
    #10 rst_in = 0;
    #10 rst_in = 1;
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 2
    #10 din = 10'b00_0010_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // open 
//    #20 open = 1;
//    #10 open = 0;
    #20 sure = 1;
    #20 sure = 0;
    #10 open = 0;
    #50 rst_open = 0;
    #50 rst_open = 1;
    

    #100

    // reset
    #10 change = 1;

    #10 rst_in = 0;
    #10 rst_in = 1;
    // ��֤ԭ����
     #10 din = 10'b00_1000_0000;
    #10 load = 1;
    #10  load = 0;
    // 2
    #10 din = 10'b00_0100_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0010_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // ������
    #10 din = 10'b00_1000_0000;
    #10 load = 1;
    #10  load = 0;
    // 2
    #10 din = 10'b00_0100_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0010_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    #10 sure = 1;
    #10 sure = 0;

    //
    //ԭ����
     // 
    #100
    #10 rst_in = 0;
    #10 rst_in = 1;
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 2
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    //
       // ������
    #10 din = 10'b00_1000_0000;
    #10 load = 1;
    #10  load = 0;
    // 2
    #10 din = 10'b00_0100_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0010_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    #10 sure = 1;
    #10 sure = 0;
    #10 change = 0;
    #100
    // Ӧ���޸ĳɹ�
    // �ٴο���
    
    //֮ǰ�����룬Ӧ�ò���
    #10 rst =1 ;
    #10 rst = 0;
    #10 open = 1;
    #10 rst_in = 0;
    #10 rst_in = 1;
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 2
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    #10 sure = 1;
    #10 sure = 0;
    #100
    // ��ȷ������
    #10 rst_in = 0;
    #10 rst_in = 1; 
    #10 din = 10'b00_1000_0000;
    #10 load = 1;
    #10  load = 0;
    // 2
    #10 din = 10'b00_0100_0000;
    #10 load = 1;
    #10  load = 0;
    // 3
    #10 din = 10'b00_0010_0000;
    #10 load = 1;
    #10  load = 0;
    // 4
    #10 din = 10'b00_0001_0000;
    #10 load = 1;
    #10  load = 0;
    #10 sure = 1;
    #10 sure = 0;
    #10 open = 0;
end

always # 1 clk = ~clk;
Lock_status lock(
    clk, rst_in, rst_code, rst_open, rst_timer, rst, // ϵͳʱ�ӣ����븴λ�����븴λ��������λ����ʱ����λ��״̬��λ
    load, sure, change, open,   // ���ּ��أ� ����ȷ�ϣ��޸����룬��������
    din, // ��������
    succ, fail, locked, change_succ, rest_times, // �ɹ������źţ�����ʧ���źţ������źţ��޸�����ɹ��ź�
    open_now, change_now // ��ǰ���ڿ������̣���ǰ�����޸��������
);
endmodule // 