-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
-- Date        : Wed Jun 13 10:18:57 2018
-- Host        : ninja-PC running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               g:/project_FPGA/power_analyzer/PA_CODE/PA_2018_6_5_X1/Power_Analyzer/Power_Analyzer.srcs/sources_1/ip/vio_0/vio_0_stub.vhdl
-- Design      : vio_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vio_0 is
  Port ( 
    clk : in STD_LOGIC;
    probe_in0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out0 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    probe_out1 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_out2 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    probe_out3 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_out4 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    probe_out5 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_out6 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    probe_out7 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_out8 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    probe_out9 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_out10 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    probe_out11 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_out12 : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );

end vio_0;

architecture stub of vio_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_in0[0:0],probe_out0[15:0],probe_out1[31:0],probe_out2[15:0],probe_out3[31:0],probe_out4[15:0],probe_out5[31:0],probe_out6[15:0],probe_out7[31:0],probe_out8[15:0],probe_out9[31:0],probe_out10[15:0],probe_out11[31:0],probe_out12[2:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vio,Vivado 2016.4";
begin
end;
