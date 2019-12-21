module Lock_status(
    clk, rst_in, rst_code, rst_open, rst_timer, rst, // ϵͳʱ�ӣ����븴λ�����븴λ��������λ����ʱ����λ��״̬��λ
    load, sure, change, open,   // ���ּ��أ� ����ȷ�ϣ��޸����룬��������
    din, // ��������
    succ, fail, locked, change_succ, cnt_open,// �ɹ������źţ�����ʧ���źţ������źţ��޸�����ɹ��źţ�ʣ�࿪������
    open_now, change_now
    //sm_wei, sm_duan // ��ǰ���ڿ������̣���ǰ�����޸��������
);
input clk, rst_in, rst_code, rst_open, rst_timer, rst;
input load, sure, change, open;
input [9:0] din;
output reg succ, fail, locked, change_succ;
output reg open_now, change_now;
output reg [2:0] cnt_open;
// ��ʱ�洢
reg [9:0] din_1, din_2, din_3, din_4;
// ��ȷ���룬���������
reg [39:0] right_code, in_code;
// ״̬����ǰ״̬����һ״̬
reg [2:0] currentState, nextState;

parameter START_STATE = 3'b000; // ��ʼ
parameter OPEN_STATE = 3'b001; // ����
parameter CHANGE_STATE = 3'b010; // ��������
parameter PASS_STATE = 3'b011; // �ɹ�����
parameter LOCKED_STATE = 3'b100; // ����״̬
parameter CHANGE_SUCC_STATE = 3'b101; // �ɹ��޸�����

// ״̬����
always @(posedge clk or posedge rst) begin
    if (rst) currentState <= START_STATE;
    else currentState <= nextState;
end
/** 
 �����������ڶ������� 
 һ����8����ʱ�洢
    �ڿ���ʱ��Ĭ��ʹ��ǰ��λ��
    ���޸�����ʱ��ǰ�ĸ����ڱ��������֤ʱ�����ԭ���룬���ĸ���ʾҪ���õ�������
 ÿ��load���ؽ�һ�����֣�0-9������������һ��ֱ��4λ������8λ��
 */
