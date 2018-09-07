`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:12:10 11/07/2016 
// Design Name: 
// Module Name:    Level_state_detect_128ch 
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
module Level_state_detect_143ch(

	input		[143:0]		nomal_mode_data,
	input		[3:0]			trig_mod,
	input		[143:0]		A_ch_valid,
	input		[143:0]		B_ch_valid,
	input		[143:0]		A_state,
	input		[143:0]		B_state,
	input						level_clk,
	input						trig_rst_n,

	output		     	    A_level_state_data,           //只要用到电平比较的都会输出 只用一个比较电平的从A输出B不用
	output		    	    B_level_state_data
    );
	
	wire		[15:0]		A_level_state_data_1;
	wire		[15:0]		B_level_state_data_1;
	wire		[15:0]		A_level_state_data_2;
	wire		[15:0]		B_level_state_data_2;
	wire		[15:0]		A_level_state_data_3;
	wire		[15:0]		B_level_state_data_3;
	wire		[15:0]		A_level_state_data_4;
	wire		[15:0]		B_level_state_data_4;
	wire		[15:0]		A_level_state_data_5;
	wire		[15:0]		B_level_state_data_5;
	wire		[15:0]		A_level_state_data_6;
	wire		[15:0]		B_level_state_data_6;
	wire		[15:0]		A_level_state_data_7;
	wire		[15:0]		B_level_state_data_7;
	wire		[15:0]		A_level_state_data_8;
	wire		[15:0]		B_level_state_data_8;     
	wire		[15:0]		A_level_state_data_9; 
	wire		[15:0]		B_level_state_data_9; 
	
Level_state_detect Level_state_detect_inst1(

	.nomal_data(nomal_mode_data[15:0]),
	.trig_mod(trig_mod[3:0]),
	.A_ch_valid(A_ch_valid[15:0]),
	.B_ch_valid(B_ch_valid[15:0]),
	.A_state(A_state[15:0]),
	.B_state(B_state[15:0]),
	.level_clk(level_clk),
	.rst_n(trig_rst_n),
	
	.A_level_state_data(A_level_state_data_1),           //只要用到电平比较的都会输出 只用一个比较电平的从A输出B不用
	.B_level_state_data(B_level_state_data_1)
    );
	
Level_state_detect Level_state_detect_inst2(

	.nomal_data(nomal_mode_data[31:16]),
	.trig_mod(trig_mod[3:0]),
	.A_ch_valid(A_ch_valid[31:16]),
	.B_ch_valid(B_ch_valid[31:16]),
	.A_state(A_state[31:16]),
	.B_state(B_state[31:16]),
	.level_clk(level_clk),
	.rst_n(trig_rst_n),
	
	.A_level_state_data(A_level_state_data_2),           //只要用到电平比较的都会输出 只用一个比较电平的从A输出B不用
	.B_level_state_data(B_level_state_data_2)
    );
	
Level_state_detect Level_state_detect_inst3(

	.nomal_data(nomal_mode_data[47:32]),
	.trig_mod(trig_mod[3:0]),
	.A_ch_valid(A_ch_valid[47:32]),
	.B_ch_valid(B_ch_valid[47:32]),
	.A_state(A_state[47:32]),
	.B_state(B_state[47:32]),
	.level_clk(level_clk),
	.rst_n(trig_rst_n),
	
	.A_level_state_data(A_level_state_data_3),           //只要用到电平比较的都会输出 只用一个比较电平的从A输出B不用
	.B_level_state_data(B_level_state_data_3)
    );
	
Level_state_detect Level_state_detect_inst4(

	.nomal_data(nomal_mode_data[63:48]),
	.trig_mod(trig_mod[3:0]),
	.A_ch_valid(A_ch_valid[63:48]),
	.B_ch_valid(B_ch_valid[63:48]),
	.A_state(A_state[63:48]),
	.B_state(B_state[63:48]),
	.level_clk(level_clk),
	.rst_n(trig_rst_n),
	
	.A_level_state_data(A_level_state_data_4),           //只要用到电平比较的都会输出 只用一个比较电平的从A输出B不用
	.B_level_state_data(B_level_state_data_4)
    );
	
Level_state_detect Level_state_detect_inst5(

	.nomal_data(nomal_mode_data[79:64]),
	.trig_mod(trig_mod[3:0]),
	.A_ch_valid(A_ch_valid[79:64]),
	.B_ch_valid(B_ch_valid[79:64]),
	.A_state(A_state[79:64]),
	.B_state(B_state[79:64]),
	.level_clk(level_clk),
	.rst_n(trig_rst_n),
	
	.A_level_state_data(A_level_state_data_5),           //只要用到电平比较的都会输出 只用一个比较电平的从A输出B不用
	.B_level_state_data(B_level_state_data_5)
    );
	
Level_state_detect Level_state_detect_inst6(

	.nomal_data(nomal_mode_data[95:80]),
	.trig_mod(trig_mod[3:0]),
	.A_ch_valid(A_ch_valid[95:80]),
	.B_ch_valid(B_ch_valid[95:80]),
	.A_state(A_state[95:80]),
	.B_state(B_state[95:80]),
	.level_clk(level_clk),
	.rst_n(trig_rst_n),
	
	.A_level_state_data(A_level_state_data_6),           //只要用到电平比较的都会输出 只用一个比较电平的从A输出B不用
	.B_level_state_data(B_level_state_data_6)
    );
	
Level_state_detect Level_state_detect_inst7(

	.nomal_data(nomal_mode_data[111:96]),
	.trig_mod(trig_mod[3:0]),
	.A_ch_valid(A_ch_valid[111:96]),
	.B_ch_valid(B_ch_valid[111:96]),
	.A_state(A_state[111:96]),
	.B_state(B_state[111:96]),
	.level_clk(level_clk),
	.rst_n(trig_rst_n),
	
	.A_level_state_data(A_level_state_data_7),           //只要用到电平比较的都会输出 只用一个比较电平的从A输出B不用
	.B_level_state_data(B_level_state_data_7)
    );
	
Level_state_detect Level_state_detect_inst8(

	.nomal_data(nomal_mode_data[127:112]),
	.trig_mod(trig_mod[3:0]),
	.A_ch_valid(A_ch_valid[127:112]),
	.B_ch_valid(B_ch_valid[127:112]),
	.A_state(A_state[127:112]),
	.B_state(B_state[127:112]),
	.level_clk(level_clk),
	.rst_n(trig_rst_n),
	
	.A_level_state_data(A_level_state_data_8),           //只要用到电平比较的都会输出 只用一个比较电平的从A输出B不用
	.B_level_state_data(B_level_state_data_8)
    );
    
Level_state_detect Level_state_detect_inst9(

	.nomal_data(nomal_mode_data[143:128]),
	.trig_mod(trig_mod[3:0]),
	.A_ch_valid(A_ch_valid[143:128]),
	.B_ch_valid(B_ch_valid[143:128]),
	.A_state(A_state[143:128]),
	.B_state(B_state[143:128]),
	.level_clk(level_clk),
	.rst_n(trig_rst_n),
	
	.A_level_state_data(A_level_state_data_9),           //只要用到电平比较的都会输出 只用一个比较电平的从A输出B不用
	.B_level_state_data(B_level_state_data_9)
    );    

assign	A_level_state_data = (A_level_state_data_1&&A_level_state_data_2&&A_level_state_data_3&&A_level_state_data_4&&A_level_state_data_5&&A_level_state_data_6&&A_level_state_data_7&&A_level_state_data_8&&A_level_state_data_9);
assign	B_level_state_data = (B_level_state_data_1&&B_level_state_data_2&&B_level_state_data_3&&B_level_state_data_4&&B_level_state_data_5&&B_level_state_data_6&&B_level_state_data_7&&B_level_state_data_8&&B_level_state_data_9);

	
endmodule
