// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Tue Apr 17 09:24:53 2018
// Host        : USER-20170706XM running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               D:/Jia_ShuLin_USER/NORMA_4000_project/Power_Analyzer_04161945/Power_Analyzer/Power_Analyzer.srcs/sources_1/ip/mig_7series_0/mig_7series_0_stub.v
// Design      : mig_7series_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module mig_7series_0(c0_ddr3_dq, c0_ddr3_dqs_n, c0_ddr3_dqs_p, 
  c0_ddr3_addr, c0_ddr3_ba, c0_ddr3_ras_n, c0_ddr3_cas_n, c0_ddr3_we_n, c0_ddr3_reset_n, 
  c0_ddr3_ck_p, c0_ddr3_ck_n, c0_ddr3_cke, c0_ddr3_cs_n, c0_ddr3_dm, c0_ddr3_odt, c0_sys_clk_i, 
  c0_app_addr, c0_app_cmd, c0_app_en, c0_app_wdf_data, c0_app_wdf_end, c0_app_wdf_mask, 
  c0_app_wdf_wren, c0_app_rd_data, c0_app_rd_data_end, c0_app_rd_data_valid, c0_app_rdy, 
  c0_app_wdf_rdy, c0_app_sr_req, c0_app_ref_req, c0_app_zq_req, c0_app_sr_active, 
  c0_app_ref_ack, c0_app_zq_ack, c0_ui_clk, c0_ui_clk_sync_rst, c0_init_calib_complete, 
  c0_device_temp, c1_ddr3_dq, c1_ddr3_dqs_n, c1_ddr3_dqs_p, c1_ddr3_addr, c1_ddr3_ba, 
  c1_ddr3_ras_n, c1_ddr3_cas_n, c1_ddr3_we_n, c1_ddr3_reset_n, c1_ddr3_ck_p, c1_ddr3_ck_n, 
  c1_ddr3_cke, c1_ddr3_cs_n, c1_ddr3_dm, c1_ddr3_odt, c1_sys_clk_i, c1_app_addr, c1_app_cmd, 
  c1_app_en, c1_app_wdf_data, c1_app_wdf_end, c1_app_wdf_mask, c1_app_wdf_wren, 
  c1_app_rd_data, c1_app_rd_data_end, c1_app_rd_data_valid, c1_app_rdy, c1_app_wdf_rdy, 
  c1_app_sr_req, c1_app_ref_req, c1_app_zq_req, c1_app_sr_active, c1_app_ref_ack, 
  c1_app_zq_ack, c1_ui_clk, c1_ui_clk_sync_rst, c1_init_calib_complete, c1_device_temp, 
  c2_ddr3_dq, c2_ddr3_dqs_n, c2_ddr3_dqs_p, c2_ddr3_addr, c2_ddr3_ba, c2_ddr3_ras_n, 
  c2_ddr3_cas_n, c2_ddr3_we_n, c2_ddr3_reset_n, c2_ddr3_ck_p, c2_ddr3_ck_n, c2_ddr3_cke, 
  c2_ddr3_cs_n, c2_ddr3_dm, c2_ddr3_odt, c2_sys_clk_i, c2_app_addr, c2_app_cmd, c2_app_en, 
  c2_app_wdf_data, c2_app_wdf_end, c2_app_wdf_mask, c2_app_wdf_wren, c2_app_rd_data, 
  c2_app_rd_data_end, c2_app_rd_data_valid, c2_app_rdy, c2_app_wdf_rdy, c2_app_sr_req, 
  c2_app_ref_req, c2_app_zq_req, c2_app_sr_active, c2_app_ref_ack, c2_app_zq_ack, c2_ui_clk, 
  c2_ui_clk_sync_rst, c2_init_calib_complete, c2_device_temp, sys_rst)
