module check(
    input clk,//系统时钟
    input clock_in,// 并转串移位使能信号
    input reset,//重置消抖
    input clear,//重置状态机
    input load_in,// 读取并行序列的加载信号
    input [7:0] data_in, // 并行输入的序列
    output reg dout // 检测结果信号
    );
    wire clock_out; // 经过消抖处理后的移位使能信号
    wire load_out; // 经过消抖处理后的并转串加载信号
    wire din; // 串行化处理后的信号
    xiaodou U1(.clk(clk),.reset(reset),.load_in(load_in),.load_out(load_out),.clock_in(clock_in),.clock_out(clock_out));
    par2ser PAR(.clk(clock_out),.set(load_out),.d(data_in),.q(din));

// 五个状态，S4为最终态
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
