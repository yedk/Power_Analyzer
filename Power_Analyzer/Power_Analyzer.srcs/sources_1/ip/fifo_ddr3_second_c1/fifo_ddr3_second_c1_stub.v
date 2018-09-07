// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Wed Apr 18 15:18:09 2018
// Host        : USER-20170706XM running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub -rename_top fifo_ddr3_second_c1 -prefix
//               fifo_ddr3_second_c1_ fifo_ddr3_second_stub.v
// Design      : fifo_ddr3_second
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_1_3,Vivado 2016.4" *)
module fifo_ddr3_second_c1(rst, wr_clk, rd_clk, din, wr_en, rd_en, 
  prog_empty_thresh, prog_full_thresh, dout, full, wr_ack, empty, valid, rd_data_count, 
  wr_data_count, prog_full, prog_empty)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[48:0],wr_en,rd_en,prog_empty_thresh[8:0],prog_full_thresh[9:0],dout[97:0],full,wr_ack,empty,valid,rd_data_count[8:0],wr_data_count[9:0],prog_full,prog_empty" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [48:0]din;
  input wr_en;
  input rd_en;
  input [8:0]prog_empty_thresh;
  input [9:0]prog_full_thresh;
  output [97:0]dout;
  output full;
  output wr_ack;
  output empty;
  output valid;
  output [8:0]rd_data_count;
  output [9:0]wr_data_count;
  output prog_full;
  output prog_empty;
endmodule