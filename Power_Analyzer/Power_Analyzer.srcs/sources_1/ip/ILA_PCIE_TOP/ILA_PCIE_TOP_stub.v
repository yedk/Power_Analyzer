// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Wed May 23 09:48:42 2018
// Host        : USER-20170706XM running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               d:/Jia_ShuLin_USER/NORMA_4000_project/Power_Analyzer_Code/Power_Analyzer_2018_5_23_X1/Power_Analyzer/Power_Analyzer.srcs/sources_1/ip/ILA_PCIE_TOP/ILA_PCIE_TOP_stub.v
// Design      : ILA_PCIE_TOP
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2016.4" *)
module ILA_PCIE_TOP(clk, probe0, probe1)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[127:0],probe1[127:0]" */;
  input clk;
  input [127:0]probe0;
  input [127:0]probe1;
endmodule
