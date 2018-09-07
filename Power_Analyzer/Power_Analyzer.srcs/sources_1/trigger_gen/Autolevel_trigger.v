`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:52:15 11/27/2017 
// Design Name: 
// Module Name:    Autolevel_trigger 
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
module Autolevel_trigger(

input					clk_1KHz,
input					clk,
input					rst_n,
input		[31:0]		data1,
input		[31:0]		data2,
input		[31:0]		data3,
input		[31:0]		data4,
//input		[255:0]		data5,
//input		[255:0]		data6,
//input		[255:0]		data7,
//input		[255:0]		data8,
//input		[255:0]		data9,

input					trigger,

output		[15:0]		auto_trig_level_1,
output		[15:0]		auto_trig_level_2,
output		[15:0]		auto_trig_level_3,
output		[15:0]		auto_trig_level_4,
output		[15:0]		auto_trig_level_5,
output		[15:0]		auto_trig_level_6,
output		[15:0]		auto_trig_level_7,
output		[15:0]		auto_trig_level_8
//output		[15:0]		auto_trig_level_9,
//output		[15:0]		auto_trig_level_10,
//output		[15:0]		auto_trig_level_11,
//output		[15:0]		auto_trig_level_12,
//output		[15:0]		auto_trig_level_13,
//output		[15:0]		auto_trig_level_14,
//output		[15:0]		auto_trig_level_15,
//output		[15:0]		auto_trig_level_16,
//
//output		[15:0]		auto_trig_level_17,
//output		[15:0]		auto_trig_level_18,
//output		[15:0]		auto_trig_level_19,
//output		[15:0]		auto_trig_level_20,
//output		[15:0]		auto_trig_level_21,
//output		[15:0]		auto_trig_level_22,
//output		[15:0]		auto_trig_level_23,
//output		[15:0]		auto_trig_level_24,
//output		[15:0]		auto_trig_level_25,
//output		[15:0]		auto_trig_level_26,
//output		[15:0]		auto_trig_level_27,
//output		[15:0]		auto_trig_level_28,
//output		[15:0]		auto_trig_level_29,
//output		[15:0]		auto_trig_level_30,
//output		[15:0]		auto_trig_level_31,
//output		[15:0]		auto_trig_level_32,
//
//output		[15:0]		auto_trig_level_33,
//output		[15:0]		auto_trig_level_34,
//output		[15:0]		auto_trig_level_35,
//output		[15:0]		auto_trig_level_36,
//output		[15:0]		auto_trig_level_37,
//output		[15:0]		auto_trig_level_38,
//output		[15:0]		auto_trig_level_39,
//output		[15:0]		auto_trig_level_40,
//output		[15:0]		auto_trig_level_41,
//output		[15:0]		auto_trig_level_42,
//output		[15:0]		auto_trig_level_43,
//output		[15:0]		auto_trig_level_44,
//output		[15:0]		auto_trig_level_45,
//output		[15:0]		auto_trig_level_46,
//output		[15:0]		auto_trig_level_47,
//output		[15:0]		auto_trig_level_48,
//
//output		[15:0]		auto_trig_level_49,
//output		[15:0]		auto_trig_level_50,
//output		[15:0]		auto_trig_level_51,
//output		[15:0]		auto_trig_level_52,
//output		[15:0]		auto_trig_level_53,
//output		[15:0]		auto_trig_level_54,
//output		[15:0]		auto_trig_level_55,
//output		[15:0]		auto_trig_level_56,
//output		[15:0]		auto_trig_level_57,
//output		[15:0]		auto_trig_level_58,
//output		[15:0]		auto_trig_level_59,
//output		[15:0]		auto_trig_level_60,
//output		[15:0]		auto_trig_level_61,
//output		[15:0]		auto_trig_level_62,
//output		[15:0]		auto_trig_level_63,
//output		[15:0]		auto_trig_level_64,
//
//output		[15:0]		auto_trig_level_65,
//output		[15:0]		auto_trig_level_66,
//output		[15:0]		auto_trig_level_67,
//output		[15:0]		auto_trig_level_68,
//output		[15:0]		auto_trig_level_69,
//output		[15:0]		auto_trig_level_70,
//output		[15:0]		auto_trig_level_71,
//output		[15:0]		auto_trig_level_72,
//output		[15:0]		auto_trig_level_73,
//output		[15:0]		auto_trig_level_74,
//output		[15:0]		auto_trig_level_75,
//output		[15:0]		auto_trig_level_76,
//output		[15:0]		auto_trig_level_77,
//output		[15:0]		auto_trig_level_78,
//output		[15:0]		auto_trig_level_79,
//output		[15:0]		auto_trig_level_80,
//
//output		[15:0]		auto_trig_level_81,
//output		[15:0]		auto_trig_level_82,
//output		[15:0]		auto_trig_level_83,
//output		[15:0]		auto_trig_level_84,
//output		[15:0]		auto_trig_level_85,
//output		[15:0]		auto_trig_level_86,
//output		[15:0]		auto_trig_level_87,
//output		[15:0]		auto_trig_level_88,
//output		[15:0]		auto_trig_level_89,
//output		[15:0]		auto_trig_level_90,
//output		[15:0]		auto_trig_level_91,
//output		[15:0]		auto_trig_level_92,
//output		[15:0]		auto_trig_level_93,
//output		[15:0]		auto_trig_level_94,
//output		[15:0]		auto_trig_level_95,
//output		[15:0]		auto_trig_level_96,
//
//output		[15:0]		auto_trig_level_97,
//output		[15:0]		auto_trig_level_98,
//output		[15:0]		auto_trig_level_99,
//output		[15:0]		auto_trig_level_100,
//output		[15:0]		auto_trig_level_101,
//output		[15:0]		auto_trig_level_102,
//output		[15:0]		auto_trig_level_103,
//output		[15:0]		auto_trig_level_104,
//output		[15:0]		auto_trig_level_105,
//output		[15:0]		auto_trig_level_106,
//output		[15:0]		auto_trig_level_107,
//output		[15:0]		auto_trig_level_108,
//output		[15:0]		auto_trig_level_109,
//output		[15:0]		auto_trig_level_110,
//output		[15:0]		auto_trig_level_111,
//output		[15:0]		auto_trig_level_112,
//
//output		[15:0]		auto_trig_level_113,
//output		[15:0]		auto_trig_level_114,
//output		[15:0]		auto_trig_level_115,
//output		[15:0]		auto_trig_level_116,
//output		[15:0]		auto_trig_level_117,
//output		[15:0]		auto_trig_level_118,
//output		[15:0]		auto_trig_level_119,
//output		[15:0]		auto_trig_level_120,
//output		[15:0]		auto_trig_level_121,
//output		[15:0]		auto_trig_level_122,
//output		[15:0]		auto_trig_level_123,
//output		[15:0]		auto_trig_level_124,
//output		[15:0]		auto_trig_level_125,
//output		[15:0]		auto_trig_level_126,
//output		[15:0]		auto_trig_level_127,
//output		[15:0]		auto_trig_level_128,
//
//output		[15:0]		auto_trig_level_129,
//output		[15:0]		auto_trig_level_130,
//output		[15:0]		auto_trig_level_131,
//output		[15:0]		auto_trig_level_132,
//output		[15:0]		auto_trig_level_133,
//output		[15:0]		auto_trig_level_134,
//output		[15:0]		auto_trig_level_135,
//output		[15:0]		auto_trig_level_136,
//output		[15:0]		auto_trig_level_137,
//output		[15:0]		auto_trig_level_138,
//output		[15:0]		auto_trig_level_139,
//output		[15:0]		auto_trig_level_140,
//output		[15:0]		auto_trig_level_141,
//output		[15:0]		auto_trig_level_142,
//output		[15:0]		auto_trig_level_143,
//output		[15:0]		auto_trig_level_144

    );


Autolevel_16ch Autolevel_16ch_inst1(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data1),
	.trigger(trig_out),
	
	.auto_trig_level_1(auto_trig_level_1),
	.auto_trig_level_2(auto_trig_level_2)
	//.auto_trig_level_3(auto_trig_level_3),
	//.auto_trig_level_4(auto_trig_level_4),
	//.auto_trig_level_5(auto_trig_level_5),
	//.auto_trig_level_6(auto_trig_level_6),
	//.auto_trig_level_7(auto_trig_level_7),
	//.auto_trig_level_8(auto_trig_level_8),
	//.auto_trig_level_9(auto_trig_level_9),
	//.auto_trig_level_10(auto_trig_level_10),
	//.auto_trig_level_11(auto_trig_level_11),
	//.auto_trig_level_12(auto_trig_level_12),
	//.auto_trig_level_13(auto_trig_level_13),
	//.auto_trig_level_14(auto_trig_level_14),
	//.auto_trig_level_15(auto_trig_level_15),
	//.auto_trig_level_16(auto_trig_level_16)
    );
    
Autolevel_16ch Autolevel_16ch_inst2(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data2),
	.trigger(trig_out),
	
	.auto_trig_level_1( auto_trig_level_3),
	.auto_trig_level_2( auto_trig_level_4)
	//.auto_trig_level_3( auto_trig_level_19),
	//.auto_trig_level_4( auto_trig_level_20),
	//.auto_trig_level_5( auto_trig_level_21),
	//.auto_trig_level_6( auto_trig_level_22),
	//.auto_trig_level_7( auto_trig_level_23),
	//.auto_trig_level_8( auto_trig_level_24),
	//.auto_trig_level_9( auto_trig_level_25),
	//.auto_trig_level_10(auto_trig_level_26),
	//.auto_trig_level_11(auto_trig_level_27),
	//.auto_trig_level_12(auto_trig_level_28),
	//.auto_trig_level_13(auto_trig_level_29),
	//.auto_trig_level_14(auto_trig_level_30),
	//.auto_trig_level_15(auto_trig_level_31),
	//.auto_trig_level_16(auto_trig_level_32)
    );    

Autolevel_16ch Autolevel_16ch_inst3(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data3),
	.trigger(trig_out),
	
	.auto_trig_level_1( auto_trig_level_5),
	.auto_trig_level_2( auto_trig_level_6)
	//.auto_trig_level_3( auto_trig_level_35),
	//.auto_trig_level_4( auto_trig_level_36),
	//.auto_trig_level_5( auto_trig_level_37),
	//.auto_trig_level_6( auto_trig_level_38),
	//.auto_trig_level_7( auto_trig_level_39),
	//.auto_trig_level_8( auto_trig_level_40),
	//.auto_trig_level_9( auto_trig_level_41),
	//.auto_trig_level_10(auto_trig_level_42),
	//.auto_trig_level_11(auto_trig_level_43),
	//.auto_trig_level_12(auto_trig_level_44),
	//.auto_trig_level_13(auto_trig_level_45),
	//.auto_trig_level_14(auto_trig_level_46),
	//.auto_trig_level_15(auto_trig_level_47),
	//.auto_trig_level_16(auto_trig_level_48)
    );

Autolevel_16ch Autolevel_16ch_inst4(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data4),
	.trigger(trig_out),
	
	.auto_trig_level_1( auto_trig_level_7 ),
	.auto_trig_level_2( auto_trig_level_8 )
	//.auto_trig_level_3( auto_trig_level_51 ),
	//.auto_trig_level_4( auto_trig_level_52 ),
	//.auto_trig_level_5( auto_trig_level_53 ),
	//.auto_trig_level_6( auto_trig_level_54 ),
	//.auto_trig_level_7( auto_trig_level_55 ),
	//.auto_trig_level_8( auto_trig_level_56 ),
	//.auto_trig_level_9( auto_trig_level_57 ),
	//.auto_trig_level_10(auto_trig_level_58),
	//.auto_trig_level_11(auto_trig_level_59),
	//.auto_trig_level_12(auto_trig_level_60),
	//.auto_trig_level_13(auto_trig_level_61),
	//.auto_trig_level_14(auto_trig_level_62),
	//.auto_trig_level_15(auto_trig_level_63),
	//.auto_trig_level_16(auto_trig_level_64)
    );

/*
Autolevel_16ch Autolevel_16ch_inst5(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data5),
	.trigger(trig_out),
	
	.auto_trig_level_1( auto_trig_level_65 ),
	.auto_trig_level_2( auto_trig_level_66 ),
	.auto_trig_level_3( auto_trig_level_67 ),
	.auto_trig_level_4( auto_trig_level_68 ),
	.auto_trig_level_5( auto_trig_level_69 ),
	.auto_trig_level_6( auto_trig_level_70 ),
	.auto_trig_level_7( auto_trig_level_71 ),
	.auto_trig_level_8( auto_trig_level_72 ),
	.auto_trig_level_9( auto_trig_level_73 ),
	.auto_trig_level_10(auto_trig_level_74),
	.auto_trig_level_11(auto_trig_level_75),
	.auto_trig_level_12(auto_trig_level_76),
	.auto_trig_level_13(auto_trig_level_77),
	.auto_trig_level_14(auto_trig_level_78),
	.auto_trig_level_15(auto_trig_level_79),
	.auto_trig_level_16(auto_trig_level_80)
    );

Autolevel_16ch Autolevel_16ch_inst6(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data6),
	.trigger(trig_out),
	
	.auto_trig_level_1( auto_trig_level_81 ),
	.auto_trig_level_2( auto_trig_level_82 ),
	.auto_trig_level_3( auto_trig_level_83 ),
	.auto_trig_level_4( auto_trig_level_84 ),
	.auto_trig_level_5( auto_trig_level_85 ),
	.auto_trig_level_6( auto_trig_level_86 ),
	.auto_trig_level_7( auto_trig_level_87 ),
	.auto_trig_level_8( auto_trig_level_88 ),
	.auto_trig_level_9( auto_trig_level_89 ),
	.auto_trig_level_10(auto_trig_level_90),
	.auto_trig_level_11(auto_trig_level_91),
	.auto_trig_level_12(auto_trig_level_92),
	.auto_trig_level_13(auto_trig_level_93),
	.auto_trig_level_14(auto_trig_level_94),
	.auto_trig_level_15(auto_trig_level_95),
	.auto_trig_level_16(auto_trig_level_96)
    );

Autolevel_16ch Autolevel_16ch_inst7(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data7),
	.trigger(trig_out),
	
	.auto_trig_level_1( auto_trig_level_97 ),
	.auto_trig_level_2( auto_trig_level_98 ),
	.auto_trig_level_3( auto_trig_level_99 ),
	.auto_trig_level_4( auto_trig_level_100 ),
	.auto_trig_level_5( auto_trig_level_101 ),
	.auto_trig_level_6( auto_trig_level_102 ),
	.auto_trig_level_7( auto_trig_level_103 ),
	.auto_trig_level_8( auto_trig_level_104 ),
	.auto_trig_level_9( auto_trig_level_105 ),
	.auto_trig_level_10(auto_trig_level_106),
	.auto_trig_level_11(auto_trig_level_107),
	.auto_trig_level_12(auto_trig_level_108),
	.auto_trig_level_13(auto_trig_level_109),
	.auto_trig_level_14(auto_trig_level_110),
	.auto_trig_level_15(auto_trig_level_111),
	.auto_trig_level_16(auto_trig_level_112)
    );

Autolevel_16ch Autolevel_16ch_inst8(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data8),
	.trigger(trig_out),
	
	.auto_trig_level_1( auto_trig_level_113 ),
	.auto_trig_level_2( auto_trig_level_114 ),
	.auto_trig_level_3( auto_trig_level_115 ),
	.auto_trig_level_4( auto_trig_level_116 ),
	.auto_trig_level_5( auto_trig_level_117 ),
	.auto_trig_level_6( auto_trig_level_118 ),
	.auto_trig_level_7( auto_trig_level_119 ),
	.auto_trig_level_8( auto_trig_level_120 ),
	.auto_trig_level_9( auto_trig_level_121 ),
	.auto_trig_level_10(auto_trig_level_122),
	.auto_trig_level_11(auto_trig_level_123),
	.auto_trig_level_12(auto_trig_level_124),
	.auto_trig_level_13(auto_trig_level_125),
	.auto_trig_level_14(auto_trig_level_126),
	.auto_trig_level_15(auto_trig_level_127),
	.auto_trig_level_16(auto_trig_level_128)
    );
    
Autolevel_16ch Autolevel_16ch_inst9(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data9),
	.trigger(trig_out),
	
	.auto_trig_level_1( auto_trig_level_129 ),
	.auto_trig_level_2( auto_trig_level_130 ),
	.auto_trig_level_3( auto_trig_level_131 ),
	.auto_trig_level_4( auto_trig_level_132 ),
	.auto_trig_level_5( auto_trig_level_133 ),
	.auto_trig_level_6( auto_trig_level_134 ),
	.auto_trig_level_7( auto_trig_level_135 ),
	.auto_trig_level_8( auto_trig_level_136 ),
	.auto_trig_level_9( auto_trig_level_137 ),
	.auto_trig_level_10(auto_trig_level_138),
	.auto_trig_level_11(auto_trig_level_139),
	.auto_trig_level_12(auto_trig_level_140),
	.auto_trig_level_13(auto_trig_level_141),
	.auto_trig_level_14(auto_trig_level_142),
	.auto_trig_level_15(auto_trig_level_143),
	.auto_trig_level_16(auto_trig_level_144)
    );    
*/


endmodule
