`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/16 18:45:24
// Design Name: 
// Module Name: PA_TOP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PA_TOP(
  
  //PCIE物理接口begin
  output  [0:0]    pci_exp_txp,
  output  [0:0]    pci_exp_txn,
  input   [0:0]    pci_exp_rxp,
  input   [0:0]    pci_exp_rxn,

  output           pcie_led_0,
  output           pcie_led_1,
  output           pcie_led_2,
  output           pcie_led_3,
  
  //output wire [3:0]GPIO_OUT,
//  (* DONT_TOUCH = "TRUE" *) input emcclk,
  
//  input            pcie_system_clk_n,            //板子上的系统时钟，200M
//  input            pcie_system_clk_p,

  input            pcie_sys_clk_p, 
  input            pcie_sys_clk_n,
  input            pcie_sys_rst_n,
	//PCIE物理接口end
	
  
     // Inouts
   inout [7:0]            c0_ddr3_dq,
   inout [0:0]            c0_ddr3_dqs_n,
   inout [0:0]            c0_ddr3_dqs_p,

   // Outputs
   output [15:0]          c0_ddr3_addr,
   output [2:0]           c0_ddr3_ba,
   output                 c0_ddr3_ras_n,
   output                 c0_ddr3_cas_n,
   output                 c0_ddr3_we_n,
   output                 c0_ddr3_reset_n,
   output [0:0]           c0_ddr3_ck_p,
   output [0:0]           c0_ddr3_ck_n,
   output [0:0]           c0_ddr3_cke,
   
   output [0:0]           c0_ddr3_cs_n,   
   output [0:0]           c0_ddr3_dm,   
   output [0:0]           c0_ddr3_odt,

//   output                 tg_compare_error,
//   output                 init_calib_complete,
   
      
   // Inouts
   inout [7:0]            c1_ddr3_dq,
   inout [0:0]            c1_ddr3_dqs_n,
   inout [0:0]            c1_ddr3_dqs_p,

   // Outputs
   output [15:0]          c1_ddr3_addr,
   output [2:0]           c1_ddr3_ba,
   output                 	 c1_ddr3_ras_n,
   output                   c1_ddr3_cas_n,
   output                 c1_ddr3_we_n,
   output                 c1_ddr3_reset_n,
   output [0:0]           c1_ddr3_ck_p,
   output [0:0]           c1_ddr3_ck_n,
   output [0:0]           c1_ddr3_cke,
   
   output [0:0]           c1_ddr3_cs_n,   
   output [0:0]           c1_ddr3_dm,  
   output [0:0]           c1_ddr3_odt,
 /*    
   // Inouts
   inout [7:0]           c2_ddr3_dq,
   inout [0:0]           c2_ddr3_dqs_n,
   inout [0:0]           c2_ddr3_dqs_p,

   // Outputs
   output [15:0]         c2_ddr3_addr,
   output [2:0]          c2_ddr3_ba,
   output                c2_ddr3_ras_n,
   output                c2_ddr3_cas_n,
   output                c2_ddr3_we_n,
   output                c2_ddr3_reset_n,
   output [0:0]          c2_ddr3_ck_p,
   output [0:0]          c2_ddr3_ck_n,
   output [0:0]          c2_ddr3_cke,
   
   output [0:0]          c2_ddr3_cs_n,   
   output [0:0]          c2_ddr3_dm,   
   output [0:0]          c2_ddr3_odt,
   */
   //参考时钟定义
   input                 uart_rx,
   input                 REF_50M_CLK,
   input                 REF_200M_CLKN,
   input                 REF_200M_CLKP,
   //solt 1接口定义
   input                 CARD1_CUR_ADC_BUSY, 
   //output                CARD1_CUR_ADC_CLK_N,
   //output                CARD1_CUR_ADC_CLK_P,
   //input                 CARD1_CUR_ADC_CNV_N,
   //input                 CARD1_CUR_ADC_CNV_P,
   //input                 CARD1_CUR_ADC_DAT_N,
   //input                 CARD1_CUR_ADC_DAT_P,
   //input                 CARD1_CUR_ADC_DCO_N,
   //input                 CARD1_CUR_ADC_DCO_P,
   output                CARD1_CUR_CMD_OE,   
   output                CARD1_CUR_CMD_RCLK, 
   input                 CARD1_CUR_CMD_SER,  
   output                CARD1_CUR_CMD_SRCLK,
   input                 CARD1_CUR_FREQ,     
   input                 CARD1_CUR_PROT,     
   //input                 CARD1_CUR_RSV_N,    
   //input                 CARD1_CUR_RSV_P,    
   //input [3:0]           CARD1_ID, 
   input                  CARD1_ID_2,
   input                  CARD1_ID_0,
   output                 CARD1_ID_1,
   output                 CARD1_ID_3,
                              
   input                 CARD1_VOL_ADC_BUSY ,
   //output                CARD1_VOL_ADC_CLK_N,
   //output                CARD1_VOL_ADC_CLK_P,
   //input                 CARD1_VOL_ADC_CNV_N,
   //input                 CARD1_VOL_ADC_CNV_P,
   //input                 CARD1_VOL_ADC_DAT_N,
   //input                 CARD1_VOL_ADC_DAT_P,
   //input                 CARD1_VOL_ADC_DCO_N,
   //input                 CARD1_VOL_ADC_DCO_P,
   output                CARD1_VOL_CMD_OE,   
   output                CARD1_VOL_CMD_RCLK, 
   output                CARD1_VOL_CMD_SER,  
   output                CARD1_VOL_CMD_SRCLK,
   input                 CARD1_VOL_FREQ,     
   input                 CARD1_VOL_PROT,     
   //input                 CARD1_VOL_RSV_N,    
   //input                 CARD1_VOL_RSV_P,    

   //solt 2接口定义                               
   input                 CARD2_CUR_ADC_BUSY,      
   //output                CARD2_CUR_ADC_CLK_N,     
   //output                CARD2_CUR_ADC_CLK_P,     
   //input                 CARD2_CUR_ADC_CNV_N,     
   //input                 CARD2_CUR_ADC_CNV_P,     
   //input                 CARD2_CUR_ADC_DAT_N,     
   //input                 CARD2_CUR_ADC_DAT_P,     
   //input                 CARD2_CUR_ADC_DCO_N,     
   //input                 CARD2_CUR_ADC_DCO_P,     
   output                CARD2_CUR_CMD_OE,        
   output                CARD2_CUR_CMD_RCLK,      
   input                CARD2_CUR_CMD_SER,       
   output                CARD2_CUR_CMD_SRCLK,     
   input                 CARD2_CUR_FREQ,          
   input                 CARD2_CUR_PROT,          
   //input                 CARD2_CUR_RSV_N,         
   //input                 CARD2_CUR_RSV_P,         
   //input [3:0]           CARD2_ID,
   input                 CARD2_ID_2,
   input                 CARD2_ID_0,
   output                CARD2_ID_1,
   output                CARD2_ID_3,
                   
   input                 CARD2_VOL_ADC_BUSY ,     
   //output                CARD2_VOL_ADC_CLK_N,     
   //output                CARD2_VOL_ADC_CLK_P,     
   //input                 CARD2_VOL_ADC_CNV_N,     
   //input                 CARD2_VOL_ADC_CNV_P,     
   //input                 CARD2_VOL_ADC_DAT_N,     
   //input                 CARD2_VOL_ADC_DAT_P,     
   //input                 CARD2_VOL_ADC_DCO_N,     
   //input                 CARD2_VOL_ADC_DCO_P,     
   output                CARD2_VOL_CMD_OE,        
   output                CARD2_VOL_CMD_RCLK,      
   output                CARD2_VOL_CMD_SER,       
   output                CARD2_VOL_CMD_SRCLK,     
   input                 CARD2_VOL_FREQ,          
   input                 CARD2_VOL_PROT,          
   //input                 CARD2_VOL_RSV_N,         
   //input                 CARD2_VOL_RSV_P,         

   //solt 3接口定义                               
   input                 CARD3_CUR_ADC_BUSY,      
   //output                CARD3_CUR_ADC_CLK_N,     
   //output                CARD3_CUR_ADC_CLK_P,     
   //input                 CARD3_CUR_ADC_CNV_N,     
   //input                 CARD3_CUR_ADC_CNV_P,     
   //input                 CARD3_CUR_ADC_DAT_N,     
   //input                 CARD3_CUR_ADC_DAT_P,     
   //input                 CARD3_CUR_ADC_DCO_N,     
   //input                 CARD3_CUR_ADC_DCO_P,     
   output                CARD3_CUR_CMD_OE,        
   output                CARD3_CUR_CMD_RCLK,      
   input                CARD3_CUR_CMD_SER,       
   output                CARD3_CUR_CMD_SRCLK,     
   input                 CARD3_CUR_FREQ,          
   input                 CARD3_CUR_PROT,          
   //input                 CARD3_CUR_RSV_N,         
   //input                 CARD3_CUR_RSV_P,         
   //input [3:0]           CARD3_ID,                
   input                CARD3_ID_2,
   input                CARD3_ID_0,
   output               CARD3_ID_1,
   output               CARD3_ID_3,
   input                 CARD3_VOL_ADC_BUSY ,     
   //output                CARD3_VOL_ADC_CLK_N,     
   //output                CARD3_VOL_ADC_CLK_P,     
   //input                 CARD3_VOL_ADC_CNV_N,     
   //input                 CARD3_VOL_ADC_CNV_P,     
   //input                 CARD3_VOL_ADC_DAT_N,     
   //input                 CARD3_VOL_ADC_DAT_P,     
   //input                 CARD3_VOL_ADC_DCO_N,     
   //input                 CARD3_VOL_ADC_DCO_P,     
   output                CARD3_VOL_CMD_OE,        
   output                CARD3_VOL_CMD_RCLK,      
   output                CARD3_VOL_CMD_SER,       
   output                CARD3_VOL_CMD_SRCLK,     
   input                 CARD3_VOL_FREQ,          
   input                 CARD3_VOL_PROT,          
   //input                 CARD3_VOL_RSV_N,         
   //input                 CARD3_VOL_RSV_P,         

  //保留测频接口
   input                 CLKIN,
   output                CLKOUT,
   
  //保留LED接口，1：LED亮，0：LED灭    
  output                LED0,      //修改了约束，严格按处理板的led顺序
  output                LED1, 
  output                LED2,    
  output                LED3,
  output                LED4,  
  //output                LED5,    //这4颗pcie已使用 
  //output                LED6,  
  //output                LED7,  
  //output                LED8, 
  
  
  //保留按键接口：1：默认状态，2：按下按键
  input                 SW0,
  input                 SW1,
  input                 SW2,
  input                 SW3,
  
  //板卡低功耗设置：1：板卡12V电源断开，0：板卡12V电源接入
  output                SWITCH_12V,
  
  //保留调试接口

  //input   [51:0]       GPIO_N,
  //input   [51:0]       GPIO_P,
  output  [29:0]       BANK13_GPIO   
  );   
 
  wire  clk_100M;
  wire  clk_10M;
  wire  clk_50M;
  //wire  ddr3_sys_clk_i;
  wire  clk_200M;    
  wire  REF_clk_200M;
                        
  wire [15:0]	 delay_dat;           
  wire [31:0]   add_dat_s12;         
  wire [31:0]   add_dat_s34;         
  wire [31:0]   add_dat_s56;         
  wire [31:0]   add_dat_s78;  
  wire [31:0]   delay_dat2;
         
  wire [31:0]   data_from_serdes_s1; 
  wire [31:0]   data_from_serdes_s2; 
  wire [31:0]   data_from_serdes_s3; 
  wire [31:0]   data_from_serdes_s4; 
  
  wire [31:0]   data_from_card_s1;
  wire [31:0]   data_from_card_s2;
  wire [31:0]   data_from_card_s3;
  wire [31:0]   data_from_card_s4;
  
  wire [1:0]  oserdes_data_sel;  
  wire [31:0]	data_real_source1;
  wire [31:0]	data_real_source2;
  wire [31:0]	data_real_source3;
  wire [31:0]	data_real_source4;

  wire freq_data_choose;
  
  wire         adc_Rxdat_valid;
  //wire [127:0] adc_data_8ch;
  
  wire pcie_wr_fifo_full;  
  
  
  wire [12:0] prog_full_thresh;
  wire fifo_rd_s0;  
  wire adc_Rxdat_valid;
  wire fifo_full; 
  wire fifo_empty;   
  wire prog_full;
  wire fifo_dout_8ch_valid;
  wire [127:0] fifo_dout_8ch; 
  
  wire [127:0] tx_fifo_in_data;
  wire tx_fifo_wr_en; 
  wire rst_trans_fifo;
  wire [9:0] pcie_wr_data_count;
  wire pcie_prog_full; 
  
  wire pc_dma_read_en;  
  wire [31:0] time_gap_num;
  wire data_flow_mode;   
  wire [2:0] acq_mode;  
  wire fifo_rclk_sel;       
  wire pcFifo_reset_L; 
  wire UI_fifo_reset_L;
  wire Program_Full; 
	wire fifo_wr_enable;
  wire auto_rclk_en;
  wire fifo_wen_tri;
  wire	[31:0]	predepth;	//real sample pre tri depth
  wire	[36:0]	posdepth;	//after tri depth set
  wire	[31:0]	tri_holdoff;
  wire  [15:0]  num_program;
  wire  [4:0]   trans_id;
  wire		[31:0]		trig_level_ch0;   
	wire		[31:0]		trig_level_ch1;   
	wire		[31:0]		trig_level_ch2;   
	wire		[31:0]		trig_level_ch3;   
	wire		[31:0]		trig_level_ch4;   
	wire		[31:0]		trig_level_ch5;   
	wire		[31:0]		trig_level_ch6;   
	wire		[31:0]		trig_level_ch7;
	wire              trig_rst_n; 
	wire		[31:0]		trig_mode;        
	wire		[7:0]		Edge_ch_valid;    
	wire		[31:0]		Edge_mode;
	wire tri_auto; 
	wire [31:0] auto_trig_level_1;
	wire [31:0] auto_trig_level_2;
	wire [31:0] auto_trig_level_3;
	wire [31:0] auto_trig_level_4;
	wire [31:0] auto_trig_level_5;
	wire [31:0] auto_trig_level_6;
	wire [31:0] auto_trig_level_7;
  wire [31:0] auto_trig_level_8;  
  wire ready_dsp;
  wire auto_dsp;     
  wire trigged_dsp;
  wire trig_out;  
  wire ready;          
  wire close_fifo_en_reg;
  wire time_over;  
  wire pre_trig_real_over;  
  wire pos_tri_s;  
  wire trigged_reg;      
  
  wire  UI_fifo_write;
  wire  UI_fifo_read; 
  
  //功率模式参数             
  wire 				  power_mode_rst_n;     
  wire [31:0]   power_mode_predepth;  
  wire          power_mode_begin;             
  wire          data_ch1_6_valid;     
  wire          power_rd_en2;                                
  wire  [127:0] power_dout_8ch;       
  wire          power_dout_8ch_valid; 
  wire  [12:0]  power_fifo_data_count;
  wire          power_fifo_full;      
  wire          power_prog_full;      
  
  
  
  //测频模块   
  wire         detect_freq_rst_n;
  wire [31:0]  sel_ch;
  wire [127:0] comp_level;          
  wire [31:0]  gate_vaule;         
  wire [31:0]  cnt_cycle;                                                                                                          
  wire [39:0]	 cnt_period0;			   
  wire [31:0]	 cnt_freq_fx0;			   
  wire [31:0]	 cnt_freq_fs0;			                                    
  wire			   per_full_flag0;		   
  wire				 per_mea_flag0;		   
  wire				 fre_mea_flag0;		    		                           
  wire	[39:0] cnt_period1;		     
  wire	[31:0] cnt_freq_fx1;			   
  wire	[31:0] cnt_freq_fs1;			                          
  wire		     per_full_flag1;		   
  wire				 per_mea_flag1;		   
  wire				 fre_mea_flag1;		                   
  wire	[39:0] cnt_period2;		     
  wire	[31:0] cnt_freq_fx2;			   
  wire	[31:0] cnt_freq_fs2;			                        
  wire		     per_full_flag2;		   
  wire				 per_mea_flag2;		   
  wire				 fre_mea_flag2;		                             
  wire	[39:0] cnt_period3;		     
  wire	[31:0] cnt_freq_fx3;			   
  wire	[31:0] cnt_freq_fs3;			                               
  wire				 per_full_flag3;		   
  wire				 per_mea_flag3;		   
  wire				 fre_mea_flag3;		   
  
  wire         clk_adc      ;
  wire         clkout_change;
  wire   [31:0]period_in    ;
  wire         clkin_up     ;
  
  wire [31:0]S1_1_coe_mul;
  wire [15:0]S1_1_coe_add;
  wire [31:0]S1_2_coe_mul;
  wire [15:0]S1_2_coe_add;
  wire [31:0]S2_1_coe_mul;
  wire [15:0]S2_1_coe_add;
  wire [31:0]S2_2_coe_mul;
  wire [15:0]S2_2_coe_add;
  wire [31:0]S3_1_coe_mul;
  wire [15:0]S3_1_coe_add;
  wire [31:0]S3_2_coe_mul;
  wire [15:0]S3_2_coe_add;
  wire  [2:0]fre_choose  ;
  
  wire [15:0]S1_1_odata_signed  ;
  wire [15:0]S1_2_odata_signed  ;
  wire [15:0]S2_1_odata_signed  ;
  wire [15:0]S2_2_odata_signed  ;
  wire [15:0]S3_1_odata_signed  ;
  wire [15:0]S3_2_odata_signed  ;

  //wire [15:0]S1_1_odata_unsigned;
  //wire [15:0]S1_2_odata_unsigned;
  //wire [15:0]S2_1_odata_unsigned;
  //wire [15:0]S2_2_odata_unsigned;
  //wire [15:0]S3_1_odata_unsigned;
  //wire [15:0]S3_2_odata_unsigned;

  wire       S1_1_odata_valid   ;
  wire       S1_2_odata_valid   ;
  wire       S2_1_odata_valid   ;
  wire       S2_2_odata_valid   ;
  wire       S3_1_odata_valid   ;
  wire       S3_2_odata_valid   ;
  
  
  wire   [0:0]  ddr3_sys_rst;
  wire   [31:0] ddr3_depth;
  wire   [0:0]  ddr3_startpingpang;
  
  
  
          
            
    
  
  
  
  
 IBUFGDS #(
      .DIFF_TERM("FALSE"),    // Differential Termination
      .IBUF_LOW_PWR("TRUE"),  // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")  // Specify the input I/O standard
   ) IBUFGDS_inst_200M (
      .O(REF_clk_200M),  // Clock buffer output
      .I(REF_200M_CLKP),  // Diff_p clock buffer input (connect directly to top-level port)
      .IB(REF_200M_CLKN) // Diff_n clock buffer input (connect directly to top-level port)
   );
  
    
 
 
  /*时钟配置模块*/
clk_wiz_0 clk_wiz_0_inst
   (
    // Clock out ports
    .clk_out1(clk_200M),     // output clk_out1 200
    .clk_out2(clk_100M),     // output clk_out2 100  
    .clk_out3(clk_10M),
    .clk_out4(clk_50M),     // output clk_out4
    // Status and control signals
    //.reset(0), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(REF_50M_CLK)
    //.clk_in1(REF_clk_200M)
    );      // input clk_in1

/*
vio_0 vio_0 (
  .clk(clk_100M),                // input wire clk
  .probe_in0(probe_in0),    // input wire [0 : 0] probe_in0
  .probe_out0 ( S1_1_coe_add ),  // output wire [15 : 0] probe_out0
  .probe_out1 ( S1_1_coe_mul ),  // output wire [31 : 0] probe_out1
  .probe_out2 ( S1_2_coe_add ),  // output wire [15 : 0] probe_out2 
  .probe_out3 ( S1_2_coe_mul ),  // output wire [31 : 0] probe_out3 
  .probe_out4 ( S2_1_coe_add ),  // output wire [15 : 0] probe_out4 
  .probe_out5 ( S2_1_coe_mul ),  // output wire [31 : 0] probe_out5 
  .probe_out6 ( S2_2_coe_add ),  // output wire [15 : 0] probe_out6 
  .probe_out7 ( S2_2_coe_mul ),  // output wire [31 : 0] probe_out7 
  .probe_out8 ( S3_1_coe_add ),  // output wire [15 : 0] probe_out8 
  .probe_out9 ( S3_1_coe_mul ),  // output wire [31 : 0] probe_out9 
  .probe_out10( S3_2_coe_add ),  // output wire [15 : 0] probe_out10
  .probe_out11( S3_2_coe_mul ),  // output wire [31 : 0] probe_out11 
  .probe_out12( fre_choose    )
  
);
*/
/////////////////////////////////////////////////////////////////


////////////////////////////////////////

/*
fre_double_module fre_double_module(
  .clk_200M      ( clk_200M   ),          
  .CARD1_VOL_FREQ( CARD1_VOL_FREQ ),
  .CARD1_CUR_FREQ( CARD1_CUR_FREQ ),
  .CARD2_VOL_FREQ( CARD2_VOL_FREQ ),
  .CARD2_CUR_FREQ( CARD2_CUR_FREQ ),
  .CARD3_VOL_FREQ( CARD3_VOL_FREQ ),
  .CARD3_CUR_FREQ( CARD3_CUR_FREQ ),
  .rst_n         ( 1              ),
  .fre_choose    ( fre_choose     ),
                                                                              
  .clk_out      ( clk_adc        ),                  
  .clkout_change( clkout_change  ),
  .C            ( period_in      ),
  .clkin_up     ( clkin_up       )             

);


card_acq_module card_acq_module(

  .clk_100M           ( clk_100M          ),            
  .clk_50M            ( clk_50M           ), 
  .clk_10M            ( clk_10M           ),       
  .rst_n              ( 1                 ),               
  .sample_clk         ( clk_adc                ),
  
  .S1_1_adc_busy      ( CARD1_ID_2            ),
  .S1_1_adc_sdo       ( CARD1_ID_0            ),
  .S1_1_adc_sck       ( CARD1_ID_1            ),
  .S1_1_adc_cnv       ( CARD1_ID_3            ),  
  .S1_2_adc_busy      ( CARD1_CUR_ADC_BUSY    ),
  .S1_2_adc_sdo       ( CARD1_CUR_CMD_SER     ),
  .S1_2_adc_sck       ( CARD1_CUR_CMD_SRCLK   ),
  .S1_2_adc_cnv       ( CARD1_CUR_CMD_OE      ),  
  .S2_1_adc_busy      ( CARD2_ID_2             ),
  .S2_1_adc_sdo       ( CARD2_ID_0             ),
  .S2_1_adc_sck       ( CARD2_ID_1             ),
  .S2_1_adc_cnv       ( CARD2_ID_3             ),  
  .S2_2_adc_busy      ( CARD2_CUR_ADC_BUSY     ),
  .S2_2_adc_sdo       ( CARD2_CUR_CMD_SER      ),
  .S2_2_adc_sck       ( CARD2_CUR_CMD_SRCLK    ),
  .S2_2_adc_cnv       ( CARD2_CUR_CMD_OE       ),  
  .S3_1_adc_busy      ( CARD3_ID_2             ),
  .S3_1_adc_sdo       ( CARD3_ID_0             ),
  .S3_1_adc_sck       ( CARD3_ID_1             ),
  .S3_1_adc_cnv       ( CARD3_ID_3             ),  
  .S3_2_adc_busy      ( CARD3_CUR_ADC_BUSY     ),
  .S3_2_adc_sdo       ( CARD3_CUR_CMD_SER      ),
  .S3_2_adc_sck       ( CARD3_CUR_CMD_SRCLK    ),
  .S3_2_adc_cnv       ( CARD3_CUR_CMD_OE       ),
     
  .S1_1_coeff         ( S1_1_coe_mul          ),
  .S1_1_offset        ( S1_1_coe_add         ),
  .S1_1_coeff_valid   ( 1                   ), 
  .S1_1_offset_valid  ( 1                   ),
  .S1_2_coeff         ( S1_2_coe_mul          ),
  .S1_2_offset        ( S1_2_coe_add         ),
  .S1_2_coeff_valid   ( 1                   ),
  .S1_2_offset_valid  ( 1                   ),
  .S2_1_coeff         ( S2_1_coe_mul          ),
  .S2_1_offset        ( S2_1_coe_add         ),
  .S2_1_coeff_valid   ( 1                   ),
  .S2_1_offset_valid  ( 1                   ),
  .S2_2_coeff         ( S2_2_coe_mul          ),
  .S2_2_offset        ( S2_2_coe_add         ),
  .S2_2_coeff_valid   ( 1                   ),
  .S2_2_offset_valid  ( 1                   ),
  .S3_1_coeff         ( S3_1_coe_mul          ),
  .S3_1_offset        ( S3_1_coe_add         ),
  .S3_1_coeff_valid   ( 1                   ),
  .S3_1_offset_valid  ( 1                   ),
  .S3_2_coeff         ( S3_2_coe_mul          ),
  .S3_2_offset        ( S3_2_coe_add         ),
  .S3_2_coeff_valid   ( 1                   ),
  .S3_2_offset_valid  ( 1                   ),
  
  .S1_1_odata_signed  ( S1_1_odata_signed   ), 
  .S1_2_odata_signed  ( S1_2_odata_signed   ),
  .S2_1_odata_signed  ( S2_1_odata_signed   ),
  .S2_2_odata_signed  ( S2_2_odata_signed   ),
  .S3_1_odata_signed  ( S3_1_odata_signed   ),
  .S3_2_odata_signed  ( S3_2_odata_signed   ),

  .S1_1_odata_unsigned( data_from_card_s1[15:0] ),
  .S1_2_odata_unsigned( data_from_card_s1[31:16] ),
  .S2_1_odata_unsigned( data_from_card_s2[15:0]  ),
  .S2_2_odata_unsigned( data_from_card_s2[31:16] ),
  .S3_1_odata_unsigned( data_from_card_s3[15:0]  ),
  .S3_2_odata_unsigned( data_from_card_s3[31:16] ),

  .S1_1_odata_valid   ( S1_1_odata_valid    ),
  .S1_2_odata_valid   ( S1_2_odata_valid    ),
  .S2_1_odata_valid   ( S2_1_odata_valid    ),
  .S2_2_odata_valid   ( S2_2_odata_valid    ),
  .S3_1_odata_valid   ( S3_1_odata_valid    ),
  .S3_2_odata_valid   ( S3_2_odata_valid    )
  
    
);
*/

    /*仿真数据产生模块*/
/*	K7_test_data
		K7_test_data_i(
		.adc_tx_clk         (clk_100M         ),         
    .CLK_5M             (    ),             
    .UI_fifo_reset_L    (UI_fifo_reset_L    ),    
    .delay_dat          (delay_dat          ),          
    .add_dat_s12        (add_dat_s12        ),        
    .add_dat_s34        (add_dat_s34        ),        
    .add_dat_s56        (add_dat_s56        ), 
    .add_dat_s78        (add_dat_s78        ),
    .delay_dat2         (delay_dat2         ),   
    .data_valid         (data_ch1_6_valid   ),
    .data_from_serdes_s1(data_from_serdes_s1),
    .data_from_serdes_s2(data_from_serdes_s2),
    .data_from_serdes_s3(data_from_serdes_s3),
    .data_from_serdes_s4(data_from_serdes_s4) 
		);  
		
	data_source_choose
		data_source_choose_i(
			.clk_100M(clk_100M),
		  .data_from_serdes_s1(data_from_serdes_s1), 
		  .data_from_serdes_s2(data_from_serdes_s2), 
		  .data_from_serdes_s3(data_from_serdes_s3), 
		  .data_from_serdes_s4(data_from_serdes_s4), 
		  .data_from_card_s1(data_from_card_s1),   
		  .data_from_card_s2(data_from_card_s2),   
		  .data_from_card_s3(data_from_card_s3),   
		  .data_from_card_s4(data_from_serdes_s4),   
		  .oserdes_data_sel (oserdes_data_sel ),    
		  .data_real_source1(data_real_source1),   
		  .data_real_source2(data_real_source2),   
		  .data_real_source3(data_real_source3),   
		  .data_real_source4(data_real_source4)   
		  		  			
		);
		
	
	acquistion_module
		acquistion_module_i
		(
			 .rst_n(UI_fifo_reset_L),             
			 .adc_tx_clk(clk_100M),        
			 .data_from_serdes_s1(data_real_source1),
			 .data_from_serdes_s2(data_real_source2),
			 .data_from_serdes_s3(data_real_source3),
			 .data_from_serdes_s4(data_real_source4),			                     
			 .ext_clk(),            
			 .clk_choose(1'b0),          //写固定值，不接外部时钟
			 .time_gap_num(time_gap_num),            //抽点系数
			 .data_flow_mode(data_flow_mode),          //1：抽点使能  0：抽点不使能
			 .acq_mode(3'b000),                //采集模式，写死，只选正常模式	                     
			 .adc_Rxdat_valid(adc_Rxdat_valid),  
			 //.adc_data_8ch(adc_data_8ch),
			 //.pcie_wr_fifo_full(pcie_wr_fifo_full) 
			 .prog_full_thresh(prog_full_thresh),        //FIFO可编程空值
			 .fifo_write_en(UI_fifo_write),
			 .fifo_rd_fpga (fifo_wr_enable&adc_Rxdat_valid&auto_rclk_en),  
			 .fifo_rd_s0   (fifo_rd_s0),  		
			 .fifo_full (fifo_full),     
			 .fifo_empty(fifo_empty),
			 .prog_full (prog_full),     
			 .fifo_dout_8ch_valid(fifo_dout_8ch_valid),
			 .fifo_dout_8ch(fifo_dout_8ch)
			      						
		);
	
	fifo_control_UI fifo_control_UI(
     .fifo_rxclk( clk_100M ),//FIFO读时钟
     .fifo_rclk_sel( fifo_rclk_sel ),              //上位机发送，FIFO读信号选择，1：PC读，0：FPGA读
     .pcFifo_reset_L( pcFifo_reset_L ),                               //input  普通采集复位信号
     .fifo_wr_enable( fifo_wr_enable ),//FIFO 写信号，active high     //input 普通采集FIFO的写使能信号
     .fifo_wen_tri(),                  //不管
     .wen_fifo_adc6(),                 //不管
     .ddr3_en(1'b0),                      //ddr3使能，置为0，永不使能
     .ssram_mode_en(1'b0),          //ssram使能，置为0，永不使能
     .adc_Rxdat_valid( adc_Rxdat_valid ),
     .ready( ready_dsp ),                        
     .triggered( trigged_dsp ),
     .UI_fifo_reset_L(UI_fifo_reset_L  ),                      //output    普通采集的复位信号
     .UI_fifo_write( UI_fifo_write ),                           //output    FIFO写使能
     .UI_fifo_read( UI_fifo_read )                              //output    FIFO读使能

    );
    
    
   fifo_ddr_ssrsm_trig_choose_valid fifo_ddr_ssrsm_trig_choose_valid_inst(
     .adc_tx_clk(clk_100M),
     .wen_fifo_ddr(wen_fifo_ddr),                //不管
     .wen_fifo_adc3(wen_fifo_adc3),								//不管
     .adc_Rxdat_valid(adc_Rxdat_valid),
     .adc_Rxdat_valid_f(),   //不管
     .sys_arrange_en(),                       //不管
     .ddr3_en(1'b0),
     .scan_mode_en(1'b0),
     .ssram_mode_en(1'b0),
     .UI_fifo_write(UI_fifo_write),         //input    FIFO写使能
     .sram_state(),                          //不管
     .wen_ddr3(),                            //不管        
     .fifo_wen_tri(fifo_wen_tri),            //output  
     .wen_fifo_adc4(),                       //不管
     .wen_fifo_adc5(),                       //不管
     .wen_fifo_adc6()													//不管
);                                            
	
	fifo_program_full fifo_program_full(
	.clk( clk_100M  ),
	.reset( UI_fifo_reset_L  ),//active low
	.wen( UI_fifo_write),
	.adc_Rxdat_valid(adc_Rxdat_valid&UI_fifo_write),
	.ren( UI_fifo_read&auto_rclk_en ), 
	.num_program( num_program  ), 
	.ready_dsp( ready_dsp  ),
	.trigged_dsp( trigged_dsp  ),	
        .auto_dsp( auto_dsp  ),	//if "1" means Auto trig      
        .tri_auto( tri_auto ), 
	.program_full( Program_Full  ),
	.auto_rclk_en(auto_rclk_en)
	);
	
	
	trigger_module trigger_module_inst (
  .trig_force_ctrl(  ),	
	.tri_sys_selected( trig_out ),	//触发模块产生触发信号输入
	.tri_auto( tri_auto ),	//trigger style
	.clk_10M( clk_10M ),	//自动触发计数参考时钟      锁相环产生
	.wclk( clk_100M ),		//the fifo write clk
	.rxclk_125mhz( clk_50M ),//自动触发时钟参考
	
	.count_clr( UI_fifo_reset_L  ),	//复位trigger标志
	.fifo_reset( UI_fifo_reset_L  ),//FIFO复位信号，复位ready 、trigger等标志
	.fifo_clr( UI_fifo_reset_L  ),//active ,预触发计数复位
	.scan_cnt_load( scan_cnt_load  ),

	.predepth( predepth  ),	//real sample pre tri depth
	.posdepth( posdepth  ),	//after tri depth set
	.tri_holdoff( tri_holdoff  ),//37bit

	//.fifo_wen( adc_Rxdat_valid&UI_fifo_write  ), 	//fifo is wen and start the counter (   ), "1" is Actived
	//.scan_en( adc_Rxdat_valid&UI_fifo_write  ),//scan模式使能信号
	.fifo_wen( fifo_wen_tri  ), 	//fifo is wen and start the counter (   ), "1" is Actived
	.scan_en( fifo_wen_tri&(1'b0)  ),//scan模式使能信号
	//.scan_en( ssram_scan_en ),//scan模式使能信号fifo_wen_tri&scan_mode_en 
	.fifo_wr_gap( adc_Rxdat_valid ),
	.fifo_rclk_sel(   ),	//没有使用
	.trig_sig(   ),//没有使用

	//output signals
	.trigged_dsp( trigged_dsp  ),	//trigged status	
	.auto_dsp( auto_dsp  ),	//if "1" means Auto trig

	.scan_cnt_num( scan_cnt_num  ),//16bits，
	.ready_dsp( ready_dsp  ),		//ready status  waiting for trig
	.TRIG_DEALY_VALUE(   ),
	.CaliTrigDelay(   ),
	.auto_rclk_en( auto_rclk_en  ),	//自动读使能信号
	.trigged_detect_flag(   ),//没有使用
	.trigged_reg( trigged_reg  ),//有效触发信号输出
	.trig_clr_out(   ),
	.pos_tri_s( pos_tri_s ),
	.fifo_ddr3_scan(fifo_ddr3_scan),
	.clk_1KHz(clk_1KHz),
	.ready(ready),           
	.close_fifo_en_reg(close_fifo_en_reg),
	.time_over(time_over),
	.pre_trig_real_over(pre_trig_real_over)        
	
	);
	
	Trigger_gen Trigger_gen_inst(                                                 
	.data1(data_real_source1),   //卡槽1数据  0——16 ch1                   
	.data2(data_real_source2),                                              
	.data3(data_real_source3),                                              
	.data4(data_real_source4),                                               
	//.data9({p4_o,p3_o,p2_o,p1_o,{15'd0,power_trigger},16'd0,{15'd0,triggerin_pulse}}),     //outtrigger,time,line,p1,p2,p3,p4                                       
	.trig_level_ch0(trig_level_ch0),   //低16位对应低电平      //来自上位机                  
	.trig_level_ch1(trig_level_ch1),                                          
	.trig_level_ch2(trig_level_ch2),                                          
	.trig_level_ch3(trig_level_ch3),                                          
	.trig_level_ch4(trig_level_ch4),                                          
	.trig_level_ch5(trig_level_ch5),                                          
	.trig_level_ch6(trig_level_ch6),                                          
	.trig_level_ch7(trig_level_ch7),                                          
	                                                                          
                                                                              
	.auto_trig_level_1(auto_trig_level_1),        //发给上位机                                
	.auto_trig_level_2(auto_trig_level_2),                                    
	.auto_trig_level_3(auto_trig_level_3),                                    
	.auto_trig_level_4(auto_trig_level_4),                                    
	.auto_trig_level_5(auto_trig_level_5),                                    
	.auto_trig_level_6(auto_trig_level_6),                                    
	.auto_trig_level_7(auto_trig_level_7),                                    
	.auto_trig_level_8(auto_trig_level_8),                                      
	                              	                                                                          
	.trig_mod(trig_mode),                                                             
	.Edge_mode(Edge_mode),                                                    
	.Edge_ch_valid(Edge_ch_valid),  //上位机发送 边沿触发通道使能                                          
	.A_ch_valid(A_ch_valid),        //不需要                                                 
	.B_ch_valid(B_ch_valid),        //不需要                                         
	.A_state(A_state),              //不需要                                          
	.B_state(B_state),              //不需要                                          
	.ABN_num(ABN_num),              //不需要                                          
	.AdelayB_time(AdelayB_time),	  //不需要                                        
	                                                                          
	.trig_clk(clk_100M),                                                    
	.trig_rst_n(trig_rst_n),       //上位机发送复位信号                                            
	                                                                          
	.trig_out(trig_out),           //输出                                                 
	.trig_level_sel(trig_level_sel),  //不需要                                         
	.clk_1KHz(clk_1KHz)               //来自触发模块                                              
            
    );
	
	power_mode_modele
		power_mode_modele_i(
	.clk_100M             (clk_100M             ),              
	.power_mode_rst_n     (power_mode_rst_n     ),      
	.power_mode_predepth  (power_mode_predepth  ),   
	.power_mode_begin     (power_mode_begin     ),      
	.trigger_in			      (trig_out			        ),            
	.data_from_serdes_s1  (data_from_serdes_s1  ),   
	.data_from_serdes_s2  (data_from_serdes_s2  ),   
	.data_from_serdes_s3  (data_from_serdes_s3  ),   
	.data_from_serdes_s4  (data_from_serdes_s4  ),   
	.data_ch1_6_valid     (data_ch1_6_valid     ),      
	.power_rd_en2         (power_rd_en2         ),                              
	.power_dout_8ch       (power_dout_8ch       ),        
	.power_dout_8ch_valid (power_dout_8ch_valid ),  
	.power_fifo_data_count(power_fifo_data_count), 
	.power_fifo_full      (power_fifo_full      ),       
	.power_prog_full      (power_prog_full      ),
	.power_fifo_empty     (power_fifo_empty     )      
	);
	
*/	
	
	PCIe_FIFO_control
		PCIe_FIFO_control_i
	(
		.clk_100M           (clk_100M),          
		.rst_trans_fifo     (rst_trans_fifo),    
		.pc_dma_read_en     (pc_dma_read_en),    
		.pc_dma_read_en_ddr (),
		.trans_id           (trans_id),         
		.ddr3_rd_en(ddr3_rd_en), 		                   
//		.fifo_full          (fifo_full),         
//		.fifo_empty         (fifo_empty),        
//		.fifo_rd_s0         (fifo_rd_s0),        
//		.fifo_dout_8ch_valid(fifo_dout_8ch_valid),
//	  .fifo_dout_8ch      (fifo_dout_8ch),   	 	                    	                     
	  .tx_fifo_in_data    (tx_fifo_in_data),   
	  .tx_fifo_wr_en      (tx_fifo_wr_en),     
	  .pcie_wr_fifo_full  (pcie_wr_fifo_full),
	  .pcie_prog_full     (pcie_prog_full),
//	  .power_dout_8ch      (power_dout_8ch),      
//	  .power_dout_8ch_valid(power_dout_8ch_valid),
//	  .power_fifo_full     (power_fifo_full),     
//	  .power_fifo_empty    (power_fifo_empty),    
//	  .power_rd_en2        (power_rd_en2) ,
	  .ddr_fifo_valid (ddr3_fifo_valid),
	  .ddr_fifo_empty(ddr3_fifo_empty),
	  .ddr_fifo_dout_8ch(app_rd_data_to_pcie)    	  
	
	);

	//测频模块
/*	detect_freq_period
		detect_freq_period_i
		(
				.rst_n(detect_freq_rst_n),              
				.clk  (clk_10M),  
				.sel_ch(sel_ch),              
				.comp_level(comp_level),         
				.gate_vaule(gate_vaule),         
				.cnt_cycle (cnt_cycle),          				                    
				.data_from_serdes_s1(freq_data_choose ? data_from_card_s1 : data_from_serdes_s1),
				.data_from_serdes_s2(freq_data_choose ? data_from_card_s2 : data_from_serdes_s2),
				.data_from_serdes_s3(freq_data_choose ? data_from_card_s3 : data_from_serdes_s3),
				.data_from_serdes_s4(freq_data_choose ? data_from_serdes_s4 : data_from_serdes_s4),
				                    				                    
				.cnt_period0   (cnt_period0   ),			  
				.cnt_freq_fx0  (cnt_freq_fx0  ),			  
				.cnt_freq_fs0  (cnt_freq_fs0  ),			  				                    
				.per_full_flag0(per_full_flag0),		  
				.per_mea_flag0 (per_mea_flag0 ),		  
				.fre_mea_flag0 (fre_mea_flag0 ),		  
				                    
				.cnt_period1   (cnt_period1   ),		    
				.cnt_freq_fx1  (cnt_freq_fx1  ),			  
				.cnt_freq_fs1  (cnt_freq_fs1  ),			  				                    
				.per_full_flag1(per_full_flag1),		  
				.per_mea_flag1 (per_mea_flag1 ),		  
				.fre_mea_flag1 (fre_mea_flag1 ),		  
				                    
				.cnt_period2   (cnt_period2   ),		    
				.cnt_freq_fx2  (cnt_freq_fx2  ),			  
				.cnt_freq_fs2  (cnt_freq_fs2  ),			  			                    
				.per_full_flag2(per_full_flag2),		  
				.per_mea_flag2 (per_mea_flag2 ),		  
				.fre_mea_flag2 (fre_mea_flag2 ),
						  				                    
				.cnt_period3   (cnt_period3   ),		    
				.cnt_freq_fx3  (cnt_freq_fx3  ),			  
				.cnt_freq_fs3  (cnt_freq_fs3  ),			  				                    
				.per_full_flag3(per_full_flag3),		  
				.per_mea_flag3 (per_mea_flag3 ),		  
				.fre_mea_flag3 (fre_mea_flag3 )		  										
		
		);
*/
wire [127:0]app_rd_data_to_pcie;
wire ddr3_fifo_valid;
wire ddr3_fifo_empty;

wire ddr3_rd_en;
wire ddr_buffer_full;
wire [7:0] buff_full_thresh;

wire ddr_c0_wr;
wire ddr_c1_wr;
wire rd_done;
wire [28:0]rd_init_length;
wire [29:0] addr_rd_init;
wire rd_c0;
wire rd_c1;

  /*DDR3接口控制模块*/
  DDR3_Interface   DDR3_Interface_inst
	  (
		.c0_ddr3_dq     (c0_ddr3_dq     )  ,      
		.c0_ddr3_dqs_n  (c0_ddr3_dqs_n  )  ,   
		.c0_ddr3_dqs_p  (c0_ddr3_dqs_p  )  ,   		                		                 
		.c0_ddr3_addr   (c0_ddr3_addr   )  ,    
		.c0_ddr3_ba     (c0_ddr3_ba     )  ,      
		.c0_ddr3_ras_n  (c0_ddr3_ras_n  )  ,   
		.c0_ddr3_cas_n  (c0_ddr3_cas_n  )  ,   
		.c0_ddr3_we_n   (c0_ddr3_we_n   )  ,    
		.c0_ddr3_reset_n(c0_ddr3_reset_n)  , 
		.c0_ddr3_ck_p   (c0_ddr3_ck_p   ) ,    
		.c0_ddr3_ck_n   (c0_ddr3_ck_n   )  ,    
		.c0_ddr3_cke    (c0_ddr3_cke    )  ,     		                 
		.c0_ddr3_cs_n   (c0_ddr3_cs_n   )   ,    		                 
		.c0_ddr3_dm     (c0_ddr3_dm     ) ,      		                 
		.c0_ddr3_odt    (c0_ddr3_odt    ) ,     
		
		.c1_ddr3_dq     (c1_ddr3_dq     ),      
		.c1_ddr3_dqs_n  (c1_ddr3_dqs_n  )   ,   
		.c1_ddr3_dqs_p  (c1_ddr3_dqs_p  )   ,   		                 		                 
		.c1_ddr3_addr   (c1_ddr3_addr   )  ,    
		.c1_ddr3_ba     (c1_ddr3_ba     ) ,      
		.c1_ddr3_ras_n  (c1_ddr3_ras_n  ),   
		.c1_ddr3_cas_n  (c1_ddr3_cas_n  ),   
		.c1_ddr3_we_n   (c1_ddr3_we_n   ) ,    
		.c1_ddr3_reset_n(c1_ddr3_reset_n), 
		.c1_ddr3_ck_p   (c1_ddr3_ck_p   ),    
		.c1_ddr3_ck_n   (c1_ddr3_ck_n   ),    
		.c1_ddr3_cke    (c1_ddr3_cke    ),     		                 
		.c1_ddr3_cs_n   (c1_ddr3_cs_n   ),    		                 
		.c1_ddr3_dm     (c1_ddr3_dm     ),      		                 
		.c1_ddr3_odt    (c1_ddr3_odt    ), 
		
		.ddr3_rd_en	(ddr3_rd_en),
		/*
		.c2_ddr3_dq   	(c2_ddr3_dq   	),     
		.c2_ddr3_dqs_n	(c2_ddr3_dqs_n	),  
		.c2_ddr3_dqs_p	(c2_ddr3_dqs_p	),  		               		                
		.c2_ddr3_addr		(c2_ddr3_addr		),   
		.c2_ddr3_ba			(c2_ddr3_ba			),     
		.c2_ddr3_ras_n	(c2_ddr3_ras_n	)	,  
		.c2_ddr3_cas_n	(c2_ddr3_cas_n	)	,  
		.c2_ddr3_we_n		(c2_ddr3_we_n		)	,		   
		.c2_ddr3_reset_n(c2_ddr3_reset_n)	,
		.c2_ddr3_ck_p		(c2_ddr3_ck_p		)	,   
		.c2_ddr3_ck_n		(c2_ddr3_ck_n		)	,   
		.c2_ddr3_cke		(c2_ddr3_cke		) ,			    		                
		.c2_ddr3_cs_n	  (c2_ddr3_cs_n	  ) ,   		                
		.c2_ddr3_dm     (c2_ddr3_dm     ),     		                    
	  .c2_ddr3_odt    (c2_ddr3_odt    ) , 
	  	  */
	  .sys_rst_n       (SW0) , 
	  .ddr3_sys_clk_i  (clk_200M), 
    .clk_100M        (clk_100M),
    .clk_50M         (clk_50M),   
    .test_depth      (ddr3_depth),
    .ddr3_start_pingpang  (ddr3_start_pingpang),
    	.ddr_c0_wr	(ddr_c0_wr),
	.ddr_c1_wr	(ddr_c1_wr),
	.rd_done		(rd_done),  
	.rd_init_length(rd_init_length[28:0]),
	.addr_rd_init(addr_rd_init[29:0]),
	.rd_c0(rd_c0),
	.rd_c1(rd_c1),
    .ddr3_fifo_valid(ddr3_fifo_valid),
    .ddr3_fifo_empty(ddr3_fifo_empty),
    .app_rd_data_to_pcie(app_rd_data_to_pcie),
    .ddr_buffer_full(ddr_buffer_full),
    .buff_full_thresh(buff_full_thresh[7:0]),
    .pcie_prog_full(pcie_prog_full)      
	     
	);
wire  [4:0] test_depth;	
	
	
	ILA_PCIE_TOP 
		ILA_PCIE_TOP_100M_clk (
	.clk(clk_100M), // input wire clk


	.probe0({
			//		data_from_serdes_s1[15:0],					
	       // fifo_dout_8ch[127:112],
	       // tx_fifo_in_data[127:112],
	       tx_fifo_in_data[127:0],
	        //time_gap_num[31:0],
	       // predepth[15:0],
	       // posdepth[15:0],
	        power_mode_predepth[15:0]
	         
	
	}), // input wire [127:0]  probe0  
	.probe1({
					pcie_wr_fifo_full,                                                       
//					prog_full_thresh[12:0],           
//					fifo_rd_s0,              
//					adc_Rxdat_valid,        
					fifo_full ,              
					fifo_empty,              
					prog_full,              
					fifo_dout_8ch_valid,    
          			tx_fifo_wr_en,
					rst_trans_fifo,
					pc_dma_read_en,      					 
//					data_flow_mode,      
//					acq_mode[2:0],      
//					fifo_rclk_sel,       
//					pcFifo_reset_L,      
//					UI_fifo_reset_L,     
					Program_Full,        
					fifo_wr_enable,      
//					auto_rclk_en,        
//					fifo_wen_tri, 												       
					trans_id[4:0], 
//					Edge_ch_valid[7:0],
					pcie_wr_data_count[9:0],
//					trig_out,      					               
//					UI_fifo_write, 
//					UI_fifo_read,
//					ready,           
//					close_fifo_en_reg,
//					time_over,
//					pre_trig_real_over,
//					pos_tri_s,
//					trigged_reg,
//					per_full_flag0,
//					per_mea_flag0,
//					fre_mea_flag0,
					pcie_prog_full
				//	Edge_mode[1:0],
//					power_fifo_full, 
//					power_prog_full, 
//					power_fifo_empty,
//					power_mode_rst_n,
//					power_mode_begin ,
//					data_ch1_6_valid,
//					power_rd_en2    , 
//					power_dout_8ch[127:112],      
//					power_dout_8ch_valid       
					 
							   				  
	}) // input wire [127:0]  probe1
);

//////*串口模拟上位机***///

/*UART_Interface UART_Interface (
    .clk_100M        (clk_100M),
    .clk_50M         (clk_50M),  
    .rst_n           (1'b1), 
    .uart_rx         (uart_rx),                                      
//    .DataOut_Addr000(    ), //测试地址        
//    .DataOut_Addr001(    ), //测试地址        
//    .DataOut_Addr002(    ), //PC读数据专用端口
//    .DataOut_Addr003(    ), //测试地址        
//    .DataOut_Addr004(    ), //测试地址        
//    .DataOut_Addr005(    ), //测试地址        
//    .DataOut_Addr006(    ), //测试地址        
//    .DataOut_Addr007(    ), //测试地址        
//    .DataOut_Addr008(    ), //测试地址        
//    .DataOut_Addr009(    ), //测试地址        
//    .DataOut_Addr00A(    ), //测试地址        
//    .DataOut_Addr00B(    ), //测试地址        
//    .DataOut_Addr00C(    ), //测试地址        
//    .DataOut_Addr00D(    ), //测试地址        
//    .DataOut_Addr00E(    ), //测试地址        
//    .DataOut_Addr00F(    ), //测试地址  
      
      .DataOut_Addr010(        ),  
      .DataOut_Addr011(        ),  //正序反序和测试数据的选择
      .DataOut_Addr012(        ), 
      .DataOut_Addr013(  test_depth  ), 
      .DataOut_Addr014( {LED1,LED0} ), //DAC的片选控制 00:cs1_ch1;通道1的DAC1   01:cs2_ch1;通道1的DAC2   10:cs1_ch2;通道2的DAC1  11:cs2_ch2; 通道2的DAC2
      .DataOut_Addr015(        ), //DAC配置数据
      .DataOut_Addr016(        )
      );
*/

	
/**pcTx地址分配：贾树林128个（0x00~0x80）刘威256个（0x81~0x180）何小双128个（0x181~0x200）陈树轩128个（0x201~0x280）板卡、公共部分460个（0x281~0x44c）********/
/**pcRx地址分配：贾树林96个（0x00~0x60） 刘威160个（0x61~0x100）何小双48个（0x101~0x130）陈树轩48个（0x131~0x160）板卡、公共部分160个（0x161~0x1FF）********/	
	
	/**PCIE接口控制，物理层、用户层，PIO接口，DMA接口**/
	xilinx_pcie_x1_top
		xilinx_pcie_x1_top_i
		(
		  .pci_exp_txp (pci_exp_txp	  ), 
			.pci_exp_txn (pci_exp_txn   ),
			.pci_exp_rxp (pci_exp_rxp   ),
			.pci_exp_rxn (pci_exp_rxn   ),
			.led_0       (pcie_led_0    ),
			.led_1       (pcie_led_1    ),
			.led_2       (pcie_led_2    ),
			.led_3       (pcie_led_3    ),
			//.emcclk      (emcclk        ),
			//.system_clk_n(pcie_system_clk_n  ),
			//.system_clk_p(pcie_system_clk_p  ),
			.sys_clk_p   (pcie_sys_clk_p),
			.sys_clk_n   (pcie_sys_clk_n),
			.sys_rst_n	 (pcie_sys_rst_n),
	  //  .uart_rx     (uart_rx),
			.clk_100M(clk_100M),
			.tx_fifo_in_data(tx_fifo_in_data),  
			.tx_fifo_wr_en(tx_fifo_wr_en),    
			.pcie_wr_fifo_full(pcie_wr_fifo_full),	
			.tx_fifo_rst_n(rst_trans_fifo)	,
			.pcie_wr_data_count(pcie_wr_data_count),
			.pcie_prog_full(pcie_prog_full),
			
			.clk_10M(clk_10M),    //测试时钟
			.mode_choose(BANK13_GPIO[25] ),     //mode_choose为低时，interface参数来源于PC；mode_choose为高时，interface参数来源于串口，高接2.5V

     //PC——>FPGA		
/*0050*/    .pcTx_data_014(  ),     //used 回环测试端口             
/*0054*/    .pcTx_data_015(  ),     //used 固定值测试端口 0x12345678
/*0058*/    .pcTx_data_016(  ),     //used  fifo_tx_wr_begin
/*005C*/    .pcTx_data_017( rst_trans_fifo ),     //used  tx_fifo_rst_n    PCIe FIFO复位，DMA发送复位
/*0060*/    .pcTx_data_018( pc_dma_read_en ),    //DMA读使能    
/*0064*/    .pcTx_data_019( time_gap_num   ),   
/*0068*/    .pcTx_data_01A( data_flow_mode ),        
/*006C*/    .pcTx_data_01B( acq_mode       ),          //采集模式控制(  ),000:正常，001：峰值，010：平均
/*0070*/    .pcTx_data_01C( fifo_rclk_sel  ),     //FIFO读信号选择，1：PC读，0：FPGA读     
/*0074*/    .pcTx_data_01D( pcFifo_reset_L ),    //采集复位信号，active low                 
/*0078*/    .pcTx_data_01E( fifo_wr_enable ),    //FIFO 写信号，active high          
/*007C*/    .pcTx_data_01F( tri_holdoff    ),          
/*0080*/    .pcTx_data_020( predepth[31:0]   ),             
/*0084*/    .pcTx_data_021( posdepth[31:0]  ),          
/*0088*/    .pcTx_data_022( posdepth[36:32] ),          
/*008C*/    .pcTx_data_023( num_program     ),          
/*0090*/    .pcTx_data_024( prog_full_thresh ),          
/*0094*/    .pcTx_data_025( trans_id        ),          
/*0098*/    .pcTx_data_026( trig_level_ch0 ),        //触发电平       
/*009C*/    .pcTx_data_027( trig_level_ch1 ),          
/*00A0*/    .pcTx_data_028( trig_level_ch2 ),          
/*00A4*/    .pcTx_data_029( trig_level_ch3 ),          
/*00A8*/    .pcTx_data_02A( trig_level_ch4 ),          
/*00AC*/    .pcTx_data_02B( trig_level_ch5 ),          
/*00B0*/    .pcTx_data_02C( trig_level_ch6 ),          
/*00B4*/    .pcTx_data_02D( trig_level_ch7 ),          
/*00B8*/    .pcTx_data_02E( trig_mode      ),          
/*00BC*/    .pcTx_data_02F( trig_rst_n     ),          
/*00C0*/    .pcTx_data_030( Edge_mode      ),               
/*00C4*/    .pcTx_data_031( tri_auto       ),          
/*00C8*/    .pcTx_data_032( Edge_ch_valid[7:0]),               
/*00CC*/    .pcTx_data_033(    ),          
/*00D0*/    .pcTx_data_034(    ),          
/*00D4*/    .pcTx_data_035( power_mode_rst_n         ),            //功率模式参数    
/*00D8*/    .pcTx_data_036( power_mode_predepth[31:0]),          
/*00DC*/    .pcTx_data_037( power_mode_begin         ),          
/*00E0*/    .pcTx_data_038(   ),          
/*00E4*/    .pcTx_data_039(   ),          
/*00E8*/    .pcTx_data_03A(  buff_full_thresh[7:0] ),          
/*00EC*/    .pcTx_data_03B( rd_init_length[28:0]  ),          
/*00F0*/    .pcTx_data_03C( addr_rd_init[29:0]  ),          
/*00F4*/    .pcTx_data_03D( rd_c0 ),          
/*00F8*/    .pcTx_data_03E( rd_c1 ),          
/*00FC*/    .pcTx_data_03F(  ),          
/*0100*/    .pcTx_data_040( detect_freq_rst_n ),   //测频复位信号              //测频参数       
/*0104*/    .pcTx_data_041( comp_level[31:0]   ),  //比较电平        
/*0108*/    .pcTx_data_042( comp_level[63:32]  ),          
/*010C*/    .pcTx_data_043( comp_level[95:64]  ),          
/*0110*/    .pcTx_data_044( comp_level[127:96] ),          
/*0114*/    .pcTx_data_045( gate_vaule[31:0] ),    //闸门时间       
/*0118*/    .pcTx_data_046( cnt_cycle[31:0]  ),    //计数周期     
/*011C*/    .pcTx_data_047( sel_ch[31:0] ),          
/*0120*/    .pcTx_data_048( oserdes_data_sel ),       //仿真、板卡数据选择         
/*0124*/    .pcTx_data_049( freq_data_choose ),        //测频数据源选择      
/*0128*/    .pcTx_data_04A(  ),          
/*012C*/    .pcTx_data_04B(  ),          
/*0130*/    .pcTx_data_04C(  ),          
/*0134*/    .pcTx_data_04D(  ),          
/*0138*/    .pcTx_data_04E(  ),          
/*013C*/    .pcTx_data_04F(  ),          
/*0140*/    .pcTx_data_050(  ),          
/*0144*/    .pcTx_data_051(  ),          
/*0148*/    .pcTx_data_052(  ),          
/*014C*/    .pcTx_data_053(  ),          
/*0150*/    .pcTx_data_054(  ),          
/*0154*/    .pcTx_data_055(  ),          
/*0158*/    .pcTx_data_056(  ),          
/*015C*/    .pcTx_data_057(  ),          
/*0160*/    .pcTx_data_058(  ),          
/*0164*/    .pcTx_data_059(  ),          
/*0168*/    .pcTx_data_05A(  ),          
/*016C*/    .pcTx_data_05B(  ),          
/*0170*/    .pcTx_data_05C(  ),          
/*0174*/    .pcTx_data_05D(  ),          
/*0178*/    .pcTx_data_05E(  ),                                                                    
/*017C*/    .pcTx_data_05F(  ),                                                                             
/*0180*/    .pcTx_data_060(  ),                                                                                     
/*0184*/    .pcTx_data_061(  ),                                      
/*0188*/    .pcTx_data_062(  ),                                           
/*018C*/    .pcTx_data_063(  ),                                                        
/*0190*/    .pcTx_data_064(  ),                                                            
/*0194*/    .pcTx_data_065(  ),                                                                   
/*0198*/    .pcTx_data_066(  ),                                                            
/*019C*/    .pcTx_data_067(  ),                                                            
/*01A0*/    .pcTx_data_068(  ), 
/*01A4*/    .pcTx_data_069( 	),
/*01A8*/    .pcTx_data_06A( 	), 
/*01AC*/    .pcTx_data_06B(  ),       
/*01B0*/    .pcTx_data_06C(  ),       
/*01B4*/    .pcTx_data_06D( 	),   
/*01B8*/    .pcTx_data_06E( 	),                                                      
/*01BC*/    .pcTx_data_06F(  ),                                                          
/*01C0*/    .pcTx_data_070( 	),
/*01C4*/    .pcTx_data_071(  ), 
/*01C8*/    .pcTx_data_072( 	),                                          
/*01CC*/    .pcTx_data_073(  ),                                                                
/*01D0*/    .pcTx_data_074(  ),                                        
/*01D4*/    .pcTx_data_075(  ),                                
/*01D8*/    .pcTx_data_076(  ),                                                                 
/*01DC*/    .pcTx_data_077(  ),                              
/*01E0*/    .pcTx_data_078(  ),       
/*01E4*/    .pcTx_data_079(  ),                                 
/*01E8*/    .pcTx_data_07A(  ),                                                                   
/*01EC*/    .pcTx_data_07B(  ),                        
/*01F0*/    .pcTx_data_07C(  ),                                      
/*01F4*/    .pcTx_data_07D(  ),										                                          
/*01F8*/    .pcTx_data_07E(  ),                                                    
/*01FC*/    .pcTx_data_07F(  ),      
/*0200*/    .pcTx_data_080(  ),      
/*0204*/    .pcTx_data_081(  ),            
/*0208*/    .pcTx_data_082(  ),            
/*020C*/    .pcTx_data_083(  ),                                                     
/*0210*/    .pcTx_data_084(  ),                                                     
/*0214*/    .pcTx_data_085(  ),                                                     
/*0218*/    .pcTx_data_086(  ),                                                     
/*021C*/    .pcTx_data_087(  ),                                                     
/*0220*/    .pcTx_data_088(  ),                                                    
/*0224*/    .pcTx_data_089(  ),                                                     
/*0228*/    .pcTx_data_08A(  ),                                             
/*022C*/    .pcTx_data_08B(  ),                                                     
/*0230*/    .pcTx_data_08C(  ),                                                     
/*0234*/    .pcTx_data_08D(  ),                                                              
/*0238*/    .pcTx_data_08E(  ),                                                                  
/*023C*/    .pcTx_data_08F(  ),                                                   
/*0240*/    .pcTx_data_090(  ), 
/*0244*/    .pcTx_data_091(  ), 
/*0248*/    .pcTx_data_092(  ), 
/*024C*/    .pcTx_data_093(  ), 
/*0250*/    .pcTx_data_094(  ),
/*0254*/    .pcTx_data_095(  ), 
/*0258*/    .pcTx_data_096(  ),
/*025C*/    .pcTx_data_097(  ),
/*0260*/    .pcTx_data_098(  ),
/*0264*/    .pcTx_data_099(  ), 
/*0268*/    .pcTx_data_09A(  ), 
/*026C*/    .pcTx_data_09B(  ), 
/*0270*/    .pcTx_data_09C(  ), 
/*0274*/    .pcTx_data_09D(  ),                          
/*0278*/    .pcTx_data_09E(  ),
/*027C*/    .pcTx_data_09F(  ),       
/*0280*/    .pcTx_data_0A0(  ),                        
/*0284*/    .pcTx_data_0A1(  ),     
/*0288*/    .pcTx_data_0A2(  ),
/*028C*/    .pcTx_data_0A3(  ),
/*0290*/    .pcTx_data_0A4(  ),
/*0294*/    .pcTx_data_0A5(  ),
/*0298*/    .pcTx_data_0A6(  ),
/*029C*/    .pcTx_data_0A7(  ),
/*02A0*/    .pcTx_data_0A8(  ),
/*02A4*/    .pcTx_data_0A9(  ),
/*02A8*/    .pcTx_data_0AA(  ),
/*02AC*/    .pcTx_data_0AB(  ),
/*02B0*/    .pcTx_data_0AC(  ),
/*02B4*/    .pcTx_data_0AD(  ),
/*02B8*/    .pcTx_data_0AE(   ),
/*02BC*/    .pcTx_data_0AF(  ),
/*02C0*/    .pcTx_data_0B0(  ),
/*02C4*/    .pcTx_data_0B1(  ),
/*02C8*/    .pcTx_data_0B2(  ),
/*02CC*/    .pcTx_data_0B3(  ),
/*02D0*/    .pcTx_data_0B4(  ),
/*02D4*/    .pcTx_data_0B5(  ),
/*02D8*/    .pcTx_data_0B6(  ),
/*02DC*/    .pcTx_data_0B7(  ),
/*02E0*/    .pcTx_data_0B8(  ),
/*02E4*/    .pcTx_data_0B9(  ),
/*02E8*/    .pcTx_data_0BA(  ),
/*02EC*/    .pcTx_data_0BB(  ),
/*02F0*/    .pcTx_data_0BC(  ),
/*02F4*/    .pcTx_data_0BD(  ),
/*02F8*/    .pcTx_data_0BE(  ),
/*02FC*/    .pcTx_data_0BF(  ),
/*0300*/    .pcTx_data_0C0(  ),
/*0304*/    .pcTx_data_0C1(  ),
/*0308*/    .pcTx_data_0C2(  ),
/*030C*/    .pcTx_data_0C3(  ),
/*0310*/    .pcTx_data_0C4(  ),
/*0314*/    .pcTx_data_0C5(  ),
/*0318*/    .pcTx_data_0C6(  ),
/*031C*/    .pcTx_data_0C7(  ),
/*0320*/    .pcTx_data_0C8(  ),
/*0324*/    .pcTx_data_0C9(  ),
/*0328*/    .pcTx_data_0CA(  ),
/*032C*/    .pcTx_data_0CB(  ),
/*0330*/    .pcTx_data_0CC(  ),
/*0334*/    .pcTx_data_0CD(  ),
/*0338*/    .pcTx_data_0CE(  ),
/*033C*/    .pcTx_data_0CF(  ),
/*0340*/    .pcTx_data_0D0(  ),
/*0344*/    .pcTx_data_0D1(  ),
/*0348*/    .pcTx_data_0D2(  ),
/*034C*/    .pcTx_data_0D3(  ),
/*0350*/    .pcTx_data_0D4(  ),
/*0354*/    .pcTx_data_0D5(  ),
/*0358*/    .pcTx_data_0D6(  ),
/*035C*/    .pcTx_data_0D7(  ),
/*0360*/    .pcTx_data_0D8(  ),
/*0364*/    .pcTx_data_0D9(  ),
/*0368*/    .pcTx_data_0DA(  ),
/*036C*/    .pcTx_data_0DB(  ),
/*0370*/    .pcTx_data_0DC(  ),
/*0374*/    .pcTx_data_0DD(  ),
/*0378*/    .pcTx_data_0DE(  ),
/*037C*/    .pcTx_data_0DF(  ),
/*0380*/    .pcTx_data_0E0(  ),
/*0384*/    .pcTx_data_0E1(  ),
/*0388*/    .pcTx_data_0E2(  ),
/*038C*/    .pcTx_data_0E3(  ),
/*0390*/    .pcTx_data_0E4(  ),
/*0394*/    .pcTx_data_0E5(  ),
/*0398*/    .pcTx_data_0E6(  ),
/*039C*/    .pcTx_data_0E7(  ),
/*03A0*/    .pcTx_data_0E8(  ),
/*03A4*/    .pcTx_data_0E9(  ),
/*03A8*/    .pcTx_data_0EA(  ),
/*03AC*/    .pcTx_data_0EB(  ),
/*03B0*/    .pcTx_data_0EC(  ),
/*03B4*/    .pcTx_data_0ED(  ),
/*03B8*/    .pcTx_data_0EE(  ),
/*03BC*/    .pcTx_data_0EF(  ),
/*03C0*/    .pcTx_data_0F0(  ),
/*03C4*/    .pcTx_data_0F1(  ),
/*03C8*/    .pcTx_data_0F2(  ),
/*03CC*/    .pcTx_data_0F3(  ),
/*03D0*/    .pcTx_data_0F4(  ),
/*03D4*/    .pcTx_data_0F5(  ),
/*03D8*/    .pcTx_data_0F6(  ),
/*03DC*/    .pcTx_data_0F7(  ),
/*03E0*/    .pcTx_data_0F8(  ),
/*03E4*/    .pcTx_data_0F9(  ),
/*03E8*/    .pcTx_data_0FA(  ),
/*03EC*/    .pcTx_data_0FB(  ),
/*03F0*/    .pcTx_data_0FC(  ),
/*03F4*/    .pcTx_data_0FD(  ),
/*03F8*/    .pcTx_data_0FE(  ),
/*03FC*/    .pcTx_data_0FF(  ),
/*0400*/    .pcTx_data_100(  ),
/*0404*/    .pcTx_data_101(  ),
/*0408*/    .pcTx_data_102(  ),
/*040C*/    .pcTx_data_103(  ),
/*0410*/    .pcTx_data_104(  ),
/*0414*/    .pcTx_data_105(  ),
/*0418*/    .pcTx_data_106(  ),
/*041C*/    .pcTx_data_107(  ),
/*0420*/    .pcTx_data_108(  ),
/*0424*/    .pcTx_data_109(  ),
/*0428*/    .pcTx_data_10A(  ),
/*042C*/    .pcTx_data_10B(  ),
/*0430*/    .pcTx_data_10C(  ),
/*0434*/    .pcTx_data_10D(  ),
/*0438*/    .pcTx_data_10E(  ),
/*043C*/    .pcTx_data_10F(  ),
/*0440*/    .pcTx_data_110(  ),
/*0444*/    .pcTx_data_111(  ),
/*0448*/    .pcTx_data_112(  ),
/*044C*/    .pcTx_data_113(  ),
/*0450*/    .pcTx_data_114(  ),
/*0454*/    .pcTx_data_115(  ),
/*0458*/    .pcTx_data_116(  ),
/*045C*/    .pcTx_data_117(  ),
/*0460*/    .pcTx_data_118(  ),
/*0464*/    .pcTx_data_119(  ),
/*0468*/    .pcTx_data_11A(  ),
/*046C*/    .pcTx_data_11B(  ),
/*0470*/    .pcTx_data_11C(  ),
/*0474*/    .pcTx_data_11D(  ),
/*0478*/    .pcTx_data_11E(  ),
/*047C*/    .pcTx_data_11F(  ),
/*0480*/    .pcTx_data_120(  ),
/*0484*/    .pcTx_data_121(  ),
/*0488*/    .pcTx_data_122(  ),
/*048C*/    .pcTx_data_123(  ),
/*0490*/    .pcTx_data_124(  ),
/*0494*/    .pcTx_data_125(  ),
/*0498*/    .pcTx_data_126(  ),
/*049C*/    .pcTx_data_127(  ),
/*04A0*/    .pcTx_data_128(  ),
/*04A4*/    .pcTx_data_129(  ),
/*04A8*/    .pcTx_data_12A(  ),
/*04AC*/    .pcTx_data_12B(  ),
/*04B0*/    .pcTx_data_12C(  ),
/*04B4*/    .pcTx_data_12D(  ),
/*04B8*/    .pcTx_data_12E(  ),
/*04BC*/    .pcTx_data_12F(  ),
/*04C0*/    .pcTx_data_130(  ),
/*04C4*/    .pcTx_data_131(  ),
/*04C8*/    .pcTx_data_132(  ),
/*04CC*/    .pcTx_data_133(  ),
/*04D0*/    .pcTx_data_134(  ),
/*04D4*/    .pcTx_data_135(  ),
/*04D8*/    .pcTx_data_136(  ),
/*04DC*/    .pcTx_data_137(  ),
/*04E0*/    .pcTx_data_138(  ),
/*04E4*/    .pcTx_data_139(  ),
/*04E8*/    .pcTx_data_13A(  ),
/*04EC*/    .pcTx_data_13B(  ),
/*04F0*/    .pcTx_data_13C(  ),
/*04F4*/    .pcTx_data_13D(  ),
/*04F8*/    .pcTx_data_13E(  ),
/*04FC*/    .pcTx_data_13F(  ),
/*0500*/    .pcTx_data_140(  ),
/*0504*/    .pcTx_data_141(  ),
/*0508*/    .pcTx_data_142(  ),
/*050C*/    .pcTx_data_143(  ),
/*0510*/    .pcTx_data_144(  ),
/*0514*/    .pcTx_data_145(  ),
/*0518*/    .pcTx_data_146(  ),
/*051C*/    .pcTx_data_147(  ),
/*0520*/    .pcTx_data_148(  ),
/*0524*/    .pcTx_data_149(  ),
/*0528*/    .pcTx_data_14A(  ),
/*052C*/    .pcTx_data_14B(  ),
/*0530*/    .pcTx_data_14C(  ),
/*0534*/    .pcTx_data_14D(  ),
/*0538*/    .pcTx_data_14E(  ),
/*053C*/    .pcTx_data_14F(  ),
/*0540*/    .pcTx_data_150(  ),
/*0544*/    .pcTx_data_151(  ),
/*0548*/    .pcTx_data_152(  ),
/*054C*/    .pcTx_data_153(  ),
/*0550*/    .pcTx_data_154(  ),
/*0554*/    .pcTx_data_155(  ),
/*0558*/    .pcTx_data_156(  ),
/*055C*/    .pcTx_data_157(  ),
/*0560*/    .pcTx_data_158(  ),
/*0564*/    .pcTx_data_159(  ),
/*0568*/    .pcTx_data_15A(  ),
/*056C*/    .pcTx_data_15B(  ),
/*0570*/    .pcTx_data_15C(  ),
/*0574*/    .pcTx_data_15D(  ),
/*0578*/    .pcTx_data_15E(  ),
/*057C*/    .pcTx_data_15F(  ),
/*0580*/    .pcTx_data_160(  ),
/*0584*/    .pcTx_data_161(  ),
/*0588*/    .pcTx_data_162(  ),
/*058C*/    .pcTx_data_163(  ),
/*0590*/    .pcTx_data_164(  ),
/*0594*/    .pcTx_data_165(  ),
/*0598*/    .pcTx_data_166(  ),
/*059C*/    .pcTx_data_167(  ),
/*05A0*/    .pcTx_data_168(  ),
/*05A4*/    .pcTx_data_169(  ),
/*05A8*/    .pcTx_data_16A(  ),
/*05AC*/    .pcTx_data_16B(  ),
/*05B0*/    .pcTx_data_16C(  ),
/*05B4*/    .pcTx_data_16D(  ),
/*05B8*/    .pcTx_data_16E(  ),
/*05BC*/    .pcTx_data_16F(  ),
/*05C0*/    .pcTx_data_170(  ),
/*05C4*/    .pcTx_data_171(  ),
/*05C8*/    .pcTx_data_172(  ),
/*05CC*/    .pcTx_data_173(  ),
/*05D0*/    .pcTx_data_174(  ),
/*05D4*/    .pcTx_data_175(  ),
/*05D8*/    .pcTx_data_176(  ),
/*05DC*/    .pcTx_data_177(  ),
/*05E0*/    .pcTx_data_178(  ),
/*05E4*/    .pcTx_data_179(  ),
/*05E8*/    .pcTx_data_17A(  ),
/*05EC*/    .pcTx_data_17B(  ),
/*05F0*/    .pcTx_data_17C(  ),
/*05F4*/    .pcTx_data_17D(  ),
/*05F8*/    .pcTx_data_17E(  ),
/*05FC*/    .pcTx_data_17F(  ),
/*0600*/    .pcTx_data_180(  ),
/*0604*/    .pcTx_data_181( ddr3_sys_rst       ),       //DDR3的两片复位信号
/*0608*/    .pcTx_data_182( ddr3_depth         ),       //DDR3的单片容量控制
/*060C*/    .pcTx_data_183( ddr3_start_pingpang ),       //乒乓操作的开始信号
/*0610*/    .pcTx_data_184(  {LED3,LED2}       ),       //用于测试上位机发送的数据是否到位
/*0614*/    .pcTx_data_185(  ),
/*0618*/    .pcTx_data_186(  ),
/*061C*/    .pcTx_data_187(  ),
/*0620*/    .pcTx_data_188(  ),
/*0624*/    .pcTx_data_189(  ),
/*0628*/    .pcTx_data_18A(  ),
/*062C*/    .pcTx_data_18B(  ),
/*0630*/    .pcTx_data_18C(  ),
/*0634*/    .pcTx_data_18D(  ),
/*0638*/    .pcTx_data_18E(  ),
/*063C*/    .pcTx_data_18F(  ),
/*0640*/    .pcTx_data_190(  ),
/*0644*/    .pcTx_data_191(  ),
/*0648*/    .pcTx_data_192(  ),
/*064C*/    .pcTx_data_193(  ),
/*0650*/    .pcTx_data_194(  ),
/*0654*/    .pcTx_data_195(  ),
/*0658*/    .pcTx_data_196(  ),
/*065C*/    .pcTx_data_197(  ),
/*0660*/    .pcTx_data_198(  ),
/*0664*/    .pcTx_data_199(  ),
/*0668*/    .pcTx_data_19A(  ),
/*066C*/    .pcTx_data_19B(  ),
/*0670*/    .pcTx_data_19C(  ),
/*0674*/    .pcTx_data_19D(  ),
/*0678*/    .pcTx_data_19E(  ),
/*067C*/    .pcTx_data_19F(  ),
/*0680*/    .pcTx_data_1A0(  ),
/*0684*/    .pcTx_data_1A1(  ),
/*0688*/    .pcTx_data_1A2(  ),
/*068C*/    .pcTx_data_1A3(  ),
/*0690*/    .pcTx_data_1A4(  ),
/*0694*/    .pcTx_data_1A5(  ),
/*0698*/    .pcTx_data_1A6(  ),
/*069C*/    .pcTx_data_1A7(  ),
/*06A0*/    .pcTx_data_1A8(  ),
/*06A4*/    .pcTx_data_1A9(  ),
/*06A8*/    .pcTx_data_1AA(  ),         //回环测试
/*06AC*/    .pcTx_data_1AB(  ),
/*06B0*/    .pcTx_data_1AC(  ),
/*06B4*/    .pcTx_data_1AD(  ),
/*06B8*/    .pcTx_data_1AE(  ),
/*06BC*/    .pcTx_data_1AF(  ),
/*06C0*/    .pcTx_data_1B0(  ),
/*06C4*/    .pcTx_data_1B1(  ),
/*06C8*/    .pcTx_data_1B2(  ),
/*06CC*/    .pcTx_data_1B3(  ),
/*06D0*/    .pcTx_data_1B4(  ),
/*06D4*/    .pcTx_data_1B5(  ),
/*06D8*/    .pcTx_data_1B6(  ),
/*06DC*/    .pcTx_data_1B7(  ),
/*06E0*/    .pcTx_data_1B8(  ),
/*06E4*/    .pcTx_data_1B9(  ),
/*06E8*/    .pcTx_data_1BA(  ),
/*06EC*/    .pcTx_data_1BB(  ),
/*06F0*/    .pcTx_data_1BC(  ),
/*06F4*/    .pcTx_data_1BD(  ),
/*06F8*/    .pcTx_data_1BE(  ),
/*06FC*/    .pcTx_data_1BF(  ),
/*0700*/    .pcTx_data_1C0(  ),
/*0704*/    .pcTx_data_1C1(  ),
/*0708*/    .pcTx_data_1C2(  ),
/*070C*/    .pcTx_data_1C3(  ),
/*0710*/    .pcTx_data_1C4(  ),
/*0714*/    .pcTx_data_1C5(  ),
/*0718*/    .pcTx_data_1C6(  ),
/*071C*/    .pcTx_data_1C7(  ),
/*0720*/    .pcTx_data_1C8(  ),
/*0724*/    .pcTx_data_1C9(  ),
/*0728*/    .pcTx_data_1CA(  ),
/*072C*/    .pcTx_data_1CB(  ),
/*0730*/    .pcTx_data_1CC(  ),
/*0734*/    .pcTx_data_1CD(  ),
/*0738*/    .pcTx_data_1CE(  ),
/*073C*/    .pcTx_data_1CF(  ),
/*0740*/    .pcTx_data_1D0(  ),
/*0744*/    .pcTx_data_1D1(  ),
/*0748*/    .pcTx_data_1D2(  ),
/*074C*/    .pcTx_data_1D3(  ),
/*0750*/    .pcTx_data_1D4(  ),
/*0754*/    .pcTx_data_1D5(  ),
/*0758*/    .pcTx_data_1D6(  ),
/*075C*/    .pcTx_data_1D7(  ),
/*0760*/    .pcTx_data_1D8(  ),
/*0764*/    .pcTx_data_1D9(  ),
/*0768*/    .pcTx_data_1DA(  ),
/*076C*/    .pcTx_data_1DB(  ),
/*0770*/    .pcTx_data_1DC(  ),
/*0774*/    .pcTx_data_1DD(  ),
/*0778*/    .pcTx_data_1DE(  ),
/*077C*/    .pcTx_data_1DF(  ),
/*0780*/    .pcTx_data_1E0(  ),
/*0784*/    .pcTx_data_1E1(  ),
/*0788*/    .pcTx_data_1E2(  ),
/*078C*/    .pcTx_data_1E3(  ),
/*0790*/    .pcTx_data_1E4(  ),
/*0794*/    .pcTx_data_1E5(  ),
/*0798*/    .pcTx_data_1E6(  ),
/*079C*/    .pcTx_data_1E7(  ),
/*07A0*/    .pcTx_data_1E8(  ),
/*07A4*/    .pcTx_data_1E9(  ),
/*07A8*/    .pcTx_data_1EA(  ),
/*07AC*/    .pcTx_data_1EB(  ),
/*07B0*/    .pcTx_data_1EC(  ),
/*07B4*/    .pcTx_data_1ED(  ),
/*07B8*/    .pcTx_data_1EE(  ),
/*07BC*/    .pcTx_data_1EF(  ),
/*07C0*/    .pcTx_data_1F0(  ),
/*07C4*/    .pcTx_data_1F1(  ),
/*07C8*/    .pcTx_data_1F2(  ),
/*07CC*/    .pcTx_data_1F3(  ),
/*07D0*/    .pcTx_data_1F4(  ),
/*07D4*/    .pcTx_data_1F5(  ),
/*07D8*/    .pcTx_data_1F6(  ),
/*07DC*/    .pcTx_data_1F7(  ),
/*07E0*/    .pcTx_data_1F8(  ),
/*07E4*/    .pcTx_data_1F9(  ),
/*07E8*/    .pcTx_data_1FA(  ),
/*07EC*/    .pcTx_data_1FB(  ),
/*07F0*/    .pcTx_data_1FC(  ),
/*07F4*/    .pcTx_data_1FD(  ),
/*07F8*/    .pcTx_data_1FE(  ),
/*07FC*/    .pcTx_data_1FF(  ),
/*0800*/    .pcTx_data_200(  ),
/*0804*/    .pcTx_data_201(  ),
/*0808*/    .pcTx_data_202(  ),
/*080C*/    .pcTx_data_203(  ),
/*0810*/    .pcTx_data_204(  ),
/*0814*/    .pcTx_data_205(  ),          
/*0818*/    .pcTx_data_206(  ),          
/*081C*/    .pcTx_data_207(  ),          
/*0820*/    .pcTx_data_208(  ),          
/*0824*/    .pcTx_data_209(  ),          
/*0828*/    .pcTx_data_20A(  ),          
/*082C*/    .pcTx_data_20B(  ),          
/*0830*/    .pcTx_data_20C(  ),          
/*0834*/    .pcTx_data_20D(  ),          
/*0838*/    .pcTx_data_20E(  ),          
/*083C*/    .pcTx_data_20F(  ),          
/*0840*/    .pcTx_data_210(  ),          
/*0844*/    .pcTx_data_211(  ),          
/*0848*/    .pcTx_data_212(  ),          
/*084C*/    .pcTx_data_213(  ),          
/*0850*/    .pcTx_data_214(  ),          
/*0854*/    .pcTx_data_215(  ),          
/*0858*/    .pcTx_data_216(  ),          
/*085C*/    .pcTx_data_217(  ),          
/*0860*/    .pcTx_data_218(  ),          
/*0864*/    .pcTx_data_219(  ),          
/*0868*/    .pcTx_data_21A(  ),          
/*086C*/    .pcTx_data_21B(  ),          
/*0870*/    .pcTx_data_21C(  ),          
/*0874*/    .pcTx_data_21D(  ),          
/*0878*/    .pcTx_data_21E(  ),          
/*087C*/    .pcTx_data_21F(  ),          
/*0880*/    .pcTx_data_220(  ),          
/*0884*/    .pcTx_data_221(  ),          
/*0888*/    .pcTx_data_222(  ),          
/*088C*/    .pcTx_data_223(  ),          
/*0890*/    .pcTx_data_224(  ),          
/*0894*/    .pcTx_data_225(  ),          
/*0898*/    .pcTx_data_226(  ),          
/*089C*/    .pcTx_data_227(  ),          
/*08A0*/    .pcTx_data_228(  ),          
/*08A4*/    .pcTx_data_229(  ),          
/*08A8*/    .pcTx_data_22A(  ),          
/*08AC*/    .pcTx_data_22B(  ),          
/*08B0*/    .pcTx_data_22C(  ),          
/*08B4*/    .pcTx_data_22D(  ),          
/*08B8*/    .pcTx_data_22E(  ),          
/*08BC*/    .pcTx_data_22F(  ),          
/*08C0*/    .pcTx_data_230(  ),          
/*08C4*/    .pcTx_data_231(  ),          
/*08C8*/    .pcTx_data_232(  ),          
/*08CC*/    .pcTx_data_233(  ),          
/*08D0*/    .pcTx_data_234(  ),          
/*08D4*/    .pcTx_data_235(  ),          
/*08D8*/    .pcTx_data_236(  ),          
/*08DC*/    .pcTx_data_237(  ),          
/*08E0*/    .pcTx_data_238(  ),          
/*08E4*/    .pcTx_data_239(  ),          
/*08E8*/    .pcTx_data_23A(  ),          
/*08EC*/    .pcTx_data_23B(  ),          
/*08F0*/    .pcTx_data_23C(  ),          
/*08F4*/    .pcTx_data_23D(  ),          
/*08F8*/    .pcTx_data_23E(  ),          
/*08FC*/    .pcTx_data_23F(  ),          
/*0900*/    .pcTx_data_240(  ),          
/*0904*/    .pcTx_data_241(  ),          
/*0908*/    .pcTx_data_242(  ),          
/*090C*/    .pcTx_data_243(  ),          
/*0910*/    .pcTx_data_244(  ),          
/*0914*/    .pcTx_data_245(  ),          
/*0918*/    .pcTx_data_246(  ),          
/*091C*/    .pcTx_data_247(  ),          
/*0920*/    .pcTx_data_248(  ),          
/*0924*/    .pcTx_data_249(  ),          
/*0928*/    .pcTx_data_24A(  ),          
/*092C*/    .pcTx_data_24B(  ),          
/*0930*/    .pcTx_data_24C(  ),          
/*0934*/    .pcTx_data_24D(  ),          
/*0938*/    .pcTx_data_24E(  ),          
/*093C*/    .pcTx_data_24F(  ),          
/*0940*/    .pcTx_data_250(  ),          
/*0944*/    .pcTx_data_251(  ),          
/*0948*/    .pcTx_data_252(  ),          
/*094C*/    .pcTx_data_253(  ),          
/*0950*/    .pcTx_data_254(  ),          
/*0954*/    .pcTx_data_255(  ),          
/*0958*/    .pcTx_data_256(  ),          
/*095C*/    .pcTx_data_257(  ),          
/*0960*/    .pcTx_data_258(  ),          
/*0964*/    .pcTx_data_259(  ),          
/*0968*/    .pcTx_data_25A(  ),          
/*096C*/    .pcTx_data_25B(  ),          
/*0970*/    .pcTx_data_25C(  ),          
/*0974*/    .pcTx_data_25D(  ),          
/*0978*/    .pcTx_data_25E(  ),          
/*097C*/    .pcTx_data_25F(  ),          
/*0980*/    .pcTx_data_260(  ),          
/*0984*/    .pcTx_data_261(  ),          
/*0988*/    .pcTx_data_262(  ),        
/*098C*/    .pcTx_data_263(  ),
/*0990*/    .pcTx_data_264(  ),
/*0994*/    .pcTx_data_265(  ),
/*0998*/    .pcTx_data_266(  ),
/*099C*/    .pcTx_data_267(  ),
/*09A0*/    .pcTx_data_268(  ),
/*09A4*/    .pcTx_data_269(  ),
/*09A8*/    .pcTx_data_26A(  ),
/*09AC*/    .pcTx_data_26B(  ),
/*09B0*/    .pcTx_data_26C(  ),
/*09B4*/    .pcTx_data_26D(  ),
/*09B8*/    .pcTx_data_26E(  ),
/*09BC*/    .pcTx_data_26F(  ),
/*09C0*/    .pcTx_data_270(  ),
/*09C4*/    .pcTx_data_271(  ),
/*09C8*/    .pcTx_data_272(  ),
/*09CC*/    .pcTx_data_273(  ),
/*09D0*/    .pcTx_data_274(  ),
/*09D4*/    .pcTx_data_275(  ),
/*09D8*/    .pcTx_data_276(  ),
/*09DC*/    .pcTx_data_277(  ),
/*09E0*/    .pcTx_data_278(  ),
/*09E4*/    .pcTx_data_279(  ),
/*09E8*/    .pcTx_data_27A(  ),
/*09EC*/    .pcTx_data_27B(  ),
/*09F0*/    .pcTx_data_27C(  ),
/*09F4*/    .pcTx_data_27D(  ),
/*09F8*/    .pcTx_data_27E(  ),
/*09FC*/    .pcTx_data_27F(  ),
/*0A00*/    .pcTx_data_280( S1_1_coe_mul ),
/*0A04*/    .pcTx_data_281( S1_1_coe_add ),              //板卡参数
/*0A08*/    .pcTx_data_282(  ),
/*0A0C*/    .pcTx_data_283(  ),                              
/*0A10*/    .pcTx_data_284(  ),                              
/*0A14*/    .pcTx_data_285(  ),                              
/*0A18*/    .pcTx_data_286(  ),                              
/*0A1C*/    .pcTx_data_287(  ),                              
/*0A20*/    .pcTx_data_288(  ),                              
/*0A24*/    .pcTx_data_289(  ),                              
/*0A28*/    .pcTx_data_28A(  ),                              
/*0A2C*/    .pcTx_data_28B(  ),                              
/*0A30*/    .pcTx_data_28C(  ),                              
/*0A34*/    .pcTx_data_28D(  ),                              
/*0A38*/    .pcTx_data_28E(  ),                              
/*0A3C*/    .pcTx_data_28F(  ),                              
/*0A40*/    .pcTx_data_290(  ),
/*0A44*/    .pcTx_data_291(  ),
/*0A48*/    .pcTx_data_292(  ),
/*0A4C*/    .pcTx_data_293(  ),
/*0A50*/    .pcTx_data_294(  ),
/*0A54*/    .pcTx_data_295(  ),
/*0A58*/    .pcTx_data_296(  ),
/*0A5C*/    .pcTx_data_297(  ),
/*0A60*/    .pcTx_data_298(  ),
/*0A64*/    .pcTx_data_299(  ),
/*0A68*/    .pcTx_data_29A(  ),
/*0A6C*/    .pcTx_data_29B(  ),
/*0A70*/    .pcTx_data_29C(  ),
/*0A74*/    .pcTx_data_29D(  ),
/*0A78*/    .pcTx_data_29E(  ),
/*0A7C*/    .pcTx_data_29F(  ),
/*0A80*/    .pcTx_data_2A0( S1_2_coe_mul ),
/*0A84*/    .pcTx_data_2A1( S1_2_coe_add ),
/*0A88*/    .pcTx_data_2A2(  ),
/*0A8C*/    .pcTx_data_2A3(  ),
/*0A90*/    .pcTx_data_2A4(  ),
/*0A94*/    .pcTx_data_2A5(  ),
/*0A98*/    .pcTx_data_2A6(  ),
/*0A9C*/    .pcTx_data_2A7(  ),
/*0AA0*/    .pcTx_data_2A8(  ),
/*0AA4*/    .pcTx_data_2A9(  ),
/*0AA8*/    .pcTx_data_2AA(  ),
/*0AAC*/    .pcTx_data_2AB(  ),
/*0AB0*/    .pcTx_data_2AC(  ),
/*0AB4*/    .pcTx_data_2AD(  ),
/*0AB8*/    .pcTx_data_2AE(  ),
/*0ABC*/    .pcTx_data_2AF(  ),
/*0AC0*/    .pcTx_data_2B0(  ),
/*0AC4*/    .pcTx_data_2B1(  ),
/*0AC8*/    .pcTx_data_2B2(  ),
/*0ACC*/    .pcTx_data_2B3(  ),
/*0AD0*/    .pcTx_data_2B4(  ),
/*0AD4*/    .pcTx_data_2B5(  ),
/*0AD8*/    .pcTx_data_2B6(  ),
/*0ADC*/    .pcTx_data_2B7(  ),
/*0AE0*/    .pcTx_data_2B8(  ),
/*0AE4*/    .pcTx_data_2B9(  ),
/*0AE8*/    .pcTx_data_2BA(  ),
/*0AEC*/    .pcTx_data_2BB(  ),
/*0AF0*/    .pcTx_data_2BC(  ),
/*0AF4*/    .pcTx_data_2BD(  ),
/*0AF8*/    .pcTx_data_2BE(  ),
/*0AFC*/    .pcTx_data_2BF(  ),
/*0B00*/    .pcTx_data_2C0( S2_1_coe_mul ),
/*0B04*/    .pcTx_data_2C1( S2_1_coe_add ),
/*0B08*/    .pcTx_data_2C2(  ),
/*0B0C*/    .pcTx_data_2C3(  ),
/*0B10*/    .pcTx_data_2C4(  ),
/*0B14*/    .pcTx_data_2C5(  ),
/*0B18*/    .pcTx_data_2C6(  ),
/*0B1C*/    .pcTx_data_2C7(  ),
/*0B20*/    .pcTx_data_2C8(  ),
/*0B24*/    .pcTx_data_2C9(  ),
/*0B28*/    .pcTx_data_2CA(  ),
/*0B2C*/    .pcTx_data_2CB(  ),
/*0B30*/    .pcTx_data_2CC(  ),
/*0B34*/    .pcTx_data_2CD(  ),
/*0B38*/    .pcTx_data_2CE(  ),
/*0B3C*/    .pcTx_data_2CF(  ),
/*0B40*/    .pcTx_data_2D0(  ),
/*0B44*/    .pcTx_data_2D1(  ),
/*0B48*/    .pcTx_data_2D2(  ),
/*0B4C*/    .pcTx_data_2D3(  ),
/*0B50*/    .pcTx_data_2D4(  ),
/*0B54*/    .pcTx_data_2D5(  ),
/*0B58*/    .pcTx_data_2D6(  ),
/*0B5C*/    .pcTx_data_2D7(  ),
/*0B60*/    .pcTx_data_2D8(  ),
/*0B64*/    .pcTx_data_2D9(  ),
/*0B68*/    .pcTx_data_2DA(  ),
/*0B6C*/    .pcTx_data_2DB(  ),
/*0B70*/    .pcTx_data_2DC(  ),
/*0B74*/    .pcTx_data_2DD(  ),
/*0B78*/    .pcTx_data_2DE(  ),
/*0B7C*/    .pcTx_data_2DF(  ),
/*0B80*/    .pcTx_data_2E0( S2_2_coe_mul ),
/*0B84*/    .pcTx_data_2E1( S2_2_coe_add ),
/*0B88*/    .pcTx_data_2E2(  ),
/*0B8C*/    .pcTx_data_2E3(  ),
/*0B90*/    .pcTx_data_2E4(  ),
/*0B94*/    .pcTx_data_2E5(  ),
/*0B98*/    .pcTx_data_2E6(  ),
/*0B9C*/    .pcTx_data_2E7(  ),
/*0BA0*/    .pcTx_data_2E8(  ),
/*0BA4*/    .pcTx_data_2E9(  ),
/*0BA8*/    .pcTx_data_2EA(  ),
/*0BAC*/    .pcTx_data_2EB(  ),
/*0BB0*/    .pcTx_data_2EC(  ),
/*0BB4*/    .pcTx_data_2ED(  ),
/*0BB8*/    .pcTx_data_2EE(  ),
/*0BBC*/    .pcTx_data_2EF(  ),
/*0BC0*/    .pcTx_data_2F0(  ),
/*0BC4*/    .pcTx_data_2F1(  ),
/*0BC8*/    .pcTx_data_2F2(  ),
/*0BCC*/    .pcTx_data_2F3(  ),
/*0BD0*/    .pcTx_data_2F4(  ),
/*0BD4*/    .pcTx_data_2F5(  ),
/*0BD8*/    .pcTx_data_2F6(  ),
/*0BDC*/    .pcTx_data_2F7(  ),
/*0BE0*/    .pcTx_data_2F8(  ),
/*0BE4*/    .pcTx_data_2F9(  ),
/*0BE8*/    .pcTx_data_2FA(  ),
/*0BEC*/    .pcTx_data_2FB(  ),
/*0BF0*/    .pcTx_data_2FC(  ),
/*0BF4*/    .pcTx_data_2FD(  ),
/*0BF8*/    .pcTx_data_2FE(  ),
/*0BFC*/    .pcTx_data_2FF(  ),
/*0C00*/    .pcTx_data_300( S3_1_coe_mul ),
/*0C04*/    .pcTx_data_301( S3_1_coe_add ),
/*0C08*/    .pcTx_data_302(  ),
/*0C0C*/    .pcTx_data_303(  ),
/*0C10*/    .pcTx_data_304(  ),
/*0C14*/    .pcTx_data_305(  ),
/*0C18*/    .pcTx_data_306(  ),
/*0C1C*/    .pcTx_data_307(  ),
/*0C20*/    .pcTx_data_308(  ),
/*0C24*/    .pcTx_data_309(  ),
/*0C28*/    .pcTx_data_30A(  ),
/*0C2C*/    .pcTx_data_30B(  ),
/*0C30*/    .pcTx_data_30C(  ),
/*0C34*/    .pcTx_data_30D(  ),
/*0C38*/    .pcTx_data_30E(  ),
/*0C3C*/    .pcTx_data_30F(  ),
/*0C40*/    .pcTx_data_310(  ),
/*0C44*/    .pcTx_data_311(  ),
/*0C48*/    .pcTx_data_312(  ),
/*0C4C*/    .pcTx_data_313(  ),
/*0C50*/    .pcTx_data_314(  ),
/*0C54*/    .pcTx_data_315(  ),
/*0C58*/    .pcTx_data_316(  ),
/*0C5C*/    .pcTx_data_317(  ),
/*0C60*/    .pcTx_data_318(  ),
/*0C64*/    .pcTx_data_319(  ),
/*0C68*/    .pcTx_data_31A(  ),
/*0C6C*/    .pcTx_data_31B(  ),
/*0C70*/    .pcTx_data_31C(  ),
/*0C74*/    .pcTx_data_31D(  ),
/*0C78*/    .pcTx_data_31E(  ),
/*0C7C*/    .pcTx_data_31F(  ),
/*0C80*/    .pcTx_data_320( S3_2_coe_mul ),
/*0C84*/    .pcTx_data_321( S3_2_coe_add ),
/*0C88*/    .pcTx_data_322(  ),
/*0C8C*/    .pcTx_data_323(  ),
/*0C90*/    .pcTx_data_324(  ),
/*0C94*/    .pcTx_data_325(  ),
/*0C98*/    .pcTx_data_326(  ),
/*0C9C*/    .pcTx_data_327(  ),
/*0CA0*/    .pcTx_data_328(  ),
/*0CA4*/    .pcTx_data_329(  ),
/*0CA8*/    .pcTx_data_32A(  ),
/*0CAC*/    .pcTx_data_32B(  ),
/*0CB0*/    .pcTx_data_32C(  ),
/*0CB4*/    .pcTx_data_32D(  ),
/*0CB8*/    .pcTx_data_32E(  ),
/*0CBC*/    .pcTx_data_32F(  ),
/*0CC0*/    .pcTx_data_330(  ),
/*0CC4*/    .pcTx_data_331(  ),
/*0CC8*/    .pcTx_data_332(  ),
/*0CCC*/    .pcTx_data_333(  ),
/*0CD0*/    .pcTx_data_334(  ),
/*0CD4*/    .pcTx_data_335(  ),
/*0CD8*/    .pcTx_data_336(  ),
/*0CDC*/    .pcTx_data_337(  ),
/*0CE0*/    .pcTx_data_338(  ),
/*0CE4*/    .pcTx_data_339(  ),
/*0CE8*/    .pcTx_data_33A(  ),
/*0CEC*/    .pcTx_data_33B(  ),
/*0CF0*/    .pcTx_data_33C(  ),
/*0CF4*/    .pcTx_data_33D(  ),
/*0CF8*/    .pcTx_data_33E(  ),
/*0CFC*/    .pcTx_data_33F(  ),
/*0D00*/    .pcTx_data_340(  ),
/*0D04*/    .pcTx_data_341(  ),
/*0D08*/    .pcTx_data_342(  ),
/*0D0C*/    .pcTx_data_343(  ),
/*0D10*/    .pcTx_data_344(  ),
/*0D14*/    .pcTx_data_345(  ),
/*0D18*/    .pcTx_data_346(  ),
/*0D1C*/    .pcTx_data_347(  ),
/*0D20*/    .pcTx_data_348(  ),
/*0D24*/    .pcTx_data_349(  ),
/*0D28*/    .pcTx_data_34A(  ),
/*0D2C*/    .pcTx_data_34B(  ),
/*0D30*/    .pcTx_data_34C(  ),
/*0D34*/    .pcTx_data_34D(  ),
/*0D38*/    .pcTx_data_34E(  ),
/*0D3C*/    .pcTx_data_34F(  ),
/*0D40*/    .pcTx_data_350(  ),
/*0D44*/    .pcTx_data_351(  ),
/*0D48*/    .pcTx_data_352(  ),
/*0D4C*/    .pcTx_data_353(  ),
/*0D50*/    .pcTx_data_354(  ),
/*0D54*/    .pcTx_data_355(  ),
/*0D58*/    .pcTx_data_356(  ),
/*0D5C*/    .pcTx_data_357(  ),
/*0D60*/    .pcTx_data_358(  ),
/*0D64*/    .pcTx_data_359(  ),
/*0D68*/    .pcTx_data_35A(  ),
/*0D6C*/    .pcTx_data_35B(  ),
/*0D70*/    .pcTx_data_35C(  ),
/*0D74*/    .pcTx_data_35D(  ),
/*0D78*/    .pcTx_data_35E(  ),
/*0D7C*/    .pcTx_data_35F(  ),
/*0D80*/    .pcTx_data_360(  ),
/*0D84*/    .pcTx_data_361(  ),
/*0D88*/    .pcTx_data_362(  ),
/*0D8C*/    .pcTx_data_363(  ),
/*0D90*/    .pcTx_data_364(  ),
/*0D94*/    .pcTx_data_365(  ),
/*0D98*/    .pcTx_data_366(  ),
/*0D9C*/    .pcTx_data_367(  ),
/*0DA0*/    .pcTx_data_368(  ),
/*0DA4*/    .pcTx_data_369(  ),
/*0DA8*/    .pcTx_data_36A(  ),
/*0DAC*/    .pcTx_data_36B(  ),
/*0DB0*/    .pcTx_data_36C(  ),
/*0DB4*/    .pcTx_data_36D(  ),
/*0DB8*/    .pcTx_data_36E(  ),
/*0DBC*/    .pcTx_data_36F(  ),
/*0DC0*/    .pcTx_data_370(  ),
/*0DC4*/    .pcTx_data_371(  ),
/*0DC8*/    .pcTx_data_372(  ),
/*0DCC*/    .pcTx_data_373(  ),
/*0DD0*/    .pcTx_data_374(  ),
/*0DD4*/    .pcTx_data_375(  ), 
/*0DD8*/    .pcTx_data_376(  ),
/*0DDC*/    .pcTx_data_377(  ),
/*0DE0*/    .pcTx_data_378(  ),
/*0DE4*/    .pcTx_data_379(  ),
/*0DE8*/    .pcTx_data_37A(  ),
/*0DEC*/    .pcTx_data_37B(  ),
/*0DF0*/    .pcTx_data_37C(  ),                               
/*0DF4*/    .pcTx_data_37D(  ),                               
/*0DF8*/    .pcTx_data_37E(  ),                               
/*0DFC*/    .pcTx_data_37F(  ),
/*0E00*/    .pcTx_data_380(  ),                                                                       
/*0E04*/    .pcTx_data_381(  ),                                                                                          
/*0E08*/    .pcTx_data_382(  ),                                                                                          
/*0E0C*/    .pcTx_data_383(  ),                                                                                          
/*0E10*/    .pcTx_data_384(  ),                                                                                          
/*0E14*/    .pcTx_data_385(  ),                                                                                          
/*0E18*/    .pcTx_data_386(  ),                                                                                          
/*0E1C*/    .pcTx_data_387(  ),                                                                                          
/*0E20*/    .pcTx_data_388(  ),                                                                                          
/*0E24*/    .pcTx_data_389(  ),                                                                                          
/*0E28*/    .pcTx_data_38A(  ),                                                                                         
/*0E2C*/    .pcTx_data_38B(  ),                                                                                         
/*0E30*/    .pcTx_data_38C(  ),                                                                                         
/*0E34*/    .pcTx_data_38D(  ),                                                                                         
/*0E38*/    .pcTx_data_38E(  ),                                                                                         
/*0E3C*/    .pcTx_data_38F(  ),                                                                                         
/*0E40*/    .pcTx_data_390(  ),                                                                                         
/*0E44*/    .pcTx_data_391(  ),                                                                                         
/*0E48*/    .pcTx_data_392(  ),                                                                                         
/*0E4C*/    .pcTx_data_393(  ),                                                                                         
/*0E50*/    .pcTx_data_394(  ),                                                                                         
/*0E54*/    .pcTx_data_395(  ),                                                                                         
/*0E58*/    .pcTx_data_396(  ),                                                                                         
/*0E5C*/    .pcTx_data_397(  ),                                                                                         
/*0E60*/    .pcTx_data_398(  ),                                                                                         
/*0E64*/    .pcTx_data_399(  ),                                                                                         
/*0E68*/    .pcTx_data_39A(  ),                                                                                         
/*0E6C*/    .pcTx_data_39B(  ),                                                                                         
/*0E70*/    .pcTx_data_39C(  ),                                                                                         
/*0E74*/    .pcTx_data_39D(  ),                                                                                         
/*0E78*/    .pcTx_data_39E(  ),                                                                                         
/*0E7C*/    .pcTx_data_39F(  ),                                                                                         
/*0E80*/    .pcTx_data_3A0(  ),                                                                                         
/*0E84*/    .pcTx_data_3A1(  ),                                                                                         
/*0E88*/    .pcTx_data_3A2(  ),                                                                                         
/*0E8C*/    .pcTx_data_3A3(  ),                                                                                         
/*0E90*/    .pcTx_data_3A4(  ),                                                                                         
/*0E94*/    .pcTx_data_3A5(  ),                                                                                         
/*0E98*/    .pcTx_data_3A6(  ),                                                                                         
/*0E9C*/    .pcTx_data_3A7(  ),                                                                                         
/*0EA0*/    .pcTx_data_3A8(  ),                                                                                         
/*0EA4*/    .pcTx_data_3A9(  ),                                                                                         
/*0EA8*/    .pcTx_data_3AA(  ),                                                                                         
/*0EAC*/    .pcTx_data_3AB(  ),                                                                                         
/*0EB0*/    .pcTx_data_3AC(  ),                                                                                         
/*0EB4*/    .pcTx_data_3AD(  ),                                                                                         
/*0EB8*/    .pcTx_data_3AE(  ),                                                                                         
/*0EBC*/    .pcTx_data_3AF(  ),                                                                                         
/*0EC0*/    .pcTx_data_3B0(  ),                                                                                         
/*0EC4*/    .pcTx_data_3B1(  ),                                                                                         
/*0EC8*/    .pcTx_data_3B2(  ),                                                                                         
/*0ECC*/    .pcTx_data_3B3(  ),                                                                                         
/*0ED0*/    .pcTx_data_3B4(  ),                                                                                         
/*0ED4*/    .pcTx_data_3B5(  ),                                                                                         
/*0ED8*/    .pcTx_data_3B6(  ),                                                                                         
/*0EDC*/    .pcTx_data_3B7(  ),                                                                                         
/*0EE0*/    .pcTx_data_3B8(  ),                                                                                         
/*0EE4*/    .pcTx_data_3B9(  ),                                                                                         
/*0EE8*/    .pcTx_data_3BA(  ),                                                                                         
/*0EEC*/    .pcTx_data_3BB(  ),                                                                                         
/*0EF0*/    .pcTx_data_3BC(  ),                                                                                         
/*0EF4*/    .pcTx_data_3BD(  ),                                                                                         
/*0EF8*/    .pcTx_data_3BE(  ),                                                                                         
/*0EFC*/    .pcTx_data_3BF(  ),                                                                                         
/*0F00*/    .pcTx_data_3C0(  ),                                                                                         
/*0F04*/    .pcTx_data_3C1(  ),                                                                                         
/*0F08*/    .pcTx_data_3C2(  ),                                                                                         
/*0F0C*/    .pcTx_data_3C3(  ),                                                                                         
/*0F10*/    .pcTx_data_3C4(  ),                                                                                         
/*0F14*/    .pcTx_data_3C5(  ),                                                                                         
/*0F18*/    .pcTx_data_3C6(  ),                                                                                         
/*0F1C*/    .pcTx_data_3C7(  ),                                                                                         
/*0F20*/    .pcTx_data_3C8(  ),                                                                                         
/*0F24*/    .pcTx_data_3C9(  ),                                                                                         
/*0F28*/    .pcTx_data_3CA(  ),                                                                                         
/*0F2C*/    .pcTx_data_3CB(  ),                                                                                         
/*0F30*/    .pcTx_data_3CC(  ),                                                                                         
/*0F34*/    .pcTx_data_3CD(  ),                                                                                         
/*0F38*/    .pcTx_data_3CE(  ),                                                                                         
/*0F3C*/    .pcTx_data_3CF(  ),                                                                                         
/*0F40*/    .pcTx_data_3D0(  ),                                                                                         
/*0F44*/    .pcTx_data_3D1(  ),                                                                                         
/*0F48*/    .pcTx_data_3D2(  ),                                                                                         
/*0F4C*/    .pcTx_data_3D3(  ),                                                                                         
/*0F50*/    .pcTx_data_3D4(  ),                                                                                         
/*0F54*/    .pcTx_data_3D5(  ),                                                                                         
/*0F58*/    .pcTx_data_3D6(  ),                                                                                         
/*0F5C*/    .pcTx_data_3D7(  ),                                                                                         
/*0F60*/    .pcTx_data_3D8(  ),                                                                                         
/*0F64*/    .pcTx_data_3D9(  ),                                                                                         
/*0F68*/    .pcTx_data_3DA(  ),                                                                                         
/*0F6C*/    .pcTx_data_3DB(  ),                                                                                         
/*0F70*/    .pcTx_data_3DC(  ),                                                                                         
/*0F74*/    .pcTx_data_3DD(  ),                                                                                         
/*0F78*/    .pcTx_data_3DE(  ),                                                                                         
/*0F7C*/    .pcTx_data_3DF(  ),                                                                                         
/*0F80*/    .pcTx_data_3E0(  ),                                                                                         
/*0F84*/    .pcTx_data_3E1(  ),                                                                                         
/*0F88*/    .pcTx_data_3E2(  ),                                                                                         
/*0F8C*/    .pcTx_data_3E3(  ),                                                                                         
/*0F90*/    .pcTx_data_3E4(  ),                                                                                        
/*0F94*/    .pcTx_data_3E5(  ),                                                                                        
/*0F98*/    .pcTx_data_3E6(  ),                                                                                        
/*0F9C*/    .pcTx_data_3E7(  ),                                                                                        
/*0FA0*/    .pcTx_data_3E8(  ),                                                                                        
/*0FA4*/    .pcTx_data_3E9(  ),                                                                                        
/*0FA8*/    .pcTx_data_3EA(  ),                                                                                        
/*0FAC*/    .pcTx_data_3EB(  ),                                                                                        
/*0FB0*/    .pcTx_data_3EC(  ),                                                                                        
/*0FB4*/    .pcTx_data_3ED(  ),                                                                                        
/*0FB8*/    .pcTx_data_3EE(  ),                                                                                        
/*0FBC*/    .pcTx_data_3EF(  ),                                                                                        
/*0FC0*/    .pcTx_data_3F0(  ),                                                                                        
/*0FC4*/    .pcTx_data_3F1(  ),                                                                                        
/*0FC8*/    .pcTx_data_3F2(  ),                                                                                        
/*0FCC*/    .pcTx_data_3F3(  ),                                                                                        
/*0FD0*/    .pcTx_data_3F4(  ),                                                                                        
/*0FD4*/    .pcTx_data_3F5(  ),                                                                                        
/*0FD8*/    .pcTx_data_3F6(  ),                                                                                        
/*0FDC*/    .pcTx_data_3F7(  ),                                                                                        
/*0FE0*/    .pcTx_data_3F8(  ),                                                                                        
/*0FE4*/    .pcTx_data_3F9(  ),                                                                                        
/*0FE8*/    .pcTx_data_3FA(  ),                                                                                        
/*0FEC*/    .pcTx_data_3FB(  ),                                                                                        
/*0FF0*/    .pcTx_data_3FC(  ),                                                                                        
/*0FF4*/    .pcTx_data_3FD(  ),                                                                                        
/*0FF8*/    .pcTx_data_3FE(  ),                                                                                        
/*0FFC*/    .pcTx_data_3FF(  ),                                                                                        
/*1000*/    .pcTx_data_400(  ),                                                                         
/*1004*/    .pcTx_data_401(  ),                                                                           
/*1008*/    .pcTx_data_402(  ),                                                                      
/*100C*/    .pcTx_data_403(   ),   
/*1010*/    .pcTx_data_404(   ),   
/*1014*/    .pcTx_data_405(   ),                                                               
/*1018*/    .pcTx_data_406(   ),                                                               
/*101C*/    .pcTx_data_407(   ),	  
/*1020*/    .pcTx_data_408(   ),   
/*1024*/    .pcTx_data_409(   ),                                                                                     
/*1028*/    .pcTx_data_40A(   ),                                                                                     
/*102C*/    .pcTx_data_40B(   ),                                                                                 
/*1030*/    .pcTx_data_40C(   ),                                                                                 
/*1034*/    .pcTx_data_40D(   ),                                                                                 
/*1038*/    .pcTx_data_40E(   ),                                                                                 
/*103C*/    .pcTx_data_40F(   ),                                                                                 
/*1040*/    .pcTx_data_410(   ),                                                                                 
/*1044*/    .pcTx_data_411(   ),                                                                                        
/*1048*/    .pcTx_data_412(   ),                                                                                        
/*104C*/    .pcTx_data_413(   ),                                                                                             
/*1050*/    .pcTx_data_414(   ),                                                                                  
/*1054*/    .pcTx_data_415(   ),                                                                                  
/*1058*/    .pcTx_data_416(   ),                                                                                  
/*105C*/    .pcTx_data_417(   ),                                                                                  
/*1060*/    .pcTx_data_418(   ),                                                                                  
/*1064*/    .pcTx_data_419(   ),
/*1068*/    .pcTx_data_41A(   ), 
/*106C*/    .pcTx_data_41B(   ),
/*1070*/    .pcTx_data_41C(   ),
/*1074*/    .pcTx_data_41D(  ),
/*1078*/    .pcTx_data_41E(  ),
/*107C*/    .pcTx_data_41F(  ),
/*1080*/    .pcTx_data_420(  ),
/*1084*/    .pcTx_data_421(  ),
/*1088*/    .pcTx_data_422(  ),
/*108C*/    .pcTx_data_423(  ),
/*1090*/    .pcTx_data_424(  ),
/*1094*/    .pcTx_data_425(  ),
/*1098*/    .pcTx_data_426(  ),
/*109C*/    .pcTx_data_427(  ),
/*10A0*/    .pcTx_data_428(  ),
/*10A4*/    .pcTx_data_429(  ),
/*10A8*/    .pcTx_data_42A(  ),
/*10AC*/    .pcTx_data_42B(  ),
/*10B0*/    .pcTx_data_42C(  ),
/*10B4*/    .pcTx_data_42D(  ),
/*10B8*/    .pcTx_data_42E(  ),
/*10BC*/    .pcTx_data_42F(  ),
/*10C0*/    .pcTx_data_430(  ),
/*10C4*/    .pcTx_data_431(  ),
/*10C8*/    .pcTx_data_432(  ),
/*10CC*/    .pcTx_data_433(  ),
/*10D0*/    .pcTx_data_434(  ),
/*10D4*/    .pcTx_data_435(  ),           
/*10D8*/    .pcTx_data_436(  ),           
/*10DC*/    .pcTx_data_437(  ),           
/*10E0*/    .pcTx_data_438(  ),           
/*10E4*/    .pcTx_data_439(  ),           
/*10E8*/    .pcTx_data_43A(  ),
/*10EC*/    .pcTx_data_43B(  ),
/*10F0*/    .pcTx_data_43C(  ),
/*10F4*/    .pcTx_data_43D(  ),
/*10F8*/    .pcTx_data_43E(  ),    
/*10FC*/    .pcTx_data_43F(  ),
/*1100*/    .pcTx_data_440(  ),  
/*1104*/    .pcTx_data_441(  ),  
/*1108*/    .pcTx_data_442(  ),  
/*110C*/    .pcTx_data_443(  ),  
/*1110*/    .pcTx_data_444(  ),  	                                                              
/*1114*/    .pcTx_data_445(  ),     		                                                      
/*1118*/    .pcTx_data_446( delay_dat2 ),                                                                   
/*111C*/    .pcTx_data_447( fre_choose ),        //同步时钟选择                                                                
/*1120*/    .pcTx_data_448( add_dat_s12 ),        //仿真数据                                                             
/*1124*/    .pcTx_data_449( add_dat_s34 ),                                                                       
/*1128*/    .pcTx_data_44A( add_dat_s56 ),                                                                        
/*112C*/    .pcTx_data_44B( add_dat_s78 ),      
/*1130*/    .pcTx_data_44C( delay_dat   ),

//PC机读数,FPGA——>PC
           	
/*0050*/    .pcRx_data_014(   ),      //used     
/*0054*/    .pcRx_data_015(   ),      //used    
/*0058*/    .pcRx_data_016( pcie_wr_data_count[9:0]  ),      //used    pcie_wr_data_count[13:0]
/*005C*/    .pcRx_data_017( pcie_wr_fifo_full  ),      //used    pcie_wr_fifo_full    
/*0060*/    .pcRx_data_018(  pcie_prog_full ),      //used    pcie_prog_full       
/*0064*/    .pcRx_data_019(   ),      //used    speed_cnt[31:0]        
/*0068*/    .pcRx_data_01A(   ),      //used    dma_cnt[3:0]         
/*006C*/    .pcRx_data_01B( {fifo_full,prog_full,ready_dsp,auto_dsp,trigged_dsp,Program_Full}  ),          
/*0070*/    .pcRx_data_01C( auto_trig_level_1 ),         
/*0074*/    .pcRx_data_01D( auto_trig_level_2 ),          
/*0078*/    .pcRx_data_01E( auto_trig_level_3 ),          
/*007C*/    .pcRx_data_01F( auto_trig_level_4 ),          
/*0080*/    .pcRx_data_020( auto_trig_level_5 ),          
/*0084*/    .pcRx_data_021( auto_trig_level_6 ),          
/*0088*/    .pcRx_data_022( auto_trig_level_7 ),          
/*008C*/    .pcRx_data_023( auto_trig_level_8 ),          
/*0090*/    .pcRx_data_024( ddr_buffer_full ),          
/*0094*/    .pcRx_data_025( ddr_c0_wr ),          
/*0098*/    .pcRx_data_026( ddr_c1_wr ),            
/*009C*/    .pcRx_data_027( rd_done),          
/*00A0*/    .pcRx_data_028( power_fifo_data_count[12:0] ),              //功率模式参数
/*00A4*/    .pcRx_data_029( power_fifo_full  ),          
/*00A8*/    .pcRx_data_02A(  ),          
/*00AC*/    .pcRx_data_02B(  ),          
/*00B0*/    .pcRx_data_02C(  ),          
/*00B4*/    .pcRx_data_02D(  ),          
/*00B8*/    .pcRx_data_02E(  ),          
/*00BC*/    .pcRx_data_02F(  ),          
/*00C0*/    .pcRx_data_030(cnt_period0[31:0]   ),   //测周法计数值             //测频参数     
/*00C4*/    .pcRx_data_031(cnt_period0[39:32]  ),   //被测信号测频法计数值      
/*00C8*/    .pcRx_data_032(cnt_freq_fx0  ),   //标准时钟测频法计数值       
/*00CC*/    .pcRx_data_033(cnt_freq_fs0   ),          
/*00D0*/    .pcRx_data_034(cnt_period1[31:0]   ),          
/*00D4*/    .pcRx_data_035(cnt_period1[39:32]  ),          
/*00D8*/    .pcRx_data_036(cnt_freq_fx1   ),          
/*00DC*/    .pcRx_data_037(cnt_freq_fs1  ),          
/*00E0*/    .pcRx_data_038(cnt_period2[31:0]   ),          
/*00E4*/    .pcRx_data_039(cnt_period2[39:32]  ),          
/*00E8*/    .pcRx_data_03A(cnt_freq_fx2  ),          
/*00EC*/    .pcRx_data_03B(cnt_freq_fs2  ),          
/*00F0*/    .pcRx_data_03C(cnt_period3[31:0]  ),          
/*00F4*/    .pcRx_data_03D(cnt_period3[39:32] ),          
/*00F8*/    .pcRx_data_03E(cnt_freq_fx3  ),          
/*00FC*/    .pcRx_data_03F(cnt_freq_fs3  ),          
/*0100*/    .pcRx_data_040({per_full_flag3,per_mea_flag3,fre_mea_flag3,per_full_flag2,per_mea_flag2,fre_mea_flag2,per_full_flag1,per_mea_flag1,fre_mea_flag1,per_full_flag0,per_mea_flag0,fre_mea_flag0 }  ),          
/*0104*/    .pcRx_data_041(  ),          
/*0108*/    .pcRx_data_042(  ),          
/*010C*/    .pcRx_data_043(  ),          
/*0110*/    .pcRx_data_044(  ),          
/*0114*/    .pcRx_data_045(  ),          
/*0118*/    .pcRx_data_046(  ),          
/*011C*/    .pcRx_data_047(  ),          
/*0120*/    .pcRx_data_048(  ),          
/*0124*/    .pcRx_data_049(  ),          
/*0128*/    .pcRx_data_04A(  ),          
/*012C*/    .pcRx_data_04B(  ),          
/*0130*/    .pcRx_data_04C(  ),          
/*0134*/    .pcRx_data_04D(  ),          
/*0138*/    .pcRx_data_04E(  ),          
/*013C*/    .pcRx_data_04F(  ),          
/*0140*/    .pcRx_data_050(  ),          
/*0144*/    .pcRx_data_051(  ),          
/*0148*/    .pcRx_data_052(  ),          
/*014C*/    .pcRx_data_053(  ),          
/*0150*/    .pcRx_data_054(  ),          
/*0154*/    .pcRx_data_055(  ),          
/*0158*/    .pcRx_data_056(  ),          
/*015C*/    .pcRx_data_057(  ),          
/*0160*/    .pcRx_data_058(  ),          
/*0164*/    .pcRx_data_059(  ),          
/*0168*/    .pcRx_data_05A(  ),          
/*016C*/    .pcRx_data_05B(  ),          
/*0170*/    .pcRx_data_05C(  ),          
/*0174*/    .pcRx_data_05D(  ),          
/*0178*/    .pcRx_data_05E(  ),          
/*017C*/    .pcRx_data_05F(  ),          
/*0180*/    .pcRx_data_060(  ),                                                                                 
/*0184*/    .pcRx_data_061(  ),                                                                                                     
/*0188*/    .pcRx_data_062(  ),                         
/*018C*/    .pcRx_data_063(  ),                                                                          
/*0190*/    .pcRx_data_064(  ),                                                                                 
/*0194*/    .pcRx_data_065(  ),                                                                  
/*0198*/    .pcRx_data_066(  ),                                                                  
/*019C*/    .pcRx_data_067(  ),                                                                                  
/*01A0*/    .pcRx_data_068(  ),                                                                               
/*01A4*/    .pcRx_data_069(  ),                                                                                      
/*01A8*/    .pcRx_data_06A(  ),
/*01AC*/    .pcRx_data_06B(   ),
/*01B0*/    .pcRx_data_06C(  ),
/*01B4*/    .pcRx_data_06D(  ),
/*01B8*/    .pcRx_data_06E(  ),
/*01BC*/    .pcRx_data_06F(  ),    
/*01C0*/    .pcRx_data_070(  ),
/*01C4*/    .pcRx_data_071(  ),
/*01C8*/    .pcRx_data_072(  ),
/*01CC*/    .pcRx_data_073(  ),
/*01D0*/    .pcRx_data_074(  ),
/*01D4*/    .pcRx_data_075(  ),
/*01D8*/    .pcRx_data_076(  ),
/*01DC*/    .pcRx_data_077(  ),
/*01E0*/    .pcRx_data_078(  ),
/*01E4*/    .pcRx_data_079(  ),
/*01E8*/    .pcRx_data_07A(  ),
/*01EC*/    .pcRx_data_07B(  ),
/*01F0*/    .pcRx_data_07C(  ),
/*01F4*/    .pcRx_data_07D(  ),
/*01F8*/    .pcRx_data_07E(  ),
/*01FC*/    .pcRx_data_07F(  ),
/*0200*/    .pcRx_data_080(  ),
/*0204*/    .pcRx_data_081(  ),
/*0208*/    .pcRx_data_082(  ),
/*020C*/    .pcRx_data_083(  ),
/*0210*/    .pcRx_data_084(  ),
/*0214*/    .pcRx_data_085(  ),
/*0218*/    .pcRx_data_086(  ),
/*021C*/    .pcRx_data_087(  ),
/*0220*/    .pcRx_data_088(  ),
/*0224*/    .pcRx_data_089(  ),
/*0228*/    .pcRx_data_08A(  ),
/*022C*/    .pcRx_data_08B(  ),
/*0230*/    .pcRx_data_08C(  ),
/*0234*/    .pcRx_data_08D(  ),
/*0238*/    .pcRx_data_08E(  ),
/*023C*/    .pcRx_data_08F(  ),
/*0240*/    .pcRx_data_090(  ),
/*0244*/    .pcRx_data_091(  ),
/*0248*/    .pcRx_data_092(  ),
/*024C*/    .pcRx_data_093(  ),
/*0250*/    .pcRx_data_094(  ),
/*0254*/    .pcRx_data_095(  ),
/*0258*/    .pcRx_data_096(  ),
/*025C*/    .pcRx_data_097(  ),
/*0260*/    .pcRx_data_098(  ),
/*0264*/    .pcRx_data_099(  ),
/*0268*/    .pcRx_data_09A(  ),
/*026C*/    .pcRx_data_09B(  ),
/*0270*/    .pcRx_data_09C(  ),
/*0274*/    .pcRx_data_09D(  ),
/*0278*/    .pcRx_data_09E(  ),
/*027C*/    .pcRx_data_09F(  ),
/*0280*/    .pcRx_data_0A0(  ),
/*0284*/    .pcRx_data_0A1(  ),
/*0288*/    .pcRx_data_0A2(   ),
/*028C*/    .pcRx_data_0A3(   ),
/*0290*/    .pcRx_data_0A4( ),
/*0294*/    .pcRx_data_0A5( ),
/*0298*/    .pcRx_data_0A6( ),
/*029C*/    .pcRx_data_0A7( ),
/*02A0*/    .pcRx_data_0A8( ),
/*02A4*/    .pcRx_data_0A9( ),
/*02A8*/    .pcRx_data_0AA( ),
/*02AC*/    .pcRx_data_0AB( ),
/*02B0*/    .pcRx_data_0AC( ),
/*02B4*/    .pcRx_data_0AD( ),
/*02B8*/    .pcRx_data_0AE( ),
/*02BC*/    .pcRx_data_0AF( ),
/*02C0*/    .pcRx_data_0B0( ),
/*02C4*/    .pcRx_data_0B1(   ),         
/*02C8*/    .pcRx_data_0B2(   ),
/*02CC*/    .pcRx_data_0B3(  ),
/*02D0*/    .pcRx_data_0B4(  ),
/*02D4*/    .pcRx_data_0B5(  ),
/*02D8*/    .pcRx_data_0B6(  ),
/*02DC*/    .pcRx_data_0B7(  ),
/*02E0*/    .pcRx_data_0B8(  ),
/*02E4*/    .pcRx_data_0B9(  ),
/*02E8*/    .pcRx_data_0BA(  ),
/*02EC*/    .pcRx_data_0BB(  ),
/*02F0*/    .pcRx_data_0BC(  ),
/*02F4*/    .pcRx_data_0BD(  ),
/*02F8*/    .pcRx_data_0BE(  ),
/*02FC*/    .pcRx_data_0BF(  ),
/*0300*/    .pcRx_data_0C0(  ),
/*0304*/    .pcRx_data_0C1(  ),
/*0308*/    .pcRx_data_0C2(  ),
/*030C*/    .pcRx_data_0C3(  ),
/*0310*/    .pcRx_data_0C4(  ),
/*0314*/    .pcRx_data_0C5(  ),
/*0318*/    .pcRx_data_0C6(  ),
/*031C*/    .pcRx_data_0C7(  ),
/*0320*/    .pcRx_data_0C8(  ),
/*0324*/    .pcRx_data_0C9(  ),
/*0328*/    .pcRx_data_0CA(  ),
/*032C*/    .pcRx_data_0CB(  ),
/*0330*/    .pcRx_data_0CC(  ),
/*0334*/    .pcRx_data_0CD(  ),
/*0338*/    .pcRx_data_0CE(  ),
/*033C*/    .pcRx_data_0CF(  ),
/*0340*/    .pcRx_data_0D0(  ),
/*0344*/    .pcRx_data_0D1(  ),
/*0348*/    .pcRx_data_0D2(  ),
/*034C*/    .pcRx_data_0D3(  ),
/*0350*/    .pcRx_data_0D4(  ),
/*0354*/    .pcRx_data_0D5(  ),
/*0358*/    .pcRx_data_0D6(  ),
/*035C*/    .pcRx_data_0D7(  ),
/*0360*/    .pcRx_data_0D8(  ),
/*0364*/    .pcRx_data_0D9(  ),
/*0368*/    .pcRx_data_0DA(  ),
/*036C*/    .pcRx_data_0DB(  ),
/*0370*/    .pcRx_data_0DC(  ),
/*0374*/    .pcRx_data_0DD(  ),
/*0378*/    .pcRx_data_0DE(  ),
/*037C*/    .pcRx_data_0DF(  ),
/*0380*/    .pcRx_data_0E0(  ),
/*0384*/    .pcRx_data_0E1(  ),
/*0388*/    .pcRx_data_0E2(  ),
/*038C*/    .pcRx_data_0E3(  ),
/*0390*/    .pcRx_data_0E4(  ),
/*0394*/    .pcRx_data_0E5(  ),
/*0398*/    .pcRx_data_0E6(  ),
/*039C*/    .pcRx_data_0E7(  ),
/*03A0*/    .pcRx_data_0E8(  ),
/*03A4*/    .pcRx_data_0E9(  ),
/*03A8*/    .pcRx_data_0EA(  ),
/*03AC*/    .pcRx_data_0EB(  ),
/*03B0*/    .pcRx_data_0EC(  ),
/*03B4*/    .pcRx_data_0ED(  ),
/*03B8*/    .pcRx_data_0EE(  ),
/*03BC*/    .pcRx_data_0EF(  ),
/*03C0*/    .pcRx_data_0F0(  ),
/*03C4*/    .pcRx_data_0F1(  ),
/*03C8*/    .pcRx_data_0F2(  ),
/*03CC*/    .pcRx_data_0F3(  ),
/*03D0*/    .pcRx_data_0F4(  ),
/*03D4*/    .pcRx_data_0F5(  ),
/*03D8*/    .pcRx_data_0F6(  ),
/*03DC*/    .pcRx_data_0F7(  ),
/*03E0*/    .pcRx_data_0F8(  ),
/*03E4*/    .pcRx_data_0F9(  ),
/*03E8*/    .pcRx_data_0FA(  ),
/*03EC*/    .pcRx_data_0FB(  ),
/*03F0*/    .pcRx_data_0FC(  ),
/*03F4*/    .pcRx_data_0FD(  ),
/*03F8*/    .pcRx_data_0FE(  ),
/*03FC*/    .pcRx_data_0FF(  ),
/*0400*/    .pcRx_data_100(  ),                                                                                    
/*0404*/    .pcRx_data_101(  ),                                                                                     
/*0408*/    .pcRx_data_102(  ),
/*040C*/    .pcRx_data_103(  ),
/*0410*/    .pcRx_data_104(  ),
/*0414*/    .pcRx_data_105(  ),
/*0418*/    .pcRx_data_106(  ),
/*041C*/    .pcRx_data_107(  ),
/*0420*/    .pcRx_data_108(  ),
/*0424*/    .pcRx_data_109(  ),
/*0428*/    .pcRx_data_10A(  ),
/*042C*/    .pcRx_data_10B(  ),
/*0430*/    .pcRx_data_10C(  ),
/*0434*/    .pcRx_data_10D(  ),
/*0438*/    .pcRx_data_10E(  ),
/*043C*/    .pcRx_data_10F(  ),
/*0440*/    .pcRx_data_110(  ),
/*0444*/    .pcRx_data_111(  ),
/*0448*/    .pcRx_data_112(  ),
/*044C*/    .pcRx_data_113(  ),
/*0450*/    .pcRx_data_114(  ),
/*0454*/    .pcRx_data_115(  ),
/*0458*/    .pcRx_data_116(  ),
/*045C*/    .pcRx_data_117(  ),
/*0460*/    .pcRx_data_118(  ),
/*0464*/    .pcRx_data_119(  ),
/*0468*/    .pcRx_data_11A(  ),
/*046C*/    .pcRx_data_11B(  ),
/*0470*/    .pcRx_data_11C(  ),
/*0474*/    .pcRx_data_11D(  ),
/*0478*/    .pcRx_data_11E(  ),
/*047C*/    .pcRx_data_11F(  ),
/*0480*/    .pcRx_data_120(  ),
/*0484*/    .pcRx_data_121(  ),
/*0488*/    .pcRx_data_122(  ),
/*048C*/    .pcRx_data_123(  ),
/*0490*/    .pcRx_data_124(  ),
/*0494*/    .pcRx_data_125(  ),
/*0498*/    .pcRx_data_126(  ),
/*049C*/    .pcRx_data_127(  ),
/*04A0*/    .pcRx_data_128(  ),
/*04A4*/    .pcRx_data_129(  ),
/*04A8*/    .pcRx_data_12A(  ),
/*04AC*/    .pcRx_data_12B(  ),
/*04B0*/    .pcRx_data_12C(  ),
/*04B4*/    .pcRx_data_12D(  ),
/*04B8*/    .pcRx_data_12E(  ),
/*04BC*/    .pcRx_data_12F(  ),
/*04C0*/    .pcRx_data_130(  ),
/*04C4*/    .pcRx_data_131(  ),
/*04C8*/    .pcRx_data_132(  ),
/*04CC*/    .pcRx_data_133(  ),
/*04D0*/    .pcRx_data_134(  ),
/*04D4*/    .pcRx_data_135(  ),
/*04D8*/    .pcRx_data_136(  ),
/*04DC*/    .pcRx_data_137(  ),
/*04E0*/    .pcRx_data_138(  ),
/*04E4*/    .pcRx_data_139(  ),
/*04E8*/    .pcRx_data_13A(  ),
/*04EC*/    .pcRx_data_13B(  ),
/*04F0*/    .pcRx_data_13C(  ),
/*04F4*/    .pcRx_data_13D(  ),
/*04F8*/    .pcRx_data_13E(  ),
/*04FC*/    .pcRx_data_13F(  ),
/*0500*/    .pcRx_data_140(  ),
/*0504*/    .pcRx_data_141(  ),
/*0508*/    .pcRx_data_142(  ),
/*050C*/    .pcRx_data_143(  ),
/*0510*/    .pcRx_data_144(  ),
/*0514*/    .pcRx_data_145(  ),
/*0518*/    .pcRx_data_146(  ),
/*051C*/    .pcRx_data_147(  ),
/*0520*/    .pcRx_data_148(  ),
/*0524*/    .pcRx_data_149(  ),
/*0528*/    .pcRx_data_14A(  ),
/*052C*/    .pcRx_data_14B(  ),
/*0530*/    .pcRx_data_14C(  ),
/*0534*/    .pcRx_data_14D(  ),
/*0538*/    .pcRx_data_14E(  ),
/*053C*/    .pcRx_data_14F(  ),
/*0540*/    .pcRx_data_150(  ),
/*0544*/    .pcRx_data_151(  ),
/*0548*/    .pcRx_data_152(  ),
/*054C*/    .pcRx_data_153(  ),
/*0550*/    .pcRx_data_154(  ),
/*0554*/    .pcRx_data_155(  ),
/*0558*/    .pcRx_data_156(  ),
/*055C*/    .pcRx_data_157(  ),
/*0560*/    .pcRx_data_158(  ),
/*0564*/    .pcRx_data_159(  ),
/*0568*/    .pcRx_data_15A(  ),
/*056C*/    .pcRx_data_15B(  ),
/*0570*/    .pcRx_data_15C(  ),
/*0574*/    .pcRx_data_15D(  ),
/*0578*/    .pcRx_data_15E(  ),
/*057C*/    .pcRx_data_15F(  ),
/*0580*/    .pcRx_data_160(  ),
/*0584*/    .pcRx_data_161(  ),
/*0588*/    .pcRx_data_162(  ),
/*058C*/    .pcRx_data_163(  ),
/*0590*/    .pcRx_data_164(  ),
/*0594*/    .pcRx_data_165(  ),
/*0598*/    .pcRx_data_166(  ),
/*059C*/    .pcRx_data_167(  ),
/*05A0*/    .pcRx_data_168(  ),
/*05A4*/    .pcRx_data_169(  ),
/*05A8*/    .pcRx_data_16A(  ),
/*05AC*/    .pcRx_data_16B(  ),
/*05B0*/    .pcRx_data_16C(  ),
/*05B4*/    .pcRx_data_16D(  ),
/*05B8*/    .pcRx_data_16E(  ),
/*05BC*/    .pcRx_data_16F(  ),
/*05C0*/    .pcRx_data_170(  ),
/*05C4*/    .pcRx_data_171(  ),
/*05C8*/    .pcRx_data_172(  ),
/*05CC*/    .pcRx_data_173(  ),
/*05D0*/    .pcRx_data_174(  ),
/*05D4*/    .pcRx_data_175(  ),
/*05D8*/    .pcRx_data_176(  ),
/*05DC*/    .pcRx_data_177(  ),
/*05E0*/    .pcRx_data_178(  ),
/*05E4*/    .pcRx_data_179(  ),
/*05E8*/    .pcRx_data_17A(  ),
/*05EC*/    .pcRx_data_17B(  ),
/*05F0*/    .pcRx_data_17C(  ),
/*05F4*/    .pcRx_data_17D(  ),
/*05F8*/    .pcRx_data_17E(  ),
/*05FC*/    .pcRx_data_17F(  ),
/*0600*/    .pcRx_data_180(  ),
/*0604*/    .pcRx_data_181(  ),
/*0608*/    .pcRx_data_182(  ),
/*060C*/    .pcRx_data_183(  ),
/*0610*/    .pcRx_data_184(  ),
/*0614*/    .pcRx_data_185(  ),
/*0618*/    .pcRx_data_186(  ),
/*061C*/    .pcRx_data_187(  ),
/*0620*/    .pcRx_data_188(  ),
/*0624*/    .pcRx_data_189(  ),
/*0628*/    .pcRx_data_18A(  ),
/*062C*/    .pcRx_data_18B(  ),
/*0630*/    .pcRx_data_18C(  ),
/*0634*/    .pcRx_data_18D(  ),
/*0638*/    .pcRx_data_18E(  ),
/*063C*/    .pcRx_data_18F(  ),
/*0640*/    .pcRx_data_190(  ),
/*0644*/    .pcRx_data_191(  ),
/*0648*/    .pcRx_data_192(  ),
/*064C*/    .pcRx_data_193(  ),
/*0650*/    .pcRx_data_194(  ),
/*0654*/    .pcRx_data_195(  ),
/*0658*/    .pcRx_data_196(  ),
/*065C*/    .pcRx_data_197(  ),
/*0660*/    .pcRx_data_198(  ),
/*0664*/    .pcRx_data_199(  ),
/*0668*/    .pcRx_data_19A(  ),
/*066C*/    .pcRx_data_19B(  ),
/*0670*/    .pcRx_data_19C(  ),
/*0674*/    .pcRx_data_19D(  ),
/*0678*/    .pcRx_data_19E(  ),
/*067C*/    .pcRx_data_19F(  ),
/*0680*/    .pcRx_data_1A0(  ),
/*0684*/    .pcRx_data_1A1(  ),
/*0688*/    .pcRx_data_1A2(  ),
/*068C*/    .pcRx_data_1A3(  ),
/*0690*/    .pcRx_data_1A4(  ),
/*0694*/    .pcRx_data_1A5(  ),
/*0698*/    .pcRx_data_1A6(  ),
/*069C*/    .pcRx_data_1A7(  ),
/*06A0*/    .pcRx_data_1A8(  ),
/*06A4*/    .pcRx_data_1A9(  ),
/*06A8*/    .pcRx_data_1AA(  ),
/*06AC*/    .pcRx_data_1AB(  ),
/*06B0*/    .pcRx_data_1AC(  ),
/*06B4*/    .pcRx_data_1AD(  ),
/*06B8*/    .pcRx_data_1AE(  ),
/*06BC*/    .pcRx_data_1AF(  ),
/*06C0*/    .pcRx_data_1B0(  ),
/*06C4*/    .pcRx_data_1B1(  ),
/*06C8*/    .pcRx_data_1B2(  ),
/*06CC*/    .pcRx_data_1B3(  ),
/*06D0*/    .pcRx_data_1B4(  ),
/*06D4*/    .pcRx_data_1B5(  ),
/*06D8*/    .pcRx_data_1B6(  ),
/*06DC*/    .pcRx_data_1B7(  ),
/*06E0*/    .pcRx_data_1B8(  ),
/*06E4*/    .pcRx_data_1B9(  ),
/*06E8*/    .pcRx_data_1BA(  ),
/*06EC*/    .pcRx_data_1BB(  ),
/*06F0*/    .pcRx_data_1BC(  ),
/*06F4*/    .pcRx_data_1BD(  ),
/*06F8*/    .pcRx_data_1BE(  ),
/*06FC*/    .pcRx_data_1BF(  ),
/*0700*/    .pcRx_data_1C0(  ),
/*0704*/    .pcRx_data_1C1(  ),
/*0708*/    .pcRx_data_1C2(  ),
/*070C*/    .pcRx_data_1C3(  ),
/*0710*/    .pcRx_data_1C4(  ),
/*0714*/    .pcRx_data_1C5(  ),
/*0718*/    .pcRx_data_1C6(  ),
/*071C*/    .pcRx_data_1C7(  ),
/*0720*/    .pcRx_data_1C8(  ),
/*0724*/    .pcRx_data_1C9(  ),
/*0728*/    .pcRx_data_1CA(  ),
/*072C*/    .pcRx_data_1CB(  ),
/*0730*/    .pcRx_data_1CC(  ),
/*0734*/    .pcRx_data_1CD(  ),
/*0738*/    .pcRx_data_1CE(  ),
/*073C*/    .pcRx_data_1CF(  ),
/*0740*/    .pcRx_data_1D0(  ),
/*0744*/    .pcRx_data_1D1(  ),
/*0748*/    .pcRx_data_1D2(  ),
/*074C*/    .pcRx_data_1D3(  ),
/*0750*/    .pcRx_data_1D4(  ),
/*0754*/    .pcRx_data_1D5(  ),
/*0758*/    .pcRx_data_1D6(  ),
/*075C*/    .pcRx_data_1D7(  ),
/*0760*/    .pcRx_data_1D8(  ),
/*0764*/    .pcRx_data_1D9(  ),
/*0768*/    .pcRx_data_1DA(  ),
/*076C*/    .pcRx_data_1DB(  ),
/*0770*/    .pcRx_data_1DC(  ),
/*0774*/    .pcRx_data_1DD(  ),
/*0778*/    .pcRx_data_1DE(  ),
/*077C*/    .pcRx_data_1DF(  ),
/*0780*/    .pcRx_data_1E0(  ),
/*0784*/    .pcRx_data_1E1(  ),
/*0788*/    .pcRx_data_1E2(  ),
/*078C*/    .pcRx_data_1E3(  ),
/*0790*/    .pcRx_data_1E4(  ),
/*0794*/    .pcRx_data_1E5(  ),
/*0798*/    .pcRx_data_1E6(  ),
/*079C*/    .pcRx_data_1E7(  ),
/*07A0*/    .pcRx_data_1E8(  ),
/*07A4*/    .pcRx_data_1E9(  ),
/*07A8*/    .pcRx_data_1EA(  ),
/*07AC*/    .pcRx_data_1EB(  ),
/*07B0*/    .pcRx_data_1EC(  ),
/*07B4*/    .pcRx_data_1ED(  ),
/*07B8*/    .pcRx_data_1EE(  ),
/*07BC*/    .pcRx_data_1EF(  ),
/*07C0*/    .pcRx_data_1F0(  ),
/*07C4*/    .pcRx_data_1F1(  ),
/*07C8*/    .pcRx_data_1F2(  ),
/*07CC*/    .pcRx_data_1F3(  ),
/*07D0*/    .pcRx_data_1F4(  ),
/*07D4*/    .pcRx_data_1F5(  ),
/*07D8*/    .pcRx_data_1F6(  ),
/*07DC*/    .pcRx_data_1F7(  ),
/*07E0*/    .pcRx_data_1F8(  ),
/*07E4*/    .pcRx_data_1F9(  ),
/*07E8*/    .pcRx_data_1FA(  ),
/*07EC*/    .pcRx_data_1FB(  ),
/*07F0*/    .pcRx_data_1FC(  ),
/*07F4*/    .pcRx_data_1FD(  ),
/*07F8*/    .pcRx_data_1FE(  ),
/*07FC*/    .pcRx_data_1FF(  )
    );
				

	
	
	
	
	
	
	
	
	
	
	
	


endmodule
