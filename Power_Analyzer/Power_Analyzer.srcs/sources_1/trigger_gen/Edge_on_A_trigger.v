`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:59:41 11/08/2016 
// Design Name: 
// Module Name:    Edge_on_A_trigger 
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
module Edge_on_A_trigger(

	input		[143:0]		rise_edge_data,
	input		[143:0]		fall_edge_data,
	input		[31:0]		trig_mode,
	input					A_level_state_data,
	input		[143:0]		B_ch_valid,
	input		[143:0]		B_state,    
	input					edge_on_A_clk,
	input					rst_n,

	output					edge_on_A_pulse
	
	);
	
reg						A_state_flag;
reg			[143:0]		rise_valid_data;
reg			[143:0]		fall_valid_data;
reg					  	edge_on_A_pulse_reg;
reg					  	edge_on_A_pulse_reg_dly;
reg					  	edge_on_A_pulse_reg_rise;
reg			       		A_level_state_data_rise;
reg			       		A_level_state_data_fall;     
reg						A_level_state_data_dly;


always @(posedge edge_on_A_clk or negedge rst_n)
begin
	if(!rst_n)
		edge_on_A_pulse_reg_dly <= 1'b0;
	else 
	    edge_on_A_pulse_reg_dly <= edge_on_A_pulse_reg;
  
end 	

//边沿触发上升沿	
always @(posedge edge_on_A_clk or negedge rst_n)
begin
	if(!rst_n)
		edge_on_A_pulse_reg_rise <= 1'b0;
	else 
	   edge_on_A_pulse_reg_rise <= (edge_on_A_pulse_reg)&&(!edge_on_A_pulse_reg_dly);
end 

always @(posedge edge_on_A_clk or negedge rst_n)
begin
	if(!rst_n)
		A_level_state_data_dly <= 1'b0;
	else 
	    A_level_state_data_dly <= A_level_state_data;
  
end 	

//A上升沿	
always @(posedge edge_on_A_clk or negedge rst_n)
begin
	if(!rst_n)
		A_level_state_data_rise <= 1'b0;
	else 
	   A_level_state_data_rise <= (A_level_state_data)&&(!A_level_state_data_dly);
end 
//A下降沿
always @(posedge edge_on_A_clk or negedge rst_n)
begin
	if(!rst_n)
		A_level_state_data_fall <= 1'b0;
	else 
	   A_level_state_data_fall <= (!A_level_state_data)&&(A_level_state_data_dly);
end 

always@(posedge edge_on_A_clk or negedge rst_n)	
begin
	if(!rst_n)
		A_state_flag <= 1'd0;
	else if(edge_on_A_pulse_reg == 1'd1)
		A_state_flag <= 1'd0;
	else if(((A_level_state_data_rise == 1'd1)&&(trig_mode[6]==1'd1))||((A_level_state_data_fall == 1'd1)&&(trig_mode[6]==1'd0)))
		A_state_flag <= 1'd1;
end 

always@(posedge edge_on_A_clk or negedge rst_n)	
begin
	if(!rst_n)
		rise_valid_data <= 144'd0;
	else 
		rise_valid_data <= (rise_edge_data&(B_ch_valid&B_state));
end
	
always@(posedge edge_on_A_clk or negedge rst_n)	
begin
	if(!rst_n)
		fall_valid_data <= 144'd0;
	else 
		fall_valid_data <= (fall_edge_data&(B_ch_valid^B_state));
end	

always@(posedge edge_on_A_clk or negedge rst_n)
begin
	if(!rst_n)
		edge_on_A_pulse_reg <= 1'd0;
	else if((A_state_flag == 1'd1)&&(trig_mode[3:0]==4'd3))
		edge_on_A_pulse_reg <= |(fall_valid_data|rise_valid_data);
	else 
	    edge_on_A_pulse_reg <= 1'd0;
end	

assign edge_on_A_pulse = edge_on_A_pulse_reg_rise;

endmodule
