-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
-- Date        : Tue Apr 17 09:24:53 2018
-- Host        : USER-20170706XM running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/Jia_ShuLin_USER/NORMA_4000_project/Power_Analyzer_04161945/Power_Analyzer/Power_Analyzer.srcs/sources_1/ip/mig_7series_0/mig_7series_0_stub.vhdl
-- Design      : mig_7series_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mig_7series_0 is
  Port ( 
    c0_ddr3_dq : inout STD_LOGIC_VECTOR ( 7 downto 0 );
    c0_ddr3_dqs_n : inout STD_LOGIC_VECTOR ( 0 to 0 );
    c0_ddr3_dqs_p : inout STD_LOGIC_VECTOR ( 0 to 0 );
    c0_ddr3_addr : out STD_LOGIC_VECTOR ( 15 downto 0 );
    c0_ddr3_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    c0_ddr3_ras_n : out STD_LOGIC;
    c0_ddr3_cas_n : out STD_LOGIC;
    c0_ddr3_we_n : out STD_LOGIC;
    c0_ddr3_reset_n : out STD_LOGIC;
    c0_ddr3_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    c0_ddr3_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    c0_ddr3_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    c0_ddr3_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    c0_ddr3_dm : out STD_LOGIC_VECTOR ( 0 to 0 );
    c0_ddr3_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    c0_sys_clk_i : in STD_LOGIC;
    c0_app_addr : in STD_LOGIC_VECTOR ( 29 downto 0 );
    c0_app_cmd : in STD_LOGIC_VECTOR ( 2 downto 0 );
    c0_app_en : in STD_LOGIC;
    c0_app_wdf_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    c0_app_wdf_end : in STD_LOGIC;
    c0_app_wdf_mask : in STD_LOGIC_VECTOR ( 3 downto 0 );
    c0_app_wdf_wren : in STD_LOGIC;
    c0_app_rd_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    c0_app_rd_data_end : out STD_LOGIC;
    c0_app_rd_data_valid : out STD_LOGIC;
    c0_app_rdy : out STD_LOGIC;
    c0_app_wdf_rdy : out STD_LOGIC;
    c0_app_sr_req : in STD_LOGIC;
    c0_app_ref_req : in STD_LOGIC;
    c0_app_zq_req : in STD_LOGIC;
    c0_app_sr_active : out STD_LOGIC;
    c0_app_ref_ack : out STD_LOGIC;
    c0_app_zq_ack : out STD_LOGIC;
    c0_ui_clk : out STD_LOGIC;
    c0_ui_clk_sync_rst : out STD_LOGIC;
    c0_init_calib_complete : out STD_LOGIC;
    c0_device_temp : out STD_LOGIC_VECTOR ( 11 downto 0 );
    c1_ddr3_dq : inout STD_LOGIC_VECTOR ( 7 downto 0 );
    c1_ddr3_dqs_n : inout STD_LOGIC_VECTOR ( 0 to 0 );
    c1_ddr3_dqs_p : inout STD_LOGIC_VECTOR ( 0 to 0 );
    c1_ddr3_addr : out STD_LOGIC_VECTOR ( 15 downto 0 );
    c1_ddr3_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    c1_ddr3_ras_n : out STD_LOGIC;
    c1_ddr3_cas_n : out STD_LOGIC;
    c1_ddr3_we_n : out STD_LOGIC;
    c1_ddr3_reset_n : out STD_LOGIC;
    c1_ddr3_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    c1_ddr3_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    c1_ddr3_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    c1_ddr3_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    c1_ddr3_dm : out STD_LOGIC_VECTOR ( 0 to 0 );
    c1_ddr3_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    c1_sys_clk_i : in STD_LOGIC;
    c1_app_addr : in STD_LOGIC_VECTOR ( 29 downto 0 );
    c1_app_cmd : in STD_LOGIC_VECTOR ( 2 downto 0 );
    c1_app_en : in STD_LOGIC;
    c1_app_wdf_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    c1_app_wdf_end : in STD_LOGIC;
    c1_app_wdf_mask : in STD_LOGIC_VECTOR ( 3 downto 0 );
    c1_app_wdf_wren : in STD_LOGIC;
    c1_app_rd_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    c1_app_rd_data_end : out STD_LOGIC;
    c1_app_rd_data_valid : out STD_LOGIC;
    c1_app_rdy : out STD_LOGIC;
    c1_app_wdf_rdy : out STD_LOGIC;
    c1_app_sr_req : in STD_LOGIC;
    c1_app_ref_req : in STD_LOGIC;
    c1_app_zq_req : in STD_LOGIC;
    c1_app_sr_active : out STD_LOGIC;
    c1_app_ref_ack : out STD_LOGIC;
    c1_app_zq_ack : out STD_LOGIC;
    c1_ui_clk : out STD_LOGIC;
    c1_ui_clk_sync_rst : out STD_LOGIC;
    c1_init_calib_complete : out STD_LOGIC;
    c1_device_temp : out STD_LOGIC_VECTOR ( 11 downto 0 );
    c2_ddr3_dq : inout STD_LOGIC_VECTOR ( 7 downto 0 );
    c2_ddr3_dqs_n : inout STD_LOGIC_VECTOR ( 0 to 0 );
    c2_ddr3_dqs_p : inout STD_LOGIC_VECTOR ( 0 to 0 );
    c2_ddr3_addr : out STD_LOGIC_VECTOR ( 15 downto 0 );
    c2_ddr3_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    c2_ddr3_ras_n : out STD_LOGIC;
    c2_ddr3_cas_n : out STD_LOGIC;
    c2_ddr3_we_n : out STD_LOGIC;
    c2_ddr3_reset_n : out STD_LOGIC;
    c2_ddr3_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    c2_ddr3_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    c2_ddr3_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    c2_ddr3_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    c2_ddr3_dm : out STD_LOGIC_VECTOR ( 0 to 0 );
    c2_ddr3_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    c2_sys_clk_i : in STD_LOGIC;
    c2_app_addr : in STD_LOGIC_VECTOR ( 29 downto 0 );
    c2_app_cmd : in STD_LOGIC_VECTOR ( 2 downto 0 );
    c2_app_en : in STD_LOGIC;
    c2_app_wdf_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    c2_app_wdf_end : in STD_LOGIC;
    c2_app_wdf_mask : in STD_LOGIC_VECTOR ( 3 downto 0 );
    c2_app_wdf_wren : in STD_LOGIC;
    c2_app_rd_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    c2_app_rd_data_end : out STD_LOGIC;
    c2_app_rd_data_valid : out STD_LOGIC;
    c2_app_rdy : out STD_LOGIC;
    c2_app_wdf_rdy : out STD_LOGIC;
    c2_app_sr_req : in STD_LOGIC;
    c2_app_ref_req : in STD_LOGIC;
    c2_app_zq_req : in STD_LOGIC;
    c2_app_sr_active : out STD_LOGIC;
    c2_app_ref_ack : out STD_LOGIC;
    c2_app_zq_ack : out STD_LOGIC;
    c2_ui_clk : out STD_LOGIC;
    c2_ui_clk_sync_rst : out STD_LOGIC;
    c2_init_calib_complete : out STD_LOGIC;
    c2_device_temp : out STD_LOGIC_VECTOR ( 11 downto 0 );
    sys_rst : in STD_LOGIC
  );

end mig_7series_0;

architecture stub of mig_7series_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "c0_ddr3_dq[7:0],c0_ddr3_dqs_n[0:0],c0_ddr3_dqs_p[0:0],c0_ddr3_addr[15:0],c0_ddr3_ba[2:0],c0_ddr3_ras_n,c0_ddr3_cas_n,c0_ddr3_we_n,c0_ddr3_reset_n,c0_ddr3_ck_p[0:0],c0_ddr3_ck_n[0:0],c0_ddr3_cke[0:0],c0_ddr3_cs_n[0:0],c0_ddr3_dm[0:0],c0_ddr3_odt[0:0],c0_sys_clk_i,c0_app_addr[29:0],c0_app_cmd[2:0],c0_app_en,c0_app_wdf_data[31:0],c0_app_wdf_end,c0_app_wdf_mask[3:0],c0_app_wdf_wren,c0_app_rd_data[31:0],c0_app_rd_data_end,c0_app_rd_data_valid,c0_app_rdy,c0_app_wdf_rdy,c0_app_sr_req,c0_app_ref_req,c0_app_zq_req,c0_app_sr_active,c0_app_ref_ack,c0_app_zq_ack,c0_ui_clk,c0_ui_clk_sync_rst,c0_init_calib_complete,c0_device_temp[11:0],c1_ddr3_dq[7:0],c1_ddr3_dqs_n[0:0],c1_ddr3_dqs_p[0:0],c1_ddr3_addr[15:0],c1_ddr3_ba[2:0],c1_ddr3_ras_n,c1_ddr3_cas_n,c1_ddr3_we_n,c1_ddr3_reset_n,c1_ddr3_ck_p[0:0],c1_ddr3_ck_n[0:0],c1_ddr3_cke[0:0],c1_ddr3_cs_n[0:0],c1_ddr3_dm[0:0],c1_ddr3_odt[0:0],c1_sys_clk_i,c1_app_addr[29:0],c1_app_cmd[2:0],c1_app_en,c1_app_wdf_data[31:0],c1_app_wdf_end,c1_app_wdf_mask[3:0],c1_app_wdf_wren,c1_app_rd_data[31:0],c1_app_rd_data_end,c1_app_rd_data_valid,c1_app_rdy,c1_app_wdf_rdy,c1_app_sr_req,c1_app_ref_req,c1_app_zq_req,c1_app_sr_active,c1_app_ref_ack,c1_app_zq_ack,c1_ui_clk,c1_ui_clk_sync_rst,c1_init_calib_complete,c1_device_temp[11:0],c2_ddr3_dq[7:0],c2_ddr3_dqs_n[0:0],c2_ddr3_dqs_p[0:0],c2_ddr3_addr[15:0],c2_ddr3_ba[2:0],c2_ddr3_ras_n,c2_ddr3_cas_n,c2_ddr3_we_n,c2_ddr3_reset_n,c2_ddr3_ck_p[0:0],c2_ddr3_ck_n[0:0],c2_ddr3_cke[0:0],c2_ddr3_cs_n[0:0],c2_ddr3_dm[0:0],c2_ddr3_odt[0:0],c2_sys_clk_i,c2_app_addr[29:0],c2_app_cmd[2:0],c2_app_en,c2_app_wdf_data[31:0],c2_app_wdf_end,c2_app_wdf_mask[3:0],c2_app_wdf_wren,c2_app_rd_data[31:0],c2_app_rd_data_end,c2_app_rd_data_valid,c2_app_rdy,c2_app_wdf_rdy,c2_app_sr_req,c2_app_ref_req,c2_app_zq_req,c2_app_sr_active,c2_app_ref_ack,c2_app_zq_ack,c2_ui_clk,c2_ui_clk_sync_rst,c2_init_calib_complete,c2_device_temp[11:0],sys_rst";
begin
end;
