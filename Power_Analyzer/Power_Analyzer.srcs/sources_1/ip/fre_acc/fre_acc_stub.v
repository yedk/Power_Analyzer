// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Wed Jun 13 10:00:37 2018
// Host        : ninja-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               g:/project_FPGA/power_analyzer/PA_CODE/PA_2018_6_5_X1/Power_Analyzer/Power_Analyzer.srcs/sources_1/ip/fre_acc/fre_acc_stub.v
// Design      : fre_acc
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_counter_binary_v12_0_10,Vivado 2016.4" *)
module fre_acc(CLK, CE, SCLR, Q)
/* synthesis syn_black_box black_box_pad_pin="CLK,CE,SCLR,Q[31:0]" */;
  input CLK;
  input CE;
  input SCLR;
  output [31:0]Q;
endmodule