/* synthesis syn_black_box black_box_pad_pin="c0_ddr3_dq[7:0],c0_ddr3_dqs_n[0:0],c0_ddr3_dqs_p[0:0],c0_ddr3_addr[15:0],c0_ddr3_ba[2:0],c0_ddr3_ras_n,c0_ddr3_cas_n,c0_ddr3_we_n,c0_ddr3_reset_n,c0_ddr3_ck_p[0:0],c0_ddr3_ck_n[0:0],c0_ddr3_cke[0:0],c0_ddr3_cs_n[0:0],c0_ddr3_dm[0:0],c0_ddr3_odt[0:0],c0_sys_clk_i,c0_app_addr[29:0],c0_app_cmd[2:0],c0_app_en,c0_app_wdf_data[31:0],c0_app_wdf_end,c0_app_wdf_mask[3:0],c0_app_wdf_wren,c0_app_rd_data[31:0],c0_app_rd_data_end,c0_app_rd_data_valid,c0_app_rdy,c0_app_wdf_rdy,c0_app_sr_req,c0_app_ref_req,c0_app_zq_req,c0_app_sr_active,c0_app_ref_ack,c0_app_zq_ack,c0_ui_clk,c0_ui_clk_sync_rst,c0_init_calib_complete,c0_device_temp[11:0],c1_ddr3_dq[7:0],c1_ddr3_dqs_n[0:0],c1_ddr3_dqs_p[0:0],c1_ddr3_addr[15:0],c1_ddr3_ba[2:0],c1_ddr3_ras_n,c1_ddr3_cas_n,c1_ddr3_we_n,c1_ddr3_reset_n,c1_ddr3_ck_p[0:0],c1_ddr3_ck_n[0:0],c1_ddr3_cke[0:0],c1_ddr3_cs_n[0:0],c1_ddr3_dm[0:0],c1_ddr3_odt[0:0],c1_sys_clk_i,c1_app_addr[29:0],c1_app_cmd[2:0],c1_app_en,c1_app_wdf_data[31:0],c1_app_wdf_end,c1_app_wdf_mask[3:0],c1_app_wdf_wren,c1_app_rd_data[31:0],c1_app_rd_data_end,c1_app_rd_data_valid,c1_app_rdy,c1_app_wdf_rdy,c1_app_sr_req,c1_app_ref_req,c1_app_zq_req,c1_app_sr_active,c1_app_ref_ack,c1_app_zq_ack,c1_ui_clk,c1_ui_clk_sync_rst,c1_init_calib_complete,c1_device_temp[11:0],c2_ddr3_dq[7:0],c2_ddr3_dqs_n[0:0],c2_ddr3_dqs_p[0:0],c2_ddr3_addr[15:0],c2_ddr3_ba[2:0],c2_ddr3_ras_n,c2_ddr3_cas_n,c2_ddr3_we_n,c2_ddr3_reset_n,c2_ddr3_ck_p[0:0],c2_ddr3_ck_n[0:0],c2_ddr3_cke[0:0],c2_ddr3_cs_n[0:0],c2_ddr3_dm[0:0],c2_ddr3_odt[0:0],c2_sys_clk_i,c2_app_addr[29:0],c2_app_cmd[2:0],c2_app_en,c2_app_wdf_data[31:0],c2_app_wdf_end,c2_app_wdf_mask[3:0],c2_app_wdf_wren,c2_app_rd_data[31:0],c2_app_rd_data_end,c2_app_rd_data_valid,c2_app_rdy,c2_app_wdf_rdy,c2_app_sr_req,c2_app_ref_req,c2_app_zq_req,c2_app_sr_active,c2_app_ref_ack,c2_app_zq_ack,c2_ui_clk,c2_ui_clk_sync_rst,c2_init_calib_complete,c2_device_temp[11:0],sys_rst" */;
  inout [7:0]c0_ddr3_dq;
  inout [0:0]c0_ddr3_dqs_n;
  inout [0:0]c0_ddr3_dqs_p;
  output [15:0]c0_ddr3_addr;
  output [2:0]c0_ddr3_ba;
  output c0_ddr3_ras_n;
  output c0_ddr3_cas_n;
  output c0_ddr3_we_n;
  output c0_ddr3_reset_n;
  output [0:0]c0_ddr3_ck_p;
  output [0:0]c0_ddr3_ck_n;
  output [0:0]c0_ddr3_cke;
  output [0:0]c0_ddr3_cs_n;
  output [0:0]c0_ddr3_dm;
  output [0:0]c0_ddr3_odt;
  input c0_sys_clk_i;
  input [29:0]c0_app_addr;
  input [2:0]c0_app_cmd;
  input c0_app_en;
  input [31:0]c0_app_wdf_data;
  input c0_app_wdf_end;
  input [3:0]c0_app_wdf_mask;
  input c0_app_wdf_wren;
  output [31:0]c0_app_rd_data;
  output c0_app_rd_data_end;
  output c0_app_rd_data_valid;
  output c0_app_rdy;
  output c0_app_wdf_rdy;
  input c0_app_sr_req;
  input c0_app_ref_req;
  input c0_app_zq_req;
  output c0_app_sr_active;
  output c0_app_ref_ack;
  output c0_app_zq_ack;
  output c0_ui_clk;
  output c0_ui_clk_sync_rst;
  output c0_init_calib_complete;
  output [11:0]c0_device_temp;
  inout [7:0]c1_ddr3_dq;
  inout [0:0]c1_ddr3_dqs_n;
  inout [0:0]c1_ddr3_dqs_p;
  output [15:0]c1_ddr3_addr;
  output [2:0]c1_ddr3_ba;
  output c1_ddr3_ras_n;
  output c1_ddr3_cas_n;
  output c1_ddr3_we_n;
  output c1_ddr3_reset_n;
  output [0:0]c1_ddr3_ck_p;
  output [0:0]c1_ddr3_ck_n;
  output [0:0]c1_ddr3_cke;
  output [0:0]c1_ddr3_cs_n;
  output [0:0]c1_ddr3_dm;
  output [0:0]c1_ddr3_odt;
  input c1_sys_clk_i;
  input [29:0]c1_app_addr;
  input [2:0]c1_app_cmd;
  input c1_app_en;
  input [31:0]c1_app_wdf_data;
  input c1_app_wdf_end;
  input [3:0]c1_app_wdf_mask;
  input c1_app_wdf_wren;
  output [31:0]c1_app_rd_data;
  output c1_app_rd_data_end;
  output c1_app_rd_data_valid;
  output c1_app_rdy;
  output c1_app_wdf_rdy;
  input c1_app_sr_req;
  input c1_app_ref_req;
  input c1_app_zq_req;
  output c1_app_sr_active;
  output c1_app_ref_ack;
  output c1_app_zq_ack;
  output c1_ui_clk;
  output c1_ui_clk_sync_rst;
  output c1_init_calib_complete;
  output [11:0]c1_device_temp;
  inout [7:0]c2_ddr3_dq;
  inout [0:0]c2_ddr3_dqs_n;
  inout [0:0]c2_ddr3_dqs_p;
  output [15:0]c2_ddr3_addr;
  output [2:0]c2_ddr3_ba;
  output c2_ddr3_ras_n;
  output c2_ddr3_cas_n;
  output c2_ddr3_we_n;
  output c2_ddr3_reset_n;
  output [0:0]c2_ddr3_ck_p;
  output [0:0]c2_ddr3_ck_n;
  output [0:0]c2_ddr3_cke;
  output [0:0]c2_ddr3_cs_n;
  output [0:0]c2_ddr3_dm;
  output [0:0]c2_ddr3_odt;
  input c2_sys_clk_i;
  input [29:0]c2_app_addr;
  input [2:0]c2_app_cmd;
  input c2_app_en;
  input [31:0]c2_app_wdf_data;
  input c2_app_wdf_end;
  input [3:0]c2_app_wdf_mask;
  input c2_app_wdf_wren;
  output [31:0]c2_app_rd_data;
  output c2_app_rd_data_end;
  output c2_app_rd_data_valid;
  output c2_app_rdy;
  output c2_app_wdf_rdy;
  input c2_app_sr_req;
  input c2_app_ref_req;
  input c2_app_zq_req;
  output c2_app_sr_active;
  output c2_app_ref_ack;
  output c2_app_zq_ack;
  output c2_ui_clk;
  output c2_ui_clk_sync_rst;
  output c2_init_calib_complete;
  output [11:0]c2_device_temp;
  input sys_rst;
endmodule
