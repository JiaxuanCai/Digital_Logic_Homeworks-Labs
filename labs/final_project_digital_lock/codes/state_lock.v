module Lock(
    clk, rst_in, rst_code, rst_open, rst_timer, rst, // 系统时钟，输入复位，密码复位，开锁复位，计时器复位，状态复位
    load, sure, change, open,   // 数字加载， 操作确认，修改密码，开锁操作
    din, // 输入数字
    succ, fail, locked, change_succ, cnt_open,// 成功开锁信号，开锁失败信号，自锁信号，修改密码成功信号，剩余开锁次数
    open_now, change_now // 当前处于开锁过程，当前处于修改密码过程
);
input clk, rst_in, rst_code, rst_open, rst_timer, rst;
input load, sure, change, open;
input [9:0] din;
output reg succ, fail, locked, change_succ;
output reg open_now, change_now;
output reg [2:0] cnt_open;
// 临时存储
reg [9:0] din_1, din_2, din_3, din_4;
// 正确密码，输入的密码
reg [39:0] right_code, in_code;
// 状态机当前状态，下一状态
reg [2:0] currentState, nextState;

parameter START_STATE = 3'b000; // 初始
parameter OPEN_STATE = 3'b001; // 开锁
parameter CHANGE_STATE = 3'b010; // 设置密码
parameter PASS_STATE = 3'b011; // 成功开锁
parameter LOCKED_STATE = 3'b100; // 锁定状态
parameter CHANGE_SUCC_STATE = 3'b101; // 成功修改密码

// 状态更新
always @(posedge clk or posedge rst) begin
    if (rst) currentState <= START_STATE;
    else currentState <= nextState;
end
/** 
 计数器，用于读入数据 
 一共有8个临时存储
    在开锁时，默认使用前四位。
    在修改密码时，前四个用于保存身份验证时输入的原密码，后四个表示要设置的新密码
 每次load加载进一个数字（0-9），计数器加一，直到4位（或者8位）
 */
reg [3:0] cnt;
always @(rst_in or din or load) begin
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
状态机共有6个状态，分别为初始状态，开锁状态，修改密码状态，开锁成功状态，自锁状态，密码成功修改状态
一开始为初始状态，当判定action行为为开锁时，跳转到开锁状态，当判定action行为为修改密码时，跳转到修改密码状态
在开锁状态，如果开锁的结果为成功，则跳转到成功开锁状态，如果结果为失败，则停留在此状态，如果达到操作次数上限，则跳转到自锁状态
在修改密码状态，如果身份验证的结果为成功，则跳转到成功修改密码状态，如果为失败，则停留在此状态
在开锁成功状态、修改密码成功状态和自锁状态，持续时间T后自动跳转到初始状态
rst用于状态复位，直接回到初始状态
 */
always @(currentState or action or open_result or time_stop or change_result or rst) begin
    if (rst) nextState <= START_STATE;
    else begin
        case (currentState)
            START_STATE : 
                if(action == 2'b01) nextState <= OPEN_STATE;
                else if (action == 2'b10) nextState <= CHANGE_STATE;
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
                if(time_stop == 0) nextState <= PASS_STATE;
                else nextState <= START_STATE;

            LOCKED_STATE :
                if(time_stop == 0) nextState <= LOCKED_STATE;
                else nextState <= START_STATE; 
            CHANGE_SUCC_STATE :
                if(time_stop == 0) nextState <= CHANGE_SUCC_STATE;
                else nextState <= START_STATE;
            default: nextState <= START_STATE;
        endcase
    end
end


/* 
不同的状态对应不同的信号输出
指示当前操作阶段的信号：change_now表示正在修改密码，open_now 表示正在开锁
指示操作结果的信号：succ表示成功开锁，fail表示开锁失败，locked表示自锁，change_succ表示修改密码成功
信号的持续时间和状态的持续时间一致，为时间T
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
生成action行为激励
修改密码和开锁不能同时进行
开锁对应action 01
修改密码对应action 10 */

reg [1:0] action; // 01 - change 10 - open
always@(change or open) begin
    if(change && !open) action = 2'b10;
    else if(!change && open) action = 2'b01;
    else action = 2'b00;
end

/* 
激励信号
开锁和修改密码的结果生成逻辑 */

reg [1:0] open_result;

always @(posedge sure or posedge open or posedge change or negedge rst_open or negedge rst_code) begin 
    if(!rst_open)begin
        cnt_open <= 3'b100;
        open_result <= 3'b000;
    end 
    else if(!rst_code) begin 
        right_code <= 0;
        change_result <= 2'b10;
    end
    else begin
    // 如果当前状态为初始状态，若要开锁，则初始化计时器和开锁结果
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
    如果当前状态为开锁，当按下确认sure，比较当前输入的密码和正确密码，如果正确则结果为成功开锁
    否则计数器减一，当剩余操作次数为0的时候，自锁 */ 
    
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
            // 将数据拼接
            in_code <= {din_4, din_3, din_2, din_1};
        end        
    end
    end
    /* 如果当前状态 为修改密码
        进行身份验证，输入原密码和新密码，校验成功则设置成功，否则设置失败
        */
    CHANGE_STATE:begin
    if(currentState == CHANGE_STATE) begin
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




//change result
reg [9:0] din_temp_1, din_temp_2, din_temp_3, din_temp_4;
reg [1:0] change_result;


// 计时模块，用于状态返回
integer cnt_timer;
//parameter T = 1000000000; // 10s
parameter T = 20; // 10s
reg time_stop; // 5s倒计时

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
            cnt_timer <= 0;
        end
    end
end


endmodule // Lock_stastusssssss