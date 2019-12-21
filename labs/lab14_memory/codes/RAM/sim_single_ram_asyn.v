`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/26 14:49:37
// Design Name: 
// Module Name: sim_single_ram_asyn
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

module sim_single_ram_asyn(
);
reg clk;
reg [7:0] address;
wire [7:0] data;
reg [7:0] dataIn;
// wire [7:0] data_out;
// wire [7:0] mem;
reg we;

assign data = (we == 1) ? dataIn : 8'dz;

initial begin
    clk = 0;
    address = 0;
    dataIn = 0;
    we = 0;
end

always #5 clk = ~clk;

integer i;
initial begin
    // write
    #100 we = 1;
    for (i = 0; i < 256; i = i + 1) begin
       @(negedge clk) begin
           address = i;
           dataIn = dataIn + 1;
       end
    end 

    #100 we = 0;
    for (i = 0; i < 256; i = i + 1) begin
        @(negedge clk) begin
            address = i;
        end
    end

end
single_ram_sy my_single_ram_sy(.clk(clk), .address(address), .we(we), .data(data));



endmodule // 