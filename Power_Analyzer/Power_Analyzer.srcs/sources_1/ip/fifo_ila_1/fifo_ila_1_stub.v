// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Tue Aug 21 15:54:43 2018
// Host        : WIN-8G8S6QHROAV running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               e:/0820test/Power_Analyzer0807/Power_Analyzer/Power_Analyzer.srcs/sources_1/ip/fifo_ila_1/fifo_ila_1_stub.v
// Design      : fifo_ila_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2016.4" *)
module fifo_ila_1(clk, probe0)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[255:0]" */;
  input clk;
  input [255:0]probe0;
endmodule
