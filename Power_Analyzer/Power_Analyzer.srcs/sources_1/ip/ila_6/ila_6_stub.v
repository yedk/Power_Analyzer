// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Thu Jul 05 11:13:36 2018
// Host        : hxs-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub -rename_top ila_6 -prefix
//               ila_6_ ila_5_stub.v
// Design      : ila_5
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2016.4" *)
module ila_6(clk, probe0, probe1)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[31:0],probe1[249:0]" */;
  input clk;
  input [31:0]probe0;
  input [249:0]probe1;
endmodule
