`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/28 22:22:51
// Design Name: 
// Module Name: sim_lock_imp
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


module sim_lock_imp;
reg clk, rst_in, rst_code, rst_open, load, change, open, rst, rst_timer;
reg [9:0] din;
reg sure;
wire rest_times;
wire succ, fail, locked, open_now, change_now;
wire change_succ;
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
    
    // 默认密码为0000
    #10 change = 1;
    #10 change = 0;
    // 初始化密码

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
    #20 rst = 1;
    #20 rst = 0;
    #100
    // -------------------------------- open
     // 1

    
  #10 rst_open = 0;
  #10 rst_open = 1;
    #10 open = 1;
    #10 open = 0;
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
    #100
    
    // wrong password
     // 1
    #10 open = 1;
    #10 open = 0;
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
    
    #50 rst_open = 0;
    #50 rst_open = 1;
    

    #100

    // reset
    #10 change = 1;
    #10 change = 0;
    #10 rst_in = 0;
    #10 rst_in = 1;
    // 验证原密码
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
    // 新密码
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
    //原密码
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
       // 新密码
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
    #100
    // 应该修改成功
    // 再次开锁
    
    //之前的密码，应该不对
    #10 rst = 1;
    #10 rst = 0;
    #10 open = 1;
    #10 open = 0;
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
    // 正确的密码
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
end

always # 1 clk = ~clk;
Lock  lock(
    clk, rst_in, rst_code, rst_open, rst_timer, rst, // 系统时钟，输入复位，密码复位，开锁复位，计时器复位，状态复位
    load, sure, change, open,   // 数字加载， 操作确认，修改密码，开锁操作
    din, // 输入数字
    succ, fail, locked, change_succ, rest_times,// 成功开锁信号，开锁失败信号，自锁信号，修改密码成功信号
    open_now, change_now // 当前处于开锁过程，当前处于修改密码过程
);
endmodule // 