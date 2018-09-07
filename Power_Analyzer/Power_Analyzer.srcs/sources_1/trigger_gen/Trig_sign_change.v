`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:58:39 10/28/2016 
// Design Name: 
// Module Name:    Trig_sign_change 
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
module Trig_sign_change(

input 		[31:0]		data,
input		[31:0]		trig_level_ch0,
input		[31:0]		trig_level_ch1,
//input		[31:0]		trig_level_ch2,
//input		[31:0]		trig_level_ch3,
//input		[31:0]		trig_level_ch4,
//input		[31:0]		trig_level_ch5,
//input		[31:0]		trig_level_ch6,
//input		[31:0]		trig_level_ch7,
//input		[31:0]		trig_level_ch8,
//input		[31:0]		trig_level_ch9,
//input		[31:0]		trig_level_ch10,
//input		[31:0]		trig_level_ch11,
//input		[31:0]		trig_level_ch12,
//input		[31:0]		trig_level_ch13,
//input		[31:0]		trig_level_ch14,
//input		[31:0]		trig_level_ch15,     
input					rst_n,
input					trig_clk,

output wire [1:0]		in_mode_data,
output wire [1:0]		out_mode_data,
output wire [1:0]		nomal_mode_data

    );
	 
///////////////////////////////////////////////////////////////////////////////// 
	 
	 
	 
	//data0_15ÎªÍ¨µÀ0
Trig_single_change Trig_single_change_ch0(

	.data(data[15:0]),
	.trig_level_l(trig_level_ch0[15:0]),
	.trig_level_h(trig_level_ch0[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
    .in_data_out(in_mode_data[0]),
    .out_data_out(out_mode_data[0]),
	.nomal_data_out(nomal_mode_data[0])
    );	

Trig_single_change Trig_single_change_ch1(

	.data(data[31:16]),
	.trig_level_l(trig_level_ch1[15:0]),
	.trig_level_h(trig_level_ch1[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
    .in_data_out(in_mode_data[1]),
    .out_data_out(out_mode_data[1]),
	.nomal_data_out(nomal_mode_data[1])
    );
/*	
Trig_single_change Trig_single_change_ch2(

	.data(data[47:32]),
	.trig_level_l(trig_level_ch2[15:0]),
	.trig_level_h(trig_level_ch2[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
  .in_data_out(in_mode_data[2]),
  .out_data_out(out_mode_data[2]),
	.nomal_data_out(nomal_mode_data[2])
    );
	
Trig_single_change Trig_single_change_ch3(

	.data(data[63:48]),
	.trig_level_l(trig_level_ch3[15:0]),
	.trig_level_h(trig_level_ch3[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
  .in_data_out(in_mode_data[3]),
  .out_data_out(out_mode_data[3]),
	.nomal_data_out(nomal_mode_data[3])
    );

Trig_single_change Trig_single_change_ch4(

	.data(data[79:64]),
	.trig_level_l(trig_level_ch4[15:0]),
	.trig_level_h(trig_level_ch4[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
  .in_data_out(in_mode_data[4]),
  .out_data_out(out_mode_data[4]),
	.nomal_data_out(nomal_mode_data[4])
    );

Trig_single_change Trig_single_change_ch5(

	.data(data[95:80]),
	.trig_level_l(trig_level_ch5[15:0]),
	.trig_level_h(trig_level_ch5[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
  .in_data_out(in_mode_data[5]),
  .out_data_out(out_mode_data[5]),
	.nomal_data_out(nomal_mode_data[5])
    );
	
Trig_single_change Trig_single_change_ch6(

	.data(data[111:96]),
	.trig_level_l(trig_level_ch6[15:0]),
	.trig_level_h(trig_level_ch6[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
  .in_data_out(in_mode_data[6]),
  .out_data_out(out_mode_data[6]),
	.nomal_data_out(nomal_mode_data[6])
    );
	
Trig_single_change Trig_single_change_ch7(

	.data(data[127:112]),
	.trig_level_l(trig_level_ch7[15:0]),
	.trig_level_h(trig_level_ch7[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
  .in_data_out(in_mode_data[7]),
  .out_data_out(out_mode_data[7]),
	.nomal_data_out(nomal_mode_data[7])
    );
	
Trig_single_change Trig_single_change_ch8(

	.data(data[143:128]),
	.trig_level_l(trig_level_ch8[15:0]),
	.trig_level_h(trig_level_ch8[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
  .in_data_out(in_mode_data[8]),
  .out_data_out(out_mode_data[8]),
	.nomal_data_out(nomal_mode_data[8])
    );
	
Trig_single_change Trig_single_change_ch9(

	.data(data[159:144]),
	.trig_level_l(trig_level_ch9[15:0]),
	.trig_level_h(trig_level_ch9[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
  .in_data_out(in_mode_data[9]),
  .out_data_out(out_mode_data[9]),
	.nomal_data_out(nomal_mode_data[9])
    );
	
Trig_single_change Trig_single_change_ch10(

	.data(data[175:160]),
	.trig_level_l(trig_level_ch10[15:0]),
	.trig_level_h(trig_level_ch10[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
  .in_data_out(in_mode_data[10]),
  .out_data_out(out_mode_data[10]),
	.nomal_data_out(nomal_mode_data[10])
    );
	
Trig_single_change Trig_single_change_ch11(

	.data(data[191:176]),
	.trig_level_l(trig_level_ch11[15:0]),
	.trig_level_h(trig_level_ch11[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
  .in_data_out(in_mode_data[11]),
  .out_data_out(out_mode_data[11]),
	.nomal_data_out(nomal_mode_data[11])
    );
	
Trig_single_change Trig_single_change_ch12(

	.data(data[207:192]),
	.trig_level_l(trig_level_ch12[15:0]),
	.trig_level_h(trig_level_ch12[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
  .in_data_out(in_mode_data[12]),
  .out_data_out(out_mode_data[12]),
	.nomal_data_out(nomal_mode_data[12])
    );
	
Trig_single_change Trig_single_change_ch13(

	.data(data[223:208]),
	.trig_level_l(trig_level_ch13[15:0]),
	.trig_level_h(trig_level_ch13[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
  .in_data_out(in_mode_data[13]),
  .out_data_out(out_mode_data[13]),
	.nomal_data_out(nomal_mode_data[13])
    );
	
Trig_single_change Trig_single_change_ch14(

	.data(data[239:224]),
	.trig_level_l(trig_level_ch14[15:0]),
	.trig_level_h(trig_level_ch14[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
  .in_data_out(in_mode_data[14]),
  .out_data_out(out_mode_data[14]),
	.nomal_data_out(nomal_mode_data[14])
    );
	
Trig_single_change Trig_single_change_ch15(

	.data(data[255:240]),
	.trig_level_l(trig_level_ch15[15:0]),
	.trig_level_h(trig_level_ch15[31:16]),
	.trig_clk(trig_clk),
	.rst_n(rst_n),
 
  .in_data_out(in_mode_data[15]),
  .out_data_out(out_mode_data[15]),
	.nomal_data_out(nomal_mode_data[15])
    );
*/
endmodule