reg [3:0] cnt;
always @(din or rst_in or load) begin
    if(!rst_in) begin
        cnt <= 4'b1000;
        din_1 <= 0;
        din_2 <= 0;
        din_3 <= 0;
        din_4 <= 0; 
        din_temp_1 <= 0;
        din_temp_2 <= 0;
        din_temp_3 <= 0;
        din_temp_4 <= 0;
        in_code = 0;
    end
    else if (load)begin
        if(cnt == 4'b0000) begin
            cnt <= 4'b0000;
        end
        else begin
            if(cnt ==4'b1000) din_4 <= din;
            else if(cnt == 4'b0111) din_3 <= din;
            else if(cnt == 4'b0110) din_2 <= din;
            else if(cnt == 4'b0101) din_1 <= din;
            else if(cnt == 4'b0100) din_temp_4 <= din;
            else if(cnt == 4'b0011) din_temp_3 <= din;
            else if(cnt == 4'b0010) din_temp_2 <= din;
            else if(cnt == 4'b0001) din_temp_1 <= din;
            cnt = cnt - 1'b1;
        end 
    end
end
/* 
״̬������6��״̬���ֱ�Ϊ��ʼ״̬������״̬���޸�����״̬�������ɹ�״̬������״̬������ɹ��޸�״̬
һ��ʼΪ��ʼ״̬�����ж�action��ΪΪ����ʱ����ת������״̬�����ж�action��ΪΪ�޸�����ʱ����ת���޸�����״̬
�ڿ���״̬����������Ľ��Ϊ�ɹ�������ת���ɹ�����״̬��������Ϊʧ�ܣ���ͣ���ڴ�״̬������ﵽ�����������ޣ�����ת������״̬
���޸�����״̬����������֤�Ľ��Ϊ�ɹ�������ת���ɹ��޸�����״̬�����Ϊʧ�ܣ���ͣ���ڴ�״̬
�ڿ����ɹ�״̬���޸�����ɹ�״̬������״̬������ʱ��T���Զ���ת����ʼ״̬
rst����״̬��λ��ֱ�ӻص���ʼ״̬
 */
always @(currentState or change or open or open_result or time_stop or change_result or rst) begin
    if (rst) nextState <= START_STATE;
    else begin
        case (currentState)
            START_STATE : 
                if(!change && open) nextState <= OPEN_STATE;
                else if (!open && change) nextState <= CHANGE_STATE;
                else nextState <= START_STATE;
            OPEN_STATE : 
                if(open_result == 2'b01) nextState <= PASS_STATE;
                else if (open_result == 2'b10) nextState <= OPEN_STATE;
                else if (open_result == 2'b11) nextState <= LOCKED_STATE; //  debug
                else nextState <= START_STATE; 
            
            CHANGE_STATE : 
                if(change_result == 2'b01) nextState <= CHANGE_SUCC_STATE;
                else if(change_result == 2'b10) nextState <= CHANGE_STATE;
                else nextState <= START_STATE;
                
            PASS_STATE : 
                if(time_stop == 0 || open == 1) nextState <= PASS_STATE;
                else nextState <= START_STATE;

            LOCKED_STATE :
                if(time_stop == 0 || open == 1) nextState <= LOCKED_STATE;
                else nextState <= START_STATE; 
            CHANGE_SUCC_STATE :
                if(time_stop == 0 || change == 1) nextState <= CHANGE_SUCC_STATE;
                else nextState <= START_STATE;
            default: nextState <= START_STATE;
        endcase
    end
end


/* 
��ͬ��״̬��Ӧ��ͬ���ź����
ָʾ��ǰ�����׶ε��źţ�change_now��ʾ�����޸����룬open_now ��ʾ���ڿ���
ָʾ����������źţ�succ��ʾ�ɹ�������fail��ʾ����ʧ�ܣ�locked��ʾ������change_succ��ʾ�޸�����ɹ�
�źŵĳ���ʱ���״̬�ĳ���ʱ��һ�£�Ϊʱ��T
 */
always @(rst or currentState) begin
    if (rst) begin
        open_now <= 0;
        change_now <= 0;
        succ <= 0;
        fail <= 0;
        locked <= 0; 
    end
    else begin
        case (currentState)
            START_STATE :begin
            open_now <= 0;
            change_now <= 0;
            succ <= 0;
            fail <= 0;
            locked <= 0;
            change_succ = 0;
            end 
            OPEN_STATE :begin
                open_now <= 1;
                fail <= 1;
                change_now <= 0;
                succ <= 0;
                locked <= 0;
                change_succ = 0;
            end
            CHANGE_STATE:begin
                change_now <= 1;
                open_now <= 0;
                succ <= 0;
                fail <= 0;
                locked <= 0;
                change_succ = 0;
            end
            PASS_STATE:begin
                succ <= 1;
                open_now <= 0;
                change_now <= 0;
                fail <= 0;
                locked <= 0;
                change_succ = 0;
            end 
            LOCKED_STATE:begin
                locked <= 1;
                fail <= 1;
                open_now <= 0;
                change_now <= 0;
                succ <= 0;
                change_succ = 0;
            end
            CHANGE_SUCC_STATE :begin
                locked <= 0;
                fail <= 0;
                open_now <= 0;
                change_now <= 0;
                succ <= 0;
                change_succ = 1;
            end
        endcase
    end 
end


/* 
����action��Ϊ����
�޸�����Ϳ�������ͬʱ����
������Ӧaction 01
�޸������Ӧaction 10 */

//reg [1:0] action; // 01 - change 10 - open
//always@(change or open or rst) begin
//    if(rst) action <= 2'b00;
//    else if(change && !open) action <= 2'b10;
//    else if(!change && open) action <= 2'b01;
//    else action <= 2'b00;
//end

//always@(change or open) begin
//    if(change) action = 
//end

/* 
�����ź�
�������޸�����Ľ�������߼� */

reg [1:0] open_result;

always @(sure or open or change or rst_open or rst_code) begin 
    if(!rst_open)begin
        cnt_open <= 3'b100;
        open_result <= 3'b000;
    end
    else if(!rst_code) begin 
        right_code <= 0;
        change_result <= 2'b10;
    end
    else begin
    // �����ǰ״̬Ϊ��ʼ״̬����Ҫ���������ʼ����ʱ���Ϳ������
    case (currentState)
    START_STATE:begin
        if(open) begin
            cnt_open <= 3'b100;
            open_result <= 3'b010;
        end
        else if (change) begin  
            change_result <= 2'b10;
        end
    end
    /* 
    �����ǰ״̬Ϊ������������ȷ��sure���Ƚϵ�ǰ������������ȷ���룬�����ȷ����Ϊ�ɹ�����
    �����������һ����ʣ���������Ϊ0��ʱ������ */ 
    
    OPEN_STATE: begin
        if(sure) begin
        if(cnt_open == 3'b000) begin
            open_result <= 2'b11;
            cnt_open <= 3'b000;
        end
        else begin
            if({din_4, din_3, din_2, din_1} == right_code) begin
                open_result <= 2'b01;
                cnt_open <= 3'b100;
            end else begin
                open_result <= 2'b10;
                cnt_open <= cnt_open - 1'b1;
            end
            // ������ƴ��
            in_code <= {din_4, din_3, din_2, din_1};
        end        
    end
    end
    /* �����ǰ״̬ Ϊ�޸�����
        ���������֤������ԭ����������룬У��ɹ������óɹ�����������ʧ��
        */
    CHANGE_STATE:begin
       if(sure) begin
        if ({din_4, din_3, din_2, din_1} == right_code) begin
            right_code <= {din_temp_4, din_temp_3, din_temp_2, din_temp_1};
            change_result <= 2'b01;
        end
        else begin
            change_result <= 2'b10;
        end
    end
    end
    endcase
    end
end

// state

//change result
reg [9:0] din_temp_1, din_temp_2, din_temp_3, din_temp_4;
reg [1:0] change_result;


// ��ʱģ�飬����״̬����
integer cnt_timer;
//parameter T = 1000000000; // 10s
parameter T = 100; // 10s
reg time_stop; // 5s����ʱ

always @(posedge clk or negedge rst_timer) begin
    if(!rst_timer) begin 
        time_stop <= 0; 
        cnt_timer <= 0;
    end
    else if(currentState == PASS_STATE || currentState == LOCKED_STATE || currentState == CHANGE_STATE) begin
        if(cnt_timer < T) begin
            cnt_timer = cnt_timer + 1'b1;
            time_stop <= 0;
        end else begin
            time_stop <= 1;
            if(!open && !change)
                cnt_timer <= 0;
        end
    end
end


//// decode
//wire [3:0] dout_1, dout_2, dout_3, dout_4;

//Decode decode_0(din_1, dout_1);
//Decode decode_1(din_2, dout_2);
//Decode decode_2(din_3, dout_3);
//Decode decode_3(din_4, dout_4);

//wire [15:0] data;
//assign data[15:12] = dout_1;
//assign data[11:8] = dout_2;
//assign data[7:4] = dout_3; //����Ҫ�ļ���λ��������Ϊ0
//assign data[3:0] = dout_4;
//output [3:0] sm_wei;    //λ�����ź�
//output [7:0] sm_duan;   //�ο����ź�
////----------------------------------------------------------
//wire [3:0]sm_wei;
//wire [7:0]sm_duan;
//// smg display
//smg mysmg (.clk(clk),.data(data),.sm_wei(sm_wei),.sm_duan(sm_duan),.rst(rst_smg));


endmodule // Lock_stastus


