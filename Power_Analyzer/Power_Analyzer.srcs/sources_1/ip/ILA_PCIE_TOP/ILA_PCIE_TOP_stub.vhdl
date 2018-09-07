-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
-- Date        : Wed May 23 09:48:42 2018
-- Host        : USER-20170706XM running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/Jia_ShuLin_USER/NORMA_4000_project/Power_Analyzer_Code/Power_Analyzer_2018_5_23_X1/Power_Analyzer/Power_Analyzer.srcs/sources_1/ip/ILA_PCIE_TOP/ILA_PCIE_TOP_stub.vhdl
-- Design      : ILA_PCIE_TOP
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ILA_PCIE_TOP is
  Port ( 
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 127 downto 0 );
    probe1 : in STD_LOGIC_VECTOR ( 127 downto 0 )
  );

end ILA_PCIE_TOP;

architecture stub of ILA_PCIE_TOP is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe0[127:0],probe1[127:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ila,Vivado 2016.4";
begin
end;
