`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/26 10:22:34
// Design Name: 
// Module Name: fpga_double_ram_sy
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


module fpga_double_ram_sy(
    clk, rst, cs,
    din_a, addr_a, dout_a, we_a, oe_a,
    din_b, addr_b, dout_b, we_b, oe_b,
    load,
    memout
);
 output [2:0] memout;
 
parameter DATA_WIDTH = 3;
parameter ADDR_WIDTH = 3;
parameter RAM_DEPTH = DATA_WIDTH * 10;
input clk, rst, cs;
input [DATA_WIDTH-1:0] din_a;
input [ADDR_WIDTH-1:0] addr_a;
input we_a, oe_a;
output reg [DATA_WIDTH-1:0] dout_a;
// output wire [DATA_WIDTH-1:0] memout;

input [DATA_WIDTH-1:0] din_b;
input [ADDR_WIDTH-1:0] addr_b;
input we_b, oe_b;
output reg [DATA_WIDTH-1:0] dout_b;

input load;
integer i;

// write
reg [DATA_WIDTH-1:0] mem[RAM_DEPTH-1:0];
wire [RAM_DEPTH-1:0] memout_b;
assign memout_b = mem[addr_b];
assign memout = mem[addr_a];



// write
always@(posedge load) begin
    if(!cs) begin
        if(we_a) begin
            mem[addr_a] <= din_a;
        end
        if(we_b) begin
            mem[addr_b] <= din_b;
        end
    end
    else begin
        for(i = 0; i < RAM_DEPTH; i = i + 1)
            mem[i] <= 0;
    end 
    end
    
    // read
    always@(posedge load) begin
        if(oe_a) begin
            dout_a <= mem[addr_a];
        end
        if(oe_b) begin
            dout_b <= mem[addr_b];
        end
    end


endmodule
