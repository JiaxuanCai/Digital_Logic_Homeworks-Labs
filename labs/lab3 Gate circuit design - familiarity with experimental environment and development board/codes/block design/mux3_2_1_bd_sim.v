`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/24 20:47:14
// Design Name: 
// Module Name: mux3_2_1_bd_sim
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


module mux3_2_1_bd_sim;
reg[2:0] i0,i0_1,i1,i1_1;
reg c1,c2;
wire[2:0] fout;
mux3_4_1 mux1(.cntrl(c1),
    .cntrl_2(c2),
    .f(fout),
    .in0(i0),
    .in0_1(i0_1),
    .in1(i1),
    .in1_1(i1_1)
    );
initial
            begin
                i0=3'b000; i0_1=3'b001; i1=3'b010; i1_1=3'b011;
                c1=0;c2=0;
                #20  c1=0;c2=1;
                #20  c1=1;c2=0;
                #20  c1=1;c2=1;
                #20
                i0=3'b100; i0_1=3'b101; i1=3'b110; i1_1=3'b111;
                c1=0;c2=0;
                #20  c1=0;c2=1;
                #20  c1=1;c2=0;
                #20  c1=1;c2=1;
            end
endmodule
