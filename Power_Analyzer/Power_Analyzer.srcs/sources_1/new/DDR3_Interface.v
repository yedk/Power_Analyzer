`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/16 18:45:51
// Design Name: 
// Module Name: DDR3_Interface
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


module DDR3_Interface(
  
    input  wren,
    input  rden,
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
   output                 c1_ddr3_ras_n,
   output                 c1_ddr3_cas_n,
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
   // System reset - Default polarity of sys_rst pin is Active Low.
   // System reset polarity will change based on the option 
   // selected in GUI.
   input rd_c0,
   input rd_c1,
   output ddr_c0_wr,
   output ddr_c1_wr,
   output rd_done,
   input [29:0] addr_rd_init,
   input [28:0] rd_init_length,
   
   input                 sys_rst_n,
   input                 ddr3_sys_clk_i,
   input clk_100M,
   input clk_50M,
   input [4:0]test_depth,
   input ddr3_start_pingpang,
   
   input  pcie_prog_full,
   input [7:0]buff_full_thresh,
   input ddr3_rd_en,
   output ddr3_fifo_valid,
   output ddr3_fifo_empty,
   output ddr_buffer_full,
   output[127:0]  app_rd_data_to_pcie
   );
   
    
  // user interface signals
  wire[15:0]       ddr_c0_trans_data; 
  wire[15:0]       ddr_c1_trans_data;
  wire [29:0]      c0_app_addr;
  wire [2:0]       c0_app_cmd;
  wire             c0_app_en;
  wire [31:0]      c0_app_wdf_data;
  wire             c0_app_wdf_end;
  wire [3:0]       c0_app_wdf_mask;
  wire             c0_app_wdf_wren;
  wire [31:0]      c0_app_rd_data;
  wire             c0_app_rd_data_end;
  wire             c0_app_rd_data_valid;
  wire             c0_app_rdy;
  wire             c0_app_wdf_rdy;
  wire             c0_app_sr_req;
  wire             c0_app_ref_req;
  wire             c0_app_zq_req;
  wire             c0_app_sr_active;
  wire             c0_app_ref_ack;
  wire             c0_app_zq_ack;
  wire             c0_ui_clk;
  wire             c0_ui_clk_sync_rst;
  wire             c0_init_calib_complete;
  wire             c0_wr_burst_data_req;
 
  // user interface signals
  wire [29:0]      c1_app_addr;
  wire [2:0]       c1_app_cmd;
  wire             c1_app_en;
  wire [31:0]      c1_app_wdf_data;
  wire             c1_app_wdf_end;
  wire [3:0]       c1_app_wdf_mask;
  wire             c1_app_wdf_wren;
  wire [31:0]      c1_app_rd_data;
  wire             c1_app_rd_data_end;
  wire             c1_app_rd_data_valid;
  wire             c1_app_rdy;
  wire             c1_app_wdf_rdy;
  wire             c1_app_sr_req;
  wire             c1_app_ref_req;
  wire             c1_app_zq_req;
  wire             c1_app_sr_active;
  wire             c1_app_ref_ack;
  wire             c1_app_zq_ack;
  wire             c1_ui_clk;
  wire             c1_ui_clk_sync_rst;
  wire             c1_init_calib_complete;    
  /*
  // user interface signals
  wire [29:0]      c2_app_addr;
  wire [2:0]       c2_app_cmd;
  wire             c2_app_en;
  wire [31:0]      c2_app_wdf_data;
  wire             c2_app_wdf_end;
  wire [3:0]       c2_app_wdf_mask;
  wire             c2_app_wdf_wren;
  wire [31:0]      c2_app_rd_data;
  wire             c2_app_rd_data_end;
  wire             c2_app_rd_data_valid;
  wire             c2_app_rdy;
  wire             c2_app_wdf_rdy;
  wire             c2_app_sr_req;
  wire             c2_app_ref_req;
  wire             c2_app_zq_req;
  wire             c2_app_sr_active;
  wire             c2_app_ref_ack;
  wire             c2_app_zq_ack;
  wire             c2_ui_clk;
  wire             c2_ui_clk_sync_rst;
  wire             c2_init_calib_complete;     
 */
/* 
  clk_wiz_1 clk_wiz_0_inst
   (
    // Clock out ports
    .clk_out1(c0_sys_clk_i),     // output clk_out1
    .clk_out2(c1_sys_clk_i),     // output clk_out2
    .clk_out3(c2_sys_clk_i),     // output clk_out3
    // Status and control signals
    .reset(0),            // input reset active high
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk_50m));      // input clk_in1
*/
    

 mig_7series_0 u_mig_7series_0 (

    // Memory interface ports
    .c0_ddr3_addr                      (c0_ddr3_addr),             // output [15:0]		
    .c0_ddr3_ba                        (c0_ddr3_ba),               // output [2:0]		
    .c0_ddr3_cas_n                     (c0_ddr3_cas_n),            // output			    
    .c0_ddr3_ck_n                      (c0_ddr3_ck_n),             // output [0:0]		
    .c0_ddr3_ck_p                      (c0_ddr3_ck_p),             // output [0:0]		
    .c0_ddr3_cke                       (c0_ddr3_cke),              // output [0:0]		
    .c0_ddr3_ras_n                     (c0_ddr3_ras_n),            // output			  
    .c0_ddr3_reset_n                   (c0_ddr3_reset_n),          // output			
    .c0_ddr3_we_n                      (c0_ddr3_we_n),             // output			    
    .c0_ddr3_dq                        (c0_ddr3_dq),               // inout [7:0]		  
    .c0_ddr3_dqs_n                     (c0_ddr3_dqs_n),            // inout [0:0]		
    .c0_ddr3_dqs_p                     (c0_ddr3_dqs_p),            // inout [0:0]		
    .c0_init_calib_complete            (c0_init_calib_complete),   // output			
      
	  .c0_ddr3_cs_n                      (c0_ddr3_cs_n),             // output [0:0]	
    .c0_ddr3_dm                        (c0_ddr3_dm),               // output [0:0]		
    .c0_ddr3_odt                       (c0_ddr3_odt),              // output [0:0]	
    // Application interface ports
    .c0_app_addr                       (c0_app_addr),              // input [29:0]	
    .c0_app_cmd                        (c0_app_cmd),               // input [2:0]		
    .c0_app_en                         (c0_app_en),                // input				  
    .c0_app_wdf_data                   (c0_app_wdf_data),          // input [31:0]		
    .c0_app_wdf_end                    (c0_app_wdf_end),           // input				
    .c0_app_wdf_wren                   (c0_app_wdf_wren),          // input				
    .c0_app_rd_data                    (c0_app_rd_data),           // output [31:0]	
    .c0_app_rd_data_end                (c0_app_rd_data_end),       // output			  
    .c0_app_rd_data_valid              (c0_app_rd_data_valid),     // output			  
    .c0_app_rdy                        (c0_app_rdy),               // output			c0_app_rdy
    .c0_app_wdf_rdy                    (c0_app_wdf_rdy),           // output			c0_app_wdf_rdy
    .c0_app_sr_req                     (1'b0),                     // input			//I，datasheet上表示要接地，置为0                     
    .c0_app_ref_req                    (1'b0),                     // input		//I，高有效，表示mig控制器发送了一个更新的命令给DRAM 
    .c0_app_zq_req                     (1'b0),                     // input			//I，高有效，表示ZQ校准命令被发送给了DRAM            
    .c0_app_sr_active                  (c0_app_sr_active),         // output			
    .c0_app_ref_ack                    (c0_app_ref_ack),           // output			
    .c0_app_zq_ack                     (c0_app_zq_ack),            // output			
    .c0_ui_clk                         (c0_ui_clk),                // output			
    .c0_ui_clk_sync_rst                (c0_ui_clk_sync_rst),       // output			
    .c0_app_wdf_mask                   (4'h0),                     // input [3:0]	
    // System Clock Ports
    .c0_sys_clk_i                       (ddr3_sys_clk_i),            // input			
    
    
    // Memory interface ports
    .c1_ddr3_addr                      (c1_ddr3_addr),             // output [15:0]		
    .c1_ddr3_ba                        (c1_ddr3_ba),               // output [2:0]		
    .c1_ddr3_cas_n                     (c1_ddr3_cas_n),            // output			 
    .c1_ddr3_ck_n                      (c1_ddr3_ck_n),             // output [0:0]	
    .c1_ddr3_ck_p                      (c1_ddr3_ck_p),             // output [0:0]	
    .c1_ddr3_cke                       (c1_ddr3_cke),              // output [0:0]	
    .c1_ddr3_ras_n                     (c1_ddr3_ras_n),            // output			 
    .c1_ddr3_reset_n                   (c1_ddr3_reset_n),          // output			 
    .c1_ddr3_we_n                      (c1_ddr3_we_n),             // output			 
    .c1_ddr3_dq                        (c1_ddr3_dq),               // inout [7:0]		
    .c1_ddr3_dqs_n                     (c1_ddr3_dqs_n),            // inout [0:0]		
    .c1_ddr3_dqs_p                     (c1_ddr3_dqs_p),            // inout [0:0]		
    .c1_init_calib_complete            (c1_init_calib_complete),   // output			
      
	  .c1_ddr3_cs_n                      (c1_ddr3_cs_n),             // output [0:0]		
    .c1_ddr3_dm                        (c1_ddr3_dm),               // output [0:0]		
    .c1_ddr3_odt                       (c1_ddr3_odt),              // output [0:0]		
    // Application interface ports
    .c1_app_addr                       (c1_app_addr),              // input [29:0]	
    .c1_app_cmd                        (c1_app_cmd),               // input [2:0]		
    .c1_app_en                         (c1_app_en),                // input				  
    .c1_app_wdf_data                   (c1_app_wdf_data),          // input [31:0]	
    .c1_app_wdf_end                    (c1_app_wdf_end),           // input				  
    .c1_app_wdf_wren                   (c1_app_wdf_wren),          // input				  
    .c1_app_rd_data                    (c1_app_rd_data),           // output [31:0]	
    .c1_app_rd_data_end                (c1_app_rd_data_end),       // output		
    .c1_app_rd_data_valid              (c1_app_rd_data_valid),     // output		
    .c1_app_rdy                        (c1_app_rdy),               // output		
    .c1_app_wdf_rdy                    (c1_app_wdf_rdy),           // output		
    .c1_app_sr_req                     (1'b0),                     // input			
    .c1_app_ref_req                    (1'b0),                     // input			
    .c1_app_zq_req                     (1'b0),                     // input			
    .c1_app_sr_active                  (c1_app_sr_active),         // output		
    .c1_app_ref_ack                    (c1_app_ref_ack),           // output		
    .c1_app_zq_ack                     (c1_app_zq_ack),            // output		
    .c1_ui_clk                         (c1_ui_clk),                // output		
    .c1_ui_clk_sync_rst                (c1_ui_clk_sync_rst),       // output		
    .c1_app_wdf_mask                   (4'h0),                     // input [3:0]		
    // System Clock Ports
    .c1_sys_clk_i                       (ddr3_sys_clk_i),           // input			*/   
    // Memory interface ports                                     
    
    
   /* 
    
    .c2_ddr3_addr                      (c2_ddr3_addr),             // output [15:0]
    .c2_ddr3_ba                        (c2_ddr3_ba),               // output [2:0]	
    .c2_ddr3_cas_n                     (c2_ddr3_cas_n),            // output			 
    .c2_ddr3_ck_n                      (c2_ddr3_ck_n),             // output [0:0]	
    .c2_ddr3_ck_p                      (c2_ddr3_ck_p),             // output [0:0]	
    .c2_ddr3_cke                       (c2_ddr3_cke),              // output [0:0]	
    .c2_ddr3_ras_n                     (c2_ddr3_ras_n),            // output			 
    .c2_ddr3_reset_n                   (c2_ddr3_reset_n),          // output			 
    .c2_ddr3_we_n                      (c2_ddr3_we_n),             // output			 
    .c2_ddr3_dq                        (c2_ddr3_dq),               // inout [7:0]		
    .c2_ddr3_dqs_n                     (c2_ddr3_dqs_n),            // inout [0:0]		
    .c2_ddr3_dqs_p                     (c2_ddr3_dqs_p),            // inout [0:0]		
    .c2_init_calib_complete            (c2_init_calib_complete),   // output			 
      
	  .c2_ddr3_cs_n                      (c2_ddr3_cs_n),             // output [0:0]	
    .c2_ddr3_dm                        (c2_ddr3_dm),               // output [0:0]	
    .c2_ddr3_odt                       (c2_ddr3_odt),              // output [0:0]	
    // Application interface ports
    .c2_app_addr                       (c2_app_addr),              // input [29:0]	
    .c2_app_cmd                        (c2_app_cmd),               // input [2:0]		
    .c2_app_en                         (c2_app_en),                // input				 
    .c2_app_wdf_data                   (c2_app_wdf_data),          // input [31:0]	
    .c2_app_wdf_end                    (c2_app_wdf_end),           // input				 
    .c2_app_wdf_wren                   (c2_app_wdf_wren),          // input				 
    .c2_app_rd_data                    (c2_app_rd_data),           // output [31:0]
    .c2_app_rd_data_end                (c2_app_rd_data_end),       // output			 
    .c2_app_rd_data_valid              (c2_app_rd_data_valid),     // output			 
    .c2_app_rdy                        (c2_app_rdy),               // output			 
    .c2_app_wdf_rdy                    (c2_app_wdf_rdy),           // output			 
    .c2_app_sr_req                     (1'b0),                     // input			   
    .c2_app_ref_req                    (1'b0),                     // input			   
    .c2_app_zq_req                     (1'b0),                     // input			   
    .c2_app_sr_active                  (c2_app_sr_active),         // output			 
    .c2_app_ref_ack                    (c2_app_ref_ack),           // output			 
    .c2_app_zq_ack                     (c2_app_zq_ack),            // output			 
    .c2_ui_clk                         (c2_ui_clk),                // output			 
    .c2_ui_clk_sync_rst                (c2_ui_clk_sync_rst),       // output			 
    .c2_app_wdf_mask                   (4'h0),                     // input [3:0]		
    // System Clock Ports 
    .c2_sys_clk_i                       (ddr3_sys_clk_i),            // input			
    */
      
    .sys_rst                        (sys_rst_n)                      // input        
    );
    
   //乒乓fifo打出来的数据流 
  wire wrd_control; 
  wire [28:0]num_DIMM_depth_count;      
  wire c0_c1_fifo_prog_full;
  wire rd_done;
  wire [28:0]rd_init_length;
   
   assign rd_done= rd_done_c0||rd_done_c1;
   
   PINPAN_CO_and_C1(    
     .clk_f              (clk_50M),
     .rst_n              (!c0_ui_clk_sync_rst),   
     .clk_100M           (clk_100M),
     .ddr3_c0            (ddr_c0_trans_data),    //data_to_c0;
     .ddr3_c1            (ddr_c1_trans_data),  
     .sync_en_adc_c0        (sync_en_adc_c0),    //valid_from_c0;
     .sync_en_adc_c1        (sync_en_adc_c1),
     .c0_wr_burst_req    (c0_wr_burst_data_req ),//in
     .fenliu_stream_flag (fenliu_stream_flag),   //out
     .init_done_c0       (init_done_c0),  //in
     .init_done_c1       (init_done_c1),  //in
     .start_pingpang     (ddr3_start_pingpang),//in
     .count_depth        (num_DIMM_depth_count), //
     .wen_ddr3_c0        (wen_ddr3_c0),//out
     .ren_ddr3_c0        (ren_ddr3_c0),//out
     .wen_ddr3_c1        (wen_ddr3_c1),//out
     .ren_ddr3_c1        (ren_ddr3_c1) //out
     
    );
    //乒乓开始的vio控制
   vio_1 wrrd (
     .clk(c0_ui_clk),                // input wire clk
     //.probe_in0(probe_in0),    // input wire [0 : 0] probe_in0
     //.probe_in1(probe_in1),    // input wire [0 : 0] probe_in1
     //.probe_in2(probe_in2),    // input wire [0 : 0] probe_in2
     .probe_out0(wren_byvio),  // output wire [0 : 0] probe_out0
     .probe_out1(rden_byvio),  // output wire [0 : 0] probe_out1  
     .probe_out2(start_pingpang)
     
    // .probe_out2(auto_rd_en)  // output wire [0 : 0] probe_out2
   ); 
                          
   //****************************************C0第一片的SDRAM的使用接口例化原语**********************************//  
      
  ddr3_mig_driver
       	ddr3_mig_driver_c0(       
       .clk_100M           (clk_100M),
       .clk_f              (clk_50M),
       .ui_clk             (c0_ui_clk),                             //I    
       .rst_n              (!c0_ui_clk_sync_rst),                                //I                                            
       .init_calib_complete(c0_init_calib_complete ),               //I
       .app_rdy            (c0_app_rdy),                            //I
       .app_rd_data        (c0_app_rd_data ),                       //I     
       .app_rd_data_valid  (c0_app_rd_data_valid ),                 //I     
       .app_rd_data_end    (c0_app_rd_data_end ),                   //I     
       .app_wdf_rdy        (c0_app_wdf_rdy ),                       //I                                               
                                                
       .app_cmd            (c0_app_cmd ),                           //O     
       .app_en             (c0_app_en ),                            //O     
       .app_addr           (c0_app_addr ),                          //O
       .app_wdf_wren       (c0_app_wdf_wren ),                      //O  
       .app_wdf_data       (c0_app_wdf_data),    
       .app_wdf_end        (c0_app_wdf_end ),                       //O     
       .app_wdf_mask       (c0_app_wdf_mask ),                      //O      
       .ddr_data           (ddr_c0_trans_data),            //in
       .sync_en_adc        (sync_en_adc_c0),               //in
       .fenliu_stream_flag (fenliu_stream_flag),           //in
       .pcie_prog_full (),                         //in
       .init_done          (init_done_c0),                 //o
       .num_DIMM_depth     (num_DIMM_depth_count),               //o           
       
       
       .wr_burst_data_req  (c0_wr_burst_data_req),       
      // .rd_burst_finish    (rd_burst_finish),                      /*读完成*由状态机的状态输出表征*/ 
      // .wr_burst_finish    (wr_burst_finish),                      /*写完成*由状态机的状态输出表征*/ 
       
       .DIMMdepth_ctrl     (test_depth),//(c0_DIMMdepth_ctrl),                      //存储深度控制32K
       .predepth           (1'b0),//(c0_predepth),                      //预触发深度                                            
               
       .DIMMdepth_mode     (1'b0),//(1'b0),
       .addr_trig_ddr3     (),//(c0_addr_trig_ddr3),     //O触发地址
       .wen_ddr3           (wen_ddr3_c0),//(c0_wen_ddr3),           //I上位机发送写使能
       .ren_ddr3           (rd_c0),//(c0_ren_ddr3),           //I上位机发送读使能
       
       .rd_init_length(rd_init_length),
       .rd_done0	(rd_done_c0),
       .ddr_c0_wr0  (ddr_c0_wr),
       .c0_c1_fifo_prog_full(c0_c1_fifo_prog_full),
     //  .auto_rd_en         (auto_rd_en),//(c0_auto_rd_en),         //I读触发信号
       .addr_wr_init       (4'b0),//(c0_addr_wr_init),      //I写初始地址
       .addr_rd_init       (addr_rd_init),//(c0_addr_rd_init)      //I读初始地址
       .ch_num             (4'd0) //(ch_num)             //仅用于测试,模拟一个通道
       );
                        
  //******************************************C1第二片的SDRAM的使用接口例化原语******************************************//            
    
    ddr3_mig_driver_c1
       	ddr3_mig_driver_c1(       
       .clk_100M           (clk_100M),
       .clk_f              (clk_50M),
       .ui_clk             (c1_ui_clk),                          //I    
       .rst_n              (!c1_ui_clk_sync_rst ),                                    //I                                                    
       .init_calib_complete(c1_init_calib_complete ),               //I
       .app_rdy            (c1_app_rdy),                            //I
       .app_rd_data        (c1_app_rd_data ),                       //I     
       .app_rd_data_valid  (c1_app_rd_data_valid ),                 //I     
       .app_rd_data_end    (c1_app_rd_data_end ),                   //I     
       .app_wdf_rdy        (c1_app_wdf_rdy ),                       //I                                               
                                                
       .app_cmd            (c1_app_cmd ),                           //O     
       .app_en             (c1_app_en ),                            //O     
       .app_addr           (c1_app_addr ),                          //O
       .app_wdf_wren       (c1_app_wdf_wren ),                      //O  
       .app_wdf_data       (c1_app_wdf_data),    
       .app_wdf_end        (c1_app_wdf_end ),                       //O     
       .app_wdf_mask       (c1_app_wdf_mask ),                      //O  
       
       .rd_init_length(rd_init_length),
       .rd_done1	(rd_done_c1),
       .ddr_c1_wr(ddr_c1_wr),
       .c0_c1_fifo_prog_full (c0_c1_fifo_prog_full),
       .ddr_data           (ddr_c1_trans_data),                   //in 待存入的数据流来源
       .sync_en_adc        (sync_en_adc_c1),                      //in
       .fenliu_stream_flag (~fenliu_stream_flag),                 //in
       .pcie_prog_full (pcie_prog_full),                                  //in
       .init_done          (init_done_c1),                        //o
       
                          
       .DIMMdepth_ctrl     (test_depth),//(c1_DIMMdepth_ctrl),                      //存储深度控制
       .predepth           (1'b0),//(c1_predepth),                      //预触发深度                                                           
       .DIMMdepth_mode     (1'b0),//(1'b0),       
       .wen_ddr3           (wen_ddr3_c1),//(c1_wen_ddr3),           //I上位机发送写使能
       .ren_ddr3           (rd_c1),//(c1_ren_ddr3),           //I上位机发送读使能
    //   .auto_rd_en         (),//(c1_auto_rd_en),         //I读触发信号
       .addr_wr_init       (4'b0),//(c1_addr_wr_init),      //I写初始地址
       .addr_rd_init       (addr_rd_init),//(c1_addr_rd_init),      //I读初始地址
       .ch_num             (4'b0)//(ch_num)             //仅用于测试
       );   

 //乒乓存储后的数据流进行下行FIFO跨时域转换 
 wire c0_c1_data_rd;   
 wire c0_c1_empty;
 assign c0_c1_data_rd = (!ddr_buffer_full)&(!c0_c1_empty);

wire c0_c1_fifo_valid;

   C0_and_C1_rddata_to_FIFO
      C0_and_C1_rddata_to_FIFO   (    
     .c0_ui_clk						(c0_ui_clk),
     .c1_ui_clk                       (c1_ui_clk),
     .rst_n                           (!c0_ui_clk_sync_rst),   
     .clk_100M                        (clk_100M),
     .ddr3_rd_en					(c0_c1_data_rd),
     .c0_app_rd_data_valid            (c0_app_rd_data_valid),    //data_to_c0;
     .c1_app_rd_data_valid            (c1_app_rd_data_valid),  
     .c0_app_rd_data                 (c0_app_rd_data),    //valid_from_c0;
     .c1_app_rd_data                 (c1_app_rd_data),   
     .fenliu_stream_flag             (fenliu_stream_flag),  //out  
     .DDR3_fifo_valid				(c0_c1_fifo_valid),
     .DDR3_fifo_empty			(c0_c1_empty),  
     .c0_c1_fifo_prog_full			(c0_c1_fifo_prog_full),
     .app_rd_data_to_pcie            (data_to_buffer)
     
    );
//wire [7:0] buff_full_thresh;
//wire [7:0] buff_empty_thresh;
wire [127:0]data_to_buffer;
//wire buffer_full;
//wire ddr_buffer_full;
parameter buff_empty_thresh = 8'd0;

buff_fifo buff_fifo_i (
	.clk(clk_100M),
	.srst(c0_ui_clk_sync_rst),
	.din(data_to_buffer),
	.wr_en(c0_c1_fifo_valid),
	.rd_en(ddr3_rd_en),
	.prog_empty_thresh(buff_empty_thresh[7:0]),
	.prog_full_thresh(buff_full_thresh[7:0]),
	.dout(app_rd_data_to_pcie),
	.full(),
	.empty(),
	.valid(ddr3_fifo_valid),
	.prog_full(ddr_buffer_full),
	.prog_empty(ddr3_fifo_empty)
	);
//reg c0_c1_data_error;
//reg [31:0]app_rd_data_to_pcie_r1;
//reg [31:0]app_rd_data_to_pcie_r2;

//always @ (posedge clk_100M)
//begin
//	if(!c0_ui_clk_sync_rst)
//	begin
//		app_rd_data_to_pcie_r1 <=32'd0;
//		app_rd_data_to_pcie_r2 <=32'd0;
//	end
//else if(ddr3_fifo_valid)
//	begin
//			app_rd_data_to_pcie_r1 <={app_rd_data_to_pcie[31:0]};
//			app_rd_data_to_pcie_r2 <=app_rd_data_to_pcie_r1;
//	end
//else
//	begin
//		app_rd_data_to_pcie_r1 <=app_rd_data_to_pcie_r1;
//		app_rd_data_to_pcie_r2 <=app_rd_data_to_pcie_r2;
//	end
//end


//always @(posedge clk_100M )
//begin
//	if(!c0_ui_clk_sync_rst)
//		c0_c1_data_error <= 1'b0;
//	else if(c0_app_rd_data_valid|c1_app_rd_data_valid)
//	begin 
//	if({app_rd_data_to_pcie_r1[31:16]}-{app_rd_data_to_pcie_r2[31:16]}==4'd8)
//		c0_c1_data_error <= 1'b0;
//	else
//		c0_c1_data_error <=1'b1;
//	end
//else
//		c0_c1_data_error <=1'b0;
//end

ila_6 DDR3(
.clk(clk_100M),
.probe0(
{
	ddr3_rd_en,
	c1_app_rd_data[31:0],
	data_to_buffer[127:0],
	ddr_buffer_full,
	ddr3_rd_en,     
	ddr3_fifo_empty,
	c0_c1_fifo_prog_full,
	fenliu_stream_flag,
	c0_c1_fifo_valid,
	c1_app_rd_data_valid
}
),
.probe1(
{
	c0_app_rd_data[31:0],
	buff_full_thresh[7:0],
	c0_app_rd_data_valid,
	app_rd_data_to_pcie[31:0]
}
)
);



endmodule
