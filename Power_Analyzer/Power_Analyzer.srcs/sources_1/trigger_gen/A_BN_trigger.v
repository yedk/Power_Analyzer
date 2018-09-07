`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:50 11/03/2016 
// Design Name: 
// Module Name:    A_BN_trigger 
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
module A_BN_trigger(

	input				A_level_state_data,
	input   			B_level_state_data,
	input	[5:0]		trig_mod,
	input   [31:0]		trig_numb,
	input				rst_n,
	input				A_BN_clk,
	
	output				A_BN_pulse

    );
    
    parameter		IDLE =	2'b01;
    parameter		WAIT =	2'b10;
    
(*KEEP="TRUE"*)reg		[1:0]		state;
  	reg		[31:0]		cnt;
  	reg					A_BN_pulse_reg;
	reg			       	A_level_state_data_rise;
	reg			       	A_level_state_data_fall; 
    reg					A_level_state_data_dly;
	reg			       	B_level_state_data_rise;
	reg			       	B_level_state_data_fall; 
    reg					B_level_state_data_dly;
	reg					B_level_state_data_rise_dly;
	reg					cnt_flag;
	reg					cnt_flag_dly;
	reg					cnt_flag_rise;	
always @(posedge A_BN_clk or negedge rst_n)
begin
	if(!rst_n)
		B_level_state_data_rise_dly <= 1'b0;
	else 
	    B_level_state_data_rise_dly <= B_level_state_data_rise;
end 	
	
	
//A打一拍
always @(posedge A_BN_clk or negedge rst_n)
begin
	if(!rst_n)
		A_level_state_data_dly <= 1'b0;
	else 
	    A_level_state_data_dly <= A_level_state_data;
  
end 	

//A上升沿	
always @(posedge A_BN_clk or negedge rst_n)
begin
	if(!rst_n)
		A_level_state_data_rise <= 1'b0;
	else 
	   A_level_state_data_rise <= (A_level_state_data)&&(!A_level_state_data_dly);
end 
//A下降沿
always @(posedge A_BN_clk or negedge rst_n)
begin
	if(!rst_n)
		A_level_state_data_fall <= 1'b0;
	else 
	   A_level_state_data_fall <= (!A_level_state_data)&&(A_level_state_data_dly);
end 
//B打一拍
always @(posedge A_BN_clk or negedge rst_n)
begin
	if(!rst_n)
		B_level_state_data_dly <= 1'b0;
	else 
	    B_level_state_data_dly <= B_level_state_data;
  
end 	
//B上升沿	
always @(posedge A_BN_clk or negedge rst_n)
begin
	if(!rst_n)
		B_level_state_data_rise <= 1'b0;
	else 
	   B_level_state_data_rise <= (B_level_state_data)&&(!B_level_state_data_dly);
end 
//B下降沿
always @(posedge A_BN_clk or negedge rst_n)
begin
	if(!rst_n)
		B_level_state_data_fall <= 1'b0;
	else 
	   B_level_state_data_fall <= (!B_level_state_data)&&(B_level_state_data_dly);
end 
//FSM
always @(posedge A_BN_clk or negedge rst_n)
begin
	if(!rst_n)
    	state <= IDLE;
    else case(state)
    		IDLE: if(((A_level_state_data_rise == 1'b1)&&(trig_mod[4] == 1'b1))||((A_level_state_data_fall == 1'b1)&&(trig_mod[4] == 1'b0)))
    				begin
    				state <= WAIT;
    				end
    		WAIT: if(cnt_flag == 1'b1)
    		        state <= IDLE;
    		default:state <= IDLE;
    	endcase	
end

always @(posedge A_BN_clk or negedge rst_n)
begin
	if(!rst_n)
		cnt <= 32'd0;
	else if((((A_level_state_data_rise == 1'b1)&&(trig_mod[4] == 1'b1))||((A_level_state_data_fall == 1'b1)&&(trig_mod[4] == 1'b0)))&&(state == IDLE))
		cnt <= 32'd0;
	else if((state == WAIT) && (((B_level_state_data_rise == 1'b1)&&(trig_mod[5] == 1'b1))||((B_level_state_data_fall == 1'b1)&&(trig_mod[5] == 1'b0))))
		cnt <= cnt+1'b1;
	else if(state != WAIT)
		cnt <= 32'd0;
end
always @(posedge A_BN_clk or negedge rst_n)
begin
	if(!rst_n)
		cnt_flag <= 1'b0;
	else if((((A_level_state_data_rise == 1'b1)&&(trig_mod[4] == 1'b1))||((A_level_state_data_fall == 1'b1)&&(trig_mod[4] == 1'b0)))&&(state == IDLE))
    	cnt_flag <= 1'b0;	 
	else if(cnt >= trig_numb)          //本来是== 但是由于当计数是0时会出现问题，改为>=
	    cnt_flag <= 1'b1;
	else 
	    cnt_flag <= 1'b0;
end 

always @(posedge A_BN_clk or negedge rst_n)
begin
	if(!rst_n)
		cnt_flag_dly <= 1'b0;
	else 
	    cnt_flag_dly <= cnt_flag;
  
end 	
always @(posedge A_BN_clk or negedge rst_n)
begin
	if(!rst_n)
		cnt_flag_rise <= 1'b0;
	else 
	   cnt_flag_rise <= (cnt_flag)&&(!cnt_flag_dly);
end 

always @(posedge A_BN_clk or negedge rst_n)
begin
	if(!rst_n)
		A_BN_pulse_reg <= 1'b0;
	else if((cnt_flag_rise == 1'b1)&&(trig_mod[3:0]==4'd1))
		A_BN_pulse_reg <= 1'b1;
	else
	    A_BN_pulse_reg <= 1'b0;
end

assign A_BN_pulse = A_BN_pulse_reg;
endmodule
