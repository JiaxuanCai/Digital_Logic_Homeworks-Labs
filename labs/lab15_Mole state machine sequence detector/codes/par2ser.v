module par2ser(clk,set,d,q);
    input clk, set; // 时钟信号和加载信号
    input [7:0]d; // 并行输入序列
    output reg q; //  串行输出
    
    reg [7:0] d_reg = 8'b0000_0000;//初始化寄存器
    always@ (posedge clk, posedge set)
    begin
        if(set)
            d_reg <= d; // 读入并行序列到寄存器中
        else
            d_reg <= (d_reg<<1);// 右移一位
            q = d_reg[7]; // 最高位的数据被串行输出
    end
        //assign q= d_reg[7]; // 最高位的数据被串行输出
endmodule
