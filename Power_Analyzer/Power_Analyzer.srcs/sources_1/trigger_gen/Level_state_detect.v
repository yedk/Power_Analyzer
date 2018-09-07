`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:29 11/02/2016 
// Design Name: 
// Module Name:    Level_state_detect 
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
module Level_state_detect(

	input		[15:0]		nomal_data,
	input		[3:0]		trig_mod,
	input		[15:0]		A_ch_valid,
	input		[15:0]		B_ch_valid,
	input		[15:0]		A_state,
	input		[15:0]		B_state,
	input					level_clk,
	input					rst_n,

	output		     	    A_level_state_data,           //只要用到电平比较的都会输出 只用一个比较电平的从A输出B不用
	output		    	    B_level_state_data
    );

	reg			[15:0]		A_valid_data;
	reg			[15:0]		B_valid_data;
	reg				   	    A_level_state_data_reg;
	reg				   	    B_level_state_data_reg;

always@(posedge level_clk or negedge rst_n)
begin
	if(!rst_n)
		A_valid_data <= 16'd0;
	else 
		case(trig_mod)
			4'd1,4'd2,4'd3,4'd6,4'd7:
				A_valid_data <= ((nomal_data)&(A_ch_valid));
			4'd5:                                                        
				A_valid_data <= ((nomal_data)&(A_ch_valid)&(A_state));
			default:
				A_valid_data <= ((nomal_data)&(A_ch_valid));
		endcase
end	

always@(posedge level_clk or negedge rst_n)
begin
	if(!rst_n)
		B_valid_data <= 16'd0;
	else 
		case(trig_mod)
			4'd1,4'd2:
				B_valid_data <= ((nomal_data)&(B_ch_valid));
			default:
				B_valid_data <= ((nomal_data)&(B_ch_valid));
		endcase
end	

always@(posedge level_clk or negedge rst_n)
begin
	if(!rst_n)
		A_level_state_data_reg <= 1'd0;
	else 
		case(trig_mod)
			4'd1,4'd2,4'd3,4'd6,4'd7:
				if(A_valid_data == A_state)
					A_level_state_data_reg <= 1'd1;
				else
				    A_level_state_data_reg <= 1'd0;
			4'd5:
				if(A_valid_data == B_ch_valid)           //AND 触发模式
					A_level_state_data_reg <= 1'd1;
				else
				    A_level_state_data_reg <= 1'd0;
			default:
				A_level_state_data_reg <= 1'd0;
		endcase
end	

always@(posedge level_clk or negedge rst_n)
begin
	if(!rst_n)
		B_level_state_data_reg <= 1'd0;
	else 
		case(trig_mod)
			4'd1,4'd2:
				if(B_valid_data == B_state)
					B_level_state_data_reg <= 1'd1;
				else
				    B_level_state_data_reg <= 1'd0;
			default:
				B_level_state_data_reg <= 1'd0;
		endcase
end

assign A_level_state_data = A_level_state_data_reg;
assign B_level_state_data = B_level_state_data_reg;
endmodule
