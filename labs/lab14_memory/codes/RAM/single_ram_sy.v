module single_ram_sy(
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

always @(posedge clk) begin
    if(we == 1) begin
        mem[address] <= data;
    end
end

always @(posedge clk) begin
    if(we == 0) begin
        data_out <= mem[address];
    end
end

endmodule // single_ram_sy