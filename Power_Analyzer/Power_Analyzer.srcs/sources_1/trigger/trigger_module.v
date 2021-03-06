	`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:59:09 04/28/2007 
// Design Name: 
// Module Name:    trigger_module 
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
module trigger_module(
	//input signals
	trig_force_ctrl,	
	tri_sys_selected,	//the real trigger signal

	tri_auto,	//trigger style
	clk_10M,	//the ref frequency for timing
	wclk,		//the fifo write clk	
	rxclk_125mhz,
	//signals for random sample
	count_clr,	//clr status for random sample
	fifo_reset,
	fifo_clr,//active low
	scan_cnt_load,

	predepth,	//real sample pre tri depth
	posdepth,	//after tri depth set
	tri_holdoff,

	fifo_wen, 	//fifo is wen and start the counter , "1" is Actived
	scan_en,
	fifo_wr_gap,
	fifo_rclk_sel,	//select the rclk of fifo 	

	trig_sig,

	//output signals
	//status output
	trigged_dsp,	//trigged status	
	auto_dsp,	//if "1" means Auto trig

	scan_cnt_num,
	ready_dsp,		//ready status  waiting for trig
	TRIG_DEALY_VALUE,
	CaliTrigDelay,
	auto_rclk_en,	
	trigged_detect_flag,
	trigged_reg,
	trig_clr_out,
	pos_tri_s,
	fifo_ddr3_scan,
	clk_1KHz,
	ready,
	close_fifo_en_reg,
	time_over,
	pre_trig_real_over
	
	);
                
	//input signals
input		trig_force_ctrl,	
		tri_sys_selected,	//the real trigger signal
		tri_auto,	//trigger style
		clk_10M,	//the ref frequency for timing
		rxclk_125mhz,
		wclk;		//the fifo write clk
input 	CaliTrigDelay;
input	   [4:0] TRIG_DEALY_VALUE;
	//signals for random sample
input		count_clr,	//clr status for random sample	 
		fifo_reset,
		fifo_clr,
		scan_cnt_load;

input	[31:0]	predepth;	//real sample pre tri depth
input	[36:0]	posdepth;	//after tri depth set
input	[31:0]	tri_holdoff;

input		fifo_wen, 	//fifo is wen and start the counter , "1" is Actived
		scan_en,//scan模式使能信号
		fifo_wr_gap,	
		fifo_rclk_sel,	//select the rclk of fifo
		fifo_ddr3_scan, 
		trig_sig;
		
	//status output
output		trigged_dsp,
				auto_dsp,
				ready_dsp;
output  ready,close_fifo_en_reg,time_over,pre_trig_real_over;
output		[15:0]	scan_cnt_num;
output		auto_rclk_en;	
output		trigged_detect_flag;
output    trigged_reg;
output		trig_clr_out;
output		pos_tri_s;
output		clk_1KHz;

	///////reg////////////////////////
reg		ready;
reg		postrig_cnt_en;
reg		trigged;

reg		auto_rclk_en;
	//////////////////////////////////
	
reg		pre_trig_cnt_en;
reg		fifo_rclk_sel_reg,
			trigged_reg;
reg		close_fifo_en/* synthesis syn_preserve = 1 */;

//**************** generate dsp_rdfifo_en ************************
reg		dsp_rdfifo_en;
reg		trigged_detect_flag;
reg		trig_clr_out;
reg		fifo_wr_gap_dly,
			fifo_wr_gap_dly1;
(*KEEP = "true" *) wire tri_sys;
wire	clk_1KHz;

wire pre_trig_real_over;

assign clk_1KHz =clk_1KHz_reg;
always @ (posedge wclk)	
begin
	pre_trig_cnt_en <= fifo_wen;	
	fifo_wr_gap_dly <= fifo_wr_gap;
end

//***************************************************************
//real sample pretrig counter
pre_trig_counter   REAL_PRE_CNT (
			    .clr(fifo_clr), 		//复位信号，内部低有效			
			    .count_en(pre_trig_cnt_en),		//计数使能信号，高有效
			    .pre_trg_clkin(wclk),//计数时钟
			    .data(predepth[31:0]), 
			    .cout(pre_trig_real_over)	//计数满输出高
			 );

// real sample after trig counter			    
pos_trig_counter pos_trig_counter_inst (
				    .clr(postrig_cnt_en),	//复位信号，active low
				   // .count_en(postrig_cnt_en), 
				    .inclk(wclk),		//计数参考时钟
				    .data(posdepth[36:0]), //计数长度
				    .cout(pos_tri_s)		//计数满输出高
				    );
				    
 //generate ready status
always @ (posedge wclk)
begin
	ready   <=  pre_trig_real_over ;
	fifo_rclk_sel_reg <= fifo_rclk_sel;
end

always @ (posedge wclk)
begin
	trigged_reg <= trigged ;
end


always @ (posedge wclk)
begin
	close_fifo_en = ~trigged_reg;	//Low Active
end


//ready状态时，无触发信号、没有超时则进入边读边写
//always @ (posedge wclk)	
//begin
//  //auto_rclk_en <=  ready & (close_fifo_en_reg) & (~time_over);
//  auto_rclk_en <=  ready & (~time_over);
//end
/*
always @ (posedge wclk)	
begin
  auto_rclk_en <=  ready & (close_fifo_en_reg) & (~time_over);
  //auto_rclk_en <=  ready & (~time_over);
end
*/

always @ (posedge wclk)	//& fifo_wen
begin
	if(pos_tri_s == 1'b1 && fifo_ddr3_scan ==0)
		auto_rclk_en <= ready & (close_fifo_en_reg) & (~time_over);
		
	else if(pos_tri_s == 1'b1 && fifo_ddr3_scan ==1)
	  auto_rclk_en <= 1 ;
	else 
		auto_rclk_en <= 1'b1;
end



reg [4:0] CaliDelayCount;
reg close_fifo_en_reg;
reg FurtherReadFIFO;

always @ (posedge wclk)	
begin
	if(!trig_clr)
	begin
	  CaliDelayCount<=0;
		FurtherReadFIFO<=1;	
	end
	else if(trigged_reg)
		begin
			if(CaliDelayCount==TRIG_DEALY_VALUE)
				FurtherReadFIFO<=0;
			else
			begin
				FurtherReadFIFO<=1;	
			  CaliDelayCount<=CaliDelayCount+1;
			end
		end
end

//always @ (posedge wclk)	
//begin
//  if(CaliTrigDelay)
//	  close_fifo_en_reg <=  FurtherReadFIFO;//触发信号到来之后继续读FIFO，用于修正实际触发点的固定偏移
//  else
//	  close_fifo_en_reg <=  close_fifo_en;
//end
always @ (posedge wclk)	
begin
  //if(CaliTrigDelay)
  //  close_fifo_en_reg <=  FurtherReadFIFO;//触发信号到来之后继续读FIFO，用于修正实际触发点的固定偏移
  //else
	  close_fifo_en_reg <=  close_fifo_en;
end

	
always @(posedge wclk)
begin
	trig_clr_out <= trig_clr;
end

//trig wait and pos trig
assign trig_clr = ready & (~time_over);

//wclk  only for realsample
reg	trig_clr_dly ;
reg	trig_clr_dly1;
reg	trig_clr_dly2;

// reject the trigger signal which is fast than sample clk in random sample

reg	trig_sig_tmp1,trig_sig_tmp2;

always @ (posedge wclk)	
begin
	trig_clr_dly <= trig_clr;
	trig_sig_tmp1 <= trig_sig;
	trig_sig_tmp2 <= trig_sig_tmp1;
end




always @ (posedge tri_sys or negedge trig_clr)	
begin
	if(!trig_clr)
		trigged <= 1'b0;
	else 
		trigged <= 1'b1;
end

//产生1k时钟信号
reg [15:0] counter_1k;               
reg clk_1KHz_reg;                        
                                     
always @(posedge clk_10M )           
begin                                
	if(counter_1k == 16'd9999)       
	begin                            
	  counter_1k <=0;                
	end                              
    else                             
    begin                            
        counter_1k <=counter_1k +1;  
    end                              
    if(counter_1k < 16'd5000)        
    begin                            
      clk_1KHz_reg <= 0;                 
    end                              
    else                             
    begin                            
       clk_1KHz_reg <= 1;                
    end                              
end                                  



// auto trig 
assign autotrig_cnt_en=(~trigged_reg) & ready & tri_auto;	

auto_trig_cnt auto_trig_cnt_inst (
    .cnt_en(autotrig_cnt_en), //active high ，使能自动触发计数功能
    .clk(rxclk_125mhz), //rxclk_125mhz
    .clk_ref(clk_1KHz_reg), 
    .sys_trig_sig(tri_sys_selected),	// 有效触发信号

    .cout(time_over)
    );

always @ (posedge wclk)
begin
	if(time_over == 1'b1)//自动触发模式下，如果计数时间到则需要开启后触发
		postrig_cnt_en <= ready;
	else if (fifo_wr_gap_dly)//正常触发，后触发使能由触发信号决定
	begin
		postrig_cnt_en <= trigged_reg;
	end
	
end	
//*****************************************************************************

Tri_Holdoff tri_holdoff_inst (	//trig holdoff 
    .Tri_Holdoff(tri_holdoff), //触发释抑时间32bit
   // .Clkin(rxclk_125mhz), //wclk  rxclk_125mhz
    .Clkin(wclk),  
    .Trigger(tri_sys_selected),	//input，触发信号

    .Sys_Tri(tri_sys)		//output
    );

//*************************** scan counter **********************************

scan_cnt_short scan_cnt_short_inst (
		    .cnt_en(scan_en), 
		    .fifo_reset(fifo_clr),
		    .scan_cnt_clr(scan_cnt_load), 
		    .cnt_clk(wclk), 

		    .scan_cnt_num(scan_cnt_num)
		    );


//**************************** Detect the trig signal *************************

always @(posedge tri_sys or negedge count_clr)
begin
	if(!count_clr)
		trigged_detect_flag <= 1'b0;
	else 
		trigged_detect_flag <= 1'b1;
end

//**************************** Tri_status to dsp *************************

tri_status tri_status_inst (
		    .clk(wclk), 
		    .reset(fifo_reset),
		    .ready(ready), 
		    .auto(time_over),
			 .trigged(trigged_reg),
			 .single(1'b0),
			 .scan(1'b0),

		    .ready_dsp(ready_dsp),
			 .auto_dsp(auto_dsp),
			 .trigged_dsp(trigged_dsp)
		    );

endmodule
	
