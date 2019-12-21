module check(
    input clk,//ϵͳʱ��
    input clock_in,// ��ת����λʹ���ź�
    input reset,//��������
    input clear,//����״̬��
    input load_in,// ��ȡ�������еļ����ź�
    input [7:0] data_in, // �������������
    output reg dout // ������ź�
    );
    wire clock_out; // ����������������λʹ���ź�
    wire load_out; // �������������Ĳ�ת�������ź�
    wire din; // ���л��������ź�
    xiaodou U1(.clk(clk),.reset(reset),.load_in(load_in),.load_out(load_out),.clock_in(clock_in),.clock_out(clock_out));
    par2ser PAR(.clk(clock_out),.set(load_out),.d(data_in),.q(din));

// ���״̬��S4Ϊ����̬
    parameter s0 = 3'b000;
    parameter s1 = 3'b001;
    parameter s2 = 3'b010;
    parameter s3 = 3'b011;
    parameter s4 = 3'b100;
    
    reg [2:0] current_state, next_state;
    
    always @(posedge clock_out or negedge clear)
    begin
        if(clear==1)
            current_state <= s0;
        else
            current_state <= next_state;
    end
    
    always @ (current_state or din)
    begin
        case(current_state)
            s0: next_state <= (din == 1'b1) ? s1 : s0;
            s1: next_state <= (din == 1'b1) ? s2 : s0;
            s2: next_state <= (din == 1'b0) ? s3 : s2;
            s3: next_state <= (din == 1'b1) ? s4 : s0;
            s4: next_state <= (din == 1'b1) ? s2 : s0;
        default: next_state = s0;
        endcase
    
    end
    
    always @(current_state)
    begin
        if(current_state == s4) dout = 1;
        else dout = 0;
    end
endmodule
