`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/08 20:41:55
// Design Name: 
// Module Name: baud_rate
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


module baud_rate(
								clk,
								rst,
								bps_start,
								clk_bps
							);

input 				clk;			//81.84MHz主时钟
input 				rst;		   //复位信号
input 				bps_start;	//接收到数据后，波特率时钟启动信号置位
output 				clk_bps;		//clk_bps的高电平为接收或者发送数据位的中间采样点 

parameter
						FOSC  = 81840000,					
						BAUDR = 115200; 

//波特率分频计数值
//`define		BPS_PARA			710	//波特率为115200时的分频计数值
//`define 		BPS_PARA_2		355	//波特率为115200时的分频计数值的一半，用于数据采样

`define		BPS_PARA			FOSC / BAUDR		//波特率为115200时的分频计数值
`define 		BPS_PARA_2		FOSC / BAUDR / 2	//波特率为115200时的分频计?

reg	[12:0] 	cnt=13'd0;					//分频计数
reg 				clk_bps_r;			//波特率时钟寄存器

//----------------------------------------------------------

always @ (posedge clk or posedge rst)
	if(rst) cnt <= 13'd0;
	else if((cnt == `BPS_PARA) || !bps_start) cnt <= 13'd0;	//波特率计数清零
	else cnt <= cnt + 1'b1;												//波特率时钟计数启动

always @ (posedge clk or posedge rst)
	if(rst) clk_bps_r <= 1'b0;
	else if(cnt == `BPS_PARA_2) clk_bps_r <= 1'b1;	// clk_bps_r高电平为接收数据位的中间采样点,同时也作为发送数据的数据改变点
	else clk_bps_r <= 1'b0;

assign clk_bps = clk_bps_r;

endmodule

