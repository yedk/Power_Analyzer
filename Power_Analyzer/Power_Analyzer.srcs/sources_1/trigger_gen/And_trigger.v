`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:09 11/08/2016 
// Design Name: 
// Module Name:    And_trigger 
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
module And_trigger(

	input		[3:0]		trig_mod,
	input		[143:0]		A_ch_valid,
	input		[143:0]		B_ch_valid,
	input		[143:0]		A_state,
	input		[143:0]		B_state,
	input		[143:0]	    out_mode_data,
	input 		[143:0]		in_mode_data,
	input					A_level_state_data,
	input					And_clk,
	input					rst_n,
	
	output					And_pulse
    );

reg				[143:0]		in_valid_data;	
reg				[143:0]		out_valid_data;
reg				[143:0]		in_out_valid_ch;
reg 				 		And_pulse_reg;
reg				[143:0]		in_valid_data_dly;	
reg				[143:0]		out_valid_data_dly;



always @(posedge And_clk or negedge rst_n)
begin
	if(!rst_n)
		in_out_valid_ch <= 144'd0;
	else
		in_out_valid_ch <= (A_ch_valid^A_state);
end

always @(posedge And_clk or negedge rst_n)
begin
	if(!rst_n)
		in_valid_data <= 144'd0;
	else
		in_valid_data <= ((A_ch_valid^A_state)&B_state)&in_mode_data;
end
	
always @(posedge And_clk or negedge rst_n)
begin
	if(!rst_n)
		out_valid_data <= 144'd0;
	else 
	    out_valid_data <= ((A_ch_valid^A_state)^B_state)&out_mode_data;
end		
//由于A_level_state_data比out_valid_data的数据慢了一拍，所以out_valid_data必须打一排保证数据同步
always @(posedge And_clk or negedge rst_n)
begin
	if(!rst_n)
		in_valid_data_dly <= 144'd0;
	else
		in_valid_data_dly <= in_valid_data;
end
always @(posedge And_clk or negedge rst_n)
begin
	if(!rst_n)
		out_valid_data_dly <= 144'd0;
	else
		out_valid_data_dly <= out_valid_data;
end

always @(posedge And_clk or negedge rst_n)
begin
	if(!rst_n)
		And_pulse_reg <= 1'd0;
	else if(trig_mod[3:0] == 4'd5)
		And_pulse_reg <= (&((~in_out_valid_ch)^(out_valid_data_dly|in_valid_data_dly)))&A_level_state_data;
end 	
	
assign  	And_pulse = And_pulse_reg;
endmodule
