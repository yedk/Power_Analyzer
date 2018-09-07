//*****************************************************************************
// (c) Copyright 2009 - 2010 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 4.0
//  \   \         Application        : MIG
//  /   /         Filename           : sim_tb_top.v
// /___/   /\     Date Last Modified : $Date: 2011/06/07 13:45:16 $
// \   \  /  \    Date Created       : Tue Sept 21 2010
//  \___\/\___\
//
// Device           : 7 Series
// Design Name      : DDR3 SDRAM
// Purpose          :
//                   Top-level testbench for testing DDR3.
//                   Instantiates:
//                     1. IP_TOP (top-level representing FPGA, contains core,
//                        clocking, built-in testbench/memory checker and other
//                        support structures)
//                     2. DDR3 Memory
//                     3. Miscellaneous clock generation and reset logic
//                     4. For ECC ON case inserts error on LSB bit
//                        of data from DRAM to FPGA.
// Reference        :
// Revision History :
//*****************************************************************************

`timescale 1ps/100fs

module sim_tb_top;


   //***************************************************************************
   // Traffic Gen related parameters
   //***************************************************************************
   parameter C0_SIMULATION            = "TRUE";
   parameter C0_PORT_MODE             = "BI_MODE";
   parameter C0_DATA_MODE             = 4'b0010;
   parameter C0_TST_MEM_INSTR_MODE    = "R_W_INSTR_MODE";
   parameter C0_EYE_TEST              = "FALSE";
                                     // set EYE_TEST = "TRUE" to probe memory
                                     // signals. Traffic Generator will only
                                     // write to one single location and no
                                     // read transactions will be generated.
   parameter C0_DATA_PATTERN          = "DGEN_ALL";
                                      // For small devices, choose one only.
                                      // For large device, choose "DGEN_ALL"
                                      // "DGEN_HAMMER", "DGEN_WALKING1",
                                      // "DGEN_WALKING0","DGEN_ADDR","
                                      // "DGEN_NEIGHBOR","DGEN_PRBS","DGEN_ALL"
   parameter C0_CMD_PATTERN           = "CGEN_ALL";
                                      // "CGEN_PRBS","CGEN_FIXED","CGEN_BRAM",
                                      // "CGEN_SEQUENTIAL", "CGEN_ALL"
   parameter C0_BEGIN_ADDRESS         = 32'h00000000;
   parameter C0_END_ADDRESS           = 32'h00000fff;
   parameter C0_PRBS_EADDR_MASK_POS   = 32'hff000000;

   //***************************************************************************
   // The following parameters refer to width of various ports
   //***************************************************************************
   parameter C0_COL_WIDTH             = 10;
                                     // # of memory Column Address bits.
   parameter C0_CS_WIDTH              = 1;
                                     // # of unique CS outputs to memory.
   parameter C0_DM_WIDTH              = 1;
                                     // # of DM (data mask)
   parameter C0_DQ_WIDTH              = 8;
                                     // # of DQ (data)
   parameter C0_DQS_WIDTH             = 1;
   parameter C0_DQS_CNT_WIDTH         = 1;
                                     // = ceil(log2(DQS_WIDTH))
   parameter C0_DRAM_WIDTH            = 8;
                                     // # of DQ per DQS
   parameter C0_ECC                   = "OFF";
   parameter C0_RANKS                 = 1;
                                     // # of Ranks.
   parameter C0_ODT_WIDTH             = 1;
                                     // # of ODT outputs to memory.
   parameter C0_ROW_WIDTH             = 16;
                                     // # of memory Row Address bits.
   parameter C0_ADDR_WIDTH            = 30;
                                     // # = RANK_WIDTH + BANK_WIDTH
                                     //     + ROW_WIDTH + COL_WIDTH;
                                     // Chip Select is always tied to low for
                                     // single rank devices
   //***************************************************************************
   // The following parameters are mode register settings
   //***************************************************************************
   parameter C0_BURST_MODE            = "8";
                                     // DDR3 SDRAM:
                                     // Burst Length (Mode Register 0).
                                     // # = "8", "4", "OTF".
                                     // DDR2 SDRAM:
                                     // Burst Length (Mode Register).
                                     // # = "8", "4".
   parameter C0_CA_MIRROR             = "OFF";
                                     // C/A mirror opt for DDR3 dual rank
   
   //***************************************************************************
   // The following parameters are multiplier and divisor factors for PLLE2.
   // Based on the selected design frequency these parameters vary.
   //***************************************************************************
   parameter C0_CLKIN_PERIOD          = 5000;
                                     // Input Clock Period


   //***************************************************************************
   // Simulation parameters
   //***************************************************************************
   parameter C0_SIM_BYPASS_INIT_CAL   = "FAST";
                                     // # = "SIM_INIT_CAL_FULL" -  Complete
                                     //              memory init &
                                     //              calibration sequence
                                     // # = "SKIP" - Not supported
                                     // # = "FAST" - Complete memory init & use
                                     //              abbreviated calib sequence

   //***************************************************************************
   // IODELAY and PHY related parameters
   //***************************************************************************
   parameter C0_TCQ                   = 100;
   //***************************************************************************
   // IODELAY and PHY related parameters
   //***************************************************************************
   parameter RST_ACT_LOW           = 1;
                                     // =1 for active low reset,
                                     // =0 for active high.

   //***************************************************************************
   // Referece clock frequency parameters
   //***************************************************************************
   parameter REFCLK_FREQ           = 200.0;
                                     // IODELAYCTRL reference clock frequency
   //***************************************************************************
   // System clock frequency parameters
   //***************************************************************************
   parameter C0_tCK                   = 2500;
                                     // memory tCK paramter.
                     // # = Clock Period in pS.
   parameter C0_nCK_PER_CLK           = 2;
                                     // # of memory CKs per fabric CLK

   

   //***************************************************************************
   // Debug and Internal parameters
   //***************************************************************************
   parameter C0_DEBUG_PORT            = "OFF";
                                     // # = "ON" Enable debug signals/controls.
                                     //   = "OFF" Disable debug signals/controls.
   //***************************************************************************
   // Debug and Internal parameters
   //***************************************************************************
   parameter DRAM_TYPE             = "DDR3";

    
   //***************************************************************************
   // Traffic Gen related parameters
   //***************************************************************************
   parameter C1_SIMULATION            = "TRUE";
   parameter C1_PORT_MODE             = "BI_MODE";
   parameter C1_DATA_MODE             = 4'b0010;
   parameter C1_TST_MEM_INSTR_MODE    = "R_W_INSTR_MODE";
   parameter C1_EYE_TEST              = "FALSE";
                                     // set EYE_TEST = "TRUE" to probe memory
                                     // signals. Traffic Generator will only
                                     // write to one single location and no
                                     // read transactions will be generated.
   parameter C1_DATA_PATTERN          = "DGEN_ALL";
                                      // For small devices, choose one only.
                                      // For large device, choose "DGEN_ALL"
                                      // "DGEN_HAMMER", "DGEN_WALKING1",
                                      // "DGEN_WALKING0","DGEN_ADDR","
                                      // "DGEN_NEIGHBOR","DGEN_PRBS","DGEN_ALL"
   parameter C1_CMD_PATTERN           = "CGEN_ALL";
                                      // "CGEN_PRBS","CGEN_FIXED","CGEN_BRAM",
                                      // "CGEN_SEQUENTIAL", "CGEN_ALL"
   parameter C1_BEGIN_ADDRESS         = 32'h00000000;
   parameter C1_END_ADDRESS           = 32'h00000fff;
   parameter C1_PRBS_EADDR_MASK_POS   = 32'hff000000;

   //***************************************************************************
   // The following parameters refer to width of various ports
   //***************************************************************************
   parameter C1_COL_WIDTH             = 10;
                                     // # of memory Column Address bits.
   parameter C1_CS_WIDTH              = 1;
                                     // # of unique CS outputs to memory.
   parameter C1_DM_WIDTH              = 1;
                                     // # of DM (data mask)
   parameter C1_DQ_WIDTH              = 8;
                                     // # of DQ (data)
   parameter C1_DQS_WIDTH             = 1;
   parameter C1_DQS_CNT_WIDTH         = 1;
                                     // = ceil(log2(DQS_WIDTH))
   parameter C1_DRAM_WIDTH            = 8;
                                     // # of DQ per DQS
   parameter C1_ECC                   = "OFF";
   parameter C1_RANKS                 = 1;
                                     // # of Ranks.
   parameter C1_ODT_WIDTH             = 1;
                                     // # of ODT outputs to memory.
   parameter C1_ROW_WIDTH             = 16;
                                     // # of memory Row Address bits.
   parameter C1_ADDR_WIDTH            = 30;
                                     // # = RANK_WIDTH + BANK_WIDTH
                                     //     + ROW_WIDTH + COL_WIDTH;
                                     // Chip Select is always tied to low for
                                     // single rank devices
   //***************************************************************************
   // The following parameters are mode register settings
   //***************************************************************************
   parameter C1_BURST_MODE            = "8";
                                     // DDR3 SDRAM:
                                     // Burst Length (Mode Register 0).
                                     // # = "8", "4", "OTF".
                                     // DDR2 SDRAM:
                                     // Burst Length (Mode Register).
                                     // # = "8", "4".
   parameter C1_CA_MIRROR             = "OFF";
                                     // C/A mirror opt for DDR3 dual rank
   
   //***************************************************************************
   // The following parameters are multiplier and divisor factors for PLLE2.
   // Based on the selected design frequency these parameters vary.
   //***************************************************************************
   parameter C1_CLKIN_PERIOD          = 5000;
                                     // Input Clock Period


   //***************************************************************************
   // Simulation parameters
   //***************************************************************************
   parameter C1_SIM_BYPASS_INIT_CAL   = "FAST";
                                     // # = "SIM_INIT_CAL_FULL" -  Complete
                                     //              memory init &
                                     //              calibration sequence
                                     // # = "SKIP" - Not supported
                                     // # = "FAST" - Complete memory init & use
                                     //              abbreviated calib sequence

   //***************************************************************************
   // IODELAY and PHY related parameters
   //***************************************************************************
   parameter C1_TCQ                   = 100;
   

   
   //***************************************************************************
   // System clock frequency parameters
   //***************************************************************************
   parameter C1_tCK                   = 2500;
                                     // memory tCK paramter.
                     // # = Clock Period in pS.
   parameter C1_nCK_PER_CLK           = 2;
                                     // # of memory CKs per fabric CLK

   

   //***************************************************************************
   // Debug and Internal parameters
   //***************************************************************************
   parameter C1_DEBUG_PORT            = "OFF";
                                     // # = "ON" Enable debug signals/controls.
                                     //   = "OFF" Disable debug signals/controls.
   

    
   //***************************************************************************
   // Traffic Gen related parameters
   //***************************************************************************
   parameter C2_SIMULATION            = "TRUE";
   parameter C2_PORT_MODE             = "BI_MODE";
   parameter C2_DATA_MODE             = 4'b0010;
   parameter C2_TST_MEM_INSTR_MODE    = "R_W_INSTR_MODE";
   parameter C2_EYE_TEST              = "FALSE";
                                     // set EYE_TEST = "TRUE" to probe memory
                                     // signals. Traffic Generator will only
                                     // write to one single location and no
                                     // read transactions will be generated.
   parameter C2_DATA_PATTERN          = "DGEN_ALL";
                                      // For small devices, choose one only.
                                      // For large device, choose "DGEN_ALL"
                                      // "DGEN_HAMMER", "DGEN_WALKING1",
                                      // "DGEN_WALKING0","DGEN_ADDR","
                                      // "DGEN_NEIGHBOR","DGEN_PRBS","DGEN_ALL"
   parameter C2_CMD_PATTERN           = "CGEN_ALL";
                                      // "CGEN_PRBS","CGEN_FIXED","CGEN_BRAM",
                                      // "CGEN_SEQUENTIAL", "CGEN_ALL"
   parameter C2_BEGIN_ADDRESS         = 32'h00000000;
   parameter C2_END_ADDRESS           = 32'h00000fff;
   parameter C2_PRBS_EADDR_MASK_POS   = 32'hff000000;

   //***************************************************************************
   // The following parameters refer to width of various ports
   //***************************************************************************
   parameter C2_COL_WIDTH             = 10;
                                     // # of memory Column Address bits.
   parameter C2_CS_WIDTH              = 1;
                                     // # of unique CS outputs to memory.
   parameter C2_DM_WIDTH              = 1;
                                     // # of DM (data mask)
   parameter C2_DQ_WIDTH              = 8;
                                     // # of DQ (data)
   parameter C2_DQS_WIDTH             = 1;
   parameter C2_DQS_CNT_WIDTH         = 1;
                                     // = ceil(log2(DQS_WIDTH))
   parameter C2_DRAM_WIDTH            = 8;
                                     // # of DQ per DQS
   parameter C2_ECC                   = "OFF";
   parameter C2_RANKS                 = 1;
                                     // # of Ranks.
   parameter C2_ODT_WIDTH             = 1;
                                     // # of ODT outputs to memory.
   parameter C2_ROW_WIDTH             = 16;
                                     // # of memory Row Address bits.
   parameter C2_ADDR_WIDTH            = 30;
                                     // # = RANK_WIDTH + BANK_WIDTH
                                     //     + ROW_WIDTH + COL_WIDTH;
                                     // Chip Select is always tied to low for
                                     // single rank devices
   //***************************************************************************
   // The following parameters are mode register settings
   //***************************************************************************
   parameter C2_BURST_MODE            = "8";
                                     // DDR3 SDRAM:
                                     // Burst Length (Mode Register 0).
                                     // # = "8", "4", "OTF".
                                     // DDR2 SDRAM:
                                     // Burst Length (Mode Register).
                                     // # = "8", "4".
   parameter C2_CA_MIRROR             = "OFF";
                                     // C/A mirror opt for DDR3 dual rank
   
   //***************************************************************************
   // The following parameters are multiplier and divisor factors for PLLE2.
   // Based on the selected design frequency these parameters vary.
   //***************************************************************************
   parameter C2_CLKIN_PERIOD          = 5000;
                                     // Input Clock Period


   //***************************************************************************
   // Simulation parameters
   //***************************************************************************
   parameter C2_SIM_BYPASS_INIT_CAL   = "FAST";
                                     // # = "SIM_INIT_CAL_FULL" -  Complete
                                     //              memory init &
                                     //              calibration sequence
                                     // # = "SKIP" - Not supported
                                     // # = "FAST" - Complete memory init & use
                                     //              abbreviated calib sequence

   //***************************************************************************
   // IODELAY and PHY related parameters
   //***************************************************************************
   parameter C2_TCQ                   = 100;
   

   
   //***************************************************************************
   // System clock frequency parameters
   //***************************************************************************
   parameter C2_tCK                   = 2500;
                                     // memory tCK paramter.
                     // # = Clock Period in pS.
   parameter C2_nCK_PER_CLK           = 2;
                                     // # of memory CKs per fabric CLK

   

   //***************************************************************************
   // Debug and Internal parameters
   //***************************************************************************
   parameter C2_DEBUG_PORT            = "OFF";
                                     // # = "ON" Enable debug signals/controls.
                                     //   = "OFF" Disable debug signals/controls.
   

    

  //**************************************************************************//
  // Local parameters Declarations
  //**************************************************************************//

  localparam real C0_TPROP_DQS          = 0.00;
                                       // Delay for DQS signal during Write Operation
  localparam real C0_TPROP_DQS_RD       = 0.00;
                       // Delay for DQS signal during Read Operation
  localparam real C0_TPROP_PCB_CTRL     = 0.00;
                       // Delay for Address and Ctrl signals
  localparam real C0_TPROP_PCB_DATA     = 0.00;
                       // Delay for data signal during Write operation
  localparam real C0_TPROP_PCB_DATA_RD  = 0.00;
                       // Delay for data signal during Read operation

  localparam C0_MEMORY_WIDTH            = 8;
  localparam C0_NUM_COMP                = C0_DQ_WIDTH/C0_MEMORY_WIDTH;
  localparam C0_ECC_TEST 		   	= "OFF" ;
  localparam C0_ERR_INSERT = (C0_ECC_TEST == "ON") ? "OFF" : C0_ECC ;
  

  localparam real REFCLK_PERIOD = (1000000.0/(2*REFCLK_FREQ));
  localparam RESET_PERIOD = 200000; //in pSec  
  localparam real C0_SYSCLK_PERIOD = C0_tCK;
    
    
  localparam real C1_TPROP_DQS          = 0.00;
                                       // Delay for DQS signal during Write Operation
  localparam real C1_TPROP_DQS_RD       = 0.00;
                       // Delay for DQS signal during Read Operation
  localparam real C1_TPROP_PCB_CTRL     = 0.00;
                       // Delay for Address and Ctrl signals
  localparam real C1_TPROP_PCB_DATA     = 0.00;
                       // Delay for data signal during Write operation
  localparam real C1_TPROP_PCB_DATA_RD  = 0.00;
                       // Delay for data signal during Read operation

  localparam C1_MEMORY_WIDTH            = 8;
  localparam C1_NUM_COMP                = C1_DQ_WIDTH/C1_MEMORY_WIDTH;
  localparam C1_ECC_TEST 		   	= "OFF" ;
  localparam C1_ERR_INSERT = (C1_ECC_TEST == "ON") ? "OFF" : C1_ECC ;
  

  localparam real C1_SYSCLK_PERIOD = C1_tCK;
    
    
  localparam real C2_TPROP_DQS          = 0.00;
                                       // Delay for DQS signal during Write Operation
  localparam real C2_TPROP_DQS_RD       = 0.00;
                       // Delay for DQS signal during Read Operation
  localparam real C2_TPROP_PCB_CTRL     = 0.00;
                       // Delay for Address and Ctrl signals
  localparam real C2_TPROP_PCB_DATA     = 0.00;
                       // Delay for data signal during Write operation
  localparam real C2_TPROP_PCB_DATA_RD  = 0.00;
                       // Delay for data signal during Read operation

  localparam C2_MEMORY_WIDTH            = 8;
  localparam C2_NUM_COMP                = C2_DQ_WIDTH/C2_MEMORY_WIDTH;
  localparam C2_ECC_TEST 		   	= "OFF" ;
  localparam C2_ERR_INSERT = (C2_ECC_TEST == "ON") ? "OFF" : C2_ECC ;
  

  localparam real C2_SYSCLK_PERIOD = C2_tCK;
    
    

  //**************************************************************************//
  // Wire Declarations
  //**************************************************************************//
  reg                                sys_rst_n;
  wire                               sys_rst;


  reg                     c0_sys_clk_i;

  reg clk_ref_i;

  
  wire                               c0_ddr3_reset_n;
  wire [C0_DQ_WIDTH-1:0]                c0_ddr3_dq_fpga;
  wire [C0_DQS_WIDTH-1:0]               c0_ddr3_dqs_p_fpga;
  wire [C0_DQS_WIDTH-1:0]               c0_ddr3_dqs_n_fpga;
  wire [C0_ROW_WIDTH-1:0]               c0_ddr3_addr_fpga;
  wire [3-1:0]              c0_ddr3_ba_fpga;
  wire                               c0_ddr3_ras_n_fpga;
  wire                               c0_ddr3_cas_n_fpga;
  wire                               c0_ddr3_we_n_fpga;
  wire [1-1:0]               c0_ddr3_cke_fpga;
  wire [1-1:0]                c0_ddr3_ck_p_fpga;
  wire [1-1:0]                c0_ddr3_ck_n_fpga;
    
  
  wire                               init_calib_complete;
  wire                               tg_compare_error;
  wire [(C0_CS_WIDTH*1)-1:0] c0_ddr3_cs_n_fpga;
    
  wire [C0_DM_WIDTH-1:0]                c0_ddr3_dm_fpga;
    
  wire [C0_ODT_WIDTH-1:0]               c0_ddr3_odt_fpga;
    
  
  reg [(C0_CS_WIDTH*1)-1:0] c0_ddr3_cs_n_sdram_tmp;
    
  reg [C0_DM_WIDTH-1:0]                 c0_ddr3_dm_sdram_tmp;
    
  reg [C0_ODT_WIDTH-1:0]                c0_ddr3_odt_sdram_tmp;
    

  
  wire [C0_DQ_WIDTH-1:0]                c0_ddr3_dq_sdram;
  reg [C0_ROW_WIDTH-1:0]                c0_ddr3_addr_sdram [0:1];
  reg [3-1:0]               c0_ddr3_ba_sdram [0:1];
  reg                                c0_ddr3_ras_n_sdram;
  reg                                c0_ddr3_cas_n_sdram;
  reg                                c0_ddr3_we_n_sdram;
  wire [(C0_CS_WIDTH*1)-1:0] c0_ddr3_cs_n_sdram;
  wire [C0_ODT_WIDTH-1:0]               c0_ddr3_odt_sdram;
  reg [1-1:0]                c0_ddr3_cke_sdram;
  wire [C0_DM_WIDTH-1:0]                c0_ddr3_dm_sdram;
  wire [C0_DQS_WIDTH-1:0]               c0_ddr3_dqs_p_sdram;
  wire [C0_DQS_WIDTH-1:0]               c0_ddr3_dqs_n_sdram;
  reg [1-1:0]                 c0_ddr3_ck_p_sdram;
  reg [1-1:0]                 c0_ddr3_ck_n_sdram;
  
    
  reg                     c1_sys_clk_i;


  
  wire                               c1_ddr3_reset_n;
  wire [C1_DQ_WIDTH-1:0]                c1_ddr3_dq_fpga;
  wire [C1_DQS_WIDTH-1:0]               c1_ddr3_dqs_p_fpga;
  wire [C1_DQS_WIDTH-1:0]               c1_ddr3_dqs_n_fpga;
  wire [C1_ROW_WIDTH-1:0]               c1_ddr3_addr_fpga;
  wire [3-1:0]              c1_ddr3_ba_fpga;
  wire                               c1_ddr3_ras_n_fpga;
  wire                               c1_ddr3_cas_n_fpga;
  wire                               c1_ddr3_we_n_fpga;
  wire [1-1:0]               c1_ddr3_cke_fpga;
  wire [1-1:0]                c1_ddr3_ck_p_fpga;
  wire [1-1:0]                c1_ddr3_ck_n_fpga;
    
  
  wire [(C1_CS_WIDTH*1)-1:0] c1_ddr3_cs_n_fpga;
    
  wire [C1_DM_WIDTH-1:0]                c1_ddr3_dm_fpga;
    
  wire [C1_ODT_WIDTH-1:0]               c1_ddr3_odt_fpga;
    
  
  reg [(C1_CS_WIDTH*1)-1:0] c1_ddr3_cs_n_sdram_tmp;
    
  reg [C1_DM_WIDTH-1:0]                 c1_ddr3_dm_sdram_tmp;
    
  reg [C1_ODT_WIDTH-1:0]                c1_ddr3_odt_sdram_tmp;
    

  
  wire [C1_DQ_WIDTH-1:0]                c1_ddr3_dq_sdram;
  reg [C1_ROW_WIDTH-1:0]                c1_ddr3_addr_sdram [0:1];
  reg [3-1:0]               c1_ddr3_ba_sdram [0:1];
  reg                                c1_ddr3_ras_n_sdram;
  reg                                c1_ddr3_cas_n_sdram;
  reg                                c1_ddr3_we_n_sdram;
  wire [(C1_CS_WIDTH*1)-1:0] c1_ddr3_cs_n_sdram;
  wire [C1_ODT_WIDTH-1:0]               c1_ddr3_odt_sdram;
  reg [1-1:0]                c1_ddr3_cke_sdram;
  wire [C1_DM_WIDTH-1:0]                c1_ddr3_dm_sdram;
  wire [C1_DQS_WIDTH-1:0]               c1_ddr3_dqs_p_sdram;
  wire [C1_DQS_WIDTH-1:0]               c1_ddr3_dqs_n_sdram;
  reg [1-1:0]                 c1_ddr3_ck_p_sdram;
  reg [1-1:0]                 c1_ddr3_ck_n_sdram;
  
    
  reg                     c2_sys_clk_i;


  
  wire                               c2_ddr3_reset_n;
  wire [C2_DQ_WIDTH-1:0]                c2_ddr3_dq_fpga;
  wire [C2_DQS_WIDTH-1:0]               c2_ddr3_dqs_p_fpga;
  wire [C2_DQS_WIDTH-1:0]               c2_ddr3_dqs_n_fpga;
  wire [C2_ROW_WIDTH-1:0]               c2_ddr3_addr_fpga;
  wire [3-1:0]              c2_ddr3_ba_fpga;
  wire                               c2_ddr3_ras_n_fpga;
  wire                               c2_ddr3_cas_n_fpga;
  wire                               c2_ddr3_we_n_fpga;
  wire [1-1:0]               c2_ddr3_cke_fpga;
  wire [1-1:0]                c2_ddr3_ck_p_fpga;
  wire [1-1:0]                c2_ddr3_ck_n_fpga;
    
  
  wire [(C2_CS_WIDTH*1)-1:0] c2_ddr3_cs_n_fpga;
    
  wire [C2_DM_WIDTH-1:0]                c2_ddr3_dm_fpga;
    
  wire [C2_ODT_WIDTH-1:0]               c2_ddr3_odt_fpga;
    
  
  reg [(C2_CS_WIDTH*1)-1:0] c2_ddr3_cs_n_sdram_tmp;
    
  reg [C2_DM_WIDTH-1:0]                 c2_ddr3_dm_sdram_tmp;
    
  reg [C2_ODT_WIDTH-1:0]                c2_ddr3_odt_sdram_tmp;
    

  
  wire [C2_DQ_WIDTH-1:0]                c2_ddr3_dq_sdram;
  reg [C2_ROW_WIDTH-1:0]                c2_ddr3_addr_sdram [0:1];
  reg [3-1:0]               c2_ddr3_ba_sdram [0:1];
  reg                                c2_ddr3_ras_n_sdram;
  reg                                c2_ddr3_cas_n_sdram;
  reg                                c2_ddr3_we_n_sdram;
  wire [(C2_CS_WIDTH*1)-1:0] c2_ddr3_cs_n_sdram;
  wire [C2_ODT_WIDTH-1:0]               c2_ddr3_odt_sdram;
  reg [1-1:0]                c2_ddr3_cke_sdram;
  wire [C2_DM_WIDTH-1:0]                c2_ddr3_dm_sdram;
  wire [C2_DQS_WIDTH-1:0]               c2_ddr3_dqs_p_sdram;
  wire [C2_DQS_WIDTH-1:0]               c2_ddr3_dqs_n_sdram;
  reg [1-1:0]                 c2_ddr3_ck_p_sdram;
  reg [1-1:0]                 c2_ddr3_ck_n_sdram;
  
    

//**************************************************************************//

  //**************************************************************************//
  // Reset Generation
  //**************************************************************************//
  initial begin
    sys_rst_n = 1'b0;
    #RESET_PERIOD
      sys_rst_n = 1'b1;
   end

   assign sys_rst = RST_ACT_LOW ? sys_rst_n : ~sys_rst_n;

  //**************************************************************************//
  // Clock Generation
  //**************************************************************************//

  initial
    c0_sys_clk_i = 1'b0;
  always
    c0_sys_clk_i = #(C0_CLKIN_PERIOD/2.0) ~c0_sys_clk_i;


  initial
    clk_ref_i = 1'b0;
  always
    clk_ref_i = #REFCLK_PERIOD ~clk_ref_i;

  initial
    c1_sys_clk_i = 1'b0;
  always
    c1_sys_clk_i = #(C1_CLKIN_PERIOD/2.0) ~c1_sys_clk_i;



  initial
    c2_sys_clk_i = 1'b0;
  always
    c2_sys_clk_i = #(C2_CLKIN_PERIOD/2.0) ~c2_sys_clk_i;






  always @( * ) begin
    c0_ddr3_ck_p_sdram      <=  #(C0_TPROP_PCB_CTRL) c0_ddr3_ck_p_fpga;
    c0_ddr3_ck_n_sdram      <=  #(C0_TPROP_PCB_CTRL) c0_ddr3_ck_n_fpga;
    c0_ddr3_addr_sdram[0]   <=  #(C0_TPROP_PCB_CTRL) c0_ddr3_addr_fpga;
    c0_ddr3_addr_sdram[1]   <=  #(C0_TPROP_PCB_CTRL) (C0_CA_MIRROR == "ON") ?
                                                 {c0_ddr3_addr_fpga[C0_ROW_WIDTH-1:9],
                                                  c0_ddr3_addr_fpga[7], c0_ddr3_addr_fpga[8],
                                                  c0_ddr3_addr_fpga[5], c0_ddr3_addr_fpga[6],
                                                  c0_ddr3_addr_fpga[3], c0_ddr3_addr_fpga[4],
                                                  c0_ddr3_addr_fpga[2:0]} :
                                                 c0_ddr3_addr_fpga;
    c0_ddr3_ba_sdram[0]     <=  #(C0_TPROP_PCB_CTRL) c0_ddr3_ba_fpga;
    c0_ddr3_ba_sdram[1]     <=  #(C0_TPROP_PCB_CTRL) (C0_CA_MIRROR == "ON") ?
                                                 {c0_ddr3_ba_fpga[3-1:2],
                                                  c0_ddr3_ba_fpga[0],
                                                  c0_ddr3_ba_fpga[1]} :
                                                 c0_ddr3_ba_fpga;
    c0_ddr3_ras_n_sdram     <=  #(C0_TPROP_PCB_CTRL) c0_ddr3_ras_n_fpga;
    c0_ddr3_cas_n_sdram     <=  #(C0_TPROP_PCB_CTRL) c0_ddr3_cas_n_fpga;
    c0_ddr3_we_n_sdram      <=  #(C0_TPROP_PCB_CTRL) c0_ddr3_we_n_fpga;
    c0_ddr3_cke_sdram       <=  #(C0_TPROP_PCB_CTRL) c0_ddr3_cke_fpga;
  end
    

  always @( * )
    c0_ddr3_cs_n_sdram_tmp   <=  #(C0_TPROP_PCB_CTRL) c0_ddr3_cs_n_fpga;
  assign c0_ddr3_cs_n_sdram =  c0_ddr3_cs_n_sdram_tmp;
    

  always @( * )
    c0_ddr3_dm_sdram_tmp <=  #(C0_TPROP_PCB_DATA) c0_ddr3_dm_fpga;//DM signal generation
  assign c0_ddr3_dm_sdram = c0_ddr3_dm_sdram_tmp;
    

  always @( * )
    c0_ddr3_odt_sdram_tmp  <=  #(C0_TPROP_PCB_CTRL) c0_ddr3_odt_fpga;
  assign c0_ddr3_odt_sdram =  c0_ddr3_odt_sdram_tmp;
    

// Controlling the bi-directional BUS

  genvar c0_dqwd;
  generate
    for (c0_dqwd = 1;c0_dqwd < C0_DQ_WIDTH;c0_dqwd = c0_dqwd+1) begin : c0_dq_delay
      WireDelay #
       (
        .Delay_g    (C0_TPROP_PCB_DATA),
        .Delay_rd   (C0_TPROP_PCB_DATA_RD),
        .ERR_INSERT ("OFF")
       )
      c0_u_delay_dq
       (
        .A             (c0_ddr3_dq_fpga[c0_dqwd]),
        .B             (c0_ddr3_dq_sdram[c0_dqwd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
    end
    // For ECC ON case error is inserted on LSB bit from DRAM to FPGA
          WireDelay #
       (
        .Delay_g    (C0_TPROP_PCB_DATA),
        .Delay_rd   (C0_TPROP_PCB_DATA_RD),
        .ERR_INSERT (C0_ERR_INSERT)
       )
      c0_u_delay_dq_0
       (
        .A             (c0_ddr3_dq_fpga[0]),
        .B             (c0_ddr3_dq_sdram[0]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
  endgenerate

  genvar c0_dqswd;
  generate
    for (c0_dqswd = 0;c0_dqswd < C0_DQS_WIDTH;c0_dqswd = c0_dqswd+1) begin : c0_dqs_delay
      WireDelay #
       (
        .Delay_g    (C0_TPROP_DQS),
        .Delay_rd   (C0_TPROP_DQS_RD),
        .ERR_INSERT ("OFF")
       )
      c0_u_delay_dqs_p
       (
        .A             (c0_ddr3_dqs_p_fpga[c0_dqswd]),
        .B             (c0_ddr3_dqs_p_sdram[c0_dqswd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );

      WireDelay #
       (
        .Delay_g    (C0_TPROP_DQS),
        .Delay_rd   (C0_TPROP_DQS_RD),
        .ERR_INSERT ("OFF")
       )
      c0_u_delay_dqs_n
       (
        .A             (c0_ddr3_dqs_n_fpga[c0_dqswd]),
        .B             (c0_ddr3_dqs_n_sdram[c0_dqswd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
    end
  endgenerate
    

    

  always @( * ) begin
    c1_ddr3_ck_p_sdram      <=  #(C1_TPROP_PCB_CTRL) c1_ddr3_ck_p_fpga;
    c1_ddr3_ck_n_sdram      <=  #(C1_TPROP_PCB_CTRL) c1_ddr3_ck_n_fpga;
    c1_ddr3_addr_sdram[0]   <=  #(C1_TPROP_PCB_CTRL) c1_ddr3_addr_fpga;
    c1_ddr3_addr_sdram[1]   <=  #(C1_TPROP_PCB_CTRL) (C1_CA_MIRROR == "ON") ?
                                                 {c1_ddr3_addr_fpga[C1_ROW_WIDTH-1:9],
                                                  c1_ddr3_addr_fpga[7], c1_ddr3_addr_fpga[8],
                                                  c1_ddr3_addr_fpga[5], c1_ddr3_addr_fpga[6],
                                                  c1_ddr3_addr_fpga[3], c1_ddr3_addr_fpga[4],
                                                  c1_ddr3_addr_fpga[2:0]} :
                                                 c1_ddr3_addr_fpga;
    c1_ddr3_ba_sdram[0]     <=  #(C1_TPROP_PCB_CTRL) c1_ddr3_ba_fpga;
    c1_ddr3_ba_sdram[1]     <=  #(C1_TPROP_PCB_CTRL) (C1_CA_MIRROR == "ON") ?
                                                 {c1_ddr3_ba_fpga[3-1:2],
                                                  c1_ddr3_ba_fpga[0],
                                                  c1_ddr3_ba_fpga[1]} :
                                                 c1_ddr3_ba_fpga;
    c1_ddr3_ras_n_sdram     <=  #(C1_TPROP_PCB_CTRL) c1_ddr3_ras_n_fpga;
    c1_ddr3_cas_n_sdram     <=  #(C1_TPROP_PCB_CTRL) c1_ddr3_cas_n_fpga;
    c1_ddr3_we_n_sdram      <=  #(C1_TPROP_PCB_CTRL) c1_ddr3_we_n_fpga;
    c1_ddr3_cke_sdram       <=  #(C1_TPROP_PCB_CTRL) c1_ddr3_cke_fpga;
  end
    

  always @( * )
    c1_ddr3_cs_n_sdram_tmp   <=  #(C1_TPROP_PCB_CTRL) c1_ddr3_cs_n_fpga;
  assign c1_ddr3_cs_n_sdram =  c1_ddr3_cs_n_sdram_tmp;
    

  always @( * )
    c1_ddr3_dm_sdram_tmp <=  #(C1_TPROP_PCB_DATA) c1_ddr3_dm_fpga;//DM signal generation
  assign c1_ddr3_dm_sdram = c1_ddr3_dm_sdram_tmp;
    

  always @( * )
    c1_ddr3_odt_sdram_tmp  <=  #(C1_TPROP_PCB_CTRL) c1_ddr3_odt_fpga;
  assign c1_ddr3_odt_sdram =  c1_ddr3_odt_sdram_tmp;
    

// Controlling the bi-directional BUS

  genvar c1_dqwd;
  generate
    for (c1_dqwd = 1;c1_dqwd < C1_DQ_WIDTH;c1_dqwd = c1_dqwd+1) begin : c1_dq_delay
      WireDelay #
       (
        .Delay_g    (C1_TPROP_PCB_DATA),
        .Delay_rd   (C1_TPROP_PCB_DATA_RD),
        .ERR_INSERT ("OFF")
       )
      c1_u_delay_dq
       (
        .A             (c1_ddr3_dq_fpga[c1_dqwd]),
        .B             (c1_ddr3_dq_sdram[c1_dqwd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
    end
    // For ECC ON case error is inserted on LSB bit from DRAM to FPGA
          WireDelay #
       (
        .Delay_g    (C1_TPROP_PCB_DATA),
        .Delay_rd   (C1_TPROP_PCB_DATA_RD),
        .ERR_INSERT (C1_ERR_INSERT)
       )
      c1_u_delay_dq_0
       (
        .A             (c1_ddr3_dq_fpga[0]),
        .B             (c1_ddr3_dq_sdram[0]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
  endgenerate

  genvar c1_dqswd;
  generate
    for (c1_dqswd = 0;c1_dqswd < C1_DQS_WIDTH;c1_dqswd = c1_dqswd+1) begin : c1_dqs_delay
      WireDelay #
       (
        .Delay_g    (C1_TPROP_DQS),
        .Delay_rd   (C1_TPROP_DQS_RD),
        .ERR_INSERT ("OFF")
       )
      c1_u_delay_dqs_p
       (
        .A             (c1_ddr3_dqs_p_fpga[c1_dqswd]),
        .B             (c1_ddr3_dqs_p_sdram[c1_dqswd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );

      WireDelay #
       (
        .Delay_g    (C1_TPROP_DQS),
        .Delay_rd   (C1_TPROP_DQS_RD),
        .ERR_INSERT ("OFF")
       )
      c1_u_delay_dqs_n
       (
        .A             (c1_ddr3_dqs_n_fpga[c1_dqswd]),
        .B             (c1_ddr3_dqs_n_sdram[c1_dqswd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
    end
  endgenerate
    

    

  always @( * ) begin
    c2_ddr3_ck_p_sdram      <=  #(C2_TPROP_PCB_CTRL) c2_ddr3_ck_p_fpga;
    c2_ddr3_ck_n_sdram      <=  #(C2_TPROP_PCB_CTRL) c2_ddr3_ck_n_fpga;
    c2_ddr3_addr_sdram[0]   <=  #(C2_TPROP_PCB_CTRL) c2_ddr3_addr_fpga;
    c2_ddr3_addr_sdram[1]   <=  #(C2_TPROP_PCB_CTRL) (C2_CA_MIRROR == "ON") ?
                                                 {c2_ddr3_addr_fpga[C2_ROW_WIDTH-1:9],
                                                  c2_ddr3_addr_fpga[7], c2_ddr3_addr_fpga[8],
                                                  c2_ddr3_addr_fpga[5], c2_ddr3_addr_fpga[6],
                                                  c2_ddr3_addr_fpga[3], c2_ddr3_addr_fpga[4],
                                                  c2_ddr3_addr_fpga[2:0]} :
                                                 c2_ddr3_addr_fpga;
    c2_ddr3_ba_sdram[0]     <=  #(C2_TPROP_PCB_CTRL) c2_ddr3_ba_fpga;
    c2_ddr3_ba_sdram[1]     <=  #(C2_TPROP_PCB_CTRL) (C2_CA_MIRROR == "ON") ?
                                                 {c2_ddr3_ba_fpga[3-1:2],
                                                  c2_ddr3_ba_fpga[0],
                                                  c2_ddr3_ba_fpga[1]} :
                                                 c2_ddr3_ba_fpga;
    c2_ddr3_ras_n_sdram     <=  #(C2_TPROP_PCB_CTRL) c2_ddr3_ras_n_fpga;
    c2_ddr3_cas_n_sdram     <=  #(C2_TPROP_PCB_CTRL) c2_ddr3_cas_n_fpga;
    c2_ddr3_we_n_sdram      <=  #(C2_TPROP_PCB_CTRL) c2_ddr3_we_n_fpga;
    c2_ddr3_cke_sdram       <=  #(C2_TPROP_PCB_CTRL) c2_ddr3_cke_fpga;
  end
    

  always @( * )
    c2_ddr3_cs_n_sdram_tmp   <=  #(C2_TPROP_PCB_CTRL) c2_ddr3_cs_n_fpga;
  assign c2_ddr3_cs_n_sdram =  c2_ddr3_cs_n_sdram_tmp;
    

  always @( * )
    c2_ddr3_dm_sdram_tmp <=  #(C2_TPROP_PCB_DATA) c2_ddr3_dm_fpga;//DM signal generation
  assign c2_ddr3_dm_sdram = c2_ddr3_dm_sdram_tmp;
    

  always @( * )
    c2_ddr3_odt_sdram_tmp  <=  #(C2_TPROP_PCB_CTRL) c2_ddr3_odt_fpga;
  assign c2_ddr3_odt_sdram =  c2_ddr3_odt_sdram_tmp;
    

// Controlling the bi-directional BUS

  genvar c2_dqwd;
  generate
    for (c2_dqwd = 1;c2_dqwd < C2_DQ_WIDTH;c2_dqwd = c2_dqwd+1) begin : c2_dq_delay
      WireDelay #
       (
        .Delay_g    (C2_TPROP_PCB_DATA),
        .Delay_rd   (C2_TPROP_PCB_DATA_RD),
        .ERR_INSERT ("OFF")
       )
      c2_u_delay_dq
       (
        .A             (c2_ddr3_dq_fpga[c2_dqwd]),
        .B             (c2_ddr3_dq_sdram[c2_dqwd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
    end
    // For ECC ON case error is inserted on LSB bit from DRAM to FPGA
          WireDelay #
       (
        .Delay_g    (C2_TPROP_PCB_DATA),
        .Delay_rd   (C2_TPROP_PCB_DATA_RD),
        .ERR_INSERT (C2_ERR_INSERT)
       )
      c2_u_delay_dq_0
       (
        .A             (c2_ddr3_dq_fpga[0]),
        .B             (c2_ddr3_dq_sdram[0]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
  endgenerate

  genvar c2_dqswd;
  generate
    for (c2_dqswd = 0;c2_dqswd < C2_DQS_WIDTH;c2_dqswd = c2_dqswd+1) begin : c2_dqs_delay
      WireDelay #
       (
        .Delay_g    (C2_TPROP_DQS),
        .Delay_rd   (C2_TPROP_DQS_RD),
        .ERR_INSERT ("OFF")
       )
      c2_u_delay_dqs_p
       (
        .A             (c2_ddr3_dqs_p_fpga[c2_dqswd]),
        .B             (c2_ddr3_dqs_p_sdram[c2_dqswd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );

      WireDelay #
       (
        .Delay_g    (C2_TPROP_DQS),
        .Delay_rd   (C2_TPROP_DQS_RD),
        .ERR_INSERT ("OFF")
       )
      c2_u_delay_dqs_n
       (
        .A             (c2_ddr3_dqs_n_fpga[c2_dqswd]),
        .B             (c2_ddr3_dqs_n_sdram[c2_dqswd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
    end
  endgenerate
    

    

  //===========================================================================
  //                         FPGA Memory Controller
  //===========================================================================

  example_top #
    (

     .C0_SIMULATION                (C0_SIMULATION),
     .C0_PORT_MODE                 (C0_PORT_MODE),
     .C0_DATA_MODE                 (C0_DATA_MODE),
     .C0_TST_MEM_INSTR_MODE        (C0_TST_MEM_INSTR_MODE),
     .C0_EYE_TEST                  (C0_EYE_TEST),
     .C0_DATA_PATTERN              (C0_DATA_PATTERN),
     .C0_CMD_PATTERN               (C0_CMD_PATTERN),
     .C0_BEGIN_ADDRESS             (C0_BEGIN_ADDRESS),
     .C0_END_ADDRESS               (C0_END_ADDRESS),
     .C0_PRBS_EADDR_MASK_POS       (C0_PRBS_EADDR_MASK_POS),

     .C0_COL_WIDTH                 (C0_COL_WIDTH),
     .C0_CS_WIDTH                  (C0_CS_WIDTH),
     .C0_DM_WIDTH                  (C0_DM_WIDTH),
    
     .C0_DQ_WIDTH                  (C0_DQ_WIDTH),
     .C0_DQS_CNT_WIDTH             (C0_DQS_CNT_WIDTH),
     .C0_DRAM_WIDTH                (C0_DRAM_WIDTH),
     .C0_ECC_TEST                  (C0_ECC_TEST),
     .C0_RANKS                     (C0_RANKS),
     .C0_ROW_WIDTH                 (C0_ROW_WIDTH),
     .C0_ADDR_WIDTH                (C0_ADDR_WIDTH),
     .C0_BURST_MODE                (C0_BURST_MODE),
     .C0_TCQ                       (C0_TCQ),

     
    .DRAM_TYPE                 (DRAM_TYPE),
    
     
    .C0_nCK_PER_CLK               (C0_nCK_PER_CLK),
    
     
     .C0_DEBUG_PORT                (C0_DEBUG_PORT),
    
     .C1_SIMULATION                (C1_SIMULATION),
     .C1_PORT_MODE                 (C1_PORT_MODE),
     .C1_DATA_MODE                 (C1_DATA_MODE),
     .C1_TST_MEM_INSTR_MODE        (C1_TST_MEM_INSTR_MODE),
     .C1_EYE_TEST                  (C1_EYE_TEST),
     .C1_DATA_PATTERN              (C1_DATA_PATTERN),
     .C1_CMD_PATTERN               (C1_CMD_PATTERN),
     .C1_BEGIN_ADDRESS             (C1_BEGIN_ADDRESS),
     .C1_END_ADDRESS               (C1_END_ADDRESS),
     .C1_PRBS_EADDR_MASK_POS       (C1_PRBS_EADDR_MASK_POS),

     .C1_COL_WIDTH                 (C1_COL_WIDTH),
     .C1_CS_WIDTH                  (C1_CS_WIDTH),
     .C1_DM_WIDTH                  (C1_DM_WIDTH),
    
     .C1_DQ_WIDTH                  (C1_DQ_WIDTH),
     .C1_DQS_CNT_WIDTH             (C1_DQS_CNT_WIDTH),
     .C1_DRAM_WIDTH                (C1_DRAM_WIDTH),
     .C1_ECC_TEST                  (C1_ECC_TEST),
     .C1_RANKS                     (C1_RANKS),
     .C1_ROW_WIDTH                 (C1_ROW_WIDTH),
     .C1_ADDR_WIDTH                (C1_ADDR_WIDTH),
     .C1_BURST_MODE                (C1_BURST_MODE),
     .C1_TCQ                       (C1_TCQ),

     
     
    .C1_nCK_PER_CLK               (C1_nCK_PER_CLK),
    
     
     .C1_DEBUG_PORT                (C1_DEBUG_PORT),
    
     .C2_SIMULATION                (C2_SIMULATION),
     .C2_PORT_MODE                 (C2_PORT_MODE),
     .C2_DATA_MODE                 (C2_DATA_MODE),
     .C2_TST_MEM_INSTR_MODE        (C2_TST_MEM_INSTR_MODE),
     .C2_EYE_TEST                  (C2_EYE_TEST),
     .C2_DATA_PATTERN              (C2_DATA_PATTERN),
     .C2_CMD_PATTERN               (C2_CMD_PATTERN),
     .C2_BEGIN_ADDRESS             (C2_BEGIN_ADDRESS),
     .C2_END_ADDRESS               (C2_END_ADDRESS),
     .C2_PRBS_EADDR_MASK_POS       (C2_PRBS_EADDR_MASK_POS),

     .C2_COL_WIDTH                 (C2_COL_WIDTH),
     .C2_CS_WIDTH                  (C2_CS_WIDTH),
     .C2_DM_WIDTH                  (C2_DM_WIDTH),
    
     .C2_DQ_WIDTH                  (C2_DQ_WIDTH),
     .C2_DQS_CNT_WIDTH             (C2_DQS_CNT_WIDTH),
     .C2_DRAM_WIDTH                (C2_DRAM_WIDTH),
     .C2_ECC_TEST                  (C2_ECC_TEST),
     .C2_RANKS                     (C2_RANKS),
     .C2_ROW_WIDTH                 (C2_ROW_WIDTH),
     .C2_ADDR_WIDTH                (C2_ADDR_WIDTH),
     .C2_BURST_MODE                (C2_BURST_MODE),
     .C2_TCQ                       (C2_TCQ),

     
     
    .C2_nCK_PER_CLK               (C2_nCK_PER_CLK),
    
     
     .C2_DEBUG_PORT                (C2_DEBUG_PORT),
    
     .RST_ACT_LOW               (RST_ACT_LOW)
    )
   u_ip_top
     (

     .c0_ddr3_dq              (c0_ddr3_dq_fpga),
     .c0_ddr3_dqs_n           (c0_ddr3_dqs_n_fpga),
     .c0_ddr3_dqs_p           (c0_ddr3_dqs_p_fpga),

     .c0_ddr3_addr            (c0_ddr3_addr_fpga),
     .c0_ddr3_ba              (c0_ddr3_ba_fpga),
     .c0_ddr3_ras_n           (c0_ddr3_ras_n_fpga),
     .c0_ddr3_cas_n           (c0_ddr3_cas_n_fpga),
     .c0_ddr3_we_n            (c0_ddr3_we_n_fpga),
     .c0_ddr3_reset_n         (c0_ddr3_reset_n),
     .c0_ddr3_ck_p            (c0_ddr3_ck_p_fpga),
     .c0_ddr3_ck_n            (c0_ddr3_ck_n_fpga),
     .c0_ddr3_cke             (c0_ddr3_cke_fpga),
     .c0_ddr3_cs_n            (c0_ddr3_cs_n_fpga),
    
     .c0_ddr3_dm              (c0_ddr3_dm_fpga),
    
     .c0_ddr3_odt             (c0_ddr3_odt_fpga),
    
     
     .c0_sys_clk_i            (c0_sys_clk_i),
    
     .c1_ddr3_dq              (c1_ddr3_dq_fpga),
     .c1_ddr3_dqs_n           (c1_ddr3_dqs_n_fpga),
     .c1_ddr3_dqs_p           (c1_ddr3_dqs_p_fpga),

     .c1_ddr3_addr            (c1_ddr3_addr_fpga),
     .c1_ddr3_ba              (c1_ddr3_ba_fpga),
     .c1_ddr3_ras_n           (c1_ddr3_ras_n_fpga),
     .c1_ddr3_cas_n           (c1_ddr3_cas_n_fpga),
     .c1_ddr3_we_n            (c1_ddr3_we_n_fpga),
     .c1_ddr3_reset_n         (c1_ddr3_reset_n),
     .c1_ddr3_ck_p            (c1_ddr3_ck_p_fpga),
     .c1_ddr3_ck_n            (c1_ddr3_ck_n_fpga),
     .c1_ddr3_cke             (c1_ddr3_cke_fpga),
     .c1_ddr3_cs_n            (c1_ddr3_cs_n_fpga),
    
     .c1_ddr3_dm              (c1_ddr3_dm_fpga),
    
     .c1_ddr3_odt             (c1_ddr3_odt_fpga),
    
     
     .c1_sys_clk_i            (c1_sys_clk_i),
    
     .c2_ddr3_dq              (c2_ddr3_dq_fpga),
     .c2_ddr3_dqs_n           (c2_ddr3_dqs_n_fpga),
     .c2_ddr3_dqs_p           (c2_ddr3_dqs_p_fpga),

     .c2_ddr3_addr            (c2_ddr3_addr_fpga),
     .c2_ddr3_ba              (c2_ddr3_ba_fpga),
     .c2_ddr3_ras_n           (c2_ddr3_ras_n_fpga),
     .c2_ddr3_cas_n           (c2_ddr3_cas_n_fpga),
     .c2_ddr3_we_n            (c2_ddr3_we_n_fpga),
     .c2_ddr3_reset_n         (c2_ddr3_reset_n),
     .c2_ddr3_ck_p            (c2_ddr3_ck_p_fpga),
     .c2_ddr3_ck_n            (c2_ddr3_ck_n_fpga),
     .c2_ddr3_cke             (c2_ddr3_cke_fpga),
     .c2_ddr3_cs_n            (c2_ddr3_cs_n_fpga),
    
     .c2_ddr3_dm              (c2_ddr3_dm_fpga),
    
     .c2_ddr3_odt             (c2_ddr3_odt_fpga),
    
     
     .c2_sys_clk_i            (c2_sys_clk_i),
    
      .init_calib_complete (init_calib_complete),
      .tg_compare_error    (tg_compare_error),
      .sys_rst             (sys_rst)
     );

  //**************************************************************************//
  // Memory Models instantiations
  //**************************************************************************//

  genvar c0_r,c0_i;
  generate
    for (c0_r = 0; c0_r < C0_CS_WIDTH; c0_r = c0_r + 1) begin: c0_mem_rnk
      for (c0_i = 0; c0_i < C0_NUM_COMP; c0_i = c0_i + 1) begin: c0_gen_mem
        c0_ddr3_model c0_u_comp_ddr3
          (
           .rst_n   (c0_ddr3_reset_n),
           .ck      (c0_ddr3_ck_p_sdram),
           .ck_n    (c0_ddr3_ck_n_sdram),
           .cke     (c0_ddr3_cke_sdram[c0_r]),
           .cs_n    (c0_ddr3_cs_n_sdram[c0_r]),
           .ras_n   (c0_ddr3_ras_n_sdram),
           .cas_n   (c0_ddr3_cas_n_sdram),
           .we_n    (c0_ddr3_we_n_sdram),
           .dm_tdqs (c0_ddr3_dm_sdram[c0_i]),
           .ba      (c0_ddr3_ba_sdram[c0_r]),
           .addr    (c0_ddr3_addr_sdram[c0_r]),
           .dq      (c0_ddr3_dq_sdram[C0_MEMORY_WIDTH*(c0_i+1)-1:C0_MEMORY_WIDTH*(c0_i)]),
           .dqs     (c0_ddr3_dqs_p_sdram[c0_i]),
           .dqs_n   (c0_ddr3_dqs_n_sdram[c0_i]),
           .tdqs_n  (),
           .odt     (c0_ddr3_odt_sdram[c0_r])
           );
      end
    end
  endgenerate
    
    
  genvar c1_r,c1_i;
  generate
    for (c1_r = 0; c1_r < C1_CS_WIDTH; c1_r = c1_r + 1) begin: c1_mem_rnk
      for (c1_i = 0; c1_i < C1_NUM_COMP; c1_i = c1_i + 1) begin: c1_gen_mem
        c1_ddr3_model c1_u_comp_ddr3
          (
           .rst_n   (c1_ddr3_reset_n),
           .ck      (c1_ddr3_ck_p_sdram),
           .ck_n    (c1_ddr3_ck_n_sdram),
           .cke     (c1_ddr3_cke_sdram[c1_r]),
           .cs_n    (c1_ddr3_cs_n_sdram[c1_r]),
           .ras_n   (c1_ddr3_ras_n_sdram),
           .cas_n   (c1_ddr3_cas_n_sdram),
           .we_n    (c1_ddr3_we_n_sdram),
           .dm_tdqs (c1_ddr3_dm_sdram[c1_i]),
           .ba      (c1_ddr3_ba_sdram[c1_r]),
           .addr    (c1_ddr3_addr_sdram[c1_r]),
           .dq      (c1_ddr3_dq_sdram[C1_MEMORY_WIDTH*(c1_i+1)-1:C1_MEMORY_WIDTH*(c1_i)]),
           .dqs     (c1_ddr3_dqs_p_sdram[c1_i]),
           .dqs_n   (c1_ddr3_dqs_n_sdram[c1_i]),
           .tdqs_n  (),
           .odt     (c1_ddr3_odt_sdram[c1_r])
           );
      end
    end
  endgenerate
    
    
  genvar c2_r,c2_i;
  generate
    for (c2_r = 0; c2_r < C2_CS_WIDTH; c2_r = c2_r + 1) begin: c2_mem_rnk
      for (c2_i = 0; c2_i < C2_NUM_COMP; c2_i = c2_i + 1) begin: c2_gen_mem
        c2_ddr3_model c2_u_comp_ddr3
          (
           .rst_n   (c2_ddr3_reset_n),
           .ck      (c2_ddr3_ck_p_sdram),
           .ck_n    (c2_ddr3_ck_n_sdram),
           .cke     (c2_ddr3_cke_sdram[c2_r]),
           .cs_n    (c2_ddr3_cs_n_sdram[c2_r]),
           .ras_n   (c2_ddr3_ras_n_sdram),
           .cas_n   (c2_ddr3_cas_n_sdram),
           .we_n    (c2_ddr3_we_n_sdram),
           .dm_tdqs (c2_ddr3_dm_sdram[c2_i]),
           .ba      (c2_ddr3_ba_sdram[c2_r]),
           .addr    (c2_ddr3_addr_sdram[c2_r]),
           .dq      (c2_ddr3_dq_sdram[C2_MEMORY_WIDTH*(c2_i+1)-1:C2_MEMORY_WIDTH*(c2_i)]),
           .dqs     (c2_ddr3_dqs_p_sdram[c2_i]),
           .dqs_n   (c2_ddr3_dqs_n_sdram[c2_i]),
           .tdqs_n  (),
           .odt     (c2_ddr3_odt_sdram[c2_r])
           );
      end
    end
  endgenerate
    
    


  //***************************************************************************
  // Reporting the test case status
  // Status reporting logic exists both in simulation test bench (sim_tb_top)
  // and sim.do file for ModelSim. Any update in simulation run time or time out
  // in this file need to be updated in sim.do file as well.
  //***************************************************************************
  initial
  begin : Logging
     fork
        begin : calibration_done
           wait (init_calib_complete);
           $display("Calibration Done");
           #50000000.0;
           if (!tg_compare_error) begin
              $display("TEST PASSED");
           end
           else begin
              $display("TEST FAILED: DATA ERROR");
           end
           disable calib_not_done;
            $finish;
        end

        begin : calib_not_done
           if (C0_SIM_BYPASS_INIT_CAL == "SIM_INIT_CAL_FULL")
             #2500000000.0;
           else
             #1000000000.0;
           if (!init_calib_complete) begin
              $display("TEST FAILED: INITIALIZATION DID NOT COMPLETE");
           end
           disable calibration_done;
            $finish;
        end
     join
  end
    
endmodule
