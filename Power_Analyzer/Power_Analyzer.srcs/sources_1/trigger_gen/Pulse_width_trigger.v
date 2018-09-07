`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:00:33 11/09/2016 
// Design Name: 
// Module Name:    Pulse_width_trigger 
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
module Pulse_width_trigger(

input		[31:0]		trig_mode,
input					A_level_state_data,
input		[143:0]		B_ch_valid,             //T1 OR TIME
input		[143:0]		B_state,				//T2
input					Pulse_width_clk,
input					rst_n,

output					Pulse_width_pulse
    );
    
parameter		IDLE = 2'b01;
parameter		WAIT = 2'b10;

reg			[1:0]		state;
reg			[143:0]		cnt;
reg			       		A_level_state_data_rise;
reg			       		A_level_state_data_fall;     
reg						A_level_state_data_dly;
reg						A_level_state_data_dly2;
reg						A_level_state_data_dly3;
reg						Pulse_width_pulse_reg;
always  @(posedge Pulse_width_clk or negedge rst_n)
begin
	if(!rst_n)
		state <= IDLE;
	else begin
	   case(state)
			IDLE: if(A_level_state_data_rise == 1'd1)
					state <= WAIT;
			WAIT: if(A_level_state_data_fall == 1'd1)
					state <= IDLE;
			default: state <= IDLE;
		endcase	
	end
end

always  @(posedge Pulse_width_clk or negedge rst_n)
begin
	if(!rst_n)
		cnt <= 143'd0;
	else if(state == WAIT)
		cnt <= cnt + 1'b1;
	else if(state != WAIT)
		cnt <= 143'd0;		
end

always @(posedge Pulse_width_clk or negedge rst_n)
begin
	if(!rst_n)
		{A_level_state_data_dly3,A_level_state_data_dly2,A_level_state_data_dly} <= 3'b0;
	else 
	   {A_level_state_data_dly3,A_level_state_data_dly2,A_level_state_data_dly} <= {A_level_state_data_dly2,A_level_state_data_dly,A_level_state_data};
end 	

//A上升沿	
always @(posedge Pulse_width_clk or negedge rst_n)
begin
	if(!rst_n)
		A_level_state_data_rise <= 1'b0;
	else 
	   A_level_state_data_rise <= (A_level_state_data)&&(!A_level_state_data_dly);
end 
//A下降沿
always @(posedge Pulse_width_clk or negedge rst_n)
begin
	if(!rst_n)
		A_level_state_data_fall <= 1'b0;
	else 
	   A_level_state_data_fall <= (!A_level_state_data)&&(A_level_state_data_dly);
end 


//由于延迟原因，所以出现B_ch_valid-1 和 A_level_state_data_dly3 这样实现数据对其
always  @(posedge Pulse_width_clk or negedge rst_n)
begin
	if(!rst_n)
		Pulse_width_pulse_reg <= 1'd0;
	else if(trig_mode[3:0] == 4'd7)
	begin 
		case(trig_mode[10:9])
			2'b00: if((cnt < (B_ch_valid-1))&&(A_level_state_data_fall == 1'd1))
						Pulse_width_pulse_reg <= 1'd1;
				   else
						Pulse_width_pulse_reg <= 1'd0;
			2'b01: if((cnt > (B_ch_valid-1))&&(A_level_state_data_fall == 1'd1))
						Pulse_width_pulse_reg <= 1'd1;
				   else
						Pulse_width_pulse_reg <= 1'd0;
			2'b10: if((cnt > B_ch_valid)&&(cnt < B_state)&&(A_level_state_data_fall == 1'd1))
						Pulse_width_pulse_reg <= 1'd1;
				   else
						Pulse_width_pulse_reg <= 1'd0;
			2'b11: if((cnt > B_ch_valid)&&(A_level_state_data_dly3 == 1'd1))
						Pulse_width_pulse_reg <= 1'd1;
				   else
						Pulse_width_pulse_reg <= 1'd0;
			default: Pulse_width_pulse_reg <= 1'd0; 
		endcase
	end
	else
		Pulse_width_pulse_reg <= 1'd0;
end

assign	Pulse_width_pulse = Pulse_width_pulse_reg;
endmodule
