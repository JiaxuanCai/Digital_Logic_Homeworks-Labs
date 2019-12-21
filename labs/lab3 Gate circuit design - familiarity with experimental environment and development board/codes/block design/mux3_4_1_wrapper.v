//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
//Date        : Fri Oct 25 15:42:59 2019
//Host        : DESKTOP-33UDLUR running 64-bit major release  (build 9200)
//Command     : generate_target mux3_4_1_wrapper.bd
//Design      : mux3_4_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mux3_4_1_wrapper
   (cntrl,
    cntrl_2,
    f,
    in0,
    in0_1,
    in1,
    in1_1);
  input cntrl;
  input cntrl_2;
  output [2:0]f;
  input [2:0]in0;
  input [2:0]in0_1;
  input [2:0]in1;
  input [2:0]in1_1;

  wire cntrl;
  wire cntrl_2;
  wire [2:0]f;
  wire [2:0]in0;
  wire [2:0]in0_1;
  wire [2:0]in1;
  wire [2:0]in1_1;

  mux3_4_1 mux3_4_1_i
       (.cntrl(cntrl),
        .cntrl_2(cntrl_2),
        .f(f),
        .in0(in0),
        .in0_1(in0_1),
        .in1(in1),
        .in1_1(in1_1));
endmodule
