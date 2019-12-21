`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/24 22:09:16
// Design Name: 
// Module Name: fifo_main
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


module fifo_cus
#(
parameter N = 8, //���ݿ��
parameter M = 4 //fifo�ĵ�ַ���
)
//�Զ��еĲ������á������Ժ�������ֲ��
//����Ժ�Ҫʵ�����ݿ��Ϊ16�����Ϊ2^8��FIFO��ֻ���N =16 M=8����
(
    input clko, //����ʱ��
    input clk, //ϵͳʱ�ӣ���������
    input reset, //������λ�ź�
    input rst_n, //���븴λ�ź�
    input wr, //����дʹ��
    input[N-1:0] w_data, //��������
    input rd, //�����ʹ��
    output empty, //���fifo�ձ�־
    output full, //���fifo����־
    output[N-1:0] r_data //�����ȡ������
);

    reg [N-1:0] array_reg [5*M - 1:0];  //�Ĵ����飬�����䵱FIFO����   
    reg [M-1:0] w_ptr_reg, w_ptr_next,w_ptr_succ;    //����дָ�룬ָʾ��ǰд��λ�ã���һ��״̬д��λ�ã�дλ�õ���һ��λ��
    reg [M-1:0] r_ptr_reg, r_ptr_next,r_ptr_succ;    //�����ָ�룬ָʾ��ǰ����λ�ã���һ��״̬����λ�ã���λ�õ���һ��λ��

    //����FIFO���Ϳյ��ź�
    reg full_reg, full_next;
    reg empty_reg, empty_next;

    wire wr_en; //����д���ź�
    wire clkod; //������İ����ź�

    //���ݵ�д�룬�����ݵ������ص�ʱ����дʹ���źţ��ͽ�����д��
    always@( posedge clkod ) begin
        if( wr_en )
            array_reg[w_ptr_reg] <= w_data;
        else
            array_reg[w_ptr_reg] <= array_reg[w_ptr_reg];
    end

    /*״̬��ת
    �ڸ�λ�ź���Ч(rst_n = 0)����/дָ�붼ָ��0��ַ����ʱ����״̬Ϊ�ա�
    �ڸ�λ����Ч������ʱ�ӵ������أ���/дָ���ֵ�����пգ���״̬��ֵ����һ״̬���������򱣳� */
    always@( posedge clkod ) begin
        if( !rst_n )    begin
            w_ptr_reg <= 0;
            r_ptr_reg <= 0;
            full_reg <= 1'b0;
            empty_reg <= 1'b1;  end
        else    begin
            w_ptr_reg <= w_ptr_next;
            r_ptr_reg <= r_ptr_next;
            full_reg <= full_next;
            empty_reg <= empty_next;    end
    end

    //��һ��״̬���ж�
    always@( * )    begin
        w_ptr_next = w_ptr_reg;
        r_ptr_next = r_ptr_reg;
        full_next = full_reg;
        empty_next = empty;
        w_ptr_succ = w_ptr_reg + 1'b1;
        r_ptr_succ = r_ptr_reg + 1'b1;
        case( {wr,rd} )
        /*������ڶ������£�������в�Ϊ�գ�����ǰ��ָ�����һ��ָ�븳ֵ����ָ�����һ��״̬��ͬʱ�����е�����־��0��
        Ȼ���ж϶�ָ�����һ��ָ���Ƿ��дָ���ֵһ����һ���Ļ���˵��������Ϊ�ա�����Ϊ�ա� */
        2'b01: 
        begin
            if( ~empty_reg )     begin
                r_ptr_next = r_ptr_succ;
                full_next = 0;
            if( r_ptr_succ == w_ptr_reg )
                empty_next = 1'b1;
            else
                empty_next = 1'b0;  end
        end

        /*д�����д�����£�������в�Ϊ��������ǰдָ�����һ��ָ�븳ֵ����ָ�����һ��״̬��ͬʱ�����еĿձ�־��0��
        Ȼ���ж�дָ�����һ��ָ���Ƿ�Ͷ�ָ���ֵһ����һ���Ļ���˵��������Ϊ��������Ϊ����
        */
        2'b10:
        begin
            if( ~full_reg ) begin
                w_ptr_next = w_ptr_succ;
                empty_next= 0;
            if( w_ptr_succ == r_ptr_reg )
                full_next = 1'b1;
            else    full_next = 1'b0;
            end
        end

        /*��д����ڶ�д�����£� ֱ�Ӹı��Ӧָ�����һ��״ֵ̬��*/
        2'b11:
        begin
            if( ~full_reg && ~empty_reg )   begin
                w_ptr_next = w_ptr_succ;
                r_ptr_next = r_ptr_succ;    end
            //������״̬��������д
            else if( full_reg ) begin   
                r_ptr_next = r_ptr_succ;
                full_next = 0;  end
            //�ڿյ�״̬��������д
            else if( empty_reg )    begin
                w_ptr_next = w_ptr_succ;
                empty_next = 0; end
        end
        endcase
    end

     assign r_data = array_reg[r_ptr_reg];   // ���ݵĶ�ȡ�����ݶ�ȡһֱ�ڽ��У�������ȡ����֮ǰ��ֵ��

     assign wr_en = wr & ~full_reg;  //�����в���������дʹ���źŵ�ʱ������д���ź�Ϊ1

    // ��/������źŵĸ�ֵ
    assign full = full_reg;
    assign empty = empty_reg;

    debounce mydebouncer(clk,clko,reset,clkod);

endmodule