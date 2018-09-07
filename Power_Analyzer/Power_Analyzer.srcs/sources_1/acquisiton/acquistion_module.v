`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:46:51 10/26/2016 
// Design Name: 
// Module Name:    acquistion_module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module acquistion_module(
    input         rst_n,
		input         adc_tx_clk,
		input [31:0] data_from_serdes_s1,     //低位：ch1  高位：ch2
		input [31:0] data_from_serdes_s2,     // ch3  ch4
		input [31:0] data_from_serdes_s3,     // ch5  ch6
		input [31:0] data_from_serdes_s4,     // ch7  ch8

		input		     ext_clk,
		input		     clk_choose,
    input [31:0] time_gap_num, //抽点系数[31:0]
    input        data_flow_mode,     //不抽点（0）/抽点（1）
    input [2:0]  acq_mode, //采集模式控制,000:正常，001：峰值，010：平均
        
    //input          pcie_wr_fifo_full,    
    output         fifo_dout_8ch_valid,
    output [127:0] fifo_dout_8ch,          //高位：ch1  ... 低位：ch8
    
    input [12:0]  prog_full_thresh,
    //input         serdes_rx_clk,
    input          fifo_write_en, //active high    
    input          fifo_rd_fpga,  
    input          fifo_rd_s0,
    output         adc_Rxdat_valid, 
    output         fifo_full,
    output         fifo_empty,
    output         prog_full           
    //input         fifo_rd_s10,
    //input         fifo_rd_s11,
    //input         fifo_rd_s20,
    //input         fifo_rd_s21,
    //input         fifo_rd_s30,
    //input         fifo_rd_s31,
    //input         fifo_rd_s40,
    //input         fifo_rd_s41,
    //input         fifo_rd_s50,
    //input         fifo_rd_s51,
    //input         fifo_rd_s60,
    //input         fifo_rd_s61,
    //input         fifo_rd_s70,
    //input         fifo_rd_s71,
    //input         fifo_rd_s80,
    //input         fifo_rd_s81,
     
   //output         adc_Rxdat_valid,    
   //output [255:0] fifo_dat_s10,
   //output [255:0] fifo_dat_s11,
   //output [255:0] fifo_dat_s20,
   //output [255:0] fifo_dat_s21,
   //output [255:0] fifo_dat_s30,
   //output [255:0] fifo_dat_s31,
   //output [255:0] fifo_dat_s40,
   //output [255:0] fifo_dat_s41,
   //output [255:0] fifo_dat_s50,
   //output [255:0] fifo_dat_s51,
   //output [255:0] fifo_dat_s60,
   //output [255:0] fifo_dat_s61,
   //output [255:0] fifo_dat_s70,
   //output [255:0] fifo_dat_s71,
   //output [255:0] fifo_dat_s80,
   //output [255:0] fifo_dat_s81,
   //
   //output         fifo_valid_s10,
   //output         fifo_valid_s11,
   //output         fifo_valid_s20,
   //output         fifo_valid_s21, 
   //output         fifo_valid_s30,
   //output         fifo_valid_s31,
   //output         fifo_valid_s40,
   //output         fifo_valid_s41, 
   //output         fifo_valid_s50,
   //output         fifo_valid_s51,
   //output         fifo_valid_s60,
   //output         fifo_valid_s61, 
   //output         fifo_valid_s70,
   //output         fifo_valid_s71,
   //output         fifo_valid_s80,
   //output         fifo_valid_s81,
   //output         fifo_full_s1,
   //output         fifo_full_s2,
   //output         fifo_full_s3,
   //output         fifo_full_s4,
   //output         fifo_full_s5,
   //output         fifo_full_s6,
   //output         fifo_full_s7,
   //output         fifo_full_s8,          
   //output         prog_full_s1,
   //output         prog_full_s2,
   //output         prog_full_s3,
   //output         prog_full_s4,
   //output         prog_full_s5,
   //output         prog_full_s6,
   //output         prog_full_s7,
   //output         prog_full_s8,
   //output         prog_empty_s1,
   //output         prog_empty_s2,
   //output         prog_empty_s3,
   //output         prog_empty_s4,
   //output         prog_empty_s5,
   //output         prog_empty_s6,
   //output         prog_empty_s7,
   //output         prog_empty_s8         
    );       
    
	wire [15:0] ch1_rx_data;
	wire [15:0] ch2_rx_data;
	wire [15:0] ch3_rx_data;
	wire [15:0] ch4_rx_data;
	wire [15:0] ch5_rx_data;
	wire [15:0] ch6_rx_data;
	wire [15:0] ch7_rx_data;
	wire [15:0] ch8_rx_data;

  reg wr_en;
	reg rd_en; 
	wire fifo_full;
  wire fifo_dout_8ch_valid;
  wire prog_full;
  wire prog_empty;
  
  wire [127:0]adc_data_8ch; 
  wire adc_Rxdat_valid;


wire			fifo_all_wen;
wire			fifo_all_wen1;
(*KEEP="TRUE"*)wire[15:0]      mulit_b;
reg     fifo_all_wen2,fifo_all_wen3;
reg     fifo_all_wen_rise;
always@(posedge adc_tx_clk)begin
	{fifo_all_wen3,fifo_all_wen2} <= {fifo_all_wen2,ext_clk};
end
always@(posedge adc_tx_clk)begin
	fifo_all_wen_rise <= (~fifo_all_wen2)&fifo_all_wen3;
end


 
assign   fifo_all_wen = (clk_choose==1'd1)? fifo_all_wen_rise:fifo_all_wen1;

	always @ (posedge adc_tx_clk)
	begin
		wr_en <= fifo_write_en & fifo_all_wen;	   
	end




//抽点模块
data_flow_wr_ctr data_flow_wr_ctr_inst (
    .rst(rst_n),	//active low		
    .fifo_wclk(adc_tx_clk), 
    .time_base(time_gap_num), //如果设置为n，则表示n抽(n最小设置为2)
    .data_flow_mode(data_flow_mode),//抽点使能，1：抽点开启，0：不抽点
    .fifo_all_wendiv( fifo_all_wen1),//计数到抽点系数时，输出高
    .a_dffs_en( ),//计数到抽点系数时，输出高
    .b_dffs_en( )   //计数到抽点系数/2时，输出高
    );


HR_mulitp_B HR_mulitp_B_inst(
    .s_clk( adc_tx_clk),
    .rst_n(rst_n ),
 	.time_base(time_gap_num ), 
 	.mulit_b(mulit_b ) 
    ); 
 
             
adc_data_process data_process_s1(
    .rst_L( rst_n  ),
	  .adc_tx_clk(adc_tx_clk ),
	  .data_from_serdes( data_from_serdes_s1 ),//采集卡1数据
    .time_gap_num( time_gap_num),
    .fifo_all_wen( fifo_all_wen ),
    .mulit_b( mulit_b ),   
	  .acq_mode( acq_mode), //采集模式控制( ),000:正常，001：峰值，010：平均
	  .adc_Rxdat_valid(adc_Rxdat_valid),
	  .ch1_rx_data(ch1_rx_data),  
	  .ch2_rx_data(ch2_rx_data)    
    //.fifo_rd_clk( serdes_rx_clk ),
    //.fifo_write_en( fifo_write_en ), //active high
    //.fifo_read_s0( fifo_rd_fpga|fifo_rd_s10 ), //active high
    //.fifo_read_s1( fifo_rd_fpga|fifo_rd_s11 ), //active high
    //.prog_full_thresh( prog_full_thresh ),
    //
    //.fifo_dout_s0 (fifo_dat_s10 ), 
    //.fifo_dout_s1( fifo_dat_s11 ),
    //.adc_Rxdat_valid(adc_Rxdat_valid ),
		//.fifo_full(fifo_full_s1 ),
		//.fifo_valid_s0( fifo_valid_s10 ),  
		//.fifo_valid_s1( fifo_valid_s11 ),  
		//.prog_full(prog_full_s1 ), 
    //.prog_empty(prog_empty_s1 ) 
    );
 
             
adc_data_process data_process_s2(
    .rst_L( rst_n  ),
	  .adc_tx_clk(adc_tx_clk ),
	  .data_from_serdes( data_from_serdes_s2 ),//采集卡1数据
    .time_gap_num( time_gap_num),
    .fifo_all_wen( fifo_all_wen ),
    .mulit_b( mulit_b ),   
	  .acq_mode( acq_mode), //采集模式控制( ),000:正常，001：峰值，010：平均 
	  .adc_Rxdat_valid(),
	  .ch1_rx_data(ch3_rx_data),  
	  .ch2_rx_data(ch4_rx_data) 
	  
    //.fifo_rd_clk( serdes_rx_clk ),
    //.fifo_write_en( fifo_write_en ), //active high
    //.fifo_read_s0( fifo_rd_fpga|fifo_rd_s20 ), //active high
    //.fifo_read_s1( fifo_rd_fpga|fifo_rd_s21 ), //active high
    //.prog_full_thresh( prog_full_thresh ),
    //
    //.fifo_dout_s0 (fifo_dat_s20 ), 
    //.fifo_dout_s1( fifo_dat_s21 ),
    //.adc_Rxdat_valid( ),
	  //.fifo_full(fifo_full_s2 ),
	  //.fifo_valid_s0( fifo_valid_s20 ),  
	  //.fifo_valid_s1( fifo_valid_s21 ),  
	  //.prog_full(prog_full_s2 ), 
    //.prog_empty(prog_empty_s2 ) 
    );             
             
adc_data_process data_process_s3(
    .rst_L( rst_n  ),
		.adc_tx_clk(adc_tx_clk ),
		.data_from_serdes( data_from_serdes_s3 ),//采集卡1数据
    .time_gap_num( time_gap_num),
    .fifo_all_wen( fifo_all_wen ),
    .mulit_b( mulit_b ),   
		.acq_mode( acq_mode), //采集模式控制( ),000:正常，001：峰值，010：平均
		.adc_Rxdat_valid(),
	  .ch1_rx_data(ch5_rx_data),  
	  .ch2_rx_data(ch6_rx_data) 
		
    //.fifo_rd_clk( serdes_rx_clk ),
    //.fifo_write_en( fifo_write_en ), //active high
    //.fifo_read_s0( fifo_rd_fpga|fifo_rd_s30 ), //active high
    //.fifo_read_s1( fifo_rd_fpga|fifo_rd_s31 ), //active high
    //.prog_full_thresh( prog_full_thresh ),
    //
    //.fifo_dout_s0 (fifo_dat_s30 ), 
    //.fifo_dout_s1( fifo_dat_s31 ),
    //.adc_Rxdat_valid( ),
		//.fifo_full(fifo_full_s3 ),
		//.fifo_valid_s0( fifo_valid_s30 ),  
		//.fifo_valid_s1( fifo_valid_s31 ),  
		//.prog_full(prog_full_s3 ), 
    //.prog_empty(prog_empty_s3 ) 
    );             
        
adc_data_process data_process_s4(
    .rst_L( rst_n  ),
		.adc_tx_clk(adc_tx_clk ),
		.data_from_serdes( data_from_serdes_s4 ),//采集卡1数据
    .time_gap_num( time_gap_num),
    .fifo_all_wen( fifo_all_wen ),
    .mulit_b( mulit_b ),   
		.acq_mode( acq_mode), //采集模式控制( ),000:正常，001：峰值，010：平均
		.adc_Rxdat_valid(),
	  .ch1_rx_data(ch7_rx_data),  
	  .ch2_rx_data(ch8_rx_data) 
		
    //.fifo_rd_clk( serdes_rx_clk ),
    //.fifo_write_en( fifo_write_en ), //active high
    //.fifo_read_s0( fifo_rd_fpga|fifo_rd_s40 ), //active high
    //.fifo_read_s1( fifo_rd_fpga|fifo_rd_s41 ), //active high
    //.prog_full_thresh( prog_full_thresh ),
    //
    //.fifo_dout_s0 (fifo_dat_s40 ), 
    //.fifo_dout_s1( fifo_dat_s41 ),
    //.adc_Rxdat_valid( ),
		//.fifo_full(fifo_full_s4 ),
		//.fifo_valid_s0( fifo_valid_s40 ),  
		//.fifo_valid_s1( fifo_valid_s41 ),  
		//.prog_full(prog_full_s4 ), 
    //.prog_empty(prog_empty_s4 ) 
    );   
   
   
   //assign adc_data_8ch_valid = adc_Rxdat_valid & (~pcie_wr_fifo_full);
   assign adc_data_8ch = {ch1_rx_data,ch2_rx_data,ch3_rx_data,ch4_rx_data,
   														ch5_rx_data,ch6_rx_data,ch7_rx_data,ch8_rx_data}; 
    
   
   
   fifo_acquisition             //普通采集FIFO，同步FIFO
   	 fifo_acquisition_i (
  .clk(adc_tx_clk),                              // input wire clk
  .srst(!rst_n),                            // input wire srst
  .din(adc_data_8ch),                              // input wire [127 : 0] din
  .wr_en(wr_en),                          // input wire wr_en
  .rd_en(fifo_rd_fpga|fifo_rd_s0),                          // input wire rd_en
  .prog_empty_thresh(11'd1),  // input wire [12 : 0] prog_empty_thresh
  .prog_full_thresh(prog_full_thresh),    // input wire [12 : 0] prog_full_thresh
  .dout(fifo_dout_8ch),                            // output wire [127 : 0] dout
  .full(fifo_full),                            // output wire full
  .wr_ack(wr_ack),                        // output wire wr_ack
  .empty(empty),                          // output wire empty
  .valid(fifo_dout_8ch_valid),                          // output wire valid
  .data_count(data_count),                // output wire [12 : 0] data_count
  .prog_full(prog_full),                  // output wire prog_full
  .prog_empty(prog_empty)                // output wire prog_empty
);
   

                

endmodule
