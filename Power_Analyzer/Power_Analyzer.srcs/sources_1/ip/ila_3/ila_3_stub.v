// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Tue Jul 03 21:22:29 2018
// Host        : hxs-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               D:/the_newest/PA_2018_6_28_X1_SIM/Power_Analyzer/Power_Analyzer.srcs/sources_1/ip/ila_3/ila_3_stub.v
// Design      : ila_3
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2016.4" *)
module ila_3(clk, probe0, probe1)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[31:0],probe1[329:0]" */;
  input clk;
  input [31:0]probe0;
  input [329:0]probe1;
endmodule
