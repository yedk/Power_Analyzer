`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:54:08 08/24/2016 
// Design Name: 
// Module Name:    ACQ_data_process_and_stroage 
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
module adc_data_process(
    input             rst_L,
    input             adc_tx_clk,
    input   [31:0]   data_from_serdes,

	input   [31:0]    time_gap_num, //抽点系数[31:0]
	//	 input data_flow_mode,     //不抽点（0）/抽点（1）
	input             fifo_all_wen,
	input   [15:0]    mulit_b,  //HR乘法器系数
	input   [2:0]     acq_mode, //采集模式控制,000:正常，001：峰值，010：平均

	output            adc_Rxdat_valid,
	output  [15:0]    ch1_rx_data,
	output  [15:0]    ch2_rx_data
   // input             fifo_rd_clk,
   // input             fifo_write_en, //active high
   // input             fifo_read_s0, //active high
   // input             fifo_read_s1, //active high
   // input   [10 : 0]  prog_full_thresh,
    
   // output  [255 : 0] fifo_dout_s0,
   //output  [255 : 0] fifo_dout_s1,
    
	//output            fifo_full,
	//output            fifo_valid_s0, 
	//output            fifo_valid_s1,  
	//output            prog_full, 
  //  output            prog_empty 
    );


wire [15:0] ch1_rx_data;
wire [15:0] ch2_rx_data;
//wire [31:0] ch3_rx_data;
//wire [31:0] ch4_rx_data;
//wire [31:0] ch5_rx_data;
//wire [31:0] ch6_rx_data;
//wire [31:0] ch7_rx_data;
//wire [31:0] ch8_rx_data;
//wire [31:0] ch9_rx_data;
//wire [31:0] ch10_rx_data;
//wire [31:0] ch11_rx_data;
//wire [31:0] ch12_rx_data;
//wire [31:0] ch13_rx_data;
//wire [31:0] ch14_rx_data;
//wire [31:0] ch15_rx_data;
//wire [31:0] ch16_rx_data;

reg [15:0] ch1_data;   //ch1数据
reg [15:0] ch2_data;   //ch2数据
//reg [15:0] ch3_data;   //ch3数据
//reg [15:0] ch4_data;   //ch4数据
//reg [15:0] ch5_data;   //ch5数据
//reg [15:0] ch6_data;   //ch6数据
//reg [15:0] ch7_data;   //ch7数据
//reg [15:0] ch8_data;   //ch8数据
//reg [15:0] ch9_data;   //ch9数据
//reg [15:0] ch10_data;  //ch10数据
//reg [15:0] ch11_data;  //ch11数据
//reg [15:0] ch12_data;  //ch12数据
//reg [15:0] ch13_data;  //ch13数据
//reg [15:0] ch14_data;  //ch14数据
//reg [15:0] ch15_data;  //ch15数据
//reg [15:0] ch16_data;  //ch16数据


assign adc_Rxdat_valid = fifo_all_wen;

always @( * )
begin
	  ch1_data  <= data_from_serdes[15: 0];  
    ch2_data  <= data_from_serdes[31:16];  
    //ch3_data  <= data_from_serdes[47:32];  
    //ch4_data  <= data_from_serdes[63:48];  
    //ch5_data  <= data_from_serdes[79:64];  
    //ch6_data  <= data_from_serdes[95:80];  
    //ch7_data  <= data_from_serdes[111:96];  
    //ch8_data  <= data_from_serdes[127:112];  
    //ch9_data  <= data_from_serdes[143:128];  
    //ch10_data <= data_from_serdes[159:144];
    //ch11_data <= data_from_serdes[175:160];
    //ch12_data <= data_from_serdes[191:176];
    //ch13_data <= data_from_serdes[207:192];
    //ch14_data <= data_from_serdes[223:208];
    //ch15_data <= data_from_serdes[239:224];
    //ch16_data <= data_from_serdes[255:240];            
end          


data_acq    data_acq_ch12(
  .rst_L( rst_L ),
  .adc_tx_clk( adc_tx_clk ),
  .adc1_data( ch1_data ),  //ADC1采集的数据
  .adc2_data( ch2_data ),  //ADC2采集的数据
  .time_gap_num(time_gap_num  ), //抽点系数[31:0]  PK
  .acq_mode( acq_mode ), //采集模式控制000:正常，001：峰值，010：平均
  .fifo_all_wen( fifo_all_wen ),//抽点数据有效使能
  .mulit_b( mulit_b ),  
  .adc1_rx_data( ch1_rx_data ),
  .adc2_rx_data( ch2_rx_data )
		);
/*		
data_acq    data_acq_ch34(
  .rst_L( rst_L ),
  .adc_tx_clk( adc_tx_clk ),
  .adc1_data( ch3_data ),  //ADC1采集的数据
  .adc2_data( ch4_data ),  //ADC2采集的数据
  .time_gap_num(time_gap_num  ), //抽点系数[31:0]
  .acq_mode( acq_mode ), //采集模式控制(  ),000:正常，001：峰值，010：平均
  .fifo_all_wen( fifo_all_wen ),//抽点数据有效使能
  .mulit_b( mulit_b ),  
  .adc1_rx_data( ch3_rx_data ),
  .adc2_rx_data( ch4_rx_data )
		);		

data_acq    data_acq_ch56(
    .rst_L( rst_L ),
    .adc_tx_clk( adc_tx_clk ),
    .adc1_data( ch5_data ),  //ADC1采集的数据
    .adc2_data( ch6_data ),  //ADC2采集的数据
    .time_gap_num(time_gap_num  ), //抽点系数[31:0]
	.acq_mode( acq_mode ), //采集模式控制(  ),000:正常，001：峰值，010：平均
    .fifo_all_wen( fifo_all_wen ),//抽点数据有效使能
    .mulit_b( mulit_b ),    
    .adc1_rx_data( ch5_rx_data ),
    .adc2_rx_data( ch6_rx_data )
		);
		
data_acq    data_acq_ch78(
  .rst_L( rst_L ),
  .adc_tx_clk( adc_tx_clk ),
  .adc1_data( ch7_data ),  //ADC1采集的数据
  .adc2_data( ch8_data ),  //ADC2采集的数据
  .time_gap_num(time_gap_num  ), //抽点系数[31:0]
  .acq_mode( acq_mode ), //采集模式控制(  ),000:正常，001：峰值，010：平均
  .fifo_all_wen( fifo_all_wen ),//抽点数据有效使能
  .mulit_b( mulit_b ),  
  .adc1_rx_data( ch7_rx_data ),
  .adc2_rx_data( ch8_rx_data )
		);		

data_acq    data_acq_ch910(
  .rst_L( rst_L ),
  .adc_tx_clk( adc_tx_clk ),
  .adc1_data( ch9_data ),  //ADC1采集的数据
  .adc2_data( ch10_data ),  //ADC2采集的数据
  .time_gap_num(time_gap_num  ), //抽点系数[31:0]
  .acq_mode( acq_mode ), //采集模式控制(  ),000:正常，001：峰值，010：平均
  .fifo_all_wen( fifo_all_wen ),//抽点数据有效使能
  .mulit_b( mulit_b ),  
  .adc1_rx_data( ch9_rx_data ),
  .adc2_rx_data( ch10_rx_data )
		);

data_acq    data_acq_ch1112(
  .rst_L( rst_L ),
  .adc_tx_clk( adc_tx_clk ),
  .adc1_data( ch11_data ),  //ADC1采集的数据
  .adc2_data( ch12_data ),  //ADC2采集的数据
  .time_gap_num(time_gap_num  ), //抽点系数[31:0]
  .acq_mode( acq_mode ), //采集模式控制(  ),000:正常，001：峰值，010：平均
  .fifo_all_wen( fifo_all_wen ),//抽点数据有效使能
  .mulit_b( mulit_b ),  
  .adc1_rx_data( ch11_rx_data ),
  .adc2_rx_data( ch12_rx_data )
		);
		
data_acq    data_acq_ch1314(
  .rst_L( rst_L ),
  .adc_tx_clk( adc_tx_clk ),
  .adc1_data( ch13_data ),  //ADC1采集的数据
  .adc2_data( ch14_data ),  //ADC2采集的数据
  .time_gap_num(time_gap_num  ), //抽点系数[31:0]
  .acq_mode( acq_mode ), //采集模式控制(  ),000:正常，001：峰值，010：平均
  .fifo_all_wen( fifo_all_wen ),//抽点数据有效使能
  .mulit_b( mulit_b ),  
  .adc1_rx_data( ch13_rx_data ),
  .adc2_rx_data( ch14_rx_data )
		);		

data_acq    data_acq_ch1516(
  .rst_L( rst_L ),
  .adc_tx_clk( adc_tx_clk ),
  .adc1_data( ch15_data ),  //ADC1采集的数据
  .adc2_data( ch16_data ),  //ADC2采集的数据
  .time_gap_num(time_gap_num  ), //抽点系数[31:0]
  .acq_mode( acq_mode ), //采集模式控制(  ),000:正常，001：峰值，010：平均
  .fifo_all_wen( fifo_all_wen ),//抽点数据有效使能
  .mulit_b( mulit_b ),  
  .adc1_rx_data( ch15_rx_data ),
  .adc2_rx_data( ch16_rx_data )
		);
						
reg wr_en,rd_en;
always @ (posedge adc_tx_clk)
begin
	wr_en <= fifo_write_en & fifo_all_wen;	   
end

//(*KEEP="TRUE"*)wire [10 : 0] rd_data_count;
 
(*KEEP="TRUE"*)wire [255:0] s1_rx_data,s2_rx_data;
(*KEEP="TRUE"*)reg [255:0] s1_rx_data_r;
always@(posedge adc_tx_clk)
begin
	s1_rx_data_r <=s1_rx_data;
end


assign s1_rx_data = { ch1_rx_data, ch2_rx_data,  ch3_rx_data,  ch4_rx_data,
                      ch5_rx_data, ch6_rx_data,  ch7_rx_data,  ch8_rx_data};
                       
assign s2_rx_data = {  ch9_rx_data, ch10_rx_data, ch11_rx_data, ch12_rx_data,
                       ch13_rx_data,ch14_rx_data, ch15_rx_data, ch16_rx_data };


/* 
//数据缓存FIFO
fifo_256bit_2k fifo_256bit_2k_s1 (
  .rst(!rst_L), // input rst
  .wr_clk(adc_tx_clk ), // input wr_clk
  .rd_clk(fifo_rd_clk), // input rd_clk
  .din(s1_rx_data), // input [255 : 0] din
  .wr_en(wr_en), // input wr_en
  .rd_en(fifo_read_s0), // input rd_en
  .prog_empty_thresh(11'd1), // input [10 : 0] prog_empty_thresh
  .prog_full_thresh(prog_full_thresh), // input [10 : 0] prog_full_thresh
  .dout(fifo_dout_s0), // output [255 : 0] dout
  .full(fifo_full), // output full
  .empty(empty), // output empty
  .valid(fifo_valid_s0), // output valid
  .rd_data_count(rd_data_count), // output [10 : 0] rd_data_count
  .wr_data_count(wr_data_count), // output [10 : 0] wr_data_count
  .prog_full(prog_full), // output prog_full
  .prog_empty(prog_empty) // output prog_empty
);





fifo_256bit_2k fifo_256bit_2k_s2 (
  .rst(!rst_L), // input rst
  .wr_clk(adc_tx_clk ), // input wr_clk
  .rd_clk(fifo_rd_clk), // input rd_clk
  .din(s2_rx_data), // input [255 : 0] din
  .wr_en(wr_en), // input wr_en
  .rd_en(fifo_read_s1), // input rd_en
  .prog_empty_thresh(11'd1), // input [10 : 0] prog_empty_thresh
  .prog_full_thresh(prog_full_thresh), // input [10 : 0] prog_full_thresh
  .dout(fifo_dout_s1), // output [255 : 0] dout
  .full( ), // output full
  .empty( ), // output empty
  .valid(fifo_valid_s1), // output valid
  .rd_data_count( ), // output [10 : 0] rd_data_count
  .wr_data_count( ), // output [10 : 0] wr_data_count
  .prog_full( ), // output prog_full
  .prog_empty( ) // output prog_empty
);

*/





endmodule
