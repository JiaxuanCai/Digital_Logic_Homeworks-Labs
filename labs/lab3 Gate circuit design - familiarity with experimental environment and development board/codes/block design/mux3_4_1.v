//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
//Date        : Fri Oct 25 15:42:59 2019
//Host        : DESKTOP-33UDLUR running 64-bit major release  (build 9200)
//Command     : generate_target mux3_4_1.bd
//Design      : mux3_4_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "mux3_4_1,IP_Integrator,{x_ipProduct=Vivado 2015.2,x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=mux3_4_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,synth_mode=Global}" *) (* HW_HANDOFF = "mux3_4_1.hwdef" *) 
module mux3_4_1
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

  wire cntrl_1;
  wire cntrl_2_1;
  wire [2:0]\^in0_1 ;
  wire [2:0]in0_1_1;
  wire [2:0]\^in1_1 ;
  wire [2:0]in1_1_1;
  wire [2:0]mux2_1_0_f;
  wire [2:0]mux2_1_1_f;
  wire [2:0]mux2_1_2_f;

  assign \^in0_1 [2:0] = in0[2:0];
  assign \^in1_1 [2:0] = in1[2:0];
  assign cntrl_1 = cntrl;
  assign cntrl_2_1 = cntrl_2;
  assign f[2:0] = mux2_1_2_f;
  assign in0_1_1 = in0_1[2:0];
  assign in1_1_1 = in1_1[2:0];
  mux3_4_1_mux2_1_0_0 mux2_1_0
       (.cntrl(cntrl_1),
        .f(mux2_1_0_f),
        .in0(in0_1_1),
        .in1(in1_1_1));
  mux3_4_1_mux2_1_1_0 mux2_1_1
       (.cntrl(cntrl_1),
        .f(mux2_1_1_f),
        .in0(\^in0_1 ),
        .in1(\^in1_1 ));
  mux3_4_1_mux2_1_2_1 mux2_1_2
       (.cntrl(cntrl_2_1),
        .f(mux2_1_2_f),
        .in0(mux2_1_1_f),
        .in1(mux2_1_0_f));
endmodule
