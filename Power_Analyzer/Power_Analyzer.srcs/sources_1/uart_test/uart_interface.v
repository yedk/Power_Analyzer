`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:52 03/25/2017 
// Design Name: 
// Module Name:    K7_INTERFACE 
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
module K7_INTERFACE
#(parameter spi_width = 44
)
(
    input                         ref_clk,//100M
    input  [spi_width-1:0]     spi_all_data,//高12位地址+低32位数据
    input                         spi_valid,
    output             reg         spi_en,
   
	output reg   [spi_width-1:0]  RD_DATA_K7,  //测试数据读回
    output reg   [spi_width-13:0] pcTx_data_000,//测试用
	output reg   [spi_width-13:0] pcTx_data_001,//测试用
    output reg   [spi_width-13:0] pcTx_data_002,//读地址用
    output reg   [spi_width-13:0] pcTx_data_003,//测试用
    output reg   [spi_width-13:0] pcTx_data_004,//测试用
    output reg   [spi_width-13:0] pcTx_data_005,//测试用
    output reg   [spi_width-13:0] pcTx_data_006,//测试用
    output reg   [spi_width-13:0] pcTx_data_007,//测试用          
    output reg   [spi_width-13:0] pcTx_data_008,//测试用          
    output reg   [spi_width-13:0] pcTx_data_009,//测试用          
    output reg   [spi_width-13:0] pcTx_data_00A,//测试用          
    output reg   [spi_width-13:0] pcTx_data_00B,//测试用          
    output reg   [spi_width-13:0] pcTx_data_00C,//测试用          
    output reg   [spi_width-13:0] pcTx_data_00D,//测试用          
    output reg   [spi_width-13:0] pcTx_data_00E,//测试用          
    output reg   [spi_width-13:0] pcTx_data_00F,//测试用          
    output reg   [spi_width-13:0] pcTx_data_010,          
    output reg   [spi_width-13:0] pcTx_data_011,          
    output reg   [spi_width-13:0] pcTx_data_012,          
    output reg   [spi_width-13:0] pcTx_data_013,          
    output reg   [spi_width-13:0] pcTx_data_014,          
    output reg   [spi_width-13:0] pcTx_data_015,          
    output reg   [spi_width-13:0] pcTx_data_016,          
    output reg   [spi_width-13:0] pcTx_data_017,          
    output reg   [spi_width-13:0] pcTx_data_018,          
    output reg   [spi_width-13:0] pcTx_data_019,          
    output reg   [spi_width-13:0] pcTx_data_01A,          
    output reg   [spi_width-13:0] pcTx_data_01B,          
    output reg   [spi_width-13:0] pcTx_data_01C,          
    output reg   [spi_width-13:0] pcTx_data_01D,          
    output reg   [spi_width-13:0] pcTx_data_01E,          
    output reg   [spi_width-13:0] pcTx_data_01F,          
    output reg   [spi_width-13:0] pcTx_data_020,          
    output reg   [spi_width-13:0] pcTx_data_021,          
    output reg   [spi_width-13:0] pcTx_data_022,          
    output reg   [spi_width-13:0] pcTx_data_023,          
    output reg   [spi_width-13:0] pcTx_data_024,          
    output reg   [spi_width-13:0] pcTx_data_025,          
    output reg   [spi_width-13:0] pcTx_data_026,          
    output reg   [spi_width-13:0] pcTx_data_027,          
    output reg   [spi_width-13:0] pcTx_data_028,          
    output reg   [spi_width-13:0] pcTx_data_029,          
    output reg   [spi_width-13:0] pcTx_data_02A,          
    output reg   [spi_width-13:0] pcTx_data_02B,          
    output reg   [spi_width-13:0] pcTx_data_02C,          
    output reg   [spi_width-13:0] pcTx_data_02D,          
    output reg   [spi_width-13:0] pcTx_data_02E,          
    output reg   [spi_width-13:0] pcTx_data_02F,          
    output reg   [spi_width-13:0] pcTx_data_030,          
    output reg   [spi_width-13:0] pcTx_data_031,          
    output reg   [spi_width-13:0] pcTx_data_032,          
    output reg   [spi_width-13:0] pcTx_data_033,          
    output reg   [spi_width-13:0] pcTx_data_034,          
    output reg   [spi_width-13:0] pcTx_data_035,          
    output reg   [spi_width-13:0] pcTx_data_036,          
    output reg   [spi_width-13:0] pcTx_data_037,          
    output reg   [spi_width-13:0] pcTx_data_038,          
    output reg   [spi_width-13:0] pcTx_data_039,          
    output reg   [spi_width-13:0] pcTx_data_03A,          
    output reg   [spi_width-13:0] pcTx_data_03B,          
    output reg   [spi_width-13:0] pcTx_data_03C,          
    output reg   [spi_width-13:0] pcTx_data_03D,          
    output reg   [spi_width-13:0] pcTx_data_03E,          
    output reg   [spi_width-13:0] pcTx_data_03F,          
    output reg   [spi_width-13:0] pcTx_data_040,          
    output reg   [spi_width-13:0] pcTx_data_041,          
    output reg   [spi_width-13:0] pcTx_data_042,          
    output reg   [spi_width-13:0] pcTx_data_043,          
    output reg   [spi_width-13:0] pcTx_data_044,          
    output reg   [spi_width-13:0] pcTx_data_045,          
    output reg   [spi_width-13:0] pcTx_data_046,          
    output reg   [spi_width-13:0] pcTx_data_047,          
    output reg   [spi_width-13:0] pcTx_data_048,          
    output reg   [spi_width-13:0] pcTx_data_049,          
    output reg   [spi_width-13:0] pcTx_data_04A,          
    output reg   [spi_width-13:0] pcTx_data_04B,          
    output reg   [spi_width-13:0] pcTx_data_04C,          
    output reg   [spi_width-13:0] pcTx_data_04D,          
    output reg   [spi_width-13:0] pcTx_data_04E,          
    output reg   [spi_width-13:0] pcTx_data_04F,          
    output reg   [spi_width-13:0] pcTx_data_050,          
    output reg   [spi_width-13:0] pcTx_data_051,          
    output reg   [spi_width-13:0] pcTx_data_052,          
    output reg   [spi_width-13:0] pcTx_data_053,          
    output reg   [spi_width-13:0] pcTx_data_054,          
    output reg   [spi_width-13:0] pcTx_data_055,          
    output reg   [spi_width-13:0] pcTx_data_056,          
    output reg   [spi_width-13:0] pcTx_data_057,          
    output reg   [spi_width-13:0] pcTx_data_058,          
    output reg   [spi_width-13:0] pcTx_data_059,          
    output reg   [spi_width-13:0] pcTx_data_05A,          
    output reg   [spi_width-13:0] pcTx_data_05B,          
    output reg   [spi_width-13:0] pcTx_data_05C,          
    output reg   [spi_width-13:0] pcTx_data_05D,          
    output reg   [spi_width-13:0] pcTx_data_05E,          
    output reg   [spi_width-13:0] pcTx_data_05F,          
    output reg   [spi_width-13:0] pcTx_data_060,          
    output reg   [spi_width-13:0] pcTx_data_061,          
    output reg   [spi_width-13:0] pcTx_data_062,          
    output reg   [spi_width-13:0] pcTx_data_063,          
    output reg   [spi_width-13:0] pcTx_data_064,        
    output reg   [spi_width-13:0] pcTx_data_065,
    output reg   [spi_width-13:0] pcTx_data_066,
    output reg   [spi_width-13:0] pcTx_data_067,
    output reg   [spi_width-13:0] pcTx_data_068,
    output reg   [spi_width-13:0] pcTx_data_069,
    output reg   [spi_width-13:0] pcTx_data_06A,
    output reg   [spi_width-13:0] pcTx_data_06B,
    output reg   [spi_width-13:0] pcTx_data_06C,
    output reg   [spi_width-13:0] pcTx_data_06D,
    output reg   [spi_width-13:0] pcTx_data_06E,
    output reg   [spi_width-13:0] pcTx_data_06F,
    output reg   [spi_width-13:0] pcTx_data_070,
    output reg   [spi_width-13:0] pcTx_data_071,
    output reg   [spi_width-13:0] pcTx_data_072,
    output reg   [spi_width-13:0] pcTx_data_073,
    output reg   [spi_width-13:0] pcTx_data_074,
    output reg   [spi_width-13:0] pcTx_data_075,
    output reg   [spi_width-13:0] pcTx_data_076,
    output reg   [spi_width-13:0] pcTx_data_077,
    output reg   [spi_width-13:0] pcTx_data_078,
    output reg   [spi_width-13:0] pcTx_data_079,
    output reg   [spi_width-13:0] pcTx_data_07A,
    output reg   [spi_width-13:0] pcTx_data_07B,
    output reg   [spi_width-13:0] pcTx_data_07C,
    output reg   [spi_width-13:0] pcTx_data_07D,
    output reg   [spi_width-13:0] pcTx_data_07E,
    output reg   [spi_width-13:0] pcTx_data_07F,
    output reg   [spi_width-13:0] pcTx_data_080,
    output reg   [spi_width-13:0] pcTx_data_081,
    output reg   [spi_width-13:0] pcTx_data_082,
    output reg   [spi_width-13:0] pcTx_data_083,
    output reg   [spi_width-13:0] pcTx_data_084,
    output reg   [spi_width-13:0] pcTx_data_085,
    output reg   [spi_width-13:0] pcTx_data_086,
    output reg   [spi_width-13:0] pcTx_data_087,
    output reg   [spi_width-13:0] pcTx_data_088,
    output reg   [spi_width-13:0] pcTx_data_089,
    output reg   [spi_width-13:0] pcTx_data_08A,
    output reg   [spi_width-13:0] pcTx_data_08B,
    output reg   [spi_width-13:0] pcTx_data_08C,
    output reg   [spi_width-13:0] pcTx_data_08D,
    output reg   [spi_width-13:0] pcTx_data_08E,
    output reg   [spi_width-13:0] pcTx_data_08F,
    output reg   [spi_width-13:0] pcTx_data_090,
    output reg   [spi_width-13:0] pcTx_data_091,
    output reg   [spi_width-13:0] pcTx_data_092,
    output reg   [spi_width-13:0] pcTx_data_093,
    output reg   [spi_width-13:0] pcTx_data_094,
    output reg   [spi_width-13:0] pcTx_data_095,
    output reg   [spi_width-13:0] pcTx_data_096,
    output reg   [spi_width-13:0] pcTx_data_097,
    output reg   [spi_width-13:0] pcTx_data_098,
    output reg   [spi_width-13:0] pcTx_data_099,
    output reg   [spi_width-13:0] pcTx_data_09A,
    output reg   [spi_width-13:0] pcTx_data_09B,
    output reg   [spi_width-13:0] pcTx_data_09C,
    output reg   [spi_width-13:0] pcTx_data_09D,
    output reg   [spi_width-13:0] pcTx_data_09E,
    output reg   [spi_width-13:0] pcTx_data_09F,
    output reg   [spi_width-13:0] pcTx_data_0A0,
    output reg   [spi_width-13:0] pcTx_data_0A1,
    output reg   [spi_width-13:0] pcTx_data_0A2,
    output reg   [spi_width-13:0] pcTx_data_0A3,
    output reg   [spi_width-13:0] pcTx_data_0A4,
    output reg   [spi_width-13:0] pcTx_data_0A5,
    output reg   [spi_width-13:0] pcTx_data_0A6,
    output reg   [spi_width-13:0] pcTx_data_0A7,
    output reg   [spi_width-13:0] pcTx_data_0A8,
    output reg   [spi_width-13:0] pcTx_data_0A9,
    output reg   [spi_width-13:0] pcTx_data_0AA,
    output reg   [spi_width-13:0] pcTx_data_0AB,
    output reg   [spi_width-13:0] pcTx_data_0AC,
    output reg   [spi_width-13:0] pcTx_data_0AD,
    output reg   [spi_width-13:0] pcTx_data_0AE,
    output reg   [spi_width-13:0] pcTx_data_0AF,
    output reg   [spi_width-13:0] pcTx_data_0B0,
    output reg   [spi_width-13:0] pcTx_data_0B1,
    output reg   [spi_width-13:0] pcTx_data_0B2,
    output reg   [spi_width-13:0] pcTx_data_0B3,
    output reg   [spi_width-13:0] pcTx_data_0B4,
    output reg   [spi_width-13:0] pcTx_data_0B5,
    output reg   [spi_width-13:0] pcTx_data_0B6,
    output reg   [spi_width-13:0] pcTx_data_0B7,
    output reg   [spi_width-13:0] pcTx_data_0B8,
    output reg   [spi_width-13:0] pcTx_data_0B9,
    output reg   [spi_width-13:0] pcTx_data_0BA,
    output reg   [spi_width-13:0] pcTx_data_0BB,
    output reg   [spi_width-13:0] pcTx_data_0BC,
    output reg   [spi_width-13:0] pcTx_data_0BD,
    output reg   [spi_width-13:0] pcTx_data_0BE,
    output reg   [spi_width-13:0] pcTx_data_0BF,
    output reg   [spi_width-13:0] pcTx_data_0C0,
    output reg   [spi_width-13:0] pcTx_data_0C1,
    output reg   [spi_width-13:0] pcTx_data_0C2,
    output reg   [spi_width-13:0] pcTx_data_0C3,
    output reg   [spi_width-13:0] pcTx_data_0C4,
    output reg   [spi_width-13:0] pcTx_data_0C5,
    output reg   [spi_width-13:0] pcTx_data_0C6,
    output reg   [spi_width-13:0] pcTx_data_0C7,
    output reg   [spi_width-13:0] pcTx_data_0C8,
    output reg   [spi_width-13:0] pcTx_data_0C9,
    output reg   [spi_width-13:0] pcTx_data_0CA,
    output reg   [spi_width-13:0] pcTx_data_0CB,
    output reg   [spi_width-13:0] pcTx_data_0CC,
    output reg   [spi_width-13:0] pcTx_data_0CD,
    output reg   [spi_width-13:0] pcTx_data_0CE,
    output reg   [spi_width-13:0] pcTx_data_0CF,
    output reg   [spi_width-13:0] pcTx_data_0D0,
    output reg   [spi_width-13:0] pcTx_data_0D1,
    output reg   [spi_width-13:0] pcTx_data_0D2,
    output reg   [spi_width-13:0] pcTx_data_0D3,
    output reg   [spi_width-13:0] pcTx_data_0D4,
    output reg   [spi_width-13:0] pcTx_data_0D5,
    output reg   [spi_width-13:0] pcTx_data_0D6,
    output reg   [spi_width-13:0] pcTx_data_0D7,
    output reg   [spi_width-13:0] pcTx_data_0D8,
    output reg   [spi_width-13:0] pcTx_data_0D9,
    output reg   [spi_width-13:0] pcTx_data_0DA,
    output reg   [spi_width-13:0] pcTx_data_0DB,
    output reg   [spi_width-13:0] pcTx_data_0DC,
    output reg   [spi_width-13:0] pcTx_data_0DD,
    output reg   [spi_width-13:0] pcTx_data_0DE,
    output reg   [spi_width-13:0] pcTx_data_0DF,
    output reg   [spi_width-13:0] pcTx_data_0E0,
    output reg   [spi_width-13:0] pcTx_data_0E1,
    output reg   [spi_width-13:0] pcTx_data_0E2,
    output reg   [spi_width-13:0] pcTx_data_0E3,
    output reg   [spi_width-13:0] pcTx_data_0E4,
    output reg   [spi_width-13:0] pcTx_data_0E5,
    output reg   [spi_width-13:0] pcTx_data_0E6,
    output reg   [spi_width-13:0] pcTx_data_0E7,
    output reg   [spi_width-13:0] pcTx_data_0E8,
    output reg   [spi_width-13:0] pcTx_data_0E9,
    output reg   [spi_width-13:0] pcTx_data_0EA,
    output reg   [spi_width-13:0] pcTx_data_0EB,
    output reg   [spi_width-13:0] pcTx_data_0EC,
    output reg   [spi_width-13:0] pcTx_data_0ED,
    output reg   [spi_width-13:0] pcTx_data_0EE,
    output reg   [spi_width-13:0] pcTx_data_0EF,
    output reg   [spi_width-13:0] pcTx_data_0F0,
    output reg   [spi_width-13:0] pcTx_data_0F1,
    output reg   [spi_width-13:0] pcTx_data_0F2,
    output reg   [spi_width-13:0] pcTx_data_0F3,
    output reg   [spi_width-13:0] pcTx_data_0F4,
    output reg   [spi_width-13:0] pcTx_data_0F5,
    output reg   [spi_width-13:0] pcTx_data_0F6,
    output reg   [spi_width-13:0] pcTx_data_0F7,
    output reg   [spi_width-13:0] pcTx_data_0F8,
    output reg   [spi_width-13:0] pcTx_data_0F9,
    output reg   [spi_width-13:0] pcTx_data_0FA,
    output reg   [spi_width-13:0] pcTx_data_0FB,
    output reg   [spi_width-13:0] pcTx_data_0FC,
    output reg   [spi_width-13:0] pcTx_data_0FD,
    output reg   [spi_width-13:0] pcTx_data_0FE,
    output reg   [spi_width-13:0] pcTx_data_0FF,
    output reg   [spi_width-13:0] pcTx_data_100,
    output reg   [spi_width-13:0] pcTx_data_101,
    output reg   [spi_width-13:0] pcTx_data_102,
    output reg   [spi_width-13:0] pcTx_data_103,
    output reg   [spi_width-13:0] pcTx_data_104,
    output reg   [spi_width-13:0] pcTx_data_105,
    output reg   [spi_width-13:0] pcTx_data_106,
    output reg   [spi_width-13:0] pcTx_data_107,
    output reg   [spi_width-13:0] pcTx_data_108,
    output reg   [spi_width-13:0] pcTx_data_109,
    output reg   [spi_width-13:0] pcTx_data_10A,
    output reg   [spi_width-13:0] pcTx_data_10B,
    output reg   [spi_width-13:0] pcTx_data_10C,
    output reg   [spi_width-13:0] pcTx_data_10D,
    output reg   [spi_width-13:0] pcTx_data_10E,
    output reg   [spi_width-13:0] pcTx_data_10F,
    output reg   [spi_width-13:0] pcTx_data_110,
    output reg   [spi_width-13:0] pcTx_data_111,
    output reg   [spi_width-13:0] pcTx_data_112,
    output reg   [spi_width-13:0] pcTx_data_113,
    output reg   [spi_width-13:0] pcTx_data_114,
    output reg   [spi_width-13:0] pcTx_data_115,
    output reg   [spi_width-13:0] pcTx_data_116,
    output reg   [spi_width-13:0] pcTx_data_117,
    output reg   [spi_width-13:0] pcTx_data_118,
    output reg   [spi_width-13:0] pcTx_data_119,
    output reg   [spi_width-13:0] pcTx_data_11A,
    output reg   [spi_width-13:0] pcTx_data_11B,
    output reg   [spi_width-13:0] pcTx_data_11C,
    output reg   [spi_width-13:0] pcTx_data_11D,
    output reg   [spi_width-13:0] pcTx_data_11E,
    output reg   [spi_width-13:0] pcTx_data_11F,
    output reg   [spi_width-13:0] pcTx_data_120,
    output reg   [spi_width-13:0] pcTx_data_121,
    output reg   [spi_width-13:0] pcTx_data_122,
    output reg   [spi_width-13:0] pcTx_data_123,
    output reg   [spi_width-13:0] pcTx_data_124,
    output reg   [spi_width-13:0] pcTx_data_125,
    output reg   [spi_width-13:0] pcTx_data_126,
    output reg   [spi_width-13:0] pcTx_data_127,
    output reg   [spi_width-13:0] pcTx_data_128,
    output reg   [spi_width-13:0] pcTx_data_129,
    output reg   [spi_width-13:0] pcTx_data_12A,
    output reg   [spi_width-13:0] pcTx_data_12B,
    output reg   [spi_width-13:0] pcTx_data_12C,
    output reg   [spi_width-13:0] pcTx_data_12D,
    output reg   [spi_width-13:0] pcTx_data_12E,
    output reg   [spi_width-13:0] pcTx_data_12F,
    output reg   [spi_width-13:0] pcTx_data_130,
    output reg   [spi_width-13:0] pcTx_data_131,
    output reg   [spi_width-13:0] pcTx_data_132,
    output reg   [spi_width-13:0] pcTx_data_133,
    output reg   [spi_width-13:0] pcTx_data_134,
    output reg   [spi_width-13:0] pcTx_data_135,
    output reg   [spi_width-13:0] pcTx_data_136,
    output reg   [spi_width-13:0] pcTx_data_137,
    output reg   [spi_width-13:0] pcTx_data_138,
    output reg   [spi_width-13:0] pcTx_data_139,
    output reg   [spi_width-13:0] pcTx_data_13A,
    output reg   [spi_width-13:0] pcTx_data_13B,
    output reg   [spi_width-13:0] pcTx_data_13C,
    output reg   [spi_width-13:0] pcTx_data_13D,
    output reg   [spi_width-13:0] pcTx_data_13E,
    output reg   [spi_width-13:0] pcTx_data_13F,
    output reg   [spi_width-13:0] pcTx_data_140,
    output reg   [spi_width-13:0] pcTx_data_141,
    output reg   [spi_width-13:0] pcTx_data_142,
    output reg   [spi_width-13:0] pcTx_data_143,
    output reg   [spi_width-13:0] pcTx_data_144,
    output reg   [spi_width-13:0] pcTx_data_145,
    output reg   [spi_width-13:0] pcTx_data_146,
    output reg   [spi_width-13:0] pcTx_data_147,
    output reg   [spi_width-13:0] pcTx_data_148,
    output reg   [spi_width-13:0] pcTx_data_149,
    output reg   [spi_width-13:0] pcTx_data_14A,
    output reg   [spi_width-13:0] pcTx_data_14B,
    output reg   [spi_width-13:0] pcTx_data_14C,
    output reg   [spi_width-13:0] pcTx_data_14D,
    output reg   [spi_width-13:0] pcTx_data_14E,
    output reg   [spi_width-13:0] pcTx_data_14F,
    output reg   [spi_width-13:0] pcTx_data_150,
    output reg   [spi_width-13:0] pcTx_data_151,
    output reg   [spi_width-13:0] pcTx_data_152,
    output reg   [spi_width-13:0] pcTx_data_153,
    output reg   [spi_width-13:0] pcTx_data_154,
    output reg   [spi_width-13:0] pcTx_data_155,
    output reg   [spi_width-13:0] pcTx_data_156,
    output reg   [spi_width-13:0] pcTx_data_157,
    output reg   [spi_width-13:0] pcTx_data_158,
    output reg   [spi_width-13:0] pcTx_data_159,
    output reg   [spi_width-13:0] pcTx_data_15A,
    output reg   [spi_width-13:0] pcTx_data_15B,
    output reg   [spi_width-13:0] pcTx_data_15C,
    output reg   [spi_width-13:0] pcTx_data_15D,
    output reg   [spi_width-13:0] pcTx_data_15E,
    output reg   [spi_width-13:0] pcTx_data_15F,
    output reg   [spi_width-13:0] pcTx_data_160,
    output reg   [spi_width-13:0] pcTx_data_161,
    output reg   [spi_width-13:0] pcTx_data_162,
    output reg   [spi_width-13:0] pcTx_data_163,
    output reg   [spi_width-13:0] pcTx_data_164,
    output reg   [spi_width-13:0] pcTx_data_165,
    output reg   [spi_width-13:0] pcTx_data_166,
    output reg   [spi_width-13:0] pcTx_data_167,
    output reg   [spi_width-13:0] pcTx_data_168,
    output reg   [spi_width-13:0] pcTx_data_169,
    output reg   [spi_width-13:0] pcTx_data_16A,
    output reg   [spi_width-13:0] pcTx_data_16B,
    output reg   [spi_width-13:0] pcTx_data_16C,
    output reg   [spi_width-13:0] pcTx_data_16D,
    output reg   [spi_width-13:0] pcTx_data_16E,
    output reg   [spi_width-13:0] pcTx_data_16F,
    output reg   [spi_width-13:0] pcTx_data_170,
    output reg   [spi_width-13:0] pcTx_data_171,
    output reg   [spi_width-13:0] pcTx_data_172,
    output reg   [spi_width-13:0] pcTx_data_173,
    output reg   [spi_width-13:0] pcTx_data_174,
    output reg   [spi_width-13:0] pcTx_data_175,
    output reg   [spi_width-13:0] pcTx_data_176,
    output reg   [spi_width-13:0] pcTx_data_177,
    output reg   [spi_width-13:0] pcTx_data_178,
    output reg   [spi_width-13:0] pcTx_data_179,
    output reg   [spi_width-13:0] pcTx_data_17A,
    output reg   [spi_width-13:0] pcTx_data_17B,
    output reg   [spi_width-13:0] pcTx_data_17C,
    output reg   [spi_width-13:0] pcTx_data_17D,
    output reg   [spi_width-13:0] pcTx_data_17E,
    output reg   [spi_width-13:0] pcTx_data_17F,
    output reg   [spi_width-13:0] pcTx_data_180,
    output reg   [spi_width-13:0] pcTx_data_181,
    output reg   [spi_width-13:0] pcTx_data_182,
    output reg   [spi_width-13:0] pcTx_data_183,
    output reg   [spi_width-13:0] pcTx_data_184,
    output reg   [spi_width-13:0] pcTx_data_185,
    output reg   [spi_width-13:0] pcTx_data_186,
    output reg   [spi_width-13:0] pcTx_data_187,
    output reg   [spi_width-13:0] pcTx_data_188,
    output reg   [spi_width-13:0] pcTx_data_189,
    output reg   [spi_width-13:0] pcTx_data_18A,
    output reg   [spi_width-13:0] pcTx_data_18B,
    output reg   [spi_width-13:0] pcTx_data_18C,
    output reg   [spi_width-13:0] pcTx_data_18D,
    output reg   [spi_width-13:0] pcTx_data_18E,
    output reg   [spi_width-13:0] pcTx_data_18F,
    output reg   [spi_width-13:0] pcTx_data_190,
    output reg   [spi_width-13:0] pcTx_data_191,
    output reg   [spi_width-13:0] pcTx_data_192,
    output reg   [spi_width-13:0] pcTx_data_193,
    output reg   [spi_width-13:0] pcTx_data_194,
    output reg   [spi_width-13:0] pcTx_data_195,
    output reg   [spi_width-13:0] pcTx_data_196,
    output reg   [spi_width-13:0] pcTx_data_197,
    output reg   [spi_width-13:0] pcTx_data_198,
    output reg   [spi_width-13:0] pcTx_data_199,
    output reg   [spi_width-13:0] pcTx_data_19A,
    output reg   [spi_width-13:0] pcTx_data_19B,
    output reg   [spi_width-13:0] pcTx_data_19C,
    output reg   [spi_width-13:0] pcTx_data_19D,
    output reg   [spi_width-13:0] pcTx_data_19E,
    output reg   [spi_width-13:0] pcTx_data_19F,
    output reg   [spi_width-13:0] pcTx_data_1A0,
    output reg   [spi_width-13:0] pcTx_data_1A1,
    output reg   [spi_width-13:0] pcTx_data_1A2,
    output reg   [spi_width-13:0] pcTx_data_1A3,
    output reg   [spi_width-13:0] pcTx_data_1A4,
    output reg   [spi_width-13:0] pcTx_data_1A5,
    output reg   [spi_width-13:0] pcTx_data_1A6,
    output reg   [spi_width-13:0] pcTx_data_1A7,
    output reg   [spi_width-13:0] pcTx_data_1A8,
    output reg   [spi_width-13:0] pcTx_data_1A9,
    output reg   [spi_width-13:0] pcTx_data_1AA,
    output reg   [spi_width-13:0] pcTx_data_1AB,
    output reg   [spi_width-13:0] pcTx_data_1AC,
    output reg   [spi_width-13:0] pcTx_data_1AD,
    output reg   [spi_width-13:0] pcTx_data_1AE,
    output reg   [spi_width-13:0] pcTx_data_1AF,
    output reg   [spi_width-13:0] pcTx_data_1B0,
    output reg   [spi_width-13:0] pcTx_data_1B1,
    output reg   [spi_width-13:0] pcTx_data_1B2,
    output reg   [spi_width-13:0] pcTx_data_1B3,
    output reg   [spi_width-13:0] pcTx_data_1B4,
    output reg   [spi_width-13:0] pcTx_data_1B5,
    output reg   [spi_width-13:0] pcTx_data_1B6,
    output reg   [spi_width-13:0] pcTx_data_1B7,
    output reg   [spi_width-13:0] pcTx_data_1B8,
    output reg   [spi_width-13:0] pcTx_data_1B9,
    output reg   [spi_width-13:0] pcTx_data_1BA,
    output reg   [spi_width-13:0] pcTx_data_1BB,
    output reg   [spi_width-13:0] pcTx_data_1BC,
    output reg   [spi_width-13:0] pcTx_data_1BD,
    output reg   [spi_width-13:0] pcTx_data_1BE,
    output reg   [spi_width-13:0] pcTx_data_1BF,
    output reg   [spi_width-13:0] pcTx_data_1C0,
    output reg   [spi_width-13:0] pcTx_data_1C1,
    output reg   [spi_width-13:0] pcTx_data_1C2,
    output reg   [spi_width-13:0] pcTx_data_1C3,
    output reg   [spi_width-13:0] pcTx_data_1C4,
    output reg   [spi_width-13:0] pcTx_data_1C5,
    output reg   [spi_width-13:0] pcTx_data_1C6,
    output reg   [spi_width-13:0] pcTx_data_1C7,
    output reg   [spi_width-13:0] pcTx_data_1C8,
    output reg   [spi_width-13:0] pcTx_data_1C9,
    output reg   [spi_width-13:0] pcTx_data_1CA,
    output reg   [spi_width-13:0] pcTx_data_1CB,
    output reg   [spi_width-13:0] pcTx_data_1CC,
    output reg   [spi_width-13:0] pcTx_data_1CD,
    output reg   [spi_width-13:0] pcTx_data_1CE,
    output reg   [spi_width-13:0] pcTx_data_1CF,
    output reg   [spi_width-13:0] pcTx_data_1D0,
    output reg   [spi_width-13:0] pcTx_data_1D1,
    output reg   [spi_width-13:0] pcTx_data_1D2,
    output reg   [spi_width-13:0] pcTx_data_1D3,
    output reg   [spi_width-13:0] pcTx_data_1D4,
    output reg   [spi_width-13:0] pcTx_data_1D5,
    output reg   [spi_width-13:0] pcTx_data_1D6,
    output reg   [spi_width-13:0] pcTx_data_1D7,
    output reg   [spi_width-13:0] pcTx_data_1D8,
    output reg   [spi_width-13:0] pcTx_data_1D9,
    output reg   [spi_width-13:0] pcTx_data_1DA,
    output reg   [spi_width-13:0] pcTx_data_1DB,
    output reg   [spi_width-13:0] pcTx_data_1DC,
    output reg   [spi_width-13:0] pcTx_data_1DD,
    output reg   [spi_width-13:0] pcTx_data_1DE,
    output reg   [spi_width-13:0] pcTx_data_1DF,
    output reg   [spi_width-13:0] pcTx_data_1E0,
    output reg   [spi_width-13:0] pcTx_data_1E1,
    output reg   [spi_width-13:0] pcTx_data_1E2,
    output reg   [spi_width-13:0] pcTx_data_1E3,
    output reg   [spi_width-13:0] pcTx_data_1E4,
    output reg   [spi_width-13:0] pcTx_data_1E5,
    output reg   [spi_width-13:0] pcTx_data_1E6,
    output reg   [spi_width-13:0] pcTx_data_1E7,
    output reg   [spi_width-13:0] pcTx_data_1E8,
    output reg   [spi_width-13:0] pcTx_data_1E9,
    output reg   [spi_width-13:0] pcTx_data_1EA,
    output reg   [spi_width-13:0] pcTx_data_1EB,
    output reg   [spi_width-13:0] pcTx_data_1EC,
    output reg   [spi_width-13:0] pcTx_data_1ED,
    output reg   [spi_width-13:0] pcTx_data_1EE,
    output reg   [spi_width-13:0] pcTx_data_1EF,
    output reg   [spi_width-13:0] pcTx_data_1F0,
    output reg   [spi_width-13:0] pcTx_data_1F1,
    output reg   [spi_width-13:0] pcTx_data_1F2,
    output reg   [spi_width-13:0] pcTx_data_1F3,
    output reg   [spi_width-13:0] pcTx_data_1F4,
    output reg   [spi_width-13:0] pcTx_data_1F5,
    output reg   [spi_width-13:0] pcTx_data_1F6,
    output reg   [spi_width-13:0] pcTx_data_1F7,
    output reg   [spi_width-13:0] pcTx_data_1F8,
    output reg   [spi_width-13:0] pcTx_data_1F9,
    output reg   [spi_width-13:0] pcTx_data_1FA,
    output reg   [spi_width-13:0] pcTx_data_1FB,
    output reg   [spi_width-13:0] pcTx_data_1FC,
    output reg   [spi_width-13:0] pcTx_data_1FD,
    output reg   [spi_width-13:0] pcTx_data_1FE,
    output reg   [spi_width-13:0] pcTx_data_1FF,
    output reg   [spi_width-13:0] pcTx_data_200,
    output reg   [spi_width-13:0] pcTx_data_201,
    output reg   [spi_width-13:0] pcTx_data_202,
    output reg   [spi_width-13:0] pcTx_data_203,
    output reg   [spi_width-13:0] pcTx_data_204,
    output reg   [spi_width-13:0] pcTx_data_205,
    output reg   [spi_width-13:0] pcTx_data_206,
    output reg   [spi_width-13:0] pcTx_data_207,
    output reg   [spi_width-13:0] pcTx_data_208,
    output reg   [spi_width-13:0] pcTx_data_209,
    output reg   [spi_width-13:0] pcTx_data_20A,
    output reg   [spi_width-13:0] pcTx_data_20B,
    output reg   [spi_width-13:0] pcTx_data_20C,
    output reg   [spi_width-13:0] pcTx_data_20D,
    output reg   [spi_width-13:0] pcTx_data_20E,
    output reg   [spi_width-13:0] pcTx_data_20F,
    output reg   [spi_width-13:0] pcTx_data_210,
    output reg   [spi_width-13:0] pcTx_data_211,
    output reg   [spi_width-13:0] pcTx_data_212,
    output reg   [spi_width-13:0] pcTx_data_213,
    output reg   [spi_width-13:0] pcTx_data_214,
    output reg   [spi_width-13:0] pcTx_data_215,
    output reg   [spi_width-13:0] pcTx_data_216,
    output reg   [spi_width-13:0] pcTx_data_217,
    output reg   [spi_width-13:0] pcTx_data_218,
    output reg   [spi_width-13:0] pcTx_data_219,
    output reg   [spi_width-13:0] pcTx_data_21A,
    output reg   [spi_width-13:0] pcTx_data_21B,
    output reg   [spi_width-13:0] pcTx_data_21C,
    output reg   [spi_width-13:0] pcTx_data_21D,
    output reg   [spi_width-13:0] pcTx_data_21E,
    output reg   [spi_width-13:0] pcTx_data_21F,
    output reg   [spi_width-13:0] pcTx_data_220,
    output reg   [spi_width-13:0] pcTx_data_221,
    output reg   [spi_width-13:0] pcTx_data_222,
    output reg   [spi_width-13:0] pcTx_data_223,
    output reg   [spi_width-13:0] pcTx_data_224,
    output reg   [spi_width-13:0] pcTx_data_225,
    output reg   [spi_width-13:0] pcTx_data_226,
    output reg   [spi_width-13:0] pcTx_data_227,
    output reg   [spi_width-13:0] pcTx_data_228,
    output reg   [spi_width-13:0] pcTx_data_229,
    output reg   [spi_width-13:0] pcTx_data_22A,
    output reg   [spi_width-13:0] pcTx_data_22B,
    output reg   [spi_width-13:0] pcTx_data_22C,
    output reg   [spi_width-13:0] pcTx_data_22D,
    output reg   [spi_width-13:0] pcTx_data_22E,
    output reg   [spi_width-13:0] pcTx_data_22F,
    output reg   [spi_width-13:0] pcTx_data_230,
    output reg   [spi_width-13:0] pcTx_data_231,
    output reg   [spi_width-13:0] pcTx_data_232,
    output reg   [spi_width-13:0] pcTx_data_233,
    output reg   [spi_width-13:0] pcTx_data_234,
    output reg   [spi_width-13:0] pcTx_data_235,
    output reg   [spi_width-13:0] pcTx_data_236,
    output reg   [spi_width-13:0] pcTx_data_237,
    output reg   [spi_width-13:0] pcTx_data_238,
    output reg   [spi_width-13:0] pcTx_data_239,
    output reg   [spi_width-13:0] pcTx_data_23A,
    output reg   [spi_width-13:0] pcTx_data_23B,
    output reg   [spi_width-13:0] pcTx_data_23C,
    output reg   [spi_width-13:0] pcTx_data_23D,
    output reg   [spi_width-13:0] pcTx_data_23E,
    output reg   [spi_width-13:0] pcTx_data_23F,
    
    
    
    //PC机读数
   
		input        [spi_width-13:0] pcRx_data_000, 
		input        [spi_width-13:0] pcRx_data_001,
    input        [spi_width-13:0] pcRx_data_002,
    input        [spi_width-13:0] pcRx_data_003,
    input        [spi_width-13:0] pcRx_data_004,
    input        [spi_width-13:0] pcRx_data_005,
    input        [spi_width-13:0] pcRx_data_006,
    input        [spi_width-13:0] pcRx_data_007,          
    input        [spi_width-13:0] pcRx_data_008,          
    input        [spi_width-13:0] pcRx_data_009,          
    input        [spi_width-13:0] pcRx_data_00A,          
    input        [spi_width-13:0] pcRx_data_00B,          
    input        [spi_width-13:0] pcRx_data_00C,          
    input        [spi_width-13:0] pcRx_data_00D,          
    input        [spi_width-13:0] pcRx_data_00E,          
    input        [spi_width-13:0] pcRx_data_00F,          
    input        [spi_width-13:0] pcRx_data_010,          
    input        [spi_width-13:0] pcRx_data_011,          
    input        [spi_width-13:0] pcRx_data_012,          
    input        [spi_width-13:0] pcRx_data_013,          
    input        [spi_width-13:0] pcRx_data_014,          
    input        [spi_width-13:0] pcRx_data_015,          
    input        [spi_width-13:0] pcRx_data_016,          
    input        [spi_width-13:0] pcRx_data_017,          
    input        [spi_width-13:0] pcRx_data_018,          
    input        [spi_width-13:0] pcRx_data_019,          
    input        [spi_width-13:0] pcRx_data_01A,          
    input        [spi_width-13:0] pcRx_data_01B,          
    input        [spi_width-13:0] pcRx_data_01C,          
    input        [spi_width-13:0] pcRx_data_01D,          
    input        [spi_width-13:0] pcRx_data_01E,          
    input        [spi_width-13:0] pcRx_data_01F,          
    input        [spi_width-13:0] pcRx_data_020,          
    input        [spi_width-13:0] pcRx_data_021,          
    input        [spi_width-13:0] pcRx_data_022,          
    input        [spi_width-13:0] pcRx_data_023,          
    input        [spi_width-13:0] pcRx_data_024,          
    input        [spi_width-13:0] pcRx_data_025,          
    input        [spi_width-13:0] pcRx_data_026,          
    input        [spi_width-13:0] pcRx_data_027,          
    input        [spi_width-13:0] pcRx_data_028,          
    input        [spi_width-13:0] pcRx_data_029,          
    input        [spi_width-13:0] pcRx_data_02A,          
    input        [spi_width-13:0] pcRx_data_02B,          
    input        [spi_width-13:0] pcRx_data_02C,          
    input        [spi_width-13:0] pcRx_data_02D,          
    input        [spi_width-13:0] pcRx_data_02E,          
    input        [spi_width-13:0] pcRx_data_02F,          
    input        [spi_width-13:0] pcRx_data_030,          
    input        [spi_width-13:0] pcRx_data_031,          
    input        [spi_width-13:0] pcRx_data_032,          
    input        [spi_width-13:0] pcRx_data_033,          
    input        [spi_width-13:0] pcRx_data_034,          
    input        [spi_width-13:0] pcRx_data_035,          
    input        [spi_width-13:0] pcRx_data_036,          
    input        [spi_width-13:0] pcRx_data_037,          
    input        [spi_width-13:0] pcRx_data_038,          
    input        [spi_width-13:0] pcRx_data_039,          
    input        [spi_width-13:0] pcRx_data_03A,          
    input        [spi_width-13:0] pcRx_data_03B,          
    input        [spi_width-13:0] pcRx_data_03C,          
    input        [spi_width-13:0] pcRx_data_03D,          
    input        [spi_width-13:0] pcRx_data_03E,          
    input        [spi_width-13:0] pcRx_data_03F,          
    input        [spi_width-13:0] pcRx_data_040,          
    input        [spi_width-13:0] pcRx_data_041,          
    input        [spi_width-13:0] pcRx_data_042,          
    input        [spi_width-13:0] pcRx_data_043,          
    input        [spi_width-13:0] pcRx_data_044,          
    input        [spi_width-13:0] pcRx_data_045,          
    input        [spi_width-13:0] pcRx_data_046,          
    input        [spi_width-13:0] pcRx_data_047,          
    input        [spi_width-13:0] pcRx_data_048,          
    input        [spi_width-13:0] pcRx_data_049,          
    input        [spi_width-13:0] pcRx_data_04A,          
    input        [spi_width-13:0] pcRx_data_04B,          
    input        [spi_width-13:0] pcRx_data_04C,          
    input        [spi_width-13:0] pcRx_data_04D,          
    input        [spi_width-13:0] pcRx_data_04E,          
    input        [spi_width-13:0] pcRx_data_04F,          
    input        [spi_width-13:0] pcRx_data_050,          
    input        [spi_width-13:0] pcRx_data_051,          
    input        [spi_width-13:0] pcRx_data_052,          
    input        [spi_width-13:0] pcRx_data_053,          
    input        [spi_width-13:0] pcRx_data_054,          
    input        [spi_width-13:0] pcRx_data_055,          
    input        [spi_width-13:0] pcRx_data_056,          
    input        [spi_width-13:0] pcRx_data_057,          
    input        [spi_width-13:0] pcRx_data_058,          
    input        [spi_width-13:0] pcRx_data_059,          
    input        [spi_width-13:0] pcRx_data_05A,          
    input        [spi_width-13:0] pcRx_data_05B,          
    input        [spi_width-13:0] pcRx_data_05C,          
    input        [spi_width-13:0] pcRx_data_05D,          
    input        [spi_width-13:0] pcRx_data_05E,          
    input        [spi_width-13:0] pcRx_data_05F,          
    input        [spi_width-13:0] pcRx_data_060,          
    input        [spi_width-13:0] pcRx_data_061,          
    input        [spi_width-13:0] pcRx_data_062,          
    input        [spi_width-13:0] pcRx_data_063,          
    input        [spi_width-13:0] pcRx_data_064,        
    input        [spi_width-13:0] pcRx_data_065,
    input        [spi_width-13:0] pcRx_data_066,
    input        [spi_width-13:0] pcRx_data_067,
    input        [spi_width-13:0] pcRx_data_068,
    input        [spi_width-13:0] pcRx_data_069,
    input        [spi_width-13:0] pcRx_data_06A,
    input        [spi_width-13:0] pcRx_data_06B,
    input        [spi_width-13:0] pcRx_data_06C,
    input        [spi_width-13:0] pcRx_data_06D,
    input        [spi_width-13:0] pcRx_data_06E,
    input        [spi_width-13:0] pcRx_data_06F,
    input        [spi_width-13:0] pcRx_data_070,
    input        [spi_width-13:0] pcRx_data_071,
    input        [spi_width-13:0] pcRx_data_072,
    input        [spi_width-13:0] pcRx_data_073,
    input        [spi_width-13:0] pcRx_data_074,
    input        [spi_width-13:0] pcRx_data_075,
    input        [spi_width-13:0] pcRx_data_076,
    input        [spi_width-13:0] pcRx_data_077,
    input        [spi_width-13:0] pcRx_data_078,
    input        [spi_width-13:0] pcRx_data_079,
    input        [spi_width-13:0] pcRx_data_07A,
    input        [spi_width-13:0] pcRx_data_07B,
    input        [spi_width-13:0] pcRx_data_07C,
    input        [spi_width-13:0] pcRx_data_07D,
    input        [spi_width-13:0] pcRx_data_07E,
    input        [spi_width-13:0] pcRx_data_07F,
    input        [spi_width-13:0] pcRx_data_080,
    input        [spi_width-13:0] pcRx_data_081,
    input        [spi_width-13:0] pcRx_data_082,
    input        [spi_width-13:0] pcRx_data_083,
    input        [spi_width-13:0] pcRx_data_084,
    input        [spi_width-13:0] pcRx_data_085,
    input        [spi_width-13:0] pcRx_data_086,
    input        [spi_width-13:0] pcRx_data_087,
    input        [spi_width-13:0] pcRx_data_088,
    input        [spi_width-13:0] pcRx_data_089,
    input        [spi_width-13:0] pcRx_data_08A,
    input        [spi_width-13:0] pcRx_data_08B,
    input        [spi_width-13:0] pcRx_data_08C,
    input        [spi_width-13:0] pcRx_data_08D,
    input        [spi_width-13:0] pcRx_data_08E,
    input        [spi_width-13:0] pcRx_data_08F,
    input        [spi_width-13:0] pcRx_data_090,
    input        [spi_width-13:0] pcRx_data_091,
    input        [spi_width-13:0] pcRx_data_092,
    input        [spi_width-13:0] pcRx_data_093,
    input        [spi_width-13:0] pcRx_data_094,
    input        [spi_width-13:0] pcRx_data_095,
    input        [spi_width-13:0] pcRx_data_096,
    input        [spi_width-13:0] pcRx_data_097,
    input        [spi_width-13:0] pcRx_data_098,
    input        [spi_width-13:0] pcRx_data_099,
    input        [spi_width-13:0] pcRx_data_09A,
    input        [spi_width-13:0] pcRx_data_09B,
    input        [spi_width-13:0] pcRx_data_09C,
    input        [spi_width-13:0] pcRx_data_09D,
    input        [spi_width-13:0] pcRx_data_09E,
    input        [spi_width-13:0] pcRx_data_09F,
    input        [spi_width-13:0] pcRx_data_0A0,
    input        [spi_width-13:0] pcRx_data_0A1,
    input        [spi_width-13:0] pcRx_data_0A2,
    input        [spi_width-13:0] pcRx_data_0A3,
    input        [spi_width-13:0] pcRx_data_0A4,
    input        [spi_width-13:0] pcRx_data_0A5,
    input        [spi_width-13:0] pcRx_data_0A6,
    input        [spi_width-13:0] pcRx_data_0A7,
    input        [spi_width-13:0] pcRx_data_0A8,
    input        [spi_width-13:0] pcRx_data_0A9,
    input        [spi_width-13:0] pcRx_data_0AA,
    input        [spi_width-13:0] pcRx_data_0AB,
    input        [spi_width-13:0] pcRx_data_0AC,
    input        [spi_width-13:0] pcRx_data_0AD,
    input        [spi_width-13:0] pcRx_data_0AE,
    input        [spi_width-13:0] pcRx_data_0AF,
    input        [spi_width-13:0] pcRx_data_0B0,
    input        [spi_width-13:0] pcRx_data_0B1,
    input        [spi_width-13:0] pcRx_data_0B2,
    input        [spi_width-13:0] pcRx_data_0B3,
    input        [spi_width-13:0] pcRx_data_0B4,
    input        [spi_width-13:0] pcRx_data_0B5,
    input        [spi_width-13:0] pcRx_data_0B6,
    input        [spi_width-13:0] pcRx_data_0B7,
    input        [spi_width-13:0] pcRx_data_0B8,
    input        [spi_width-13:0] pcRx_data_0B9,
    input        [spi_width-13:0] pcRx_data_0BA,
    input        [spi_width-13:0] pcRx_data_0BB,
    input        [spi_width-13:0] pcRx_data_0BC,
    input        [spi_width-13:0] pcRx_data_0BD,
    input        [spi_width-13:0] pcRx_data_0BE,
    input        [spi_width-13:0] pcRx_data_0BF,
    input        [spi_width-13:0] pcRx_data_0C0,
    input        [spi_width-13:0] pcRx_data_0C1,
    input        [spi_width-13:0] pcRx_data_0C2,
    input        [spi_width-13:0] pcRx_data_0C3,
    input        [spi_width-13:0] pcRx_data_0C4,
    input        [spi_width-13:0] pcRx_data_0C5,
    input        [spi_width-13:0] pcRx_data_0C6,
    input        [spi_width-13:0] pcRx_data_0C7,
    input        [spi_width-13:0] pcRx_data_0C8,
    input        [spi_width-13:0] pcRx_data_0C9,
    input        [spi_width-13:0] pcRx_data_0CA,
    input        [spi_width-13:0] pcRx_data_0CB,
    input        [spi_width-13:0] pcRx_data_0CC,
    input        [spi_width-13:0] pcRx_data_0CD,
    input        [spi_width-13:0] pcRx_data_0CE,
    input        [spi_width-13:0] pcRx_data_0CF,
    input        [spi_width-13:0] pcRx_data_0D0,
    input        [spi_width-13:0] pcRx_data_0D1,
    input        [spi_width-13:0] pcRx_data_0D2,
    input        [spi_width-13:0] pcRx_data_0D3,
    input        [spi_width-13:0] pcRx_data_0D4,
    input        [spi_width-13:0] pcRx_data_0D5,
    input        [spi_width-13:0] pcRx_data_0D6,
    input        [spi_width-13:0] pcRx_data_0D7,
    input        [spi_width-13:0] pcRx_data_0D8,
    input        [spi_width-13:0] pcRx_data_0D9,
    input        [spi_width-13:0] pcRx_data_0DA,
    input        [spi_width-13:0] pcRx_data_0DB,
    input        [spi_width-13:0] pcRx_data_0DC,
    input        [spi_width-13:0] pcRx_data_0DD,
    input        [spi_width-13:0] pcRx_data_0DE,
    input        [spi_width-13:0] pcRx_data_0DF,
    input        [spi_width-13:0] pcRx_data_0E0,
    input        [spi_width-13:0] pcRx_data_0E1,
    input        [spi_width-13:0] pcRx_data_0E2,
    input        [spi_width-13:0] pcRx_data_0E3,
    input        [spi_width-13:0] pcRx_data_0E4,
    input        [spi_width-13:0] pcRx_data_0E5,
    input        [spi_width-13:0] pcRx_data_0E6,
    input        [spi_width-13:0] pcRx_data_0E7,
    input        [spi_width-13:0] pcRx_data_0E8,
    input        [spi_width-13:0] pcRx_data_0E9,
    input        [spi_width-13:0] pcRx_data_0EA,
    input        [spi_width-13:0] pcRx_data_0EB,
    input        [spi_width-13:0] pcRx_data_0EC,
    input        [spi_width-13:0] pcRx_data_0ED,
    input        [spi_width-13:0] pcRx_data_0EE,
    input        [spi_width-13:0] pcRx_data_0EF,
    input        [spi_width-13:0] pcRx_data_0F0,
    input        [spi_width-13:0] pcRx_data_0F1,
    input        [spi_width-13:0] pcRx_data_0F2,
    input        [spi_width-13:0] pcRx_data_0F3,
    input        [spi_width-13:0] pcRx_data_0F4,
    input        [spi_width-13:0] pcRx_data_0F5,
    input        [spi_width-13:0] pcRx_data_0F6,
    input        [spi_width-13:0] pcRx_data_0F7,
    input        [spi_width-13:0] pcRx_data_0F8,
    input        [spi_width-13:0] pcRx_data_0F9,
    input        [spi_width-13:0] pcRx_data_0FA,
    input        [spi_width-13:0] pcRx_data_0FB,
    input        [spi_width-13:0] pcRx_data_0FC,
    input        [spi_width-13:0] pcRx_data_0FD,
    input        [spi_width-13:0] pcRx_data_0FE,
    input        [spi_width-13:0] pcRx_data_0FF,   
    input        [spi_width-13:0] pcRx_data_100,
    input        [spi_width-13:0] pcRx_data_101,
    input        [spi_width-13:0] pcRx_data_102,
    input        [spi_width-13:0] pcRx_data_103,
    input        [spi_width-13:0] pcRx_data_104,
    input        [spi_width-13:0] pcRx_data_105,
    input        [spi_width-13:0] pcRx_data_106,
    input        [spi_width-13:0] pcRx_data_107,
    input        [spi_width-13:0] pcRx_data_108,
    input        [spi_width-13:0] pcRx_data_109,
    input        [spi_width-13:0] pcRx_data_10A,
    input        [spi_width-13:0] pcRx_data_10B,
    input        [spi_width-13:0] pcRx_data_10C,
    input        [spi_width-13:0] pcRx_data_10D,
    input        [spi_width-13:0] pcRx_data_10E,
    input        [spi_width-13:0] pcRx_data_10F,
    input        [spi_width-13:0] pcRx_data_110,
    input        [spi_width-13:0] pcRx_data_111,
    input        [spi_width-13:0] pcRx_data_112,
    input        [spi_width-13:0] pcRx_data_113,
    input        [spi_width-13:0] pcRx_data_114,
    input        [spi_width-13:0] pcRx_data_115,
    input        [spi_width-13:0] pcRx_data_116,
    input        [spi_width-13:0] pcRx_data_117,
    input        [spi_width-13:0] pcRx_data_118,
    input        [spi_width-13:0] pcRx_data_119,
    input        [spi_width-13:0] pcRx_data_11A,
    input        [spi_width-13:0] pcRx_data_11B,
    input        [spi_width-13:0] pcRx_data_11C,
    input        [spi_width-13:0] pcRx_data_11D,
    input        [spi_width-13:0] pcRx_data_11E,
    input        [spi_width-13:0] pcRx_data_11F,
    input        [spi_width-13:0] pcRx_data_120,
    input        [spi_width-13:0] pcRx_data_121,
    input        [spi_width-13:0] pcRx_data_122,
    input        [spi_width-13:0] pcRx_data_123,
    input        [spi_width-13:0] pcRx_data_124,
    input        [spi_width-13:0] pcRx_data_125,
    input        [spi_width-13:0] pcRx_data_126,
    input        [spi_width-13:0] pcRx_data_127,
    input        [spi_width-13:0] pcRx_data_128,
    input        [spi_width-13:0] pcRx_data_129,
    input        [spi_width-13:0] pcRx_data_12A,
    input        [spi_width-13:0] pcRx_data_12B,
    input        [spi_width-13:0] pcRx_data_12C,
    input        [spi_width-13:0] pcRx_data_12D,
    input        [spi_width-13:0] pcRx_data_12E,
    input        [spi_width-13:0] pcRx_data_12F,
    input        [spi_width-13:0] pcRx_data_130,
    input        [spi_width-13:0] pcRx_data_131,
    input        [spi_width-13:0] pcRx_data_132,
    input        [spi_width-13:0] pcRx_data_133,
    input        [spi_width-13:0] pcRx_data_134,
    input        [spi_width-13:0] pcRx_data_135,
    input        [spi_width-13:0] pcRx_data_136,
    input        [spi_width-13:0] pcRx_data_137,
    input        [spi_width-13:0] pcRx_data_138,
    input        [spi_width-13:0] pcRx_data_139,
    input        [spi_width-13:0] pcRx_data_13A,
    input        [spi_width-13:0] pcRx_data_13B,
    input        [spi_width-13:0] pcRx_data_13C,
    input        [spi_width-13:0] pcRx_data_13D,
    input        [spi_width-13:0] pcRx_data_13E,
    input        [spi_width-13:0] pcRx_data_13F,
    input        [spi_width-13:0] pcRx_data_140,
    input        [spi_width-13:0] pcRx_data_141,
    input        [spi_width-13:0] pcRx_data_142,
    input        [spi_width-13:0] pcRx_data_143,
    input        [spi_width-13:0] pcRx_data_144,
    input        [spi_width-13:0] pcRx_data_145,
    input        [spi_width-13:0] pcRx_data_146,
    input        [spi_width-13:0] pcRx_data_147,
    input        [spi_width-13:0] pcRx_data_148,
    input        [spi_width-13:0] pcRx_data_149,
    input        [spi_width-13:0] pcRx_data_14A,
    input        [spi_width-13:0] pcRx_data_14B,
    input        [spi_width-13:0] pcRx_data_14C,
    input        [spi_width-13:0] pcRx_data_14D,
    input        [spi_width-13:0] pcRx_data_14E,
    input        [spi_width-13:0] pcRx_data_14F,
    input        [spi_width-13:0] pcRx_data_150,
    input        [spi_width-13:0] pcRx_data_151,
    input        [spi_width-13:0] pcRx_data_152,
    input        [spi_width-13:0] pcRx_data_153,
    input        [spi_width-13:0] pcRx_data_154,
    input        [spi_width-13:0] pcRx_data_155,
    input        [spi_width-13:0] pcRx_data_156,
    input        [spi_width-13:0] pcRx_data_157,
    input        [spi_width-13:0] pcRx_data_158,
    input        [spi_width-13:0] pcRx_data_159,
    input        [spi_width-13:0] pcRx_data_15A,
    input        [spi_width-13:0] pcRx_data_15B,
    input        [spi_width-13:0] pcRx_data_15C,
    input        [spi_width-13:0] pcRx_data_15D,
    input        [spi_width-13:0] pcRx_data_15E,
    input        [spi_width-13:0] pcRx_data_15F,
    input        [spi_width-13:0] pcRx_data_160,
    input        [spi_width-13:0] pcRx_data_161,
    input        [spi_width-13:0] pcRx_data_162,
    input        [spi_width-13:0] pcRx_data_163,
    input        [spi_width-13:0] pcRx_data_164,
    input        [spi_width-13:0] pcRx_data_165,
    input        [spi_width-13:0] pcRx_data_166,
    input        [spi_width-13:0] pcRx_data_167,
    input        [spi_width-13:0] pcRx_data_168,
    input        [spi_width-13:0] pcRx_data_169,
    input        [spi_width-13:0] pcRx_data_16A,
    input        [spi_width-13:0] pcRx_data_16B,
    input        [spi_width-13:0] pcRx_data_16C,
    input        [spi_width-13:0] pcRx_data_16D,
    input        [spi_width-13:0] pcRx_data_16E,
    input        [spi_width-13:0] pcRx_data_16F,
    input        [spi_width-13:0] pcRx_data_170,
    input        [spi_width-13:0] pcRx_data_171,
    input        [spi_width-13:0] pcRx_data_172,
    input        [spi_width-13:0] pcRx_data_173,
    input        [spi_width-13:0] pcRx_data_174,
    input        [spi_width-13:0] pcRx_data_175,
    input        [spi_width-13:0] pcRx_data_176,
    input        [spi_width-13:0] pcRx_data_177,
    input        [spi_width-13:0] pcRx_data_178,
    input        [spi_width-13:0] pcRx_data_179,
    input        [spi_width-13:0] pcRx_data_17A,
    input        [spi_width-13:0] pcRx_data_17B,
    input        [spi_width-13:0] pcRx_data_17C,
    input        [spi_width-13:0] pcRx_data_17D,
    input        [spi_width-13:0] pcRx_data_17E,
    input        [spi_width-13:0] pcRx_data_17F,
    input        [spi_width-13:0] pcRx_data_180,
    input        [spi_width-13:0] pcRx_data_181,
    input        [spi_width-13:0] pcRx_data_182,
    input        [spi_width-13:0] pcRx_data_183,
    input        [spi_width-13:0] pcRx_data_184,
    input        [spi_width-13:0] pcRx_data_185,
    input        [spi_width-13:0] pcRx_data_186,
    input        [spi_width-13:0] pcRx_data_187,
    input        [spi_width-13:0] pcRx_data_188,
    input        [spi_width-13:0] pcRx_data_189,
    input        [spi_width-13:0] pcRx_data_18A,
    input        [spi_width-13:0] pcRx_data_18B,
    input        [spi_width-13:0] pcRx_data_18C,
    input        [spi_width-13:0] pcRx_data_18D,
    input        [spi_width-13:0] pcRx_data_18E,
    input        [spi_width-13:0] pcRx_data_18F,
    input        [spi_width-13:0] pcRx_data_190,
    input        [spi_width-13:0] pcRx_data_191,
    input        [spi_width-13:0] pcRx_data_192,
    input        [spi_width-13:0] pcRx_data_193,
    input        [spi_width-13:0] pcRx_data_194,
    input        [spi_width-13:0] pcRx_data_195,
    input        [spi_width-13:0] pcRx_data_196,
    input        [spi_width-13:0] pcRx_data_197,
    input        [spi_width-13:0] pcRx_data_198,
    input        [spi_width-13:0] pcRx_data_199,
    input        [spi_width-13:0] pcRx_data_19A,
    input        [spi_width-13:0] pcRx_data_19B,
    input        [spi_width-13:0] pcRx_data_19C,
    input        [spi_width-13:0] pcRx_data_19D,
    input        [spi_width-13:0] pcRx_data_19E,
    input        [spi_width-13:0] pcRx_data_19F,
    input        [spi_width-13:0] pcRx_data_1A0,
    input        [spi_width-13:0] pcRx_data_1A1,
    input        [spi_width-13:0] pcRx_data_1A2,
    input        [spi_width-13:0] pcRx_data_1A3,
    input        [spi_width-13:0] pcRx_data_1A4,
    input        [spi_width-13:0] pcRx_data_1A5,
    input        [spi_width-13:0] pcRx_data_1A6,
    input        [spi_width-13:0] pcRx_data_1A7,
    input        [spi_width-13:0] pcRx_data_1A8,
    input        [spi_width-13:0] pcRx_data_1A9,
    input        [spi_width-13:0] pcRx_data_1AA,
    input        [spi_width-13:0] pcRx_data_1AB,
    input        [spi_width-13:0] pcRx_data_1AC,
    input        [spi_width-13:0] pcRx_data_1AD,
    input        [spi_width-13:0] pcRx_data_1AE,
    input        [spi_width-13:0] pcRx_data_1AF,
    input        [spi_width-13:0] pcRx_data_1B0,
    input        [spi_width-13:0] pcRx_data_1B1,
    input        [spi_width-13:0] pcRx_data_1B2,
    input        [spi_width-13:0] pcRx_data_1B3,
    input        [spi_width-13:0] pcRx_data_1B4,
    input        [spi_width-13:0] pcRx_data_1B5,
    input        [spi_width-13:0] pcRx_data_1B6,
    input        [spi_width-13:0] pcRx_data_1B7,
    input        [spi_width-13:0] pcRx_data_1B8,
    input        [spi_width-13:0] pcRx_data_1B9,
    input        [spi_width-13:0] pcRx_data_1BA,
    input        [spi_width-13:0] pcRx_data_1BB,
    input        [spi_width-13:0] pcRx_data_1BC,
    input        [spi_width-13:0] pcRx_data_1BD,
    input        [spi_width-13:0] pcRx_data_1BE,
    input        [spi_width-13:0] pcRx_data_1BF,
    input        [spi_width-13:0] pcRx_data_1C0,
    input        [spi_width-13:0] pcRx_data_1C1,
    input        [spi_width-13:0] pcRx_data_1C2,
    input        [spi_width-13:0] pcRx_data_1C3,
    input        [spi_width-13:0] pcRx_data_1C4,
    input        [spi_width-13:0] pcRx_data_1C5,
    input        [spi_width-13:0] pcRx_data_1C6,
    input        [spi_width-13:0] pcRx_data_1C7,
    input        [spi_width-13:0] pcRx_data_1C8,
    input        [spi_width-13:0] pcRx_data_1C9,
    input        [spi_width-13:0] pcRx_data_1CA,
    input        [spi_width-13:0] pcRx_data_1CB,
    input        [spi_width-13:0] pcRx_data_1CC,
    input        [spi_width-13:0] pcRx_data_1CD,
    input        [spi_width-13:0] pcRx_data_1CE,
    input        [spi_width-13:0] pcRx_data_1CF,
    input        [spi_width-13:0] pcRx_data_1D0,
    input        [spi_width-13:0] pcRx_data_1D1,
    input        [spi_width-13:0] pcRx_data_1D2,
    input        [spi_width-13:0] pcRx_data_1D3,
    input        [spi_width-13:0] pcRx_data_1D4,
    input        [spi_width-13:0] pcRx_data_1D5,
    input        [spi_width-13:0] pcRx_data_1D6,
    input        [spi_width-13:0] pcRx_data_1D7,
    input        [spi_width-13:0] pcRx_data_1D8,
    input        [spi_width-13:0] pcRx_data_1D9,
    input        [spi_width-13:0] pcRx_data_1DA,
    input        [spi_width-13:0] pcRx_data_1DB,
    input        [spi_width-13:0] pcRx_data_1DC,
    input        [spi_width-13:0] pcRx_data_1DD,
    input        [spi_width-13:0] pcRx_data_1DE,
    input        [spi_width-13:0] pcRx_data_1DF,
    input        [spi_width-13:0] pcRx_data_1E0,
    input        [spi_width-13:0] pcRx_data_1E1,
    input        [spi_width-13:0] pcRx_data_1E2,
    input        [spi_width-13:0] pcRx_data_1E3,
    input        [spi_width-13:0] pcRx_data_1E4,
    input        [spi_width-13:0] pcRx_data_1E5,
    input        [spi_width-13:0] pcRx_data_1E6,
    input        [spi_width-13:0] pcRx_data_1E7,
    input        [spi_width-13:0] pcRx_data_1E8,
    input        [spi_width-13:0] pcRx_data_1E9,
    input        [spi_width-13:0] pcRx_data_1EA,
    input        [spi_width-13:0] pcRx_data_1EB,
    input        [spi_width-13:0] pcRx_data_1EC,
    input        [spi_width-13:0] pcRx_data_1ED,
    input        [spi_width-13:0] pcRx_data_1EE,
    input        [spi_width-13:0] pcRx_data_1EF,
    input        [spi_width-13:0] pcRx_data_1F0,
    input        [spi_width-13:0] pcRx_data_1F1,
    input        [spi_width-13:0] pcRx_data_1F2,
    input        [spi_width-13:0] pcRx_data_1F3,
    input        [spi_width-13:0] pcRx_data_1F4,
    input        [spi_width-13:0] pcRx_data_1F5,
    input        [spi_width-13:0] pcRx_data_1F6,
    input        [spi_width-13:0] pcRx_data_1F7,
    input        [spi_width-13:0] pcRx_data_1F8,
    input        [spi_width-13:0] pcRx_data_1F9,
    input        [spi_width-13:0] pcRx_data_1FA,
    input        [spi_width-13:0] pcRx_data_1FB,
    input        [spi_width-13:0] pcRx_data_1FC,
    input        [spi_width-13:0] pcRx_data_1FD,
    input        [spi_width-13:0] pcRx_data_1FE,
    input        [spi_width-13:0] pcRx_data_1FF,
    input        [spi_width-13:0] pcRx_data_200,
    input        [spi_width-13:0] pcRx_data_201,
    input        [spi_width-13:0] pcRx_data_202,
    input        [spi_width-13:0] pcRx_data_203,
    input        [spi_width-13:0] pcRx_data_204,
    input        [spi_width-13:0] pcRx_data_205,
    input        [spi_width-13:0] pcRx_data_206,
    input        [spi_width-13:0] pcRx_data_207,
    input        [spi_width-13:0] pcRx_data_208,
    input        [spi_width-13:0] pcRx_data_209,
    input        [spi_width-13:0] pcRx_data_20A,
    input        [spi_width-13:0] pcRx_data_20B,
    input        [spi_width-13:0] pcRx_data_20C,
    input        [spi_width-13:0] pcRx_data_20D,
    input        [spi_width-13:0] pcRx_data_20E,
    input        [spi_width-13:0] pcRx_data_20F,
    input        [spi_width-13:0] pcRx_data_210,
    input        [spi_width-13:0] pcRx_data_211,
    input        [spi_width-13:0] pcRx_data_212,
    input        [spi_width-13:0] pcRx_data_213,
    input        [spi_width-13:0] pcRx_data_214,
    input        [spi_width-13:0] pcRx_data_215,
    input        [spi_width-13:0] pcRx_data_216,
    input        [spi_width-13:0] pcRx_data_217,
    input        [spi_width-13:0] pcRx_data_218,
    input        [spi_width-13:0] pcRx_data_219,
    input        [spi_width-13:0] pcRx_data_21A,
    input        [spi_width-13:0] pcRx_data_21B,
    input        [spi_width-13:0] pcRx_data_21C,
    input        [spi_width-13:0] pcRx_data_21D,
    input        [spi_width-13:0] pcRx_data_21E,
    input        [spi_width-13:0] pcRx_data_21F,
    input        [spi_width-13:0] pcRx_data_220,
    input        [spi_width-13:0] pcRx_data_221,
    input        [spi_width-13:0] pcRx_data_222,
    input        [spi_width-13:0] pcRx_data_223,
    input        [spi_width-13:0] pcRx_data_224,
    input        [spi_width-13:0] pcRx_data_225,
    input        [spi_width-13:0] pcRx_data_226,
    input        [spi_width-13:0] pcRx_data_227,
    input        [spi_width-13:0] pcRx_data_228,
    input        [spi_width-13:0] pcRx_data_229,
    input        [spi_width-13:0] pcRx_data_22A,
    input        [spi_width-13:0] pcRx_data_22B,
    input        [spi_width-13:0] pcRx_data_22C,
    input        [spi_width-13:0] pcRx_data_22D,
    input        [spi_width-13:0] pcRx_data_22E,
    input        [spi_width-13:0] pcRx_data_22F,
    input        [spi_width-13:0] pcRx_data_230,
    input        [spi_width-13:0] pcRx_data_231,
    input        [spi_width-13:0] pcRx_data_232,
    input        [spi_width-13:0] pcRx_data_233,
    input        [spi_width-13:0] pcRx_data_234,
    input        [spi_width-13:0] pcRx_data_235,
    input        [spi_width-13:0] pcRx_data_236,
    input        [spi_width-13:0] pcRx_data_237,
    input        [spi_width-13:0] pcRx_data_238,
    input        [spi_width-13:0] pcRx_data_239,
    input        [spi_width-13:0] pcRx_data_23A,
    input        [spi_width-13:0] pcRx_data_23B,
    input        [spi_width-13:0] pcRx_data_23C,
    input        [spi_width-13:0] pcRx_data_23D,
    input        [spi_width-13:0] pcRx_data_23E,
    input        [spi_width-13:0] pcRx_data_23F
    
        
    );

reg [spi_width-13:0] spi_data;
reg spi_valid_reg;
reg [spi_width-13:0] inter_dat0,inter_dat1,inter_dat3,inter_dat4,inter_dat5,inter_dat6,inter_dat7,
                     inter_dat8,inter_dat9,inter_dat10,inter_dat11,inter_dat12,inter_dat13,inter_dat14,inter_dat15;
(*KEEP="TRUE"*)reg [spi_width-1:0] inter_dat2;

(*KEEP="TRUE"*)reg con_en;
(*KEEP="TRUE"*)reg [9:0]con;

reg [spi_width-1:0] receive_spi_data;  




always @(posedge ref_clk)
begin
	  spi_valid_reg<=spi_valid;	
	  spi_data<=spi_all_data[spi_width-13:0];	
	  receive_spi_data <=spi_all_data; 
end


//将输出数据补全为41位，12位地址+32位数据	
always @(posedge ref_clk)
begin
    RD_DATA_K7[spi_width-1:spi_width-12] <=inter_dat2[spi_width-13:spi_width-24]; 
end

			 
//产生k7--->v6发送数据的使能信号
always @(posedge ref_clk)
begin
	 if({spi_valid_reg,spi_valid} ==2'b10 && spi_all_data[spi_width-1:spi_width-12]==12'h002&&spi_all_data[spi_width-25:0]==20'hABCDE )
	 begin
		spi_en<=0;
		con_en<=1;
		con<=10'd0;
	 end
	 if(con_en==1&&con<10'd100)
	 begin
		con<=con+1;
		spi_en<=0;
	 end
	 else if(con>=10'd100)
	 begin
		spi_en<=1;
	 end
end


//V6-------------->k7
always @ (posedge ref_clk)
begin	
//		spi_valid_reg<=spi_valid;
//		spi_valid_reg_reg<=spi_valid_reg;
//		spi_data<=spi_all_data[spi_width-13:0];
		
     if({spi_valid_reg,spi_valid} ==2'b10)
	  begin
	      case(spi_all_data[spi_width-1:spi_width-12])	//高12位为地址	
				12'h000: 
        begin
          //pcTx_data_000<= spi_data;
          inter_dat0<= spi_data; 
        end                
				12'h001: 
        begin
          //pcTx_data_001<= spi_data;
          inter_dat1<= spi_data; 
        end                          
        12'h002:                     
        begin                        
          //pcTx_data_002<= spi_data;
          inter_dat2<= spi_all_data;
        end                                                  
        12'h003:                    
        begin                       
         // pcTx_data_003<= spi_data; 
          inter_dat3<= spi_data; 
        end                          
        12'h004:                     
        begin                        
          //pcTx_data_004<= spi_data; 
          inter_dat4<= spi_data;
        end                          
        12'h005:                     
        begin                        
          //pcTx_data_005<= spi_data;
          inter_dat5<= spi_data;
        end                          
        12'h006:                     
        begin                        
          //pcTx_data_006<= spi_data;
          inter_dat6<= spi_data;
          
        end                          
        12'h007:                     
        begin                        
          //pcTx_data_007<= spi_data;
          inter_dat7<= spi_data;
        end                          
        12'h008:                     
        begin                        
          //pcTx_data_008<= spi_data;
          inter_dat8<= spi_data;
        end                          
        12'h009:                     
        begin                        
          //pcTx_data_009<= spi_data;
          inter_dat9<= spi_data;
        end                          
        12'h00A:                     
        begin                        
          //pcTx_data_00A<= spi_data;
          inter_dat10<= spi_data;
        end                          
        12'h00B:                     
        begin                        
          //pcTx_data_00B<= spi_data;
          inter_dat11<= spi_data;
        end                          
        12'h00C:                     
        begin                        
         // pcTx_data_00C<= spi_data;
         inter_dat12<= spi_data;
        end                          
        12'h00D:                     
        begin                        
          //pcTx_data_00D<= spi_data;
            inter_dat13<= spi_data;
        end                          
        12'h00E:                     
        begin                        
          //pcTx_data_00E<= spi_data;
          inter_dat14<= spi_data;
        end                          
        12'h00F:                     
        begin                        
          //pcTx_data_00F<= spi_data;
          inter_dat15<= spi_data;
        end                          
        12'h010:                     
        begin                        
          pcTx_data_010<= spi_data;
        end                          
        12'h011:                     
        begin                        
          pcTx_data_011<= spi_data;
        end                          
        12'h012:                     
        begin                        
          pcTx_data_012<= spi_data;
        end                          
        12'h013:                     
        begin                        
          pcTx_data_013<= spi_data;
        end                          
        12'h014:                     
        begin                        
          pcTx_data_014<= spi_data;
        end                          
        12'h015:                     
        begin                        
          pcTx_data_015<= spi_data;
        end                          
        12'h016:                     
        begin                        
          pcTx_data_016<= spi_data;
        end                          
        12'h017:                     
        begin                        
          pcTx_data_017<= spi_data;
        end                          
        12'h018:                     
        begin                        
          pcTx_data_018<= spi_data;
        end                          
        12'h019:                     
        begin                        
          pcTx_data_019<= spi_data;
        end                          
        12'h01A:                     
        begin                        
          pcTx_data_01A<= spi_data;
        end                          
        12'h01B:                     
        begin                        
          pcTx_data_01B<= spi_data;
        end                          
        12'h01C:                     
        begin                        
          pcTx_data_01C<= spi_data;
        end                          
        12'h01D:                     
        begin                        
          pcTx_data_01D<= spi_data;
        end                          
        12'h01E:                     
        begin                        
          pcTx_data_01E<= spi_data;
        end                          
        12'h01F:                     
        begin                        
          pcTx_data_01F<= spi_data;
        end                          
        12'h020:                     
        begin                        
          pcTx_data_020<= spi_data;
        end                          
        12'h021:                     
        begin                        
          pcTx_data_021<= spi_data;
        end                          
        12'h022:                     
        begin                        
          pcTx_data_022<= spi_data;
        end                          
        12'h023:                     
        begin                        
          pcTx_data_023<= spi_data;
        end                          
        12'h024:                     
        begin                        
          pcTx_data_024<= spi_data;
        end                          
        12'h025:                     
        begin                        
          pcTx_data_025<= spi_data;
        end                          
        12'h026:                     
        begin                        
          pcTx_data_026<= spi_data;
        end                          
        12'h027:                     
        begin                        
          pcTx_data_027<= spi_data;
        end                          
        12'h028:                     
        begin                        
          pcTx_data_028<= spi_data;
        end                          
        12'h029:                     
        begin                        
          pcTx_data_029<= spi_data;
        end                          
        12'h02A:                     
        begin                        
          pcTx_data_02A<= spi_data;
        end                          
        12'h02B:                     
        begin                        
          pcTx_data_02B<= spi_data;
        end                          
        12'h02C:                     
        begin                        
          pcTx_data_02C<= spi_data;
        end                          
        12'h02D:                     
        begin                        
          pcTx_data_02D<= spi_data;
        end                          
        12'h02E:                     
        begin                        
          pcTx_data_02E<= spi_data;
        end                          
        12'h02F:                     
        begin                        
          pcTx_data_02F<= spi_data;
        end                          
        12'h030:                     
        begin                        
          pcTx_data_030<= spi_data;
        end                          
        12'h031:                     
        begin                        
          pcTx_data_031<= spi_data;
        end                          
        12'h032:                     
        begin                        
          pcTx_data_032<= spi_data;
        end                          
        12'h033:                     
        begin                        
          pcTx_data_033<= spi_data;
        end                          
        12'h034:                     
        begin                        
          pcTx_data_034<= spi_data;
        end                          
        12'h035:                     
        begin                        
          pcTx_data_035<= spi_data;
        end                          
        12'h036:                     
        begin                        
          pcTx_data_036<= spi_data;
        end                          
        12'h037:                     
        begin                        
          pcTx_data_037<= spi_data;
        end                          
        12'h038:                     
        begin                        
          pcTx_data_038<= spi_data;
        end                          
        12'h039:                     
        begin                        
          pcTx_data_039<= spi_data;
        end                          
        12'h03A:                     
        begin                        
          pcTx_data_03A<= spi_data;
        end                          
        12'h03B:                     
        begin                        
          pcTx_data_03B<= spi_data;
        end                          
        12'h03C:                     
        begin                        
          pcTx_data_03C<= spi_data;
        end                          
        12'h03D:                     
        begin                        
          pcTx_data_03D<= spi_data;
        end                          
        12'h03E:                     
        begin                        
          pcTx_data_03E<= spi_data;
        end                          
        12'h03F:                     
        begin                        
          pcTx_data_03F<= spi_data;
        end                          
        12'h040:                     
        begin                        
          pcTx_data_040<= spi_data;
        end                          
        12'h041:                     
        begin                        
          pcTx_data_041<= spi_data;
        end                          
        12'h042:                     
        begin                        
          pcTx_data_042<= spi_data;
        end                          
        12'h043:                     
        begin                        
          pcTx_data_043<= spi_data;
        end                          
        12'h044:                     
        begin                        
          pcTx_data_044<= spi_data;
        end                          
        12'h045:                     
        begin                        
          pcTx_data_045<= spi_data;
        end                          
        12'h046:                     
        begin                        
          pcTx_data_046<= spi_data;
        end                          
        12'h047:                     
        begin                        
          pcTx_data_047<= spi_data;
        end                          
        12'h048:                     
        begin                        
          pcTx_data_048<= spi_data;
        end                          
        12'h049:                     
        begin                        
          pcTx_data_049<= spi_data;
        end                          
        12'h04A:                     
        begin                        
          pcTx_data_04A<= spi_data;
        end                          
        12'h04B:                     
        begin                        
          pcTx_data_04B<= spi_data;
        end                          
        12'h04C:                     
        begin                        
          pcTx_data_04C<= spi_data;
        end                          
        12'h04D:                     
        begin                        
          pcTx_data_04D<= spi_data;
        end                          
        12'h04E:                     
        begin                        
          pcTx_data_04E<= spi_data;
        end                          
        12'h04F:                     
        begin                        
          pcTx_data_04F<= spi_data;
        end                          
        12'h050:                     
        begin                        
          pcTx_data_050<= spi_data;
        end                          
        12'h051:                     
        begin                        
          pcTx_data_051<= spi_data;
        end                          
        12'h052:                     
        begin                        
          pcTx_data_052<= spi_data;
        end                          
        12'h053:                     
        begin                        
          pcTx_data_053<= spi_data;
        end                          
        12'h054:                     
        begin                        
          pcTx_data_054<= spi_data;
        end                          
        12'h055:                     
        begin                        
          pcTx_data_055<= spi_data;
        end                          
        12'h056:                     
        begin                        
          pcTx_data_056<= spi_data;
        end                          
        12'h057:                     
        begin                        
          pcTx_data_057<= spi_data;
        end                          
        12'h058:                     
        begin                        
          pcTx_data_058<= spi_data;
        end                          
        12'h059:                     
        begin                        
          pcTx_data_059<= spi_data;
        end                          
        12'h05A:                     
        begin                        
          pcTx_data_05A<= spi_data;
        end                          
        12'h05B:                     
        begin                        
          pcTx_data_05B<= spi_data;
        end                          
        12'h05C:                     
        begin                        
          pcTx_data_05C<= spi_data;
        end                          
        12'h05D:                     
        begin                        
          pcTx_data_05D<= spi_data;
        end                          
        12'h05E:                     
        begin                        
          pcTx_data_05E<= spi_data;
        end                          
        12'h05F:                     
        begin                        
          pcTx_data_05F<= spi_data;
        end                          
        12'h060:                     
        begin                        
          pcTx_data_060<= spi_data;
        end                          
        12'h061:                     
        begin                        
          pcTx_data_061<= spi_data;
        end                          
        12'h062:                     
        begin                        
          pcTx_data_062<= spi_data;
        end                          
        12'h063:                     
        begin                        
          pcTx_data_063<= spi_data;
        end                          
        12'h064:                     
        begin                        
          pcTx_data_064<= spi_data;
        end                          
        12'h065:                     
        begin                        
          pcTx_data_065<= spi_data;
        end                          
        12'h066:                     
        begin                        
          pcTx_data_066<= spi_data;
        end                          
        12'h067:                     
        begin                        
          pcTx_data_067<= spi_data;
        end                          
        12'h068:                     
        begin                        
          pcTx_data_068<= spi_data;
        end                          
        12'h069:                     
        begin                        
          pcTx_data_069<= spi_data;
        end                          
        12'h06A:                     
        begin                        
          pcTx_data_06A<= spi_data;
        end                          
        12'h06B:                     
        begin                        
          pcTx_data_06B<= spi_data;
        end                          
        12'h06C:                     
        begin                        
          pcTx_data_06C<= spi_data;
        end                          
        12'h06D:                     
        begin                        
          pcTx_data_06D<= spi_data;
        end                          
        12'h06E:                     
        begin                        
          pcTx_data_06E<= spi_data;
        end                          
        12'h06F:                     
        begin                        
          pcTx_data_06F<= spi_data;
        end                          
        12'h070:                     
        begin                        
          pcTx_data_070<= spi_data;
        end                          
        12'h071:                     
        begin                        
          pcTx_data_071<= spi_data;
        end                          
        12'h072:                     
        begin                        
          pcTx_data_072<= spi_data;
        end                          
        12'h073:                     
        begin                        
          pcTx_data_073<= spi_data;
        end                          
        12'h074:                     
        begin                        
          pcTx_data_074<= spi_data;
        end                          
        12'h075:                     
        begin                        
          pcTx_data_075<= spi_data;
        end                          
        12'h076:                     
        begin                        
          pcTx_data_076<= spi_data;
        end                          
        12'h077:                     
        begin                        
          pcTx_data_077<= spi_data;
        end                          
        12'h078:                     
        begin                        
          pcTx_data_078<= spi_data;
        end                          
        12'h079:                     
        begin                        
          pcTx_data_079<= spi_data;
        end                          
        12'h07A:                     
        begin                        
          pcTx_data_07A<= spi_data;
        end                          
        12'h07B:                     
        begin                        
          pcTx_data_07B<= spi_data;
        end                          
        12'h07C:                     
        begin                        
          pcTx_data_07C<= spi_data;
        end                          
        12'h07D:                     
        begin                        
          pcTx_data_07D<= spi_data;
        end                          
        12'h07E:                     
        begin                        
          pcTx_data_07E<= spi_data;
        end                          
        12'h07F:                     
        begin                        
          pcTx_data_07F<= spi_data;
        end                          
        12'h080:                     
        begin                        
          pcTx_data_080<= spi_data;
        end                          
        12'h081:                     
        begin                        
          pcTx_data_081<= spi_data;
        end                          
        12'h082:                     
        begin                        
          pcTx_data_082<= spi_data;
        end                          
        12'h083:                     
        begin                        
          pcTx_data_083<= spi_data;
        end                          
        12'h084:                     
        begin                        
          pcTx_data_084<= spi_data;
        end                          
        12'h085:                     
        begin                        
          pcTx_data_085<= spi_data;
        end                          
        12'h086:                     
        begin                        
          pcTx_data_086<= spi_data;
        end                          
        12'h087:                     
        begin                        
          pcTx_data_087<= spi_data;
        end                          
        12'h088:                     
        begin                        
          pcTx_data_088<= spi_data;
        end                          
        12'h089:                     
        begin                        
          pcTx_data_089<= spi_data;
        end                          
        12'h08A:                     
        begin                        
          pcTx_data_08A<= spi_data;
        end                          
        12'h08B:                     
        begin                        
          pcTx_data_08B<= spi_data;
        end                          
        12'h08C:                     
        begin                        
          pcTx_data_08C<= spi_data;
        end                          
        12'h08D:                     
        begin                        
          pcTx_data_08D<= spi_data;
        end                          
        12'h08E:                     
        begin                        
          pcTx_data_08E<= spi_data;
        end                          
        12'h08F:                     
        begin                        
          pcTx_data_08F<= spi_data;
        end                          
        12'h090:                     
        begin                        
          pcTx_data_090<= spi_data;
        end                          
        12'h091:                     
        begin                        
          pcTx_data_091<= spi_data;
        end                          
        12'h092:                     
        begin                        
          pcTx_data_092<= spi_data;
        end                          
        12'h093:                     
        begin                        
          pcTx_data_093<= spi_data;
        end                          
        12'h094:                     
        begin                        
          pcTx_data_094<= spi_data;
        end                          
        12'h095:                     
        begin                        
          pcTx_data_095<= spi_data;
        end                          
        12'h096:                     
        begin                        
          pcTx_data_096<= spi_data;
        end                          
        12'h097:                     
        begin                        
          pcTx_data_097<= spi_data;
        end                          
        12'h098:                     
        begin                        
          pcTx_data_098<= spi_data;
        end                          
        12'h099:                     
        begin                        
          pcTx_data_099<= spi_data;
        end                          
        12'h09A:                     
        begin                        
          pcTx_data_09A<= spi_data;
        end                          
        12'h09B:                     
        begin                        
          pcTx_data_09B<= spi_data;
        end                          
        12'h09C:                     
        begin                        
          pcTx_data_09C<= spi_data;
        end                          
        12'h09D:                     
        begin                        
          pcTx_data_09D<= spi_data;
        end                          
        12'h09E:                     
        begin                        
          pcTx_data_09E<= spi_data;
        end                          
        12'h09F:                     
        begin                        
          pcTx_data_09F<= spi_data;
        end                          
        12'h0A0:                     
        begin                        
          pcTx_data_0A0<= spi_data;
        end                          
        12'h0A1:                     
        begin                        
          pcTx_data_0A1<= spi_data;
        end                          
        12'h0A2:                     
        begin                        
          pcTx_data_0A2<= spi_data;
        end                          
        12'h0A3:                     
        begin                        
          pcTx_data_0A3<= spi_data;
        end                          
        12'h0A4:                     
        begin                        
          pcTx_data_0A4<= spi_data;
        end                          
        12'h0A5:                     
        begin                        
          pcTx_data_0A5<= spi_data;
        end                          
        12'h0A6:                     
        begin                        
          pcTx_data_0A6<= spi_data;
        end                          
        12'h0A7:                     
        begin                        
          pcTx_data_0A7<= spi_data;
        end                          
        12'h0A8:                     
        begin                        
          pcTx_data_0A8<= spi_data;
        end                          
        12'h0A9:                     
        begin                        
          pcTx_data_0A9<= spi_data;
        end                          
        12'h0AA:                     
        begin                        
          pcTx_data_0AA<= spi_data;
        end                          
        12'h0AB:                     
        begin                        
          pcTx_data_0AB<= spi_data;
        end                          
        12'h0AC:                     
        begin                        
          pcTx_data_0AC<= spi_data;
        end                          
        12'h0AD:                     
        begin                        
          pcTx_data_0AD<= spi_data;
        end                          
        12'h0AE:                     
        begin                        
          pcTx_data_0AE<= spi_data;
        end                          
        12'h0AF:                     
        begin                        
          pcTx_data_0AF<= spi_data;
        end                          
        12'h0B0:                     
        begin                        
          pcTx_data_0B0<= spi_data;
        end                          
        12'h0B1:                     
        begin                        
          pcTx_data_0B1<= spi_data;
        end                          
        12'h0B2:                     
        begin                        
          pcTx_data_0B2<= spi_data;
        end                          
        12'h0B3:                     
        begin                        
          pcTx_data_0B3<= spi_data;
        end                          
        12'h0B4:                     
        begin                        
          pcTx_data_0B4<= spi_data;
        end                          
        12'h0B5:                     
        begin                        
          pcTx_data_0B5<= spi_data;
        end                          
        12'h0B6:                     
        begin                        
          pcTx_data_0B6<= spi_data;
        end                          
        12'h0B7:                     
        begin                        
          pcTx_data_0B7<= spi_data;
        end                          
        12'h0B8:                     
        begin                        
          pcTx_data_0B8<= spi_data;
        end                          
        12'h0B9:                     
        begin                        
          pcTx_data_0B9<= spi_data;
        end                          
        12'h0BA:                     
        begin                        
          pcTx_data_0BA<= spi_data;
        end                          
        12'h0BB:                     
        begin                        
          pcTx_data_0BB<= spi_data;
        end                          
        12'h0BC:                     
        begin                        
          pcTx_data_0BC<= spi_data;
        end                          
        12'h0BD:                     
        begin                        
          pcTx_data_0BD<= spi_data;
        end                          
        12'h0BE:                     
        begin                        
          pcTx_data_0BE<= spi_data;
        end                          
        12'h0BF:                     
        begin                        
          pcTx_data_0BF<= spi_data;
        end                          
        12'h0C0:                     
        begin                        
          pcTx_data_0C0<= spi_data;
        end                          
        12'h0C1:                     
        begin                        
          pcTx_data_0C1<= spi_data;
        end                          
        12'h0C2:                     
        begin                        
          pcTx_data_0C2<= spi_data;
        end                          
        12'h0C3:                     
        begin                        
          pcTx_data_0C3<= spi_data;
        end                          
        12'h0C4:                     
        begin                        
          pcTx_data_0C4<= spi_data;
        end                          
        12'h0C5:                     
        begin                        
          pcTx_data_0C5<= spi_data;
        end                          
        12'h0C6:                     
        begin                        
          pcTx_data_0C6<= spi_data;
        end                          
        12'h0C7:                     
        begin                        
          pcTx_data_0C7<= spi_data;
        end                          
        12'h0C8:                     
        begin                        
          pcTx_data_0C8<= spi_data;
        end                          
        12'h0C9:                     
        begin                        
          pcTx_data_0C9<= spi_data;
        end                          
        12'h0CA:                     
        begin                        
          pcTx_data_0CA<= spi_data;
        end                          
        12'h0CB:                     
        begin                        
          pcTx_data_0CB<= spi_data;
        end                          
        12'h0CC:                     
        begin                        
          pcTx_data_0CC<= spi_data;
        end                          
        12'h0CD:                     
        begin                        
          pcTx_data_0CD<= spi_data;
        end                          
        12'h0CE:                     
        begin                        
          pcTx_data_0CE<= spi_data;
        end                          
        12'h0CF:                     
        begin                        
          pcTx_data_0CF<= spi_data;
        end                          
        12'h0D0:                     
        begin                        
          pcTx_data_0D0<= spi_data;
        end                          
        12'h0D1:                     
        begin                        
          pcTx_data_0D1<= spi_data;
        end                          
        12'h0D2:                     
        begin                        
          pcTx_data_0D2<= spi_data;
        end                          
        12'h0D3:                     
        begin                        
          pcTx_data_0D3<= spi_data;
        end                          
        12'h0D4:                     
        begin                        
          pcTx_data_0D4<= spi_data;
        end                          
        12'h0D5:                     
        begin                        
          pcTx_data_0D5<= spi_data;
        end                          
        12'h0D6:                     
        begin                        
          pcTx_data_0D6<= spi_data;
        end                          
        12'h0D7:                     
        begin                        
          pcTx_data_0D7<= spi_data;
        end                          
        12'h0D8:                     
        begin                        
          pcTx_data_0D8<= spi_data;
        end                          
        12'h0D9:                     
        begin                        
          pcTx_data_0D9<= spi_data;
        end                          
        12'h0DA:                     
        begin                        
          pcTx_data_0DA<= spi_data;
        end                          
        12'h0DB:                     
        begin                        
          pcTx_data_0DB<= spi_data;
        end                          
        12'h0DC:                     
        begin                        
          pcTx_data_0DC<= spi_data;
        end                          
        12'h0DD:                     
        begin                        
          pcTx_data_0DD<= spi_data;
        end                          
        12'h0DE:                     
        begin                        
          pcTx_data_0DE<= spi_data;
        end                          
        12'h0DF:                     
        begin                        
          pcTx_data_0DF<= spi_data;
        end                          
        12'h0E0:                     
        begin                        
          pcTx_data_0E0<= spi_data;
        end                          
        12'h0E1:                     
        begin                        
          pcTx_data_0E1<= spi_data;
        end                          
        12'h0E2:                     
        begin                        
          pcTx_data_0E2<= spi_data;
        end                          
        12'h0E3:                     
        begin                        
          pcTx_data_0E3<= spi_data;
        end                          
        12'h0E4:                     
        begin                        
          pcTx_data_0E4<= spi_data;
        end                          
        12'h0E5:                     
        begin                        
          pcTx_data_0E5<= spi_data;
        end                          
        12'h0E6:                     
        begin                        
          pcTx_data_0E6<= spi_data;
        end                          
        12'h0E7:                     
        begin                        
          pcTx_data_0E7<= spi_data;
        end                          
        12'h0E8:                     
        begin                        
          pcTx_data_0E8<= spi_data;
        end                          
        12'h0E9:                     
        begin                        
          pcTx_data_0E9<= spi_data;
        end                          
        12'h0EA:                     
        begin                        
          pcTx_data_0EA<= spi_data;
        end                          
        12'h0EB:                     
        begin                        
          pcTx_data_0EB<= spi_data;
        end                          
        12'h0EC:                     
        begin                        
          pcTx_data_0EC<= spi_data;
        end                          
        12'h0ED:                     
        begin                        
          pcTx_data_0ED<= spi_data;
        end                          
        12'h0EE:                     
        begin                        
          pcTx_data_0EE<= spi_data;
        end                          
        12'h0EF:                     
        begin                        
          pcTx_data_0EF<= spi_data;
        end                          
        12'h0F0:                     
        begin                        
          pcTx_data_0F0<= spi_data;
        end                          
        12'h0F1:                     
        begin                        
          pcTx_data_0F1<= spi_data;
        end                          
        12'h0F2:                     
        begin                        
          pcTx_data_0F2<= spi_data;
        end                          
        12'h0F3:                     
        begin                        
          pcTx_data_0F3<= spi_data;
        end                          
        12'h0F4:                     
        begin                        
          pcTx_data_0F4<= spi_data;
        end                          
        12'h0F5:                     
        begin                        
          pcTx_data_0F5<= spi_data;
        end                          
        12'h0F6:                     
        begin                        
          pcTx_data_0F6<= spi_data;
        end                          
        12'h0F7:                     
        begin                        
          pcTx_data_0F7<= spi_data;
        end                          
        12'h0F8:                     
        begin                        
          pcTx_data_0F8<= spi_data;
        end                          
        12'h0F9:                     
        begin                        
          pcTx_data_0F9<= spi_data;
        end                          
        12'h0FA:                     
        begin                        
          pcTx_data_0FA<= spi_data;
        end                          
        12'h0FB:                     
        begin                        
          pcTx_data_0FB<= spi_data;
        end                          
        12'h0FC:                     
        begin                        
          pcTx_data_0FC<= spi_data;
        end                          
        12'h0FD:                     
        begin                        
          pcTx_data_0FD<= spi_data;
        end                          
        12'h0FE:                     
        begin                        
          pcTx_data_0FE<= spi_data;
        end                          
        12'h0FF:                     
        begin                        
          pcTx_data_0FF<= spi_data;
        end                          

        12'h100:                     
        begin                        
          pcTx_data_100<= spi_data;
        end                          
        12'h101:                     
        begin                        
          pcTx_data_101<= spi_data;
        end                          
        12'h102:                     
        begin                        
          pcTx_data_102<= spi_data;
        end                          
        12'h103:                     
        begin                        
          pcTx_data_103<= spi_data;
        end                          
        12'h104:                     
        begin                        
          pcTx_data_104<= spi_data;
        end                          
        12'h105:                     
        begin                        
          pcTx_data_105<= spi_data;
        end                          
        12'h106:                     
        begin                        
          pcTx_data_106<= spi_data;
        end                          
        12'h107:                     
        begin                        
          pcTx_data_107<= spi_data;
        end                          
        12'h108:                     
        begin                        
          pcTx_data_108<= spi_data;
        end                          
        12'h109:                     
        begin                        
          pcTx_data_109<= spi_data;
        end                          
        12'h10A:                     
        begin                        
          pcTx_data_10A<= spi_data;
        end                          
        12'h10B:                     
        begin                        
          pcTx_data_10B<= spi_data;
        end                          
        12'h10C:                     
        begin                        
          pcTx_data_10C<= spi_data;
        end                          
        12'h10D:                     
        begin                        
          pcTx_data_10D<= spi_data;
        end                          
        12'h10E:                     
        begin                        
          pcTx_data_10E<= spi_data;
        end                          
        12'h10F:                     
        begin                        
          pcTx_data_10F<= spi_data;
        end                          
        12'h110:                     
        begin                        
          pcTx_data_110<= spi_data;
        end                          
        12'h111:                     
        begin                        
          pcTx_data_111<= spi_data;
        end                          
        12'h112:                     
        begin                        
          pcTx_data_112<= spi_data;
        end                          
        12'h113:                     
        begin                        
          pcTx_data_113<= spi_data;
        end                          
        12'h114:                     
        begin                        
          pcTx_data_114<= spi_data;
        end                          
        12'h115:                     
        begin                        
          pcTx_data_115<= spi_data;
        end                          
        12'h116:                     
        begin                        
          pcTx_data_116<= spi_data;
        end                          
        12'h117:                     
        begin                        
          pcTx_data_117<= spi_data;
        end                          
        12'h118:                     
        begin                        
          pcTx_data_118<= spi_data;
        end                          
        12'h119:                     
        begin                        
          pcTx_data_119<= spi_data;
        end                          
        12'h11A:                     
        begin                        
          pcTx_data_11A<= spi_data;
        end                          
        12'h11B:                     
        begin                        
          pcTx_data_11B<= spi_data;
        end                          
        12'h11C:                     
        begin                        
          pcTx_data_11C<= spi_data;
        end                          
        12'h11D:                     
        begin                        
          pcTx_data_11D<= spi_data;
        end                          
        12'h11E:                     
        begin                        
          pcTx_data_11E<= spi_data;
        end                          
        12'h11F:                     
        begin                        
          pcTx_data_11F<= spi_data;
        end                          
        12'h120:                     
        begin                        
          pcTx_data_120<= spi_data;
        end                          
        12'h121:                     
        begin                        
          pcTx_data_121<= spi_data;
        end                          
        12'h122:                     
        begin                        
          pcTx_data_122<= spi_data;
        end                          
        12'h123:                     
        begin                        
          pcTx_data_123<= spi_data;
        end                          
        12'h124:                     
        begin                        
          pcTx_data_124<= spi_data;
        end                          
        12'h125:                     
        begin                        
          pcTx_data_125<= spi_data;
        end                          
        12'h126:                     
        begin                        
          pcTx_data_126<= spi_data;
        end                          
        12'h127:                     
        begin                        
          pcTx_data_127<= spi_data;
        end                          
        12'h128:                     
        begin                        
          pcTx_data_128<= spi_data;
        end                          
        12'h129:                     
        begin                        
          pcTx_data_129<= spi_data;
        end                          
        12'h12A:                     
        begin                        
          pcTx_data_12A<= spi_data;
        end                          
        12'h12B:                     
        begin                        
          pcTx_data_12B<= spi_data;
        end                          
        12'h12C:                     
        begin                        
          pcTx_data_12C<= spi_data;
        end                          
        12'h12D:                     
        begin                        
          pcTx_data_12D<= spi_data;
        end                          
        12'h12E:                     
        begin                        
          pcTx_data_12E<= spi_data;
        end                          
        12'h12F:                     
        begin                        
          pcTx_data_12F<= spi_data;
        end                          
        12'h130:                     
        begin                        
          pcTx_data_130<= spi_data;
        end                          
        12'h131:                     
        begin                        
          pcTx_data_131<= spi_data;
        end                          
        12'h132:                     
        begin                        
          pcTx_data_132<= spi_data;
        end                          
        12'h133:                     
        begin                        
          pcTx_data_133<= spi_data;
        end                          
        12'h134:                     
        begin                        
          pcTx_data_134<= spi_data;
        end                          
        12'h135:                     
        begin                        
          pcTx_data_135<= spi_data;
        end                          
        12'h136:                     
        begin                        
          pcTx_data_136<= spi_data;
        end                          
        12'h137:                     
        begin                        
          pcTx_data_137<= spi_data;
        end                          
        12'h138:                     
        begin                        
          pcTx_data_138<= spi_data;
        end                          
        12'h139:                     
        begin                        
          pcTx_data_139<= spi_data;
        end                          
        12'h13A:                     
        begin                        
          pcTx_data_13A<= spi_data;
        end                          
        12'h13B:                     
        begin                        
          pcTx_data_13B<= spi_data;
        end                          
        12'h13C:                     
        begin                        
          pcTx_data_13C<= spi_data;
        end                          
        12'h13D:                     
        begin                        
          pcTx_data_13D<= spi_data;
        end                          
        12'h13E:                     
        begin                        
          pcTx_data_13E<= spi_data;
        end                          
        12'h13F:                     
        begin                        
          pcTx_data_13F<= spi_data;
        end                          
        12'h140:                     
        begin                        
          pcTx_data_140<= spi_data;
        end                          
        12'h141:                     
        begin                        
          pcTx_data_141<= spi_data;
        end                          
        12'h142:                     
        begin                        
          pcTx_data_142<= spi_data;
        end                          
        12'h143:                     
        begin                        
          pcTx_data_143<= spi_data;
        end                          
        12'h144:                     
        begin                        
          pcTx_data_144<= spi_data;
        end                          
        12'h145:                     
        begin                        
          pcTx_data_145<= spi_data;
        end                          
        12'h146:                     
        begin                        
          pcTx_data_146<= spi_data;
        end                          
        12'h147:                     
        begin                        
          pcTx_data_147<= spi_data;
        end                          
        12'h148:                     
        begin                        
          pcTx_data_148<= spi_data;
        end                          
        12'h149:                     
        begin                        
          pcTx_data_149<= spi_data;
        end                          
        12'h14A:                     
        begin                        
          pcTx_data_14A<= spi_data;
        end                          
        12'h14B:                     
        begin                        
          pcTx_data_14B<= spi_data;
        end                          
        12'h14C:                     
        begin                        
          pcTx_data_14C<= spi_data;
        end                          
        12'h14D:                     
        begin                        
          pcTx_data_14D<= spi_data;
        end                          
        12'h14E:                     
        begin                        
          pcTx_data_14E<= spi_data;
        end                          
        12'h14F:                     
        begin                        
          pcTx_data_14F<= spi_data;
        end                          
        12'h150:                     
        begin                        
          pcTx_data_150<= spi_data;
        end                          
        12'h151:                     
        begin                        
          pcTx_data_151<= spi_data;
        end                          
        12'h152:                     
        begin                        
          pcTx_data_152<= spi_data;
        end                          
        12'h153:                     
        begin                        
          pcTx_data_153<= spi_data;
        end                          
        12'h154:                     
        begin                        
          pcTx_data_154<= spi_data;
        end                          
        12'h155:                     
        begin                        
          pcTx_data_155<= spi_data;
        end                          
        12'h156:                     
        begin                        
          pcTx_data_156<= spi_data;
        end                          
        12'h157:                     
        begin                        
          pcTx_data_157<= spi_data;
        end                          
        12'h158:                     
        begin                        
          pcTx_data_158<= spi_data;
        end                          
        12'h159:                     
        begin                        
          pcTx_data_159<= spi_data;
        end                          
        12'h15A:                     
        begin                        
          pcTx_data_15A<= spi_data;
        end                          
        12'h15B:                     
        begin                        
          pcTx_data_15B<= spi_data;
        end                          
        12'h15C:                     
        begin                        
          pcTx_data_15C<= spi_data;
        end                          
        12'h15D:                     
        begin                        
          pcTx_data_15D<= spi_data;
        end                          
        12'h15E:                     
        begin                        
          pcTx_data_15E<= spi_data;
        end                          
        12'h15F:                     
        begin                        
          pcTx_data_15F<= spi_data;
        end                          
        12'h160:                     
        begin                        
          pcTx_data_160<= spi_data;
        end                          
        12'h161:                     
        begin                        
          pcTx_data_161<= spi_data;
        end                          
        12'h162:                     
        begin                        
          pcTx_data_162<= spi_data;
        end                          
        12'h163:                     
        begin                        
          pcTx_data_163<= spi_data;
        end                          
        12'h164:                     
        begin                        
          pcTx_data_164<= spi_data;
        end                          
        12'h165:                     
        begin                        
          pcTx_data_165<= spi_data;
        end                          
        12'h166:                     
        begin                        
          pcTx_data_166<= spi_data;
        end                          
        12'h167:                     
        begin                        
          pcTx_data_167<= spi_data;
        end                          
        12'h168:                     
        begin                        
          pcTx_data_168<= spi_data;
        end                          
        12'h169:                     
        begin                        
          pcTx_data_169<= spi_data;
        end                          
        12'h16A:                     
        begin                        
          pcTx_data_16A<= spi_data;
        end                          
        12'h16B:                     
        begin                        
          pcTx_data_16B<= spi_data;
        end                          
        12'h16C:                     
        begin                        
          pcTx_data_16C<= spi_data;
        end                          
        12'h16D:                     
        begin                        
          pcTx_data_16D<= spi_data;
        end                          
        12'h16E:                     
        begin                        
          pcTx_data_16E<= spi_data;
        end                          
        12'h16F:                     
        begin                        
          pcTx_data_16F<= spi_data;
        end                          
        12'h170:                     
        begin                        
          pcTx_data_170<= spi_data;
        end                          
        12'h171:                     
        begin                        
          pcTx_data_171<= spi_data;
        end                          
        12'h172:                     
        begin                        
          pcTx_data_172<= spi_data;
        end                          
        12'h173:                     
        begin                        
          pcTx_data_173<= spi_data;
        end                          
        12'h174:                     
        begin                        
          pcTx_data_174<= spi_data;
        end                          
        12'h175:                     
        begin                        
          pcTx_data_175<= spi_data;
        end                          
        12'h176:                     
        begin                        
          pcTx_data_176<= spi_data;
        end                          
        12'h177:                     
        begin                        
          pcTx_data_177<= spi_data;
        end                          
        12'h178:                     
        begin                        
          pcTx_data_178<= spi_data;
        end                          
        12'h179:                     
        begin                        
          pcTx_data_179<= spi_data;
        end                          
        12'h17A:                     
        begin                        
          pcTx_data_17A<= spi_data;
        end                          
        12'h17B:                     
        begin                        
          pcTx_data_17B<= spi_data;
        end                          
        12'h17C:                     
        begin                        
          pcTx_data_17C<= spi_data;
        end                          
        12'h17D:                     
        begin                        
          pcTx_data_17D<= spi_data;
        end                          
        12'h17E:                     
        begin                        
          pcTx_data_17E<= spi_data;
        end                          
        12'h17F:                     
        begin                        
          pcTx_data_17F<= spi_data;
        end                          
        12'h180:                     
        begin                        
          pcTx_data_180<= spi_data;
        end                          
        12'h181:                     
        begin                        
          pcTx_data_181<= spi_data;
        end                          
        12'h182:                     
        begin                        
          pcTx_data_182<= spi_data;
        end                          
        12'h183:                     
        begin                        
          pcTx_data_183<= spi_data;
        end                          
        12'h184:                     
        begin                        
          pcTx_data_184<= spi_data;
        end                          
        12'h185:                     
        begin                        
          pcTx_data_185<= spi_data;
        end                          
        12'h186:                     
        begin                        
          pcTx_data_186<= spi_data;
        end                          
        12'h187:                     
        begin                        
          pcTx_data_187<= spi_data;
        end                          
        12'h188:                     
        begin                        
          pcTx_data_188<= spi_data;
        end                          
        12'h189:                     
        begin                        
          pcTx_data_189<= spi_data;
        end                          
        12'h18A:                     
        begin                        
          pcTx_data_18A<= spi_data;
        end                          
        12'h18B:                     
        begin                        
          pcTx_data_18B<= spi_data;
        end                          
        12'h18C:                     
        begin                        
          pcTx_data_18C<= spi_data;
        end                          
        12'h18D:                     
        begin                        
          pcTx_data_18D<= spi_data;
        end                          
        12'h18E:                     
        begin                        
          pcTx_data_18E<= spi_data;
        end                          
        12'h18F:                     
        begin                        
          pcTx_data_18F<= spi_data;
        end                          
        12'h190:                     
        begin                        
          pcTx_data_190<= spi_data;
        end                          
        12'h191:                     
        begin                        
          pcTx_data_191<= spi_data;
        end                          
        12'h192:                     
        begin                        
          pcTx_data_192<= spi_data;
        end                          
        12'h193:                     
        begin                        
          pcTx_data_193<= spi_data;
        end                          
        12'h194:                     
        begin                        
          pcTx_data_194<= spi_data;
        end                          
        12'h195:                     
        begin                        
          pcTx_data_195<= spi_data;
        end                          
        12'h196:                     
        begin                        
          pcTx_data_196<= spi_data;
        end                          
        12'h197:                     
        begin                        
          pcTx_data_197<= spi_data;
        end                          
        12'h198:                     
        begin                        
          pcTx_data_198<= spi_data;
        end                          
        12'h199:                     
        begin                        
          pcTx_data_199<= spi_data;
        end                          
        12'h19A:                     
        begin                        
          pcTx_data_19A<= spi_data;
        end                          
        12'h19B:                     
        begin                        
          pcTx_data_19B<= spi_data;
        end                          
        12'h19C:                     
        begin                        
          pcTx_data_19C<= spi_data;
        end                          
        12'h19D:                     
        begin                        
          pcTx_data_19D<= spi_data;
        end                          
        12'h19E:                     
        begin                        
          pcTx_data_19E<= spi_data;
        end                          
        12'h19F:                     
        begin                        
          pcTx_data_19F<= spi_data;
        end                          
        12'h1A0:                     
        begin                        
          pcTx_data_1A0<= spi_data;
        end                          
        12'h1A1:                     
        begin                        
          pcTx_data_1A1<= spi_data;
        end                          
        12'h1A2:                     
        begin                        
          pcTx_data_1A2<= spi_data;
        end                          
        12'h1A3:                     
        begin                        
          pcTx_data_1A3<= spi_data;
        end                          
        12'h1A4:                     
        begin                        
          pcTx_data_1A4<= spi_data;
        end                          
        12'h1A5:                     
        begin                        
          pcTx_data_1A5<= spi_data;
        end                          
        12'h1A6:                     
        begin                        
          pcTx_data_1A6<= spi_data;
        end                          
        12'h1A7:                     
        begin                        
          pcTx_data_1A7<= spi_data;
        end                          
        12'h1A8:                     
        begin                        
          pcTx_data_1A8<= spi_data;
        end                          
        12'h1A9:                     
        begin                        
          pcTx_data_1A9<= spi_data;
        end                          
        12'h1AA:                     
        begin                        
          pcTx_data_1AA<= spi_data;
        end                          
        12'h1AB:                     
        begin                        
          pcTx_data_1AB<= spi_data;
        end                          
        12'h1AC:                     
        begin                        
          pcTx_data_1AC<= spi_data;
        end                          
        12'h1AD:                     
        begin                        
          pcTx_data_1AD<= spi_data;
        end                          
        12'h1AE:                     
        begin                        
          pcTx_data_1AE<= spi_data;
        end                          
        12'h1AF:                     
        begin                        
          pcTx_data_1AF<= spi_data;
        end                          
        12'h1B0:                     
        begin                        
          pcTx_data_1B0<= spi_data;
        end                          
        12'h1B1:                     
        begin                        
          pcTx_data_1B1<= spi_data;
        end                          
        12'h1B2:                     
        begin                        
          pcTx_data_1B2<= spi_data;
        end                          
        12'h1B3:                     
        begin                        
          pcTx_data_1B3<= spi_data;
        end                          
        12'h1B4:                     
        begin                        
          pcTx_data_1B4<= spi_data;
        end                          
        12'h1B5:                     
        begin                        
          pcTx_data_1B5<= spi_data;
        end                          
        12'h1B6:                     
        begin                        
          pcTx_data_1B6<= spi_data;
        end                          
        12'h1B7:                     
        begin                        
          pcTx_data_1B7<= spi_data;
        end                          
        12'h1B8:                     
        begin                        
          pcTx_data_1B8<= spi_data;
        end                          
        12'h1B9:                     
        begin                        
          pcTx_data_1B9<= spi_data;
        end                          
        12'h1BA:                     
        begin                        
          pcTx_data_1BA<= spi_data;
        end                          
        12'h1BB:                     
        begin                        
          pcTx_data_1BB<= spi_data;
        end                          
        12'h1BC:                     
        begin                        
          pcTx_data_1BC<= spi_data;
        end                          
        12'h1BD:                     
        begin                        
          pcTx_data_1BD<= spi_data;
        end                          
        12'h1BE:                     
        begin                        
          pcTx_data_1BE<= spi_data;
        end                          
        12'h1BF:                     
        begin                        
          pcTx_data_1BF<= spi_data;
        end                          
        12'h1C0:                     
        begin                        
          pcTx_data_1C0<= spi_data;
        end                          
        12'h1C1:                     
        begin                        
          pcTx_data_1C1<= spi_data;
        end                          
        12'h1C2:                     
        begin                        
          pcTx_data_1C2<= spi_data;
        end                          
        12'h1C3:                     
        begin                        
          pcTx_data_1C3<= spi_data;
        end                          
        12'h1C4:                     
        begin                        
          pcTx_data_1C4<= spi_data;
        end                          
        12'h1C5:                     
        begin                        
          pcTx_data_1C5<= spi_data;
        end                          
        12'h1C6:                     
        begin                        
          pcTx_data_1C6<= spi_data;
        end                          
        12'h1C7:                     
        begin                        
          pcTx_data_1C7<= spi_data;
        end                          
        12'h1C8:                     
        begin                        
          pcTx_data_1C8<= spi_data;
        end                          
        12'h1C9:                     
        begin                        
          pcTx_data_1C9<= spi_data;
        end                          
        12'h1CA:                     
        begin                        
          pcTx_data_1CA<= spi_data;
        end                          
        12'h1CB:                     
        begin                        
          pcTx_data_1CB<= spi_data;
        end                          
        12'h1CC:                     
        begin                        
          pcTx_data_1CC<= spi_data;
        end                          
        12'h1CD:                     
        begin                        
          pcTx_data_1CD<= spi_data;
        end                          
        12'h1CE:                     
        begin                        
          pcTx_data_1CE<= spi_data;
        end                          
        12'h1CF:                     
        begin                        
          pcTx_data_1CF<= spi_data;
        end                          
        12'h1D0:                     
        begin                        
          pcTx_data_1D0<= spi_data;
        end                          
        12'h1D1:                     
        begin                        
          pcTx_data_1D1<= spi_data;
        end                          
        12'h1D2:                     
        begin                        
          pcTx_data_1D2<= spi_data;
        end                          
        12'h1D3:                     
        begin                        
          pcTx_data_1D3<= spi_data;
        end                          
        12'h1D4:                     
        begin                        
          pcTx_data_1D4<= spi_data;
        end                          
        12'h1D5:                     
        begin                        
          pcTx_data_1D5<= spi_data;
        end                          
        12'h1D6:                     
        begin                        
          pcTx_data_1D6<= spi_data;
        end                          
        12'h1D7:                     
        begin                        
          pcTx_data_1D7<= spi_data;
        end                          
        12'h1D8:                     
        begin                        
          pcTx_data_1D8<= spi_data;
        end                          
        12'h1D9:                     
        begin                        
          pcTx_data_1D9<= spi_data;
        end                          
        12'h1DA:                     
        begin                        
          pcTx_data_1DA<= spi_data;
        end                          
        12'h1DB:                     
        begin                        
          pcTx_data_1DB<= spi_data;
        end                          
        12'h1DC:                     
        begin                        
          pcTx_data_1DC<= spi_data;
        end                          
        12'h1DD:                     
        begin                        
          pcTx_data_1DD<= spi_data;
        end                          
        12'h1DE:                     
        begin                        
          pcTx_data_1DE<= spi_data;
        end                          
        12'h1DF:                     
        begin                        
          pcTx_data_1DF<= spi_data;
        end                          
        12'h1E0:                     
        begin                        
          pcTx_data_1E0<= spi_data;
        end                          
        12'h1E1:                     
        begin                        
          pcTx_data_1E1<= spi_data;
        end                          
        12'h1E2:                     
        begin                        
          pcTx_data_1E2<= spi_data;
        end                          
        12'h1E3:                     
        begin                        
          pcTx_data_1E3<= spi_data;
        end                          
        12'h1E4:                     
        begin                        
          pcTx_data_1E4<= spi_data;
        end                          
        12'h1E5:                     
        begin                        
          pcTx_data_1E5<= spi_data;
        end                          
        12'h1E6:                     
        begin                        
          pcTx_data_1E6<= spi_data;
        end                          
        12'h1E7:                     
        begin                        
          pcTx_data_1E7<= spi_data;
        end                          
        12'h1E8:                     
        begin                        
          pcTx_data_1E8<= spi_data;
        end                          
        12'h1E9:                     
        begin                        
          pcTx_data_1E9<= spi_data;
        end                          
        12'h1EA:                     
        begin                        
          pcTx_data_1EA<= spi_data;
        end                          
        12'h1EB:                     
        begin                        
          pcTx_data_1EB<= spi_data;
        end                          
        12'h1EC:                     
        begin                        
          pcTx_data_1EC<= spi_data;
        end                          
        12'h1ED:                     
        begin                        
          pcTx_data_1ED<= spi_data;
        end                          
        12'h1EE:                     
        begin                        
          pcTx_data_1EE<= spi_data;
        end                          
        12'h1EF:                     
        begin                        
          pcTx_data_1EF<= spi_data;
        end                          
        12'h1F0:                     
        begin                        
          pcTx_data_1F0<= spi_data;
        end                          
        12'h1F1:                     
        begin                        
          pcTx_data_1F1<= spi_data;
        end                          
        12'h1F2:                     
        begin                        
          pcTx_data_1F2<= spi_data;
        end                          
        12'h1F3:                     
        begin                        
          pcTx_data_1F3<= spi_data;
        end                          
        12'h1F4:                     
        begin                        
          pcTx_data_1F4<= spi_data;
        end                         
        12'h1F5:                    
        begin                       
          pcTx_data_1F5<= spi_data;
        end                         
        12'h1F6:                    
        begin                       
          pcTx_data_1F6<= spi_data;
        end                         
        12'h1F7:                    
        begin                       
          pcTx_data_1F7<= spi_data;                           
        end                                                      
        12'h1F8:                                                 
        begin                                                    
          pcTx_data_1F8<= spi_data;                           
        end                                                      
        12'h1F9:                                                 
        begin                                                    
          pcTx_data_1F9<= spi_data;                           
        end                                                                   
        12'h1FA:                                                              
        begin                                                    
          pcTx_data_1FA<= spi_data;                           
        end                                                      
        12'h1FB:                                                 
        begin                                                    
          pcTx_data_1FB<= spi_data;                           
        end                                                      
        12'h1FC:                                                 
        begin                                                    
          pcTx_data_1FC<= spi_data;                           
        end                                                      
        12'h1FD:                                                 
        begin                                                    
          pcTx_data_1FD<= spi_data;                           
        end                                                      
        12'h1FE:                                                              
        begin                                                                 
          pcTx_data_1FE<= spi_data;                         
        end                                                                   
        12'h1FF:                                                                                                                    
        begin                                    
          pcTx_data_1FF<= spi_data;                       
        end 
        12'h200:                                
        begin                       
           pcTx_data_200 <= spi_data; 
        end             
        12'h201:                                
        begin                       
           pcTx_data_201 <= spi_data; 
        end             
        12'h202:                                
        begin                       
           pcTx_data_202 <= spi_data; 
        end             
        12'h203:                                
        begin                       
           pcTx_data_203 <= spi_data; 
        end             
        12'h204:                                
        begin                       
           pcTx_data_204 <= spi_data; 
        end             
        12'h205:                                
        begin                       
           pcTx_data_205 <= spi_data; 
        end             
        12'h206:                                
        begin                       
           pcTx_data_206 <= spi_data; 
        end             
        12'h207:                                
        begin                       
           pcTx_data_207 <= spi_data; 
        end             
        12'h208:                                
        begin                       
           pcTx_data_208 <= spi_data; 
        end             
        12'h209:                                
        begin                       
           pcTx_data_209 <= spi_data; 
        end             
        12'h20A:                                
        begin                       
           pcTx_data_20A <= spi_data; 
        end             
        12'h20B:                                
        begin                       
           pcTx_data_20B <= spi_data; 
        end             
        12'h20C:                                
        begin                       
           pcTx_data_20C <= spi_data; 
        end             
        12'h20D:                                
        begin                       
           pcTx_data_20D <= spi_data; 
        end             
        12'h20E:                                
        begin                       
           pcTx_data_20E <= spi_data; 
        end             
        12'h20F:                                
        begin                       
           pcTx_data_20F <= spi_data; 
        end             
        12'h210:                                
        begin                       
           pcTx_data_210 <= spi_data; 
        end             
        12'h211:                                
        begin                       
           pcTx_data_211 <= spi_data; 
        end             
        12'h212:                                
        begin                       
           pcTx_data_212 <= spi_data; 
        end             
        12'h213:                                
        begin                       
           pcTx_data_213 <= spi_data; 
        end             
        12'h214:                                
        begin                       
           pcTx_data_214 <= spi_data; 
        end             
        12'h215:                                
        begin                       
           pcTx_data_215 <= spi_data; 
        end             
        12'h216:                                
        begin                       
           pcTx_data_216 <= spi_data; 
        end             
        12'h217:                                
        begin                       
           pcTx_data_217 <= spi_data; 
        end             
        12'h218:                                
        begin                       
           pcTx_data_218 <= spi_data; 
        end             
        12'h219:                                
        begin                       
           pcTx_data_219 <= spi_data; 
        end             
        12'h21A:                                
        begin                       
           pcTx_data_21A <= spi_data; 
        end             
        12'h21B:                                
        begin                       
           pcTx_data_21B <= spi_data; 
        end             
        12'h21C:                                
        begin                       
           pcTx_data_21C <= spi_data; 
        end             
        12'h21D:                                
        begin                       
           pcTx_data_21D <= spi_data; 
        end             
        12'h21E:                                
        begin                       
           pcTx_data_21E <= spi_data; 
        end             
        12'h21F:                                
        begin                       
           pcTx_data_21F <= spi_data; 
        end             
        12'h220:                                
        begin                       
           pcTx_data_220 <= spi_data; 
        end             
        12'h221:                                
        begin                       
           pcTx_data_221 <= spi_data; 
        end             
        12'h222:                                
        begin                       
           pcTx_data_222 <= spi_data; 
        end             
        12'h223:                                
        begin                       
           pcTx_data_223 <= spi_data; 
        end             
        12'h224:                                
        begin                       
           pcTx_data_224 <= spi_data; 
        end             
        12'h225:                                
        begin                       
           pcTx_data_225 <= spi_data; 
        end             
        12'h226:                                
        begin                       
           pcTx_data_226 <= spi_data; 
        end             
        12'h227:                                
        begin                       
           pcTx_data_227 <= spi_data; 
        end             
        12'h228:                                
        begin                       
           pcTx_data_228 <= spi_data; 
        end             
        12'h229:                                
        begin                       
           pcTx_data_229 <= spi_data; 
        end             
        12'h22A:                                
        begin                       
           pcTx_data_22A <= spi_data; 
        end             
        12'h22B:                                
        begin                       
           pcTx_data_22B <= spi_data; 
        end             
        12'h22C:                                
        begin                       
           pcTx_data_22C <= spi_data; 
        end             
        12'h22D:                                
        begin                       
           pcTx_data_22D <= spi_data; 
        end             
        12'h22E:                                
        begin                       
           pcTx_data_22E <= spi_data; 
        end             
        12'h22F:                                
        begin                       
           pcTx_data_22F <= spi_data; 
        end             
        12'h230:                                
        begin                       
           pcTx_data_230 <= spi_data; 
        end             
        12'h231:                                
        begin                       
           pcTx_data_231 <= spi_data; 
        end             
        12'h232:                                
        begin                       
           pcTx_data_232 <= spi_data; 
        end             
        12'h233:                                
        begin                       
           pcTx_data_233 <= spi_data; 
        end             
        12'h234:                                
        begin                       
           pcTx_data_234 <= spi_data; 
        end             
        12'h235:                                
        begin                       
           pcTx_data_235 <= spi_data; 
        end             
        12'h236:                                
        begin                       
           pcTx_data_236 <= spi_data; 
        end             
        12'h237:                                
        begin                       
           pcTx_data_237 <= spi_data; 
        end             
        12'h238:                                
        begin                       
           pcTx_data_238 <= spi_data; 
        end             
        12'h239:                                
        begin                       
           pcTx_data_239 <= spi_data; 
        end             
        12'h23A:                                
        begin                       
           pcTx_data_23A <= spi_data; 
        end             
        12'h23B:                                
        begin                       
           pcTx_data_23B <= spi_data; 
        end             
        12'h23C:                                
        begin                       
           pcTx_data_23C <= spi_data; 
        end             
        12'h23D:                                
        begin                       
           pcTx_data_23D <= spi_data; 
        end             
        12'h23E:                                
        begin                       
           pcTx_data_23E <= spi_data; 
        end             
        12'h23F:                                
        begin                       
           pcTx_data_23F <= spi_data; 
        end                    
    endcase 
	 end
end   
        
        //K7-------------->V6
always @ (posedge ref_clk)
begin
    if(inter_dat2[spi_width-1:spi_width-12]==12'h002&&inter_dat2[spi_width-25:0]==20'hABCDE)
	  begin
	      case(inter_dat2[spi_width-13:spi_width-24])
 	      12'h000: 
        begin
           //RD_DATA_K7[spi_width-13:0]  <= pcRx_data_000;  
           RD_DATA_K7[spi_width-13:0]  <= inter_dat0;
        end                          
        12'h001:                     
        begin                        
           //RD_DATA_K7[spi_width-13:0]  <= pcRx_data_001;  
           RD_DATA_K7[spi_width-13:0]  <= inter_dat1;
        end                          
        12'h002:                     
        begin                        
           //RD_DATA_K7[spi_width-13:0]  <= pcRx_data_002;  
           RD_DATA_K7[spi_width-13:0]  <=32'h12345678;
        end
        12'h003:
        begin
           //RD_DATA_K7[spi_width-13:0]  <= pcRx_data_003;
           RD_DATA_K7[spi_width-13:0]  <= inter_dat3;
        end                          
        12'h004:                     
        begin                        
           //RD_DATA_K7[spi_width-13:0]  <= pcRx_data_004;
           RD_DATA_K7[spi_width-13:0]  <= inter_dat4;
        end                          
        12'h005:                     
        begin                        
           //RD_DATA_K7[spi_width-13:0]  <= pcRx_data_005;
           RD_DATA_K7[spi_width-13:0]  <= inter_dat5;
        end                          
        12'h006:                     
        begin                        
           //RD_DATA_K7[spi_width-13:0]  <= pcRx_data_006;
           RD_DATA_K7[spi_width-13:0]  <= inter_dat6;
        end                          
        12'h007:                     
        begin                        
          // RD_DATA_K7[spi_width-13:0]  <= pcRx_data_007;
          RD_DATA_K7[spi_width-13:0]  <= inter_dat7;
        end                          
        12'h008:                     
        begin                        
          // RD_DATA_K7[spi_width-13:0]  <= pcRx_data_008;
          RD_DATA_K7[spi_width-13:0]  <= inter_dat8;
        end                          
        12'h009:                     
        begin                        
          // RD_DATA_K7[spi_width-13:0]  <= pcRx_data_009;
          RD_DATA_K7[spi_width-13:0]  <= inter_dat9;
        end                          
        12'h00A:                     
        begin                        
         //  RD_DATA_K7[spi_width-13:0]  <= pcRx_data_00A;
         RD_DATA_K7[spi_width-13:0]  <= inter_dat10;
        end                          
        12'h00B:                     
        begin                        
         //  RD_DATA_K7[spi_width-13:0]  <= pcRx_data_00B;
         RD_DATA_K7[spi_width-13:0]  <= inter_dat11;
        end                          
        12'h00C:                     
        begin                        
         //  RD_DATA_K7[spi_width-13:0]  <= pcRx_data_00C;
         RD_DATA_K7[spi_width-13:0]  <= inter_dat12;
        end                          
        12'h00D:                     
        begin                        
          // RD_DATA_K7[spi_width-13:0]  <= pcRx_data_00D;
          RD_DATA_K7[spi_width-13:0]  <= inter_dat13;
        end                          
        12'h00E:                     
        begin                        
          // RD_DATA_K7[spi_width-13:0]  <= pcRx_data_00E;
          RD_DATA_K7[spi_width-13:0]  <= inter_dat14;
        end                          
        12'h00F:                     
        begin                        
          // RD_DATA_K7[spi_width-13:0]  <= pcRx_data_00F;
          RD_DATA_K7[spi_width-13:0]  <= inter_dat15;
        end                          
        12'h010:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_010;
        end                          
        12'h011:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_011;
        end                          
        12'h012:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_012;
        end                          
        12'h013:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_013;
        end                          
        12'h014:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_014;
        end                          
        12'h015:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_015;
        end                          
        12'h016:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_016;
        end                          
        12'h017:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_017;
        end                          
        12'h018:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_018;
        end                          
        12'h019:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_019;
        end                          
        12'h01A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_01A;
        end                          
        12'h01B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_01B;
        end                          
        12'h01C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_01C;
        end                          
        12'h01D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_01D;
        end                          
        12'h01E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_01E;
        end                          
        12'h01F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_01F;
        end                          
        12'h020:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_020;
        end                          
        12'h021:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_021;
        end                          
        12'h022:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_022;
        end                          
        12'h023:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_023;
        end                          
        12'h024:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_024;
        end                          
        12'h025:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_025;
        end                          
        12'h026:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_026;
        end                          
        12'h027:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_027;
        end                          
        12'h028:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_028;
        end                          
        12'h029:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_029;
        end                          
        12'h02A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_02A;
        end                          
        12'h02B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_02B;
        end                          
        12'h02C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_02C;
        end                          
        12'h02D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_02D;
        end                          
        12'h02E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_02E;
        end                          
        12'h02F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_02F;
        end                          
        12'h030:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_030;
        end                          
        12'h031:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_031;
        end                          
        12'h032:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_032;
        end                          
        12'h033:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_033;
        end                          
        12'h034:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_034;
        end                          
        12'h035:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_035;
        end                          
        12'h036:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_036;
        end                          
        12'h037:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_037;
        end                          
        12'h038:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_038;
        end                          
        12'h039:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_039;
        end                          
        12'h03A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_03A;
        end                          
        12'h03B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_03B;
        end                          
        12'h03C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_03C;
        end                          
        12'h03D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_03D;
        end                          
        12'h03E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_03E;
        end                          
        12'h03F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_03F;
        end                          
        12'h040:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_040;
        end                          
        12'h041:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_041;
        end                          
        12'h042:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_042;
        end                          
        12'h043:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_043;
        end                          
        12'h044:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_044;
        end                          
        12'h045:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_045;
        end                          
        12'h046:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_046;
        end                          
        12'h047:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_047;
        end                          
        12'h048:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_048;
        end                          
        12'h049:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_049;
        end                          
        12'h04A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_04A;
        end                          
        12'h04B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_04B;
        end                          
        12'h04C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_04C;
        end                          
        12'h04D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_04D;
        end                          
        12'h04E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_04E;
        end                          
        12'h04F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_04F;
        end                          
        12'h050:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_050;
        end                          
        12'h051:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_051;
        end                          
        12'h052:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_052;
        end                          
        12'h053:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_053;
        end                          
        12'h054:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_054;
        end                          
        12'h055:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_055;
        end                          
        12'h056:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_056;
        end                          
        12'h057:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_057;
        end                          
        12'h058:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_058;
        end                          
        12'h059:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_059;
        end                          
        12'h05A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_05A;
        end                          
        12'h05B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_05B;
        end                          
        12'h05C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_05C;
        end                          
        12'h05D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_05D;
        end                          
        12'h05E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_05E;
        end                          
        12'h05F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_05F;
        end                          
        12'h060:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_060;
        end                          
        12'h061:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_061;
        end                          
        12'h062:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_062;
        end                          
        12'h063:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_063;
        end                          
        12'h064:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_064;
        end                          
        12'h065:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_065;
        end                          
        12'h066:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_066;
        end                          
        12'h067:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_067;
        end                          
        12'h068:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_068;
        end                          
        12'h069:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_069;
        end                          
        12'h06A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_06A;
        end                          
        12'h06B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_06B;
        end                          
        12'h06C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_06C;
        end                          
        12'h06D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_06D;
        end                          
        12'h06E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_06E;
        end                          
        12'h06F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_06F;
        end                          
        12'h070:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_070;
        end                          
        12'h071:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_071;
        end                          
        12'h072:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_072;
        end                          
        12'h073:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_073;
        end                          
        12'h074:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_074;
        end                          
        12'h075:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_075;
        end                          
        12'h076:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_076;
        end                          
        12'h077:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_077;
        end                          
        12'h078:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_078;
        end                          
        12'h079:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_079;
        end                          
        12'h07A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_07A;
        end                          
        12'h07B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_07B;
        end                          
        12'h07C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_07C;
        end                          
        12'h07D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_07D;
        end                          
        12'h07E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_07E;
        end                          
        12'h07F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_07F;
        end                          
        12'h080:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_080;
        end                          
        12'h081:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_081;
        end                          
        12'h082:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_082;
        end                          
        12'h083:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_083;
        end                          
        12'h084:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_084;
        end                          
        12'h085:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_085;
        end                          
        12'h086:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_086;
        end                          
        12'h087:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_087;
        end                          
        12'h088:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_088;
        end                          
        12'h089:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_089;
        end                          
        12'h08A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_08A;
        end                          
        12'h08B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_08B;
        end                          
        12'h08C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_08C;
        end                          
        12'h08D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_08D;
        end                          
        12'h08E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_08E;
        end                          
        12'h08F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_08F;
        end                          
        12'h090:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_090;
        end                          
        12'h091:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_091;
        end                          
        12'h092:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_092;
        end                          
        12'h093:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_093;
        end                          
        12'h094:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_094;
        end                          
        12'h095:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_095;
        end                          
        12'h096:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_096;
        end                          
        12'h097:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_097;
        end                          
        12'h098:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_098;
        end                          
        12'h099:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_099;
        end                          
        12'h09A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_09A;
        end                          
        12'h09B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_09B;
        end                          
        12'h09C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_09C;
        end                          
        12'h09D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_09D;
        end                          
        12'h09E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_09E;
        end                          
        12'h09F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_09F;
        end                          
        12'h0A0:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0A0;
        end                          
        12'h0A1:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0A1;
        end                          
        12'h0A2:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0A2;
        end                          
        12'h0A3:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0A3;
        end                          
        12'h0A4:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0A4;
        end                          
        12'h0A5:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0A5;
        end                          
        12'h0A6:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0A6;
        end                          
        12'h0A7:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0A7;
        end                          
        12'h0A8:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0A8;
        end                          
        12'h0A9:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0A9;
        end                          
        12'h0AA:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0AA;
        end                          
        12'h0AB:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0AB;
        end                          
        12'h0AC:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0AC;
        end                          
        12'h0AD:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0AD;
        end                          
        12'h0AE:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0AE;
        end                          
        12'h0AF:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0AF;
        end                          
        12'h0B0:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0B0;
        end                          
        12'h0B1:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0B1;
        end                          
        12'h0B2:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0B2;
        end                          
        12'h0B3:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0B3;
        end                          
        12'h0B4:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0B4;
        end                          
        12'h0B5:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0B5;
        end                          
        12'h0B6:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0B6;
        end                          
        12'h0B7:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0B7;
        end                          
        12'h0B8:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0B8;
        end                          
        12'h0B9:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0B9;
        end                          
        12'h0BA:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0BA;
        end                          
        12'h0BB:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0BB;
        end                          
        12'h0BC:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0BC;
        end                          
        12'h0BD:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0BD;
        end                          
        12'h0BE:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0BE;
        end                          
        12'h0BF:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0BF;
        end                          
        12'h0C0:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0C0;
        end                          
        12'h0C1:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0C1;
        end                          
        12'h0C2:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0C2;
        end                          
        12'h0C3:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0C3;
        end                          
        12'h0C4:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0C4;
        end                          
        12'h0C5:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0C5;
        end                          
        12'h0C6:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0C6;
        end                          
        12'h0C7:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0C7;
        end                          
        12'h0C8:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0C8;
        end                          
        12'h0C9:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0C9;
        end                          
        12'h0CA:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0CA;
        end                          
        12'h0CB:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0CB;
        end                          
        12'h0CC:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0CC;
        end                          
        12'h0CD:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0CD;
        end                          
        12'h0CE:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0CE;
        end                          
        12'h0CF:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0CF;
        end                          
        12'h0D0:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0D0;
        end                          
        12'h0D1:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0D1;
        end                          
        12'h0D2:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0D2;
        end                          
        12'h0D3:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0D3;
        end                          
        12'h0D4:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0D4;
        end                          
        12'h0D5:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0D5;
        end                          
        12'h0D6:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0D6;
        end                          
        12'h0D7:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0D7;
        end                          
        12'h0D8:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0D8;
        end                          
        12'h0D9:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0D9;
        end                          
        12'h0DA:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0DA;
        end                          
        12'h0DB:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0DB;
        end                          
        12'h0DC:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0DC;
        end                          
        12'h0DD:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0DD;
        end                          
        12'h0DE:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0DE;
        end                          
        12'h0DF:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0DF;
        end                          
        12'h0E0:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0E0;
        end                          
        12'h0E1:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0E1;
        end                          
        12'h0E2:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0E2;
        end                          
        12'h0E3:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0E3;
        end                          
        12'h0E4:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0E4;
        end                          
        12'h0E5:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0E5;
        end                          
        12'h0E6:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0E6;
        end                          
        12'h0E7:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0E7;
        end                          
        12'h0E8:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0E8;
        end                          
        12'h0E9:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0E9;
        end                          
        12'h0EA:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0EA;
        end                          
        12'h0EB:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0EB;
        end                          
        12'h0EC:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0EC;
        end                          
        12'h0ED:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0ED;
        end                          
        12'h0EE:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0EE;
        end                          
        12'h0EF:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0EF;
        end                          
        12'h0F0:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0F0;
        end                          
        12'h0F1:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0F1;
        end                          
        12'h0F2:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0F2;
        end                          
        12'h0F3:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0F3;
        end                          
        12'h0F4:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0F4;
        end                          
        12'h0F5:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0F5;
        end                          
        12'h0F6:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0F6;
        end                          
        12'h0F7:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0F7;
        end                          
        12'h0F8:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0F8;
        end                          
        12'h0F9:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0F9;
        end                          
        12'h0FA:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0FA;
        end                          
        12'h0FB:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0FB;
        end                          
        12'h0FC:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0FC;
        end                          
        12'h0FD:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0FD;
        end                          
        12'h0FE:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0FE;
        end                          
        12'h0FF:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_0FF;
        end                          
        12'h100:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_100;
        end                          
        12'h101:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_101;
        end                          
        12'h102:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_102;
        end                          
        12'h103:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_103;
        end                          
        12'h104:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_104;
        end                          
        12'h105:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_105;
        end                          
        12'h106:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_106;
        end                          
        12'h107:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_107;
        end                          
        12'h108:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_108;
        end                          
        12'h109:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_109;
        end                          
        12'h10A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_10A;
        end                          
        12'h10B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_10B;
        end                          
        12'h10C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_10C;
        end                          
        12'h10D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_10D;
        end                          
        12'h10E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_10E;
        end                          
        12'h10F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_10F;
        end                          
        12'h110:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_110;
        end                          
        12'h111:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_111;
        end                          
        12'h112:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_112;
        end                          
        12'h113:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_113;
        end                          
        12'h114:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_114;
        end                          
        12'h115:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_115;
        end                          
        12'h116:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_116;
        end                          
        12'h117:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_117;
        end                          
        12'h118:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_118;
        end                          
        12'h119:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_119;
        end                          
        12'h11A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_11A;
        end                          
        12'h11B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_11B;
        end                          
        12'h11C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_11C;
        end                          
        12'h11D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_11D;
        end                          
        12'h11E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_11E;
        end                          
        12'h11F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_11F;
        end                          
        12'h120:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_120;
        end                          
        12'h121:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_121;
        end                          
        12'h122:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_122;
        end                          
        12'h123:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_123;
        end                          
        12'h124:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_124;
        end                          
        12'h125:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_125;
        end                          
        12'h126:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_126;
        end                          
        12'h127:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_127;
        end                          
        12'h128:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_128;
        end                          
        12'h129:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_129;
        end                          
        12'h12A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_12A;
        end                          
        12'h12B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_12B;
        end                          
        12'h12C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_12C;
        end                          
        12'h12D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_12D;
        end                          
        12'h12E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_12E;
        end                          
        12'h12F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_12F;
        end                          
        12'h130:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_130;
        end                          
        12'h131:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_131;
        end                          
        12'h132:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_132;
        end                          
        12'h133:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_133;
        end                          
        12'h134:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_134;
        end                          
        12'h135:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_135;
        end                          
        12'h136:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_136;
        end                          
        12'h137:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_137;
        end                          
        12'h138:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_138;
        end                          
        12'h139:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_139;
        end                          
        12'h13A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_13A;
        end                          
        12'h13B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_13B;
        end                          
        12'h13C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_13C;
        end                          
        12'h13D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_13D;
        end                          
        12'h13E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_13E;
        end                          
        12'h13F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_13F;
        end                          
        12'h140:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_140;
        end                          
        12'h141:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_141;
        end                          
        12'h142:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_142;
        end                          
        12'h143:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_143;
        end                          
        12'h144:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_144;
        end                          
        12'h145:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_145;
        end                          
        12'h146:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_146;
        end                          
        12'h147:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_147;
        end                          
        12'h148:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_148;
        end                          
        12'h149:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_149;
        end                          
        12'h14A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_14A;
        end                          
        12'h14B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_14B;
        end                          
        12'h14C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_14C;
        end                          
        12'h14D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_14D;
        end                          
        12'h14E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_14E;
        end                          
        12'h14F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_14F;
        end                          
        12'h150:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_150;
        end                          
        12'h151:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_151;
        end                          
        12'h152:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_152;
        end                          
        12'h153:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_153;
        end                          
        12'h154:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_154;
        end                          
        12'h155:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_155;
        end                          
        12'h156:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_156;
        end                          
        12'h157:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_157;
        end                          
        12'h158:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_158;
        end                          
        12'h159:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_159;
        end                          
        12'h15A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_15A;
        end                          
        12'h15B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_15B;
        end                          
        12'h15C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_15C;
        end                          
        12'h15D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_15D;
        end                          
        12'h15E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_15E;
        end                          
        12'h15F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_15F;
        end                          
        12'h160:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_160;
        end                          
        12'h161:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_161;
        end                          
        12'h162:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_162;
        end                          
        12'h163:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_163;
        end                          
        12'h164:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_164;
        end                          
        12'h165:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_165;
        end                          
        12'h166:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_166;
        end                          
        12'h167:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_167;
        end                          
        12'h168:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_168;
        end                          
        12'h169:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_169;
        end                          
        12'h16A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_16A;
        end                          
        12'h16B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_16B;
        end                          
        12'h16C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_16C;
        end                          
        12'h16D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_16D;
        end                          
        12'h16E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_16E;
        end                          
        12'h16F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_16F;
        end                          
        12'h170:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_170;
        end                          
        12'h171:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_171;
        end                          
        12'h172:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_172;
        end                          
        12'h173:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_173;
        end                          
        12'h174:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_174;
        end                          
        12'h175:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_175;
        end                          
        12'h176:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_176;
        end                          
        12'h177:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_177;
        end                          
        12'h178:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_178;
        end                          
        12'h179:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_179;
        end                          
        12'h17A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_17A;
        end                          
        12'h17B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_17B;
        end                          
        12'h17C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_17C;
        end                          
        12'h17D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_17D;
        end                          
        12'h17E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_17E;
        end                          
        12'h17F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_17F;
        end                          
        12'h180:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_180;
        end                          
        12'h181:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_181;
        end                          
        12'h182:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_182;
        end                          
        12'h183:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_183;
        end                          
        12'h184:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_184;
        end                          
        12'h185:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_185;
        end                          
        12'h186:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_186;
        end                          
        12'h187:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_187;
        end                          
        12'h188:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_188;
        end                          
        12'h189:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_189;
        end                          
        12'h18A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_18A;
        end                          
        12'h18B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_18B;
        end                          
        12'h18C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_18C;
        end                          
        12'h18D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_18D;
        end                          
        12'h18E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_18E;
        end                          
        12'h18F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_18F;
        end                          
        12'h190:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_190;
        end                          
        12'h191:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_191;
        end                          
        12'h192:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_192;
        end                          
        12'h193:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_193;
        end                          
        12'h194:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_194;
        end                          
        12'h195:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_195;
        end                          
        12'h196:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_196;
        end                          
        12'h197:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_197;
        end                          
        12'h198:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_198;
        end                          
        12'h199:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_199;
        end                          
        12'h19A:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_19A;
        end                          
        12'h19B:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_19B;
        end                          
        12'h19C:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_19C;
        end                          
        12'h19D:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_19D;
        end                          
        12'h19E:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_19E;
        end                          
        12'h19F:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_19F;
        end                          
        12'h1A0:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1A0;
        end                          
        12'h1A1:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1A1;
        end                          
        12'h1A2:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1A2;
        end                          
        12'h1A3:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1A3;
        end                          
        12'h1A4:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1A4;
        end                          
        12'h1A5:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1A5;
        end                          
        12'h1A6:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1A6;
        end                          
        12'h1A7:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1A7;
        end                          
        12'h1A8:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1A8;
        end                          
        12'h1A9:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1A9;
        end                          
        12'h1AA:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1AA;
        end                          
        12'h1AB:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1AB;
        end                          
        12'h1AC:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1AC;
        end                          
        12'h1AD:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1AD;
        end                          
        12'h1AE:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1AE;
        end                          
        12'h1AF:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1AF;
        end                          
        12'h1B0:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1B0;
        end                          
        12'h1B1:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1B1;
        end                          
        12'h1B2:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1B2;
        end                          
        12'h1B3:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1B3;
        end                          
        12'h1B4:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1B4;
        end                          
        12'h1B5:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1B5;
        end                          
        12'h1B6:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1B6;
        end                          
        12'h1B7:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1B7;
        end                          
        12'h1B8:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1B8;
        end                          
        12'h1B9:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1B9;
        end                          
        12'h1BA:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1BA;
        end                          
        12'h1BB:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1BB;
        end                          
        12'h1BC:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1BC;
        end                          
        12'h1BD:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1BD;
        end                          
        12'h1BE:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1BE;
        end                          
        12'h1BF:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1BF;
        end                          
        12'h1C0:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1C0;
        end                          
        12'h1C1:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1C1;
        end                          
        12'h1C2:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1C2;
        end                          
        12'h1C3:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1C3;
        end                          
        12'h1C4:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1C4;
        end                          
        12'h1C5:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1C5;
        end                          
        12'h1C6:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1C6;
        end                          
        12'h1C7:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1C7;
        end                          
        12'h1C8:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1C8;
        end                          
        12'h1C9:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1C9;
        end                          
        12'h1CA:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1CA;
        end                          
        12'h1CB:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1CB;
        end                          
        12'h1CC:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1CC;
        end                          
        12'h1CD:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1CD;
        end                          
        12'h1CE:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1CE;
        end                          
        12'h1CF:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1CF;
        end                          
        12'h1D0:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1D0;
        end                          
        12'h1D1:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1D1;
        end                          
        12'h1D2:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1D2;
        end                          
        12'h1D3:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1D3;
        end                          
        12'h1D4:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1D4;
        end                          
        12'h1D5:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1D5;
        end                          
        12'h1D6:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1D6;
        end                          
        12'h1D7:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1D7;
        end                          
        12'h1D8:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1D8;
        end                          
        12'h1D9:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1D9;
        end                          
        12'h1DA:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1DA;
        end                          
        12'h1DB:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1DB;
        end                          
        12'h1DC:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1DC;
        end                          
        12'h1DD:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1DD;
        end                          
        12'h1DE:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1DE;
        end                          
        12'h1DF:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1DF;
        end                          
        12'h1E0:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1E0;
        end                          
        12'h1E1:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1E1;
        end                          
        12'h1E2:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1E2;
        end                          
        12'h1E3:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1E3;
        end                          
        12'h1E4:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1E4;
        end                          
        12'h1E5:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1E5;
        end                          
        12'h1E6:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1E6;
        end                          
        12'h1E7:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1E7;
        end                          
        12'h1E8:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1E8;
        end                          
        12'h1E9:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1E9;
        end                          
        12'h1EA:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1EA;
        end                          
        12'h1EB:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1EB;
        end                          
        12'h1EC:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1EC;
        end                          
        12'h1ED:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1ED;
        end                          
        12'h1EE:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1EE;
        end                          
        12'h1EF:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1EF;
        end                          
        12'h1F0:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1F0;
        end                          
        12'h1F1:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1F1;
        end                          
        12'h1F2:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1F2;
        end                          
        12'h1F3:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1F3;
        end                          
        12'h1F4:                     
        begin                        
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1F4;
        end
        12'h1F5:
        begin
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1F5;
        end
        12'h1F6:
        begin
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1F6;
        end
        12'h1F7:
        begin
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1F7;                           
        end                                                      
        12'h1F8:                                                 
        begin                                                    
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1F8;                           
        end                                                      
        12'h1F9:                                                 
        begin                                                    
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1F9;                           
        end                                                                   
        12'h1FA:                                                              
        begin                                                    
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1FA;                           
        end                                                      
        12'h1FB:                                                 
        begin                                                    
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1FB;                           
        end                                                      
        12'h1FC:                                                 
        begin                                                    
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1FC;                           
        end                                                      
        12'h1FD:                                                 
        begin                                                    
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1FD;                           
        end                                                      
        12'h1FE:                                                              
        begin                                                                 
           RD_DATA_K7[spi_width-13:0]  <= pcRx_data_1FE;                         
        end                                                                   
        12'h1FF:                                                                                                                    
        begin                                    
           RD_DATA_K7[spi_width-13:0]  <=  pcRx_data_1FF;                       
        end 

        12'h200:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_200; 
        end             
        12'h201:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_201; 
        end             
        12'h202:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_202; 
        end             
        12'h203:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_203; 
        end             
        12'h204:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_204; 
        end             
        12'h205:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_205; 
        end             
        12'h206:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_206; 
        end             
        12'h207:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_207; 
        end             
        12'h208:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_208; 
        end             
        12'h209:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_209; 
        end             
        12'h20A:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_20A; 
        end             
        12'h20B:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_20B; 
        end             
        12'h20C:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_20C; 
        end             
        12'h20D:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_20D; 
        end             
        12'h20E:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_20E; 
        end             
        12'h20F:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_20F; 
        end             
        12'h210:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_210; 
        end             
        12'h211:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_211; 
        end             
        12'h212:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_212; 
        end             
        12'h213:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_213; 
        end             
        12'h214:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_214; 
        end             
        12'h215:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_215; 
        end             
        12'h216:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_216; 
        end             
        12'h217:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_217; 
        end             
        12'h218:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_218; 
        end             
        12'h219:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_219; 
        end             
        12'h21A:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_21A; 
        end             
        12'h21B:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_21B; 
        end             
        12'h21C:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_21C; 
        end             
        12'h21D:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_21D; 
        end             
        12'h21E:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_21E; 
        end             
        12'h21F:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_21F; 
        end             
        12'h220:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_220; 
        end             
        12'h221:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_221; 
        end             
        12'h222:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_222; 
        end             
        12'h223:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_223; 
        end             
        12'h224:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_224; 
        end             
        12'h225:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_225; 
        end             
        12'h226:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_226; 
        end             
        12'h227:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_227; 
        end             
        12'h228:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_228; 
        end             
        12'h229:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_229; 
        end             
        12'h22A:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_22A; 
        end             
        12'h22B:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_22B; 
        end             
        12'h22C:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_22C; 
        end             
        12'h22D:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_22D; 
        end             
        12'h22E:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_22E; 
        end             
        12'h22F:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_22F; 
        end             
        12'h230:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_230; 
        end             
        12'h231:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_231; 
        end             
        12'h232:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_232; 
        end             
        12'h233:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_233; 
        end             
        12'h234:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_234; 
        end             
        12'h235:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_235; 
        end             
        12'h236:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_236; 
        end             
        12'h237:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_237; 
        end             
        12'h238:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_238; 
        end             
        12'h239:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_239; 
        end             
        12'h23A:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_23A; 
        end             
        12'h23B:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_23B; 
        end             
        12'h23C:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_23C; 
        end             
        12'h23D:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_23D; 
        end             
        12'h23E:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_23E; 
        end             
        12'h23F:                                
        begin                       
           RD_DATA_K7[spi_width-13:0] <=  pcRx_data_23F; 
        end                                                                                                                                            
 			  default:
 			      RD_DATA_K7[spi_width-13:0]  <= 32'h4651780;
 			  endcase
 			  
 	    end                                                                                       
 end 
 
 
 endmodule
