`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:29 12/20/2017 
// Design Name: 
// Module Name:    period_detect 
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
module period_detect
( 
	input		            clkinx,
	input		            rst_n,
	input		            clkin,	
	input      [5:0]    cnt_cycle, //N 表示N个被测信号周期，最大可测64个周期
	output reg [39:0]		cnt_period,//测周法最大计数位宽
	output reg	        full_flag,
	output reg   		    mea_flag		
		);

reg    	[5:0]	gate_cnt;
reg		gate_ctl,	gate_ctl_pre;
reg		clkinx_dly1,clkinx_dly2,clkinx_dly3;


always @ (posedge clkin )	//prevent glitch
begin
	clkinx_dly1 <= clkinx;
	clkinx_dly2 <= clkinx_dly1;
	clkinx_dly3 <= clkinx_dly2;
end

always @(posedge clkin or negedge rst_n )
begin
	if (rst_n==0)
	begin
		gate_cnt <= 6'd0;
	  gate_ctl <= 0;
	end
	else if({clkinx_dly2,clkinx_dly1}== 2'b01)   	//the posedge of trigger_signal
	begin
		if(gate_cnt < cnt_cycle)
		begin
			gate_cnt <= gate_cnt + 1'b1;	
  	  gate_ctl <= 1;				
  	end
	  else if (gate_cnt >= cnt_cycle)
	  begin
	  	gate_cnt <= gate_cnt ;
	  	gate_ctl <= 0;		
	  end
	end
end

always @ (posedge clkin or negedge rst_n )
begin
  if(rst_n==0)
	begin
		cnt_period <= 40'd0;
	end
  else if( gate_ctl)
  begin
  	cnt_period <=  cnt_period + 40'd1;
  end
  else
  begin
  	cnt_period <=  cnt_period;
  end
end

//always @ ( negedge gate_ctl  or negedge rst_n )    //??è???μ?2??ü?a?ùD′
always @ ( posedge clkin or negedge rst_n)
begin
	if(!rst_n)
	begin
		mea_flag <= 1'b0;
	end	
	else if(gate_ctl == 1'b0)
	begin
		mea_flag <= 1'b1;
	end
	else
	begin
		mea_flag <= 1'b0;
	end
end

always @(posedge clkin or negedge rst_n)
begin
	if(rst_n==0)
	begin
		full_flag <= 1'd0;
	end
  else if(cnt_period == 40'hFF_FFFF_FFFF)
  begin
  	full_flag <= 1'd1;
  end
end	


endmodule
