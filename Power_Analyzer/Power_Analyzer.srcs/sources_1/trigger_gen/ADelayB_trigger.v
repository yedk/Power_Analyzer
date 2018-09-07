`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:44:36 11/07/2016 
// Design Name: 
// Module Name:    ADelayB_trigger 
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
module ADelayB_trigger(
	input				A_level_state_data,
	input   			B_level_state_data,
	input	[5:0]		trig_mod,
	input   [31:0]		AdelayB_time,
	input				rst_n,
	input				ADelayB_clk,
	
	output				ADelayB_pulse

    );
    
    parameter		IDLE =	2'b01;
    parameter		WAIT =	2'b10;
    
    reg		[1:0]		state;
  	reg		[31:0]		cnt;
  	reg					ADelayB_pulse_reg;
	reg			       	A_level_state_data_rise;
	reg			       	A_level_state_data_fall; 
    reg					A_level_state_data_dly;
	reg			       	B_level_state_data_rise;
	reg			       	B_level_state_data_fall; 
    reg					B_level_state_data_dly;
//A打一拍
always @(posedge ADelayB_clk or negedge rst_n)
begin
	if(!rst_n)
		A_level_state_data_dly <= 1'b0;
	else 
	    A_level_state_data_dly <= A_level_state_data;
  
end 	

//A上升沿	
always @(posedge ADelayB_clk or negedge rst_n)
begin
	if(!rst_n)
		A_level_state_data_rise <= 1'b0;
	else 
	   A_level_state_data_rise <= (A_level_state_data)&&(!A_level_state_data_dly);
end 
//A下降沿
always @(posedge ADelayB_clk or negedge rst_n)
begin
	if(!rst_n)
		A_level_state_data_fall <= 1'b0;
	else 
	   A_level_state_data_fall <= (!A_level_state_data)&&(A_level_state_data_dly);
end 
//B打一拍
always @(posedge ADelayB_clk or negedge rst_n)
begin
	if(!rst_n)
		B_level_state_data_dly <= 1'b0;
	else 
	    B_level_state_data_dly <= B_level_state_data;
  
end 	
//B上升沿	
always @(posedge ADelayB_clk or negedge rst_n)
begin
	if(!rst_n)
		B_level_state_data_rise <= 1'b0;
	else 
	   B_level_state_data_rise <= (B_level_state_data)&&(!B_level_state_data_dly);
end 
//B下降沿
always @(posedge ADelayB_clk or negedge rst_n)
begin
	if(!rst_n)
		B_level_state_data_fall <= 1'b0;
	else 
	   B_level_state_data_fall <= (!B_level_state_data)&&(B_level_state_data_dly);
end 
//FSM
always @(posedge ADelayB_clk or negedge rst_n)
begin
	if(!rst_n)
    	state <= IDLE;
    else case(state)
    		IDLE: if(((A_level_state_data_rise == 1'b1)&&(trig_mod[4] == 1'b1))||((A_level_state_data_fall == 1'b1)&&(trig_mod[4] == 1'b0)))
    				state <= WAIT;
    		WAIT: if((((B_level_state_data_rise == 1'b1)&&(trig_mod[5] == 1'b1))||((B_level_state_data_fall == 1'b1)&&(trig_mod[5] == 1'b0)))&&(cnt >= AdelayB_time))
    		        state <= IDLE;
    		default:state <= IDLE;
    	endcase	
end

always @(posedge ADelayB_clk or negedge rst_n)
begin
	if(!rst_n)
		cnt <= 32'd2;               //由于代码延迟了2个脉冲才开始计数，为了准确，初始值直接为2
	else if(state == WAIT)	
		cnt <= cnt+1'b1;
	else if(state != WAIT)
		cnt <= 32'd2;
end

always @(posedge ADelayB_clk or negedge rst_n)
begin
	if(!rst_n)
		ADelayB_pulse_reg <= 1'b0;
	else if(((((B_level_state_data_rise == 1'b1)&&(trig_mod[5] == 1'b1))||((B_level_state_data_fall == 1'b1)&&(trig_mod[5] == 1'b0)))&&(cnt >= AdelayB_time))&&(trig_mod[3:0]==4'd2)&&(state == WAIT))
		ADelayB_pulse_reg <= 1'b1;
	else
	    ADelayB_pulse_reg <= 1'b0;
end

assign ADelayB_pulse = ADelayB_pulse_reg;
endmodule