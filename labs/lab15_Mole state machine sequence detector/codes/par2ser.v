module par2ser(clk,set,d,q);
    input clk, set; // ʱ���źźͼ����ź�
    input [7:0]d; // ������������
    output reg q; //  �������
    
    reg [7:0] d_reg = 8'b0000_0000;//��ʼ���Ĵ���
    always@ (posedge clk, posedge set)
    begin
        if(set)
            d_reg <= d; // ���벢�����е��Ĵ�����
        else
            d_reg <= (d_reg<<1);// ����һλ
            q = d_reg[7]; // ���λ�����ݱ��������
    end
        //assign q= d_reg[7]; // ���λ�����ݱ��������
endmodule
