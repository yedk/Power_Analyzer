`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:40:34 11/08/2016 
// Design Name: 
// Module Name:    Or_trigger 
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
module Or_trigger(

	input		[3:0]		trig_mod,
	input		[143:0]		A_ch_valid,
	input		[143:0]		B_ch_valid,
	input		[143:0]		A_state,
	input		[143:0]		B_state,
	input		[143:0]	    out_mode_data,
	input 		[143:0]		in_mode_data,
	input		[143:0]		rise_edge_data,
	input		[143:0]		fall_edge_data,
	input					Or_clk,
	input					rst_n,
	
	output					Or_pulse
    );

reg			[143:0]		rise_valid_data;        //要判断上升沿的通道
reg			[143:0]		fall_valid_data;		//要判断下降沿的通道
reg			[143:0]		in_valid_data;          //要判断IN模式的通道
reg			[143:0]		out_valid_data;			//要判断OUT模式的通道
reg			[143:0]		out_mode_data_dly;
reg			[143:0]		in_mode_data_dly;
reg			[143:0]		out_mode_data_rise;
reg			[143:0]		in_mode_data_rise;
reg						Or_pulse_reg;
///////////////判断通道模式 生成有效数据///////////////////////
always @(posedge Or_clk or negedge rst_n)
begin
	if(!rst_n)
		rise_valid_data <= 144'd0;
	else 
	    rise_valid_data <= ((A_ch_valid&A_state)&B_ch_valid)&rise_edge_data;
end

always @(posedge Or_clk or negedge rst_n)
begin
	if(!rst_n)
		fall_valid_data <= 144'd0;
	else 
	    fall_valid_data <= ((A_ch_valid&A_state)^B_ch_valid)&fall_edge_data;
end
	
	
/////////////////IN、OUT模式上升沿检查\\\\\\\\\\\\\\\\\\\\\\\
always @(posedge Or_clk or negedge rst_n)
begin
	if(!rst_n)
		in_mode_data_dly <= 144'd0;
	else 
	    in_mode_data_dly <= in_mode_data;
  
end 	

//in上升沿	
always @(posedge Or_clk or negedge rst_n)
begin
	if(!rst_n)
		in_mode_data_rise <= 144'd0;
	else 
	    in_mode_data_rise <= (in_mode_data)&(~in_mode_data_dly);
end 

always @(posedge Or_clk or negedge rst_n)
begin
	if(!rst_n)
		out_mode_data_dly <= 144'd0;
	else 
	    out_mode_data_dly <= out_mode_data;
  
end 	

//out上升沿	
always @(posedge Or_clk or negedge rst_n)
begin
	if(!rst_n)
		out_mode_data_rise <= 144'd0;
	else 
	    out_mode_data_rise <= (out_mode_data)&(~out_mode_data_dly);
end 

always @(posedge Or_clk or negedge rst_n)
begin
	if(!rst_n)
		in_valid_data <= 144'd0;
	else 
	    in_valid_data <= ((A_ch_valid^A_state)&B_state)&in_mode_data_rise;
end	
	
always @(posedge Or_clk or negedge rst_n)
begin
	if(!rst_n)
		out_valid_data <= 144'd0;
	else 
	    out_valid_data <= ((A_ch_valid^A_state)^B_state)&out_mode_data_rise;
end	
	
/////////////产生触发脉冲\\\\\\\\\\\\\\\\\\

always @(posedge Or_clk or negedge rst_n)
begin
	if(!rst_n)
		Or_pulse_reg <= 1'b0;
	else if(trig_mod[3:0] == 4'd4)
	    Or_pulse_reg <= |(rise_valid_data|fall_valid_data|in_valid_data|out_valid_data);
end 

assign	Or_pulse = Or_pulse_reg;

	
	

endmodule
