`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/23 23:27:03
// Design Name: 
// Module Name: sim_double_ram_asyn
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
module sim_double_ram_asyn;
reg clk, cs, rst;
reg [7:0] din_a;
reg [15:0] addr_a;
reg we_a, oe_a;
wire [7:0] dout_a;

reg [7:0] din_b;
reg [15:0] addr_b;
reg we_b, oe_b;
wire [7:0] dout_b;

integer i = 1;

// aÐ´b¶Á
always #5 clk = ~clk;
initial begin
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

#50 @(posedge clk) begin
    cs = 0;
    din_a = 0;
    din_b = 0;
    we_a = 1'b1;
    oe_b = 1'b1;
    we_b = 1'b0;
    oe_a = 1'b0;
end

for(i = 0; i < 8; i = i + 1) begin
    @(negedge clk) begin
        addr_a = i;
        din_a = din_a + 1;
        addr_b = i+8;
    end
end

// a¶ÁbÐ´
#50 @(posedge clk) begin
    din_a = 0;
    din_b = 0;
    we_a = 1'b0;
    oe_b = 1'b0;
    we_b = 1'b1;
    oe_a = 1'b1;
end

for(i = 0; i < 8; i = i + 1) begin
    @(negedge clk) begin
        addr_a = i;
        din_b = din_b + 1;
        addr_b = i+8;
    end
end

// a¶Áb¶Á
#50 @(posedge clk) begin
    din_a = 0;
    din_b = 0;
    we_a = 1'b0;
    we_b = 1'b0;
    oe_a = 1'b1;
    oe_b = 1'b1;
end
for(i = 0; i < 8; i = i + 1) begin
    @(negedge clk) begin
        addr_a = i;
        addr_b = i + 8;
    end
end

// aÐ´bÐ´ 
#50 @(posedge clk) begin
    din_a = 0;
    din_b = 0;
    we_a = 1'b1;
    we_b = 1'b1;
    oe_a = 1'b0;
    oe_b = 1'b0;
end
for(i = 0; i < 8; i = i + 1) begin
    @(negedge clk) begin
        addr_a = i;
        addr_b = i + 8;
        din_a = din_a + 1;
        din_b = din_b + 2;
    end
end

// a¶Áb¶Á
#50 @(posedge clk) begin
    din_a = 0;
    din_b = 0;
    we_a = 1'b0;
    we_b = 1'b0;
    oe_a = 1'b1;
    oe_b = 1'b1;
end
for(i = 0; i < 8; i = i + 1) begin
    @(negedge clk) begin
        addr_a = i;
        addr_b = i + 8;
    end
end

#50 @(posedge clk) begin
    cs = 1;
end
end
double_ram_asyn my_ram(
    clk, rst, cs,
    din_a, addr_a, dout_a, we_a, oe_a,
    din_b, addr_b, dout_b, we_b, oe_b    
);

endmodule // sim_double_ram