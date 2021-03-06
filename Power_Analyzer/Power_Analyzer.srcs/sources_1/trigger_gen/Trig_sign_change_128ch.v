`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:11:28 11/04/2016 
// Design Name: 
// Module Name:    Trig_sign_change_128ch 
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
module Trig_sign_change_128ch(

	input 		[31:0]		data1,
	input 		[31:0]		data2,
	input 		[31:0]		data3,
	input 		[31:0]		data4,

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
	//input		[31:0]		trig_level_ch96,
	//input		[31:0]		trig_level_ch97,
	//input		[31:0]		trig_level_ch98,
	//input		[31:0]		trig_level_ch99,
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
	//input		[31:0]		trig_level_ch127,  
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
	//input		[31:0]		trig_level_ch143,


	
	input					trig_rst_n,
	input					trig_clk,

	output wire [7:0]		in_mode_data,
	output wire [7:0]		out_mode_data,
	output wire [7:0]		nomal_mode_data
    );

    
    

//通道0_15  对应输出数据0——15   
Trig_sign_change Trig_sign_change_inst1(

	.data(data1),
	.trig_level_ch0(trig_level_ch0),
	.trig_level_ch1(trig_level_ch1),
	//.trig_level_ch2(trig_level_ch2),
	//.trig_level_ch3(trig_level_ch3),
	//.trig_level_ch4(trig_level_ch4),
	//.trig_level_ch5(trig_level_ch5),
	//.trig_level_ch6(trig_level_ch6),
	//.trig_level_ch7(trig_level_ch7),
	//.trig_level_ch8(trig_level_ch8),
	//.trig_level_ch9(trig_level_ch9),
	//.trig_level_ch10(trig_level_ch10),
	//.trig_level_ch11(trig_level_ch11),
	//.trig_level_ch12(trig_level_ch12),
	//.trig_level_ch13(trig_level_ch13),
	//.trig_level_ch14(trig_level_ch14),
	//.trig_level_ch15(trig_level_ch15),     
	.rst_n(trig_rst_n),
	.trig_clk(trig_clk),
	
	.in_mode_data(in_mode_data[1:0]),
	.out_mode_data(out_mode_data[1:0]),
	.nomal_mode_data(nomal_mode_data[1:0])

    );
    
Trig_sign_change Trig_sign_change_inst2(

	.data(data2),
	.trig_level_ch0 (trig_level_ch2),
	.trig_level_ch1 (trig_level_ch3),
	//.trig_level_ch2 (trig_level_ch18),
	//.trig_level_ch3 (trig_level_ch19),
	//.trig_level_ch4 (trig_level_ch20),
	//.trig_level_ch5 (trig_level_ch21),
	//.trig_level_ch6 (trig_level_ch22),
	//.trig_level_ch7 (trig_level_ch23),
	//.trig_level_ch8 (trig_level_ch24),
	//.trig_level_ch9 (trig_level_ch25),
	//.trig_level_ch10(trig_level_ch26),
	//.trig_level_ch11(trig_level_ch27),
	//.trig_level_ch12(trig_level_ch28),
	//.trig_level_ch13(trig_level_ch29),
	//.trig_level_ch14(trig_level_ch30),
	//.trig_level_ch15(trig_level_ch31),     
	.rst_n(trig_rst_n),
	.trig_clk(trig_clk),
	
	.in_mode_data(in_mode_data[3:2]),
	.out_mode_data(out_mode_data[3:2]),
	.nomal_mode_data(nomal_mode_data[3:2])

    );
    
Trig_sign_change Trig_sign_change_inst3(

	.data(data3),
	.trig_level_ch0 (trig_level_ch4),
	.trig_level_ch1 (trig_level_ch5),
	//.trig_level_ch2 (trig_level_ch34),
	//.trig_level_ch3 (trig_level_ch35),
	//.trig_level_ch4 (trig_level_ch36),
	//.trig_level_ch5 (trig_level_ch37),
	//.trig_level_ch6 (trig_level_ch38),
	//.trig_level_ch7 (trig_level_ch39),
	//.trig_level_ch8 (trig_level_ch40),
	//.trig_level_ch9 (trig_level_ch41),
	//.trig_level_ch10(trig_level_ch42),
	//.trig_level_ch11(trig_level_ch43),
	//.trig_level_ch12(trig_level_ch44),
	//.trig_level_ch13(trig_level_ch45),
	//.trig_level_ch14(trig_level_ch46),
	//.trig_level_ch15(trig_level_ch47),     
	.rst_n(trig_rst_n),
	.trig_clk(trig_clk),
	
	.in_mode_data(in_mode_data[5:4]),
	.out_mode_data(out_mode_data[5:4]),
	.nomal_mode_data(nomal_mode_data[5:4])

    );

Trig_sign_change Trig_sign_change_inst4(

	.data(data4),
	.trig_level_ch0 (trig_level_ch6),
	.trig_level_ch1 (trig_level_ch7),
	//.trig_level_ch2 (trig_level_ch50),
	//.trig_level_ch3 (trig_level_ch51),
	//.trig_level_ch4 (trig_level_ch52),
	//.trig_level_ch5 (trig_level_ch53),
	//.trig_level_ch6 (trig_level_ch54),
	//.trig_level_ch7 (trig_level_ch55),
	//.trig_level_ch8 (trig_level_ch56),
	//.trig_level_ch9 (trig_level_ch57),
	//.trig_level_ch10(trig_level_ch58),
	//.trig_level_ch11(trig_level_ch59),
	//.trig_level_ch12(trig_level_ch60),
	//.trig_level_ch13(trig_level_ch61),
	//.trig_level_ch14(trig_level_ch62),
	//.trig_level_ch15(trig_level_ch63),     
	.rst_n(trig_rst_n),
	.trig_clk(trig_clk),
	
	.in_mode_data(in_mode_data[7:6]),
	.out_mode_data(out_mode_data[7:6]),
	.nomal_mode_data(nomal_mode_data[7:6])

    );
/*    
Trig_sign_change Trig_sign_change_inst5(

	.data(data5),
	.trig_level_ch0 (trig_level_ch64),
	.trig_level_ch1 (trig_level_ch65),
	.trig_level_ch2 (trig_level_ch66),
	.trig_level_ch3 (trig_level_ch67),
	.trig_level_ch4 (trig_level_ch68),
	.trig_level_ch5 (trig_level_ch69),
	.trig_level_ch6 (trig_level_ch70),
	.trig_level_ch7 (trig_level_ch71),
	.trig_level_ch8 (trig_level_ch72),
	.trig_level_ch9 (trig_level_ch73),
	.trig_level_ch10(trig_level_ch74),
	.trig_level_ch11(trig_level_ch75),
	.trig_level_ch12(trig_level_ch76),
	.trig_level_ch13(trig_level_ch77),
	.trig_level_ch14(trig_level_ch78),
	.trig_level_ch15(trig_level_ch79),     
	.rst_n(trig_rst_n),
	.trig_clk(trig_clk),
	
	.in_mode_data(in_mode_data[79:64]),
	.out_mode_data(out_mode_data[79:64]),
	.nomal_mode_data(nomal_mode_data[79:64])

    );
    
Trig_sign_change Trig_sign_change_inst6(

	.data(data6),
	.trig_level_ch0 (trig_level_ch80),
	.trig_level_ch1 (trig_level_ch81),
	.trig_level_ch2 (trig_level_ch82),
	.trig_level_ch3 (trig_level_ch83),
	.trig_level_ch4 (trig_level_ch84),
	.trig_level_ch5 (trig_level_ch85),
	.trig_level_ch6 (trig_level_ch86),
	.trig_level_ch7 (trig_level_ch87),
	.trig_level_ch8 (trig_level_ch88),
	.trig_level_ch9 (trig_level_ch89),
	.trig_level_ch10(trig_level_ch90),
	.trig_level_ch11(trig_level_ch91),
	.trig_level_ch12(trig_level_ch92),
	.trig_level_ch13(trig_level_ch93),
	.trig_level_ch14(trig_level_ch94),
	.trig_level_ch15(trig_level_ch95),     
	.rst_n(trig_rst_n),
	.trig_clk(trig_clk),
	
	.in_mode_data(in_mode_data[95:80]),
	.out_mode_data(out_mode_data[95:80]),
	.nomal_mode_data(nomal_mode_data[95:80])

    );
    
Trig_sign_change Trig_sign_change_inst7(

	.data(data7),
	.trig_level_ch0 (trig_level_ch96 ),
	.trig_level_ch1 (trig_level_ch97 ),
	.trig_level_ch2 (trig_level_ch98 ),
	.trig_level_ch3 (trig_level_ch99 ),
	.trig_level_ch4 (trig_level_ch100),
	.trig_level_ch5 (trig_level_ch101),
	.trig_level_ch6 (trig_level_ch102),
	.trig_level_ch7 (trig_level_ch103),
	.trig_level_ch8 (trig_level_ch104),
	.trig_level_ch9 (trig_level_ch105),
	.trig_level_ch10(trig_level_ch106),
	.trig_level_ch11(trig_level_ch107),
	.trig_level_ch12(trig_level_ch108),
	.trig_level_ch13(trig_level_ch109),
	.trig_level_ch14(trig_level_ch110),
	.trig_level_ch15(trig_level_ch111),     
	.rst_n(trig_rst_n),
	.trig_clk(trig_clk),
	
	.in_mode_data(in_mode_data[111:96]),
	.out_mode_data(out_mode_data[111:96]),
	.nomal_mode_data(nomal_mode_data[111:96])

    );
    
Trig_sign_change Trig_sign_change_inst8(

	.data(data8),
	.trig_level_ch0 (trig_level_ch112),
	.trig_level_ch1 (trig_level_ch113),
	.trig_level_ch2 (trig_level_ch114),
	.trig_level_ch3 (trig_level_ch115),
	.trig_level_ch4 (trig_level_ch116),
	.trig_level_ch5 (trig_level_ch117),
	.trig_level_ch6 (trig_level_ch118),
	.trig_level_ch7 (trig_level_ch119),
	.trig_level_ch8 (trig_level_ch120),
	.trig_level_ch9 (trig_level_ch121),
	.trig_level_ch10(trig_level_ch122),
	.trig_level_ch11(trig_level_ch123),
	.trig_level_ch12(trig_level_ch124),
	.trig_level_ch13(trig_level_ch125),
	.trig_level_ch14(trig_level_ch126),
	.trig_level_ch15(trig_level_ch127),     
	.rst_n(trig_rst_n),
	.trig_clk(trig_clk),
	
	.in_mode_data(in_mode_data[127:112]),
	.out_mode_data(out_mode_data[127:112]),
	.nomal_mode_data(nomal_mode_data[127:112])

    );
    
Trig_sign_change Trig_sign_change_inst9(

	.data(data9),
	.trig_level_ch0(trig_level_ch128),
	.trig_level_ch1(trig_level_ch129),
	.trig_level_ch2(trig_level_ch130),
	.trig_level_ch3(trig_level_ch131),
	.trig_level_ch4(trig_level_ch132),
	.trig_level_ch5(trig_level_ch133),
	.trig_level_ch6(trig_level_ch134),
	.trig_level_ch7(trig_level_ch135),
	.trig_level_ch8(trig_level_ch136),
	.trig_level_ch9(trig_level_ch137),
	.trig_level_ch10(trig_level_ch138),
	.trig_level_ch11(trig_level_ch139),
	.trig_level_ch12(trig_level_ch140),
	.trig_level_ch13(trig_level_ch141),
	.trig_level_ch14(trig_level_ch142),
	.trig_level_ch15(trig_level_ch143),     
	.rst_n(trig_rst_n),
	.trig_clk(trig_clk),
	
	.in_mode_data(in_mode_data[143:128]),
	.out_mode_data(out_mode_data[143:128]),
	.nomal_mode_data(nomal_mode_data[143:128])

    );    
     
*/
endmodule
