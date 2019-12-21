`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/23 16:22:09
// Design Name: 
// Module Name: sim_double_ram_sy
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
module sim_double_ram_sy;
reg clk, cs, rst;
reg [2:0] din_a;
reg [2:0] addr_a;
reg we_a, oe_a;
wire [2:0] dout_a;

reg [2:0] din_b;
reg [2:0] addr_b;
reg we_b, oe_b;
wire [2:0] dout_b;
reg load;
reg rst_clk;
integer i = 1;
wire [2:0] memout;
// aÐ´b¶Á
always #5 clk = ~clk;
initial begin
    #50
    clk = 0;
    load = 0;
    cs = 1;
    rst = 1;
    din_a = 0;
    addr_a = 0;
    we_a = 0;
    oe_a = 0;
    rst_clk = 1;
    din_b = 0;
    addr_b = 0;
    we_b = 0;
    oe_b = 0;

//    #15
//    cs = 0;
//    rst_clk = 0;
//    din_a = 0;
//    din_b = 0;
//    we_a = 1'b1;
//    oe_b = 1'b1;
//    we_b = 1'b0;
//    oe_a = 1'b0;
//    load = 1;
//    rst = 0;
//    #30
//#5 addr_a = 1; din_a = din_a + 1; addr_b = 0; #1 load = 1; #1 load = 0;
//#5 addr_a = 3; din_a = din_a + 1; addr_b = 1; #1 load = 1; #1 load = 0;
//#5 addr_b = 2; din_a = din_a + 1; addr_b = 2; #1 load = 1; #1 load = 0;

//for(i = 0; i < 3; i = i + 1) begin
//    @(negedge clk) begin
//        addr_a = i;
//        din_a = din_a + 1;ss
//        addr_b = i;
//    end
//end

#5 din_a = 0; din_b = 0; we_a = 0; oe_b = 0; we_b = 1; oe_a = 1;
#5 addr_a = 2; din_b = din_b + 1; addr_b = 2; #1 load = 1; #1 load =  0;
#5 addr_a = 1; din_b = din_b + 1; addr_b = 1; #1 load = 1; #1 load = 0;
#5 addr_a = 3; din_b = din_b + 2; addr_b = 3; #1 load = 1; #1 load = 0;


//// a¶ÁbÐ´
//#30 @(negedge clk) begin
//    din_a = 0;
//    rst_clk = 0;
//    din_b = 0;
//    we_a = 1'b0;
//    oe_b = 1'b0;
//    we_b = 1'b1;
//    oe_a = 1'b1;
//end

//for(i = 0; i < 3; i = i + 1) begin
//    @(negedge clk) begin
//        addr_a = i;
//        din_b = din_b + 1;
//        addr_b = i;
//    end
//end

//// a¶Áb¶Á
//#50 @(negedge clk) begin
//    din_a = 0;
//    din_b = 0;
//    we_a = 1'b0;
//    we_b = 1'b0;
//    oe_a = 1'b1;
//    oe_b = 1'b1;
//end
//for(i = 0; i < 16; i = i + 1) begin
//    @(negedge clk) begin
//        addr_a = i;
//        addr_b = i;
//    end
//end

//// aÐ´bÐ´ ? »á·¢ÉúÊ²Ã´£¿
//#20 
//@(negedge clk) begin
//    din_a = 0;
//    din_b = 0;
//    we_a = 1'b1;
//    we_b = 1'b1;
//    oe_a = 1'b0;
//    oe_b = 1'b0;
//end
//for(i = 0; i < 16; i = i + 1) begin
//    @(negedge clk) begin
//        addr_a = i;
//        addr_b = i;
//        din_a = din_a + 1;
//        din_b = din_b + 2;
//    end
//end

#50 @(negedge clk) begin
    cs = 1;
end
end
//top_double_ram_sy test(
//clk, rst, cs, 
//din_a, addr_a, dout_a, we_a, oe_a,
//din_b, addr_b, dout_b, we_b, oe_b,
//rst_clk,
//load
//    );

double_ram_sy test(
clk, rst, cs, 
din_a, addr_a, dout_a, we_a, oe_a,
din_b, addr_b, dout_b, we_b, oe_b,
load
    );

endmodule
    
////endmodule // sim_double_ram

//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 2019/12/23 16:22:09
//// Design Name: 
//// Module Name: sim_double_ram_sy
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
//module sim_double_ram_sy;
//reg clk, cs, rst;
//reg [2:0] din_a;
//reg [2:0] addr_a;
//reg we_a, oe_a;
//wire [2:0] dout_a;

//reg [2:0] din_b;
//reg [2:0] addr_b;
//reg we_b, oe_b;
//wire [2:0] dout_b;
//wire [2:0] memout;
//reg load;
//integer i = 1;

//// aÐ´b¶Á
//always #5 clk = ~clk;initial begin
//    clk = 0;
//    load = 0;
//    cs = 1;
//    rst = 0;
//    din_a = 0;
//    addr_a = 0;
//    we_a = 0;
//    oe_a = 0;
    
//    din_b = 0;
//    addr_b = 0;
//    we_b = 0;
//    oe_b = 0;

//#50 @(posedge clk) begin
//    cs = 0;
//    din_a = 0;
//    din_b = 0;
//    we_a = 1'b1;
//    oe_b = 1'b1;
//    we_b = 1'b0;
//    oe_a = 1'b0;
//end

//for(i = 0; i < 3; i = i + 1) begin
//    @(posedge clk) begin
//        addr_a = i;
//        din_a = din_a + 1;
//        addr_b = i;
//        #1 load = 1;
//        #1 load = 0;
//    end
//end

//// a¶ÁbÐ´
//#50 @(posedge clk) begin
//    din_a = 0;
//    din_b = 0;
//    we_a = 1'b0;
//    oe_b = 1'b0;
//    we_b = 1'b1;
//    oe_a = 1'b1;
//end

//for(i = 0; i < 3; i = i + 1) begin
//    @(posedge clk) begin
//        addr_a = i;
//        din_b = din_b + 1;
//        addr_b = i;
//    end
//end

//// a¶Áb¶Á
//#50 @(posedge clk) begin
//    din_a = 0;
//    din_b = 0;
//    we_a = 1'b0;
//    we_b = 1'b0;
//    oe_a = 1'b1;
//    oe_b = 1'b1;
//end
//for(i = 0; i < 3; i = i + 1) begin
//    @(posedge clk) begin
//        addr_a = i;
//        addr_b = i;
//    end
//end

//// aÐ´bÐ´ ? »á·¢ÉúÊ²Ã´£¿
//#50 @(posedge clk) begin
//    din_a = 0;
//    din_b = 0;
//    we_a = 1'b1;
//    we_b = 1'b1;
//    oe_a = 1'b0;
//    oe_b = 1'b0;
//end
//for(i = 0; i < 3; i = i + 1) begin
//    @(posedge clk) begin
//        addr_a = i;
//        addr_b = i;
//        din_a = din_a + 1;
//        din_b = din_b + 2;
//    end
//end

//#50 @(posedge clk) begin
//    cs = 1;
//end
//end
//double_ram_sy my_ram(
//    clk, rst, cs,
//    din_a, addr_a, dout_a, we_a, oe_a,
//    din_b, addr_b, dout_b, we_b, oe_b,
//    load
//);

//endmodule // sim_double_ram