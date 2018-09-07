// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Wed Jun 13 10:18:57 2018
// Host        : ninja-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               g:/project_FPGA/power_analyzer/PA_CODE/PA_2018_6_5_X1/Power_Analyzer/Power_Analyzer.srcs/sources_1/ip/vio_0/vio_0_stub.v
// Design      : vio_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2016.4" *)
module vio_0(clk, probe_in0, probe_out0, probe_out1, 
  probe_out2, probe_out3, probe_out4, probe_out5, probe_out6, probe_out7, probe_out8, probe_out9, 
  probe_out10, probe_out11, probe_out12)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[0:0],probe_out0[15:0],probe_out1[31:0],probe_out2[15:0],probe_out3[31:0],probe_out4[15:0],probe_out5[31:0],probe_out6[15:0],probe_out7[31:0],probe_out8[15:0],probe_out9[31:0],probe_out10[15:0],probe_out11[31:0],probe_out12[2:0]" */;
  input clk;
  input [0:0]probe_in0;
  output [15:0]probe_out0;
  output [31:0]probe_out1;
  output [15:0]probe_out2;
  output [31:0]probe_out3;
  output [15:0]probe_out4;
  output [31:0]probe_out5;
  output [15:0]probe_out6;
  output [31:0]probe_out7;
  output [15:0]probe_out8;
  output [31:0]probe_out9;
  output [15:0]probe_out10;
  output [31:0]probe_out11;
  output [2:0]probe_out12;
endmodule
