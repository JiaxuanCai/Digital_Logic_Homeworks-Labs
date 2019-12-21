`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/26 14:47:46
// Design Name: 
// Module Name: single_ram_asyn
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


module single_ram_asyn(
    clk, address, we, data
);

parameter DATA_WIDTH = 8;
parameter ADDRESS_WIDTH = 8;
parameter RAM_DEPTH = 1 << ADDRESS_WIDTH;
input clk;
input [ADDRESS_WIDTH-1:0] address;
input we;
inout [DATA_WIDTH-1:0] data;

reg [DATA_WIDTH-1:0] data_out;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];
assign data = (!we) ? data_out : 8'dz;
// write
always @(posedge clk) begin
    if(we == 1) begin
        mem[address] <= data;
    end
end
// read
always @(we or address ) begin
    if(we == 0) begin
        data_out <= mem[address];
    end
end

endmodule // single_ram_sy

