`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/25 20:26:09
// Design Name: 
// Module Name: sim_fpga_double_ram
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


module sim_fpga_double_ram;
    
reg clk, cs, rst;
reg [2:0] din_a;
reg [2:0] addr_a;
reg we_a, oe_a;
wire [2:0] dout_a;

reg [2:0] din_b;
reg [2:0] addr_b;
reg we_b, oe_b;
wire [2:0] dout_b;

reg clk_rst;
reg load;
integer i = 1;
reg clk_d;

// aÐ´b¶Á

initial begin
    load = 0;
    clk_d = 0;
    clk_rst = 0;
    clk = 0;
    cs = 1;
    rst = 0;
    din_a = 0;
    addr_a = 0;
    we_a = 0;
    oe_a = 0;
    
    din_b = 0;
    addr_b = 0;
    we_b = 0;
    oe_b = 0;

clk = 0;
clk_rst = 0;
#50 clk_rst = 1;
#50 clk_rst = 0;
@(posedge clk_d) begin
    cs = 0;
    din_a = 0;
    din_b = 0;
    we_a = 1'b1;
    oe_b = 1'b1;
    we_b = 1'b0;
    oe_a = 1'b0;
end

//for(i = 0; i < 3; i = i + 1) begin
//    @(posedge clk_d) begin
//        addr_a = i;
//        din_a = din_a + 1;
//        addr_b = i;
//        load = 1;
//        #10 load = 0;
//    end
//end

#200
addr_a = 0;
din_a = din_a + 1;
addr_b = 3;
load = 1;
#10 load = 0;

#200
addr_a = 1;
din_a = din_a + 1;
addr_b = 4;
load = 1;
#10 load = 0;
#200 
addr_a = 2;
din_a = din_a + 1;
addr_b = 5;
load = 1;
#10 load = 0;

// a¶ÁbÐ´
#200
@(posedge clk) begin
    din_a = 0;
    din_b = 0;
    we_a = 1'b0;
    oe_b = 1'b0;
    we_b = 1'b1;
    oe_a = 1'b1;
end
#100
for(i = 0; i < 3; i = i + 1) begin
    @(negedge clk_d) begin
        addr_a = 2-i;
         din_b = din_b + 1;
         addr_b = i+3;
        load = 1;
        #10 load = 0;
    end
end

// a¶Áb¶Á
#100
@(posedge clk) begin
    din_a = 0;
    din_b = 0;
    we_a = 1'b0;
    oe_b = 1'b1;
    we_b = 1'b0;
    oe_a = 1'b1;
end
#100
for(i = 0; i < 3; i = i + 1) begin
    @(negedge clk_d) begin
        addr_a = i;
        addr_b = 5 - i;
        load = 1;
        #10 load = 0;
    end
end

end
always #1 clk = ~clk;
always #100 clk_d = ~clk_d;
top_double_ram_sy test(
    clk, rst, cs,
    din_a, addr_a, dout_a, we_a, oe_a,
    din_b, addr_b, dout_b, we_b, oe_b,
    clk_rst,
    load
    );


endmodule