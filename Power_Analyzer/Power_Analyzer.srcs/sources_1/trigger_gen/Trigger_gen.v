`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:07:56 11/03/2016 
// Design Name: 
// Module Name:    Trigger_module 
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
module Trigger_gen(
	input 		[31:0]		data1,
	input 		[31:0]		data2,
	input 		[31:0]		data3,
	input 		[31:0]		data4,
	//input 		[31:0]		data5,
	//input 		[31:0]		data6,
	//input 		[31:0]		data7,
	//input 		[31:0]		data8,
	//input	    [31:0]		data9,
	input		[31:0]		trig_level_ch0,
	input		[31:0]		trig_level_ch1,
	input		[31:0]		trig_level_ch2,
	input		[31:0]		trig_level_ch3,
	input		[31:0]		trig_level_ch4,
	input		[31:0]		trig_level_ch5,
	input		[31:0]		trig_level_ch6,
	input		[31:0]		trig_level_ch7,
	//input		[31:0]		trig_level_ch8,
	//input		[31:0]		trig_level_ch9,
	//input		[31:0]		trig_level_ch10,
	//input		[31:0]		trig_level_ch11,
	//input		[31:0]		trig_level_ch12,
	//input		[31:0]		trig_level_ch13,
	//input		[31:0]		trig_level_ch14,
	//input		[31:0]		trig_level_ch15, 
  //
	//input		[31:0]		trig_level_ch16,
	//input		[31:0]		trig_level_ch17,
	//input		[31:0]		trig_level_ch18,
	//input		[31:0]		trig_level_ch19,
	//input		[31:0]		trig_level_ch20,
	//input		[31:0]		trig_level_ch21,
	//input		[31:0]		trig_level_ch22,
	//input		[31:0]		trig_level_ch23,
	//input		[31:0]		trig_level_ch24,
	//input		[31:0]		trig_level_ch25,
	//input		[31:0]		trig_level_ch26,
	//input		[31:0]		trig_level_ch27,
	//input		[31:0]		trig_level_ch28,
	//input		[31:0]		trig_level_ch29,
	//input		[31:0]		trig_level_ch30,
	//input		[31:0]		trig_level_ch31,
  //
	//input		[31:0]		trig_level_ch32,
	//input		[31:0]		trig_level_ch33,
	//input		[31:0]		trig_level_ch34,
	//input		[31:0]		trig_level_ch35,
	//input		[31:0]		trig_level_ch36,
	//input		[31:0]		trig_level_ch37,
	//input		[31:0]		trig_level_ch38,
	//input		[31:0]		trig_level_ch39,
	//input		[31:0]		trig_level_ch40,
	//input		[31:0]		trig_level_ch41,
	//input		[31:0]		trig_level_ch42,
	//input		[31:0]		trig_level_ch43,
	//input		[31:0]		trig_level_ch44,
	//input		[31:0]		trig_level_ch45,
	//input		[31:0]		trig_level_ch46,
	//input		[31:0]		trig_level_ch47,
  //
	//input		[31:0]		trig_level_ch48,
	//input		[31:0]		trig_level_ch49,
	//input		[31:0]		trig_level_ch50,
	//input		[31:0]		trig_level_ch51,
	//input		[31:0]		trig_level_ch52,
	//input		[31:0]		trig_level_ch53,
	//input		[31:0]		trig_level_ch54,
	//input		[31:0]		trig_level_ch55,
	//input		[31:0]		trig_level_ch56,
	//input		[31:0]		trig_level_ch57,
	//input		[31:0]		trig_level_ch58,
	//input		[31:0]		trig_level_ch59,
	//input		[31:0]		trig_level_ch60,
	//input		[31:0]		trig_level_ch61,
	//input		[31:0]		trig_level_ch62,
	//input		[31:0]		trig_level_ch63,
  //
	//input		[31:0]		trig_level_ch64,
	//input		[31:0]		trig_level_ch65,
	//input		[31:0]		trig_level_ch66,
	//input		[31:0]		trig_level_ch67,
	//input		[31:0]		trig_level_ch68,
	//input		[31:0]		trig_level_ch69,
	//input		[31:0]		trig_level_ch70,
	//input		[31:0]		trig_level_ch71,
	//input		[31:0]		trig_level_ch72,
	//input		[31:0]		trig_level_ch73,
	//input		[31:0]		trig_level_ch74,
	//input		[31:0]		trig_level_ch75,
	//input		[31:0]		trig_level_ch76,
	//input		[31:0]		trig_level_ch77,
	//input		[31:0]		trig_level_ch78,
	//input		[31:0]		trig_level_ch79,
  //
	//input		[31:0]		trig_level_ch80,
	//input		[31:0]		trig_level_ch81,
	//input		[31:0]		trig_level_ch82,
	//input		[31:0]		trig_level_ch83,
	//input		[31:0]		trig_level_ch84,
	//input		[31:0]		trig_level_ch85,
	//input		[31:0]		trig_level_ch86,
	//input		[31:0]		trig_level_ch87,
	//input		[31:0]		trig_level_ch88,
	//input		[31:0]		trig_level_ch89,
	//input		[31:0]		trig_level_ch90,
	//input		[31:0]		trig_level_ch91,
	//input		[31:0]		trig_level_ch92,
	//input		[31:0]		trig_level_ch93,
	//input		[31:0]		trig_level_ch94,
	//input		[31:0]		trig_level_ch95,
  //
	//input		[31:0]		trig_level_ch96 ,
	//input		[31:0]		trig_level_ch97 ,
	//input		[31:0]		trig_level_ch98 ,
	//input		[31:0]		trig_level_ch99 ,
	//input		[31:0]		trig_level_ch100,
	//input		[31:0]		trig_level_ch101,
	//input		[31:0]		trig_level_ch102,
	//input		[31:0]		trig_level_ch103,
	//input		[31:0]		trig_level_ch104,
	//input		[31:0]		trig_level_ch105,
	//input		[31:0]		trig_level_ch106,
	//input		[31:0]		trig_level_ch107,
	//input		[31:0]		trig_level_ch108,
	//input		[31:0]		trig_level_ch109,
	//input		[31:0]		trig_level_ch110,
	//input		[31:0]		trig_level_ch111,
  //
	//input		[31:0]		trig_level_ch112,
	//input		[31:0]		trig_level_ch113,
	//input		[31:0]		trig_level_ch114,
	//input		[31:0]		trig_level_ch115,
	//input		[31:0]		trig_level_ch116,
	//input		[31:0]		trig_level_ch117,
	//input		[31:0]		trig_level_ch118,
	//input		[31:0]		trig_level_ch119,
	//input		[31:0]		trig_level_ch120,
	//input		[31:0]		trig_level_ch121,
	//input		[31:0]		trig_level_ch122,
	//input		[31:0]		trig_level_ch123,
	//input		[31:0]		trig_level_ch124,
	//input		[31:0]		trig_level_ch125,
	//input		[31:0]		trig_level_ch126,
  //  input		[31:0]		trig_level_ch127,
  //  
  //  input		[31:0]		trig_level_ch128,
	//input		[31:0]		trig_level_ch129,
	//input		[31:0]		trig_level_ch130,
	//input		[31:0]		trig_level_ch131,
	//input		[31:0]		trig_level_ch132,
	//input		[31:0]		trig_level_ch133,
	//input		[31:0]		trig_level_ch134,
	//input		[31:0]		trig_level_ch135,
	//input		[31:0]		trig_level_ch136,
	//input		[31:0]		trig_level_ch137,
	//input		[31:0]		trig_level_ch138,
	//input		[31:0]		trig_level_ch139,
	//input		[31:0]		trig_level_ch140,
	//input		[31:0]		trig_level_ch141,
	//input		[31:0]		trig_level_ch142,
  //  input		[31:0]		trig_level_ch143,

	output	    [31:0]		auto_trig_level_1,
	output	    [31:0]		auto_trig_level_2,
	output	    [31:0]		auto_trig_level_3,
	output	    [31:0]		auto_trig_level_4,
	output	    [31:0]		auto_trig_level_5,
	output	    [31:0]		auto_trig_level_6,
	output	    [31:0]		auto_trig_level_7,
	output	    [31:0]		auto_trig_level_8,
	//output	    [31:0]		auto_trig_level_9,
	//output	    [31:0]		auto_trig_level_10,
	//output	    [31:0]		auto_trig_level_11,
	//output	    [31:0]		auto_trig_level_12,
	//output	    [31:0]		auto_trig_level_13,
	//output	    [31:0]		auto_trig_level_14,
	//output	    [31:0]		auto_trig_level_15,
	//output	    [31:0]		auto_trig_level_16,
	//output		[31:0]		auto_trig_level_17, 
  //  output		[31:0]		auto_trig_level_18, 
  //  output		[31:0]		auto_trig_level_19, 
  //  output		[31:0]		auto_trig_level_20, 
  //  output		[31:0]		auto_trig_level_21, 
  //  output		[31:0]		auto_trig_level_22, 
  //  output		[31:0]		auto_trig_level_23, 
  //  output		[31:0]		auto_trig_level_24, 
  //  output		[31:0]		auto_trig_level_25, 
  //  output		[31:0]		auto_trig_level_26, 
  //  output		[31:0]		auto_trig_level_27, 
  //  output		[31:0]		auto_trig_level_28, 
  //  output		[31:0]		auto_trig_level_29, 
  //  output		[31:0]		auto_trig_level_30, 
  //  output		[31:0]		auto_trig_level_31, 
  //  output		[31:0]		auto_trig_level_32, 
  //                                              
  //  output		[31:0]		auto_trig_level_33, 
  //  output		[31:0]		auto_trig_level_34, 
  //  output		[31:0]		auto_trig_level_35, 
  //  output		[31:0]		auto_trig_level_36, 
  //  output		[31:0]		auto_trig_level_37, 
  //  output		[31:0]		auto_trig_level_38, 
  //  output		[31:0]		auto_trig_level_39, 
  //  output		[31:0]		auto_trig_level_40, 
  //  output		[31:0]		auto_trig_level_41, 
  //  output		[31:0]		auto_trig_level_42, 
  //  output		[31:0]		auto_trig_level_43, 
  //  output		[31:0]		auto_trig_level_44, 
  //  output		[31:0]		auto_trig_level_45, 
  //  output		[31:0]		auto_trig_level_46, 
  //  output		[31:0]		auto_trig_level_47, 
  //  output		[31:0]		auto_trig_level_48, 
  //                                              
  //  output		[31:0]		auto_trig_level_49, 
  //  output		[31:0]		auto_trig_level_50, 
  //  output		[31:0]		auto_trig_level_51, 
  //  output		[31:0]		auto_trig_level_52, 
  //  output		[31:0]		auto_trig_level_53, 
  //  output		[31:0]		auto_trig_level_54, 
  //  output		[31:0]		auto_trig_level_55, 
  //  output		[31:0]		auto_trig_level_56, 
  //  output		[31:0]		auto_trig_level_57, 
  //  output		[31:0]		auto_trig_level_58, 
  //  output		[31:0]		auto_trig_level_59, 
  //  output		[31:0]		auto_trig_level_60, 
  //  output		[31:0]		auto_trig_level_61, 
  //  output		[31:0]		auto_trig_level_62, 
  //  output		[31:0]		auto_trig_level_63, 
  //  output		[31:0]		auto_trig_level_64, 
  //                                              
  //  output		[31:0]		auto_trig_level_65, 
  //  output		[31:0]		auto_trig_level_66, 
  //  output		[31:0]		auto_trig_level_67, 
  //  output		[31:0]		auto_trig_level_68, 
  //  output		[31:0]		auto_trig_level_69, 
  //  output		[31:0]		auto_trig_level_70, 
  //  output		[31:0]		auto_trig_level_71, 
  //  output		[31:0]		auto_trig_level_72, 
  //  output		[31:0]		auto_trig_level_73, 
  //  output		[31:0]		auto_trig_level_74, 
  //  output		[31:0]		auto_trig_level_75, 
  //  output		[31:0]		auto_trig_level_76, 
  //  output		[31:0]		auto_trig_level_77, 
  //  output		[31:0]		auto_trig_level_78, 
  //  output		[31:0]		auto_trig_level_79, 
  //  output		[31:0]		auto_trig_level_80, 
  //                                              
  //  output		[31:0]		auto_trig_level_81, 
  //  output		[31:0]		auto_trig_level_82, 
  //  output		[31:0]		auto_trig_level_83, 
  //  output		[31:0]		auto_trig_level_84, 
  //  output		[31:0]		auto_trig_level_85, 
  //  output		[31:0]		auto_trig_level_86, 
  //  output		[31:0]		auto_trig_level_87, 
  //  output		[31:0]		auto_trig_level_88, 
  //  output		[31:0]		auto_trig_level_89, 
  //  output		[31:0]		auto_trig_level_90, 
  //  output		[31:0]		auto_trig_level_91, 
  //  output		[31:0]		auto_trig_level_92, 
  //  output		[31:0]		auto_trig_level_93, 
  //  output		[31:0]		auto_trig_level_94, 
  //  output		[31:0]		auto_trig_level_95, 
  //  output		[31:0]		auto_trig_level_96, 
  //                                              
  //  output		[31:0]		auto_trig_level_97, 
  //  output		[31:0]		auto_trig_level_98, 
  //  output		[31:0]		auto_trig_level_99, 
  //  output		[31:0]		auto_trig_level_100,
  //  output		[31:0]		auto_trig_level_101,
  //  output		[31:0]		auto_trig_level_102,
  //  output		[31:0]		auto_trig_level_103,
  //  output		[31:0]		auto_trig_level_104,
  //  output		[31:0]		auto_trig_level_105,
  //  output		[31:0]		auto_trig_level_106,
  //  output		[31:0]		auto_trig_level_107,
  //  output		[31:0]		auto_trig_level_108,
  //  output		[31:0]		auto_trig_level_109,
  //  output		[31:0]		auto_trig_level_110,
  //  output		[31:0]		auto_trig_level_111,
  //  output		[31:0]		auto_trig_level_112,
  //                                              
  //  output		[31:0]		auto_trig_level_113,
  //  output		[31:0]		auto_trig_level_114,
  //  output		[31:0]		auto_trig_level_115,
  //  output		[31:0]		auto_trig_level_116,
  //  output		[31:0]		auto_trig_level_117,
  //  output		[31:0]		auto_trig_level_118,
  //  output		[31:0]		auto_trig_level_119,
  //  output		[31:0]		auto_trig_level_120,
  //  output		[31:0]		auto_trig_level_121,
  //  output		[31:0]		auto_trig_level_122,
  //  output		[31:0]		auto_trig_level_123,
  //  output		[31:0]		auto_trig_level_124,
  //  output		[31:0]		auto_trig_level_125,
  //  output		[31:0]		auto_trig_level_126,
  //  output		[31:0]		auto_trig_level_127,
  //  output		[31:0]		auto_trig_level_128,
  //  
  //  output		[31:0]		auto_trig_level_129,
  //  output		[31:0]		auto_trig_level_130,
  //  output		[31:0]		auto_trig_level_131,
  //  output		[31:0]		auto_trig_level_132,
  //  output		[31:0]		auto_trig_level_133,
  //  output		[31:0]		auto_trig_level_134,
  //  output		[31:0]		auto_trig_level_135,
  //  output		[31:0]		auto_trig_level_136,
  //  output		[31:0]		auto_trig_level_137,
  //  output		[31:0]		auto_trig_level_138,
  //  output		[31:0]		auto_trig_level_139,
  //  output		[31:0]		auto_trig_level_140,
  //  output		[31:0]		auto_trig_level_141,
  //  output		[31:0]		auto_trig_level_142,
  //  output		[31:0]		auto_trig_level_143,
  //  output		[31:0]		auto_trig_level_144,


	input		[31:0]		trig_mod,
	input		[31:0]		Edge_mode,        
	input		[7:0]		Edge_ch_valid,
	input		[143:0]		A_ch_valid,
	input		[143:0]		B_ch_valid,
	input		[143:0]		A_state,
	input		[143:0]		B_state,
	input 	[31:0]		ABN_num,    
	input 	[31:0]		AdelayB_time,	
	
	input					trig_clk,
	input					trig_rst_n,
	input					clk_1KHz,
	input					trig_level_sel,
	
	output					trig_out
	
	//output					edge_pulse,    //边沿触发输出
	//output					A_BN_pulse,    //A-B(N)触发输出
	//output					ADelayB_pulse,  //ADelayB触发输出
	//output					edge_on_A_pulse,  //edge_on_A触发输出
    //output					Or_pulse,			//OR触发输出
	//output					And_pulse,          //and触发输出
	//output					Period_pulse,		//Period触发输出
	//output					Pulse_width_pulse	//Pulse_width触发输出
	);

(*KEEP="TRUE"*)	wire		[143:0]		in_mode_data;
(*KEEP="TRUE"*)	wire		[143:0]		out_mode_data;
(*KEEP="TRUE"*)	wire		[143:0]		nomal_mode_data;
(*KEEP="TRUE"*)	wire		[143:0]		rise_edge;		
(*KEEP="TRUE"*)	wire		[143:0]		fall_edge;		
(*KEEP="TRUE"*)	wire		[143:0]		rise_or_fall_edge;	
(*KEEP="TRUE"*)	wire					A_level_state_data;
(*KEEP="TRUE"*)	wire					B_level_state_data;
(*KEEP="TRUE"*)  wire	   [31:0]     auto_trig_level_1; 
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_2; 
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_3; 
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_4; 
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_5; 
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_6; 
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_7; 
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_8; 
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_9; 
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_10;
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_11;
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_12;
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_13;
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_14;
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_15;
(*KEEP="TRUE"*)  wire      [31:0]	  auto_trig_level_16;





//assign trig_out = edge_pulse|A_BN_pulse|ADelayB_pulse|edge_on_A_pulse|Or_pulse|And_pulse|Period_pulse|Pulse_width_pulse;
assign trig_out = edge_pulse;     //只选择边沿触发


Autolevel_trigger Autolevel_trigger_inst(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data1(data1),
	.data2(data2),
	.data3(data3),
	.data4(data4),
	//.data5(data5),
	//.data6(data6),
	//.data7(data7),
	//.data8(data8),	
	//.data9(data9),
	.trigger(trig_out),
	
	.auto_trig_level_1(auto_trig_level_1),
	.auto_trig_level_2(auto_trig_level_2),
	.auto_trig_level_3(auto_trig_level_3),
	.auto_trig_level_4(auto_trig_level_4),
	.auto_trig_level_5(auto_trig_level_5),
	.auto_trig_level_6(auto_trig_level_6),
	.auto_trig_level_7(auto_trig_level_7),
	.auto_trig_level_8(auto_trig_level_8)
	//.auto_trig_level_9(auto_trig_level_9),
	//.auto_trig_level_10(auto_trig_level_10),
	//.auto_trig_level_11(auto_trig_level_11),
	//.auto_trig_level_12(auto_trig_level_12),
	//.auto_trig_level_13(auto_trig_level_13),
	//.auto_trig_level_14(auto_trig_level_14),
	//.auto_trig_level_15(auto_trig_level_15),
	//.auto_trig_level_16(auto_trig_level_16),
	//
	//.auto_trig_level_17(auto_trig_level_17),                     
	//.auto_trig_level_18(auto_trig_level_18),                     
	//.auto_trig_level_19(auto_trig_level_19),                     
	//.auto_trig_level_20(auto_trig_level_20),                     
	//.auto_trig_level_21(auto_trig_level_21),                     
	//.auto_trig_level_22(auto_trig_level_22),                     
	//.auto_trig_level_23(auto_trig_level_23),                     
	//.auto_trig_level_24(auto_trig_level_24),                     
	//.auto_trig_level_25(auto_trig_level_25),                     
	//.auto_trig_level_26(auto_trig_level_26),                     
	//.auto_trig_level_27(auto_trig_level_27),                     
	//.auto_trig_level_28(auto_trig_level_28),                     
	//.auto_trig_level_29(auto_trig_level_29),                     
	//.auto_trig_level_30(auto_trig_level_30),                     
	//.auto_trig_level_31(auto_trig_level_31),                     
	//.auto_trig_level_32(auto_trig_level_32),                     
  //                  
	//.auto_trig_level_33(auto_trig_level_33),                     
	//.auto_trig_level_34(auto_trig_level_34),                     
	//.auto_trig_level_35(auto_trig_level_35),                     
	//.auto_trig_level_36(auto_trig_level_36),                     
	//.auto_trig_level_37(auto_trig_level_37),                     
	//.auto_trig_level_38(auto_trig_level_38),                     
	//.auto_trig_level_39(auto_trig_level_39),                     
	//.auto_trig_level_40(auto_trig_level_40),                     
	//.auto_trig_level_41(auto_trig_level_41),                     
	//.auto_trig_level_42(auto_trig_level_42),                     
	//.auto_trig_level_43(auto_trig_level_43),                     
	//.auto_trig_level_44(auto_trig_level_44),                     
	//.auto_trig_level_45(auto_trig_level_45),                     
	//.auto_trig_level_46(auto_trig_level_46),                     
	//.auto_trig_level_47(auto_trig_level_47),                     
	//.auto_trig_level_48(auto_trig_level_48),                     
  //                   
	//.auto_trig_level_49(auto_trig_level_49),                     
	//.auto_trig_level_50(auto_trig_level_50),                     
	//.auto_trig_level_51(auto_trig_level_51),                     
	//.auto_trig_level_52(auto_trig_level_52),                     
	//.auto_trig_level_53(auto_trig_level_53),                     
	//.auto_trig_level_54(auto_trig_level_54),                     
	//.auto_trig_level_55(auto_trig_level_55),                     
	//.auto_trig_level_56(auto_trig_level_56),                     
	//.auto_trig_level_57(auto_trig_level_57),                     
	//.auto_trig_level_58(auto_trig_level_58),                     
	//.auto_trig_level_59(auto_trig_level_59),                     
	//.auto_trig_level_60(auto_trig_level_60),                     
	//.auto_trig_level_61(auto_trig_level_61),                     
	//.auto_trig_level_62(auto_trig_level_62),                     
	//.auto_trig_level_63(auto_trig_level_63),                     
	//.auto_trig_level_64(auto_trig_level_64),                     
  //                   
	//.auto_trig_level_65(auto_trig_level_65),                     
	//.auto_trig_level_66(auto_trig_level_66),                     
	//.auto_trig_level_67(auto_trig_level_67),                     
	//.auto_trig_level_68(auto_trig_level_68),                     
	//.auto_trig_level_69(auto_trig_level_69),                     
	//.auto_trig_level_70(auto_trig_level_70),                     
	//.auto_trig_level_71(auto_trig_level_71),                     
	//.auto_trig_level_72(auto_trig_level_72),                     
	//.auto_trig_level_73(auto_trig_level_73),                     
	//.auto_trig_level_74(auto_trig_level_74),                     
	//.auto_trig_level_75(auto_trig_level_75),                     
	//.auto_trig_level_76(auto_trig_level_76),                     
	//.auto_trig_level_77(auto_trig_level_77),                     
	//.auto_trig_level_78(auto_trig_level_78),                     
	//.auto_trig_level_79(auto_trig_level_79),                     
	//.auto_trig_level_80(auto_trig_level_80),                     
  //                   
	//.auto_trig_level_81(auto_trig_level_81),                     
	//.auto_trig_level_82(auto_trig_level_82),                     
	//.auto_trig_level_83(auto_trig_level_83),                     
	//.auto_trig_level_84(auto_trig_level_84),                     
	//.auto_trig_level_85(auto_trig_level_85),                     
	//.auto_trig_level_86(auto_trig_level_86),                     
	//.auto_trig_level_87(auto_trig_level_87),                     
	//.auto_trig_level_88(auto_trig_level_88),                     
	//.auto_trig_level_89(auto_trig_level_89),                     
	//.auto_trig_level_90(auto_trig_level_90),                     
	//.auto_trig_level_91(auto_trig_level_91),                     
	//.auto_trig_level_92(auto_trig_level_92),                     
	//.auto_trig_level_93(auto_trig_level_93),                     
	//.auto_trig_level_94(auto_trig_level_94),                     
	//.auto_trig_level_95(auto_trig_level_95),                     
	//.auto_trig_level_96(auto_trig_level_96),                     
  //                   
	//.auto_trig_level_97(auto_trig_level_97),                     
	//.auto_trig_level_98(auto_trig_level_98),                     
	//.auto_trig_level_99(auto_trig_level_99),                     
	//.auto_trig_level_100(auto_trig_level_100),                    
	//.auto_trig_level_101(auto_trig_level_101),                    
	//.auto_trig_level_102(auto_trig_level_102),                    
	//.auto_trig_level_103(auto_trig_level_103),                    
	//.auto_trig_level_104(auto_trig_level_104),                    
	//.auto_trig_level_105(auto_trig_level_105),                    
	//.auto_trig_level_106(auto_trig_level_106),                    
	//.auto_trig_level_107(auto_trig_level_107),                    
	//.auto_trig_level_108(auto_trig_level_108),                    
	//.auto_trig_level_109(auto_trig_level_109),                    
	//.auto_trig_level_110(auto_trig_level_110),                    
	//.auto_trig_level_111(auto_trig_level_111),                    
	//.auto_trig_level_112(auto_trig_level_112),                    
  //                   
	//.auto_trig_level_113(auto_trig_level_113),                    
	//.auto_trig_level_114(auto_trig_level_114),                    
	//.auto_trig_level_115(auto_trig_level_115),                    
	//.auto_trig_level_116(auto_trig_level_116),                    
	//.auto_trig_level_117(auto_trig_level_117),                    
	//.auto_trig_level_118(auto_trig_level_118),                    
	//.auto_trig_level_119(auto_trig_level_119),
  //  .auto_trig_level_120(auto_trig_level_120),
	//.auto_trig_level_121(auto_trig_level_121),                    
	//.auto_trig_level_122(auto_trig_level_122),                    
	//.auto_trig_level_123(auto_trig_level_123),                    
	//.auto_trig_level_124(auto_trig_level_124),                    
	//.auto_trig_level_125(auto_trig_level_125),                    
	//.auto_trig_level_126(auto_trig_level_126),                    
	//.auto_trig_level_127(auto_trig_level_127),                    
	//.auto_trig_level_128(auto_trig_level_128),
	//
	//.auto_trig_level_129(auto_trig_level_129),                    
	//.auto_trig_level_130(auto_trig_level_130),                    
	//.auto_trig_level_131(auto_trig_level_131),                    
	//.auto_trig_level_132(auto_trig_level_132),                    
	//.auto_trig_level_133(auto_trig_level_133),                    
	//.auto_trig_level_134(auto_trig_level_134),                    
	//.auto_trig_level_135(auto_trig_level_135),
  //  .auto_trig_level_136(auto_trig_level_136),
	//.auto_trig_level_137(auto_trig_level_137),                    
	//.auto_trig_level_138(auto_trig_level_138),                    
	//.auto_trig_level_139(auto_trig_level_139),                    
	//.auto_trig_level_140(auto_trig_level_140),                    
	//.auto_trig_level_141(auto_trig_level_141),                    
	//.auto_trig_level_142(auto_trig_level_142),                    
	//.auto_trig_level_143(auto_trig_level_143),                    
	//.auto_trig_level_144(auto_trig_level_144)                       
		
    );
    
    
		
//输入信号转换成方波
Trig_sign_change_128ch Trig_sign_change_128ch_inst(

	.data1(data1),
	.data2(data2),
	.data3(data3),
	.data4(data4),
	//.data5(data5),
	//.data6(data6),
	//.data7(data7),
	//.data8(data8),
	//.data9(data9),   
	.trig_level_ch0(trig_level_ch0),
	.trig_level_ch1(trig_level_ch1),
	.trig_level_ch2(trig_level_ch2),
	.trig_level_ch3(trig_level_ch3),
	.trig_level_ch4(trig_level_ch4),
	.trig_level_ch5(trig_level_ch5),
	.trig_level_ch6(trig_level_ch6),
	.trig_level_ch7(trig_level_ch7),
	//.trig_level_ch8(trig_level_ch8),
	//.trig_level_ch9(trig_level_ch9),
	//.trig_level_ch10(trig_level_ch10),
	//.trig_level_ch11(trig_level_ch11),
	//.trig_level_ch12(trig_level_ch12),
	//.trig_level_ch13(trig_level_ch13),
	//.trig_level_ch14(trig_level_ch14),
	//.trig_level_ch15(trig_level_ch15), 
  //
	//.trig_level_ch16(trig_level_ch16),
	//.trig_level_ch17(trig_level_ch17),
	//.trig_level_ch18(trig_level_ch18),
	//.trig_level_ch19(trig_level_ch19),
	//.trig_level_ch20(trig_level_ch20),
	//.trig_level_ch21(trig_level_ch21),
	//.trig_level_ch22(trig_level_ch22),
	//.trig_level_ch23(trig_level_ch23),
	//.trig_level_ch24(trig_level_ch24),
	//.trig_level_ch25(trig_level_ch25),
	//.trig_level_ch26(trig_level_ch26),
	//.trig_level_ch27(trig_level_ch27),
	//.trig_level_ch28(trig_level_ch28),
	//.trig_level_ch29(trig_level_ch29),
	//.trig_level_ch30(trig_level_ch30),
	//.trig_level_ch31(trig_level_ch31),
  //
	//.trig_level_ch32(trig_level_ch32),
	//.trig_level_ch33(trig_level_ch33),
	//.trig_level_ch34(trig_level_ch34),
	//.trig_level_ch35(trig_level_ch35),
	//.trig_level_ch36(trig_level_ch36),
	//.trig_level_ch37(trig_level_ch37),
	//.trig_level_ch38(trig_level_ch38),
	//.trig_level_ch39(trig_level_ch39),
	//.trig_level_ch40(trig_level_ch40),
	//.trig_level_ch41(trig_level_ch41),
	//.trig_level_ch42(trig_level_ch42),
	//.trig_level_ch43(trig_level_ch43),
	//.trig_level_ch44(trig_level_ch44),
	//.trig_level_ch45(trig_level_ch45),
	//.trig_level_ch46(trig_level_ch46),
	//.trig_level_ch47(trig_level_ch47),
  //
	//.trig_level_ch48(trig_level_ch48),
	//.trig_level_ch49(trig_level_ch49),
	//.trig_level_ch50(trig_level_ch50),
	//.trig_level_ch51(trig_level_ch51),
	//.trig_level_ch52(trig_level_ch52),
	//.trig_level_ch53(trig_level_ch53),
	//.trig_level_ch54(trig_level_ch54),
	//.trig_level_ch55(trig_level_ch55),
	//.trig_level_ch56(trig_level_ch56),
	//.trig_level_ch57(trig_level_ch57),
	//.trig_level_ch58(trig_level_ch58),
	//.trig_level_ch59(trig_level_ch59),
	//.trig_level_ch60(trig_level_ch60),
	//.trig_level_ch61(trig_level_ch61),
	//.trig_level_ch62(trig_level_ch62),
	//.trig_level_ch63(trig_level_ch63),
  //
	//.trig_level_ch64(trig_level_ch64),
	//.trig_level_ch65(trig_level_ch65),
	//.trig_level_ch66(trig_level_ch66),
	//.trig_level_ch67(trig_level_ch67),
	//.trig_level_ch68(trig_level_ch68),
	//.trig_level_ch69(trig_level_ch69),
	//.trig_level_ch70(trig_level_ch70),
	//.trig_level_ch71(trig_level_ch71),
	//.trig_level_ch72(trig_level_ch72),
	//.trig_level_ch73(trig_level_ch73),
	//.trig_level_ch74(trig_level_ch74),
	//.trig_level_ch75(trig_level_ch75),
	//.trig_level_ch76(trig_level_ch76),
	//.trig_level_ch77(trig_level_ch77),
	//.trig_level_ch78(trig_level_ch78),
	//.trig_level_ch79(trig_level_ch79),
  //
	//.trig_level_ch80(trig_level_ch80),
	//.trig_level_ch81(trig_level_ch81),
	//.trig_level_ch82(trig_level_ch82),
	//.trig_level_ch83(trig_level_ch83),
	//.trig_level_ch84(trig_level_ch84),
	//.trig_level_ch85(trig_level_ch85),
	//.trig_level_ch86(trig_level_ch86),
	//.trig_level_ch87(trig_level_ch87),
	//.trig_level_ch88(trig_level_ch88),
	//.trig_level_ch89(trig_level_ch89),
	//.trig_level_ch90(trig_level_ch90),
	//.trig_level_ch91(trig_level_ch91),
	//.trig_level_ch92(trig_level_ch92),
	//.trig_level_ch93(trig_level_ch93),
	//.trig_level_ch94(trig_level_ch94),
	//.trig_level_ch95(trig_level_ch95),
  //
	//.trig_level_ch96(trig_level_ch96),
	//.trig_level_ch97(trig_level_ch97),
	//.trig_level_ch98(trig_level_ch98),
	//.trig_level_ch99(trig_level_ch99),
	//.trig_level_ch100(trig_level_ch100),
	//.trig_level_ch101(trig_level_ch101),
	//.trig_level_ch102(trig_level_ch102),
	//.trig_level_ch103(trig_level_ch103),
	//.trig_level_ch104(trig_level_ch104),
	//.trig_level_ch105(trig_level_ch105),
	//.trig_level_ch106(trig_level_ch106),
	//.trig_level_ch107(trig_level_ch107),
	//.trig_level_ch108(trig_level_ch108),
	//.trig_level_ch109(trig_level_ch109),
	//.trig_level_ch110(trig_level_ch110),
	//.trig_level_ch111(trig_level_ch111),
  //
	//.trig_level_ch112(trig_level_ch112),
	//.trig_level_ch113(trig_level_ch113),
	//.trig_level_ch114(trig_level_ch114),
	//.trig_level_ch115(trig_level_ch115),
	//.trig_level_ch116(trig_level_ch116),
	//.trig_level_ch117(trig_level_ch117),
	//.trig_level_ch118(trig_level_ch118),
	//.trig_level_ch119(trig_level_ch119),
	//.trig_level_ch120(trig_level_ch120),
	//.trig_level_ch121(trig_level_ch121),
	//.trig_level_ch122(trig_level_ch122),
	//.trig_level_ch123(trig_level_ch123),
	//.trig_level_ch124(trig_level_ch124),
	//.trig_level_ch125(trig_level_ch125),
	//.trig_level_ch126(trig_level_ch126),
	//.trig_level_ch127(trig_level_ch127),
	//
	//.trig_level_ch128(trig_level_ch128),
	//.trig_level_ch129(trig_level_ch129),
	//.trig_level_ch130(trig_level_ch130),
	//.trig_level_ch131(trig_level_ch131),
	//.trig_level_ch132(trig_level_ch132),
	//.trig_level_ch133(trig_level_ch133),
	//.trig_level_ch134(trig_level_ch134),
	//.trig_level_ch135(trig_level_ch135),
	//.trig_level_ch136(trig_level_ch136),
	//.trig_level_ch137(trig_level_ch137),
	//.trig_level_ch138(trig_level_ch138),
	//.trig_level_ch139(trig_level_ch139),
	//.trig_level_ch140(trig_level_ch140),
	//.trig_level_ch141(trig_level_ch141),
	//.trig_level_ch142(trig_level_ch142),
	//.trig_level_ch143(trig_level_ch143),
	.trig_rst_n( trig_rst_n ),
	.trig_clk(trig_clk),

	.in_mode_data(in_mode_data),
	.out_mode_data(out_mode_data),
	.nomal_mode_data(nomal_mode_data)
    );
 
//电平状态检测    
 Level_state_detect_143ch Level_state_detect_143ch_inst(

	.nomal_mode_data(nomal_mode_data),
	.trig_mod(trig_mod[3:0]),
	.A_ch_valid(A_ch_valid),
	.B_ch_valid(B_ch_valid),
	.A_state(A_state),
	.B_state(B_state),
	.level_clk(trig_clk),
	.trig_rst_n(trig_rst_n),
	
	.A_level_state_data(A_level_state_data),           //只要用到电平比较的都会输出 只用一个比较电平的从A输出B不用
	.B_level_state_data(B_level_state_data)
    );
    
//边沿状态检测    
 Edge_detect_143ch Edge_detect_143ch(    

    .nomal_mode_data(nomal_mode_data),           
    .trig_rst_n(trig_rst_n),                
    .edge_clk(trig_clk),             
                         
    .rise_edge(rise_edge),            
    .fall_edge(fall_edge),            
    .rise_or_fall_edge(rise_or_fall_edge)     
    );


//边沿触发    
Edge_trigger Edge_trigger_inst(

    .rise_edge_data(rise_edge),
    .fall_edge_data(fall_edge),
    .rise_or_fall_edge_data(rise_or_fall_edge),
    .trig_mode(trig_mod[3:0]),
    .A_ch_valid(Edge_ch_valid),
    .A_state(Edge_mode[1:0]),
    .edge_clk(trig_clk),
    .rst_n(trig_rst_n),
    
    .edge_pulse(edge_pulse)
    );
    
//A-B(N)触发
A_BN_trigger A_BN_trigger_inst(

    .A_level_state_data(A_level_state_data),
    .B_level_state_data(B_level_state_data),
    .trig_mod(trig_mod[5:0]),
    .trig_numb(ABN_num),
    .rst_n(trig_rst_n),
    .A_BN_clk(trig_clk),
    
    .A_BN_pulse(A_BN_pulse)
    );

//ADelayB触发	
ADelayB_trigger ADelayB_trigger_inst(
	.A_level_state_data(A_level_state_data),
	.B_level_state_data(B_level_state_data),
	.trig_mod(trig_mod[5:0]),
	.AdelayB_time(AdelayB_time),
	.rst_n(trig_rst_n),
	.ADelayB_clk(trig_clk),
	
	.ADelayB_pulse(ADelayB_pulse)

    );
	
//OR触发
Or_trigger Or_trigger_inst(

	.trig_mod(trig_mod[3:0]),
	.A_ch_valid(A_ch_valid),
	.B_ch_valid(B_ch_valid),
	.A_state(A_state),
	.B_state(B_state),
	.out_mode_data(out_mode_data),
	.in_mode_data(in_mode_data),
	.rise_edge_data(rise_edge),
	.fall_edge_data(fall_edge),
	.Or_clk(trig_clk),
	.rst_n(trig_rst_n),
	
	.Or_pulse(Or_pulse)
    );
	
//Edge_on_A触发
Edge_on_A_trigger Edge_on_A_trigger_inst(

	.rise_edge_data(rise_edge),
	.fall_edge_data(fall_edge),
	.trig_mode(trig_mod),
	.A_level_state_data(A_level_state_data),
	.B_ch_valid(B_ch_valid),
	.B_state(B_state),    
	.edge_on_A_clk(trig_clk),
	.rst_n(trig_rst_n),
	
	.edge_on_A_pulse(edge_on_A_pulse)
	
	);
//AND触发
And_trigger And_trigger_inst(

	.trig_mod(trig_mod[3:0]),
	.A_ch_valid(A_ch_valid),
	.B_ch_valid(B_ch_valid),
	.A_state(A_state),
	.B_state(B_state),
	.out_mode_data(out_mode_data),
	.in_mode_data(in_mode_data),
	.A_level_state_data(A_level_state_data),
	.And_clk(trig_clk),
	.rst_n(trig_rst_n),
	
	.And_pulse(And_pulse)
    );
    
//Period触发
Period_trigger Period_trigger_inst(

	.trig_mode(trig_mod),
	.A_level_state_data(A_level_state_data),
	.B_ch_valid(B_ch_valid),             //T1 OR TIME
	.B_state(B_state),			    	//T2
	.Period_clk(trig_clk),
	.rst_n(trig_rst_n),
	
	.Period_pulse(Period_pulse)

    );

//Pulse_width触发
Pulse_width_trigger Pulse_width_trigger_inst(

	.trig_mode(trig_mod),
	.A_level_state_data(A_level_state_data),
	.B_ch_valid(B_ch_valid),             //T1 OR TIME
	.B_state(B_state),				//T2
	.Pulse_width_clk(trig_clk),
	.rst_n(trig_rst_n),
	
	.Pulse_width_pulse(Pulse_width_pulse)
    );   


endmodule