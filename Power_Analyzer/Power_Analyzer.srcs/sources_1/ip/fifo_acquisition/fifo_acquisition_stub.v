// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Mon May 28 14:27:43 2018
// Host        : USER-20170706XM running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               d:/Jia_ShuLin_USER/NORMA_4000_project/PA_Code/PA_2018_5_23_X1/Power_Analyzer/Power_Analyzer.srcs/sources_1/ip/fifo_acquisition/fifo_acquisition_stub.v
// Design      : fifo_acquisition
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_1_3,Vivado 2016.4" *)
module fifo_acquisition(clk, srst, din, wr_en, rd_en, prog_empty_thresh, 
  prog_full_thresh, dout, full, wr_ack, empty, valid, data_count, prog_full, prog_empty)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[127:0],wr_en,rd_en,prog_empty_thresh[12:0],prog_full_thresh[12:0],dout[127:0],full,wr_ack,empty,valid,data_count[12:0],prog_full,prog_empty" */;
  input clk;
  input srst;
  input [127:0]din;
  input wr_en;
  input rd_en;
  input [12:0]prog_empty_thresh;
  input [12:0]prog_full_thresh;
  output [127:0]dout;
  output full;
  output wr_ack;
  output empty;
  output valid;
  output [12:0]data_count;
  output prog_full;
  output prog_empty;
endmodule
