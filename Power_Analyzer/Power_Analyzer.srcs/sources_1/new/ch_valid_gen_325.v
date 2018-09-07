`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/03 19:45:43
// Design Name: 
// Module Name: ch_valid_gen_325
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ch_valid_gen_325
#(parameter spi_width = 44
)
(
input                        ref_clk,
input                        spi_valid,
input    [spi_width-1:0]     spi_all_data,//高12位地址+低32位数据 
output                       ch_valid_en000, 
output                       ch_valid_en001, 
output                       ch_valid_en002, 
output                       ch_valid_en003, 
output                       ch_valid_en004, 
output                       ch_valid_en005, 
output                       ch_valid_en006, 
output                       ch_valid_en007, 
output                       ch_valid_en008, 
output                       ch_valid_en009, 
output                       ch_valid_en00A, 
output                       ch_valid_en00B, 
output                       ch_valid_en00C, 
output                       ch_valid_en00D, 
output                       ch_valid_en00E, 
output                       ch_valid_en00F, 
output                       ch_valid_en010, 
output                       ch_valid_en011, 
output                       ch_valid_en012, 
output                       ch_valid_en013, 
output                       ch_valid_en014, 
output                       ch_valid_en015, 
output                       ch_valid_en016, 
output                       ch_valid_en017, 
output                       ch_valid_en018, 
output                       ch_valid_en019, 
output                       ch_valid_en01A, 
output                       ch_valid_en01B, 
output                       ch_valid_en01C, 
output                       ch_valid_en01D, 
output                       ch_valid_en01E, 
output                       ch_valid_en01F, 
output                       ch_valid_en020, 
output                       ch_valid_en021, 
output                       ch_valid_en022, 
output                       ch_valid_en023, 
output                       ch_valid_en024, 
output                       ch_valid_en025, 
output                       ch_valid_en026, 
output                       ch_valid_en027, 
output                       ch_valid_en028, 
output                       ch_valid_en029, 
output                       ch_valid_en02A, 
output                       ch_valid_en02B, 
output                       ch_valid_en02C, 
output                       ch_valid_en02D, 
output                       ch_valid_en02E, 
output                       ch_valid_en02F, 
output                       ch_valid_en030, 
output                       ch_valid_en031, 
output                       ch_valid_en032, 
output                       ch_valid_en033, 
output                       ch_valid_en034, 
output                       ch_valid_en035, 
output                       ch_valid_en036, 
output                       ch_valid_en037, 
output                       ch_valid_en038, 
output                       ch_valid_en039, 
output                       ch_valid_en03A, 
output                       ch_valid_en03B, 
output                       ch_valid_en03C, 
output                       ch_valid_en03D, 
output                       ch_valid_en03E, 
output                       ch_valid_en03F, 
output                       ch_valid_en040, 
output                       ch_valid_en041, 
output                       ch_valid_en042, 
output                       ch_valid_en043, 
output                       ch_valid_en044, 
output                       ch_valid_en045, 
output                       ch_valid_en046, 
output                       ch_valid_en047, 
output                       ch_valid_en048, 
output                       ch_valid_en049, 
output                       ch_valid_en04A, 
output                       ch_valid_en04B, 
output                       ch_valid_en04C, 
output                       ch_valid_en04D, 
output                       ch_valid_en04E, 
output                       ch_valid_en04F, 
output                       ch_valid_en050,   
output                       ch_valid_en051,   
output                       ch_valid_en052,   
output                       ch_valid_en053,   
output                       ch_valid_en054,   
output                       ch_valid_en055,   
output                       ch_valid_en056,   
output                       ch_valid_en057,   
output                       ch_valid_en058,   
output                       ch_valid_en059,   
output                       ch_valid_en05A,   
output                       ch_valid_en05B,   
output                       ch_valid_en05C,   
output                       ch_valid_en05D,   
output                       ch_valid_en05E,   
output                       ch_valid_en05F,   
output                       ch_valid_en060,   
output                       ch_valid_en061,   
output                       ch_valid_en062,   
output                       ch_valid_en063,   
output                       ch_valid_en064,   
output                       ch_valid_en065,   
output                       ch_valid_en066,   
output                       ch_valid_en067,   
output                       ch_valid_en068,   
output                       ch_valid_en069,   
output                       ch_valid_en06A,   
output                       ch_valid_en06B,   
output                       ch_valid_en06C,   
output                       ch_valid_en06D,   
output                       ch_valid_en06E,   
output                       ch_valid_en06F,   
output                       ch_valid_en070,   
output                       ch_valid_en071,   
output                       ch_valid_en072,   
output                       ch_valid_en073,   
output                       ch_valid_en074,   
output                       ch_valid_en075,   
output                       ch_valid_en076,   
output                       ch_valid_en077,   
output                       ch_valid_en078,   
output                       ch_valid_en079,   
output                       ch_valid_en07A,   
output                       ch_valid_en07B,   
output                       ch_valid_en07C,   
output                       ch_valid_en07D,   
output                       ch_valid_en07E,   
output                       ch_valid_en07F,   
output                       ch_valid_en080,   
output                       ch_valid_en081,   
output                       ch_valid_en082,   
output                       ch_valid_en083,   
output                       ch_valid_en084,   
output                       ch_valid_en085,   
output                       ch_valid_en086,   
output                       ch_valid_en087,   
output                       ch_valid_en088,   
output                       ch_valid_en089,   
output                       ch_valid_en08A,   
output                       ch_valid_en08B,   
output                       ch_valid_en08C,   
output                       ch_valid_en08D,   
output                       ch_valid_en08E,   
output                       ch_valid_en08F,   
output                       ch_valid_en090,   
output                       ch_valid_en091,   
output                       ch_valid_en092,   
output                       ch_valid_en093,   
output                       ch_valid_en094,   
output                       ch_valid_en095,   
output                       ch_valid_en096,   
output                       ch_valid_en097,   
output                       ch_valid_en098,   
output                       ch_valid_en099,   
output                       ch_valid_en09A,   
output                       ch_valid_en09B,   
output                       ch_valid_en09C,   
output                       ch_valid_en09D,   
output                       ch_valid_en09E,   
output                       ch_valid_en09F,   
output                       ch_valid_en0A0,   
output                       ch_valid_en0A1,   
output                       ch_valid_en0A2,   
output                       ch_valid_en0A3,   
output                       ch_valid_en0A4,   
output                       ch_valid_en0A5,   
output                       ch_valid_en0A6,   
output                       ch_valid_en0A7,   
output                       ch_valid_en0A8,   
output                       ch_valid_en0A9,   
output                       ch_valid_en0AA,   
output                       ch_valid_en0AB,   
output                       ch_valid_en0AC,   
output                       ch_valid_en0AD,   
output                       ch_valid_en0AE,   
output                       ch_valid_en0AF,   
output                       ch_valid_en0B0,   
output                       ch_valid_en0B1,   
output                       ch_valid_en0B2,   
output                       ch_valid_en0B3,   
output                       ch_valid_en0B4,   
output                       ch_valid_en0B5,   
output                       ch_valid_en0B6,   
output                       ch_valid_en0B7,   
output                       ch_valid_en0B8,   
output                       ch_valid_en0B9,   
output                       ch_valid_en0BA,   
output                       ch_valid_en0BB,   
output                       ch_valid_en0BC,   
output                       ch_valid_en0BD,   
output                       ch_valid_en0BE,   
output                       ch_valid_en0BF,   
output                       ch_valid_en0C0,   
output                       ch_valid_en0C1,   
output                       ch_valid_en0C2,   
output                       ch_valid_en0C3,   
output                       ch_valid_en0C4,   
output                       ch_valid_en0C5,   
output                       ch_valid_en0C6,   
output                       ch_valid_en0C7,   
output                       ch_valid_en0C8,   
output                       ch_valid_en0C9,   
output                       ch_valid_en0CA,   
output                       ch_valid_en0CB,   
output                       ch_valid_en0CC,   
output                       ch_valid_en0CD,   
output                       ch_valid_en0CE,   
output                       ch_valid_en0CF,   
output                       ch_valid_en0D0,   
output                       ch_valid_en0D1,   
output                       ch_valid_en0D2,   
output                       ch_valid_en0D3,   
output                       ch_valid_en0D4,   
output                       ch_valid_en0D5,   
output                       ch_valid_en0D6,   
output                       ch_valid_en0D7,   
output                       ch_valid_en0D8,   
output                       ch_valid_en0D9,   
output                       ch_valid_en0DA,   
output                       ch_valid_en0DB,   
output                       ch_valid_en0DC,   
output                       ch_valid_en0DD,   
output                       ch_valid_en0DE,   
output                       ch_valid_en0DF,   
output                       ch_valid_en0E0,   
output                       ch_valid_en0E1,   
output                       ch_valid_en0E2,   
output                       ch_valid_en0E3,   
output                       ch_valid_en0E4,   
output                       ch_valid_en0E5,   
output                       ch_valid_en0E6,   
output                       ch_valid_en0E7,   
output                       ch_valid_en0E8,   
output                       ch_valid_en0E9,   
output                       ch_valid_en0EA,   
output                       ch_valid_en0EB,   
output                       ch_valid_en0EC,   
output                       ch_valid_en0ED,   
output                       ch_valid_en0EE,   
output                       ch_valid_en0EF,   
output                       ch_valid_en0F0,   
output                       ch_valid_en0F1,   
output                       ch_valid_en0F2,   
output                       ch_valid_en0F3,   
output                       ch_valid_en0F4,   
output                       ch_valid_en0F5,   
output                       ch_valid_en0F6,   
output                       ch_valid_en0F7,   
output                       ch_valid_en0F8,   
output                       ch_valid_en0F9,   
output                       ch_valid_en0FA,   
output                       ch_valid_en0FB,   
output                       ch_valid_en0FC,   
output                       ch_valid_en0FD,   
output                       ch_valid_en0FE,   
output                       ch_valid_en0FF,   
output                       ch_valid_en100,   
output                       ch_valid_en101,   
output                       ch_valid_en102,   
output                       ch_valid_en103,   
output                       ch_valid_en104,   
output                       ch_valid_en105,   
output                       ch_valid_en106,   
output                       ch_valid_en107,   
output                       ch_valid_en108,   
output                       ch_valid_en109,   
output                       ch_valid_en10A,   
output                       ch_valid_en10B,   
output                       ch_valid_en10C,   
output                       ch_valid_en10D,   
output                       ch_valid_en10E,   
output                       ch_valid_en10F,   
output                       ch_valid_en110,   
output                       ch_valid_en111,   
output                       ch_valid_en112,   
output                       ch_valid_en113,   
output                       ch_valid_en114,   
output                       ch_valid_en115,   
output                       ch_valid_en116,   
output                       ch_valid_en117,   
output                       ch_valid_en118,   
output                       ch_valid_en119,   
output                       ch_valid_en11A,   
output                       ch_valid_en11B,   
output                       ch_valid_en11C,   
output                       ch_valid_en11D,   
output                       ch_valid_en11E,   
output                       ch_valid_en11F,   
output                       ch_valid_en120,   
output                       ch_valid_en121,   
output                       ch_valid_en122,   
output                       ch_valid_en123,   
output                       ch_valid_en124,   
output                       ch_valid_en125,   
output                       ch_valid_en126,   
output                       ch_valid_en127,   
output                       ch_valid_en128,   
output                       ch_valid_en129,   
output                       ch_valid_en12A,   
output                       ch_valid_en12B,   
output                       ch_valid_en12C,   
output                       ch_valid_en12D,   
output                       ch_valid_en12E,   
output                       ch_valid_en12F,   
output                       ch_valid_en130,   
output                       ch_valid_en131,   
output                       ch_valid_en132,   
output                       ch_valid_en133,   
output                       ch_valid_en134,   
output                       ch_valid_en135,   
output                       ch_valid_en136,   
output                       ch_valid_en137,   
output                       ch_valid_en138,   
output                       ch_valid_en139,   
output                       ch_valid_en13A,   
output                       ch_valid_en13B,   
output                       ch_valid_en13C,   
output                       ch_valid_en13D,   
output                       ch_valid_en13E,   
output                       ch_valid_en13F,   
output                       ch_valid_en140,   
output                       ch_valid_en141,   
output                       ch_valid_en142,   
output                       ch_valid_en143,   
output                       ch_valid_en144,   
output                       ch_valid_en145,   
output                       ch_valid_en146,   
output                       ch_valid_en147,   
output                       ch_valid_en148,   
output                       ch_valid_en149,   
output                       ch_valid_en14A,   
output                       ch_valid_en14B,   
output                       ch_valid_en14C,   
output                       ch_valid_en14D,   
output                       ch_valid_en14E,   
output                       ch_valid_en14F,   
output                       ch_valid_en150,   
output                       ch_valid_en151,   
output                       ch_valid_en152,   
output                       ch_valid_en153,   
output                       ch_valid_en154,   
output                       ch_valid_en155,   
output                       ch_valid_en156,   
output                       ch_valid_en157,   
output                       ch_valid_en158,   
output                       ch_valid_en159,   
output                       ch_valid_en15A,   
output                       ch_valid_en15B,   
output                       ch_valid_en15C,   
output                       ch_valid_en15D,   
output                       ch_valid_en15E,   
output                       ch_valid_en15F,   
output                       ch_valid_en160,   
output                       ch_valid_en161,   
output                       ch_valid_en162,   
output                       ch_valid_en163,   
output                       ch_valid_en164,   
output                       ch_valid_en165,   
output                       ch_valid_en166,   
output                       ch_valid_en167,   
output                       ch_valid_en168,   
output                       ch_valid_en169,   
output                       ch_valid_en16A,   
output                       ch_valid_en16B,   
output                       ch_valid_en16C,   
output                       ch_valid_en16D,   
output                       ch_valid_en16E,   
output                       ch_valid_en16F,   
output                       ch_valid_en170,   
output                       ch_valid_en171,   
output                       ch_valid_en172,   
output                       ch_valid_en173,   
output                       ch_valid_en174,   
output                       ch_valid_en175,   
output                       ch_valid_en176,   
output                       ch_valid_en177,   
output                       ch_valid_en178,   
output                       ch_valid_en179,   
output                       ch_valid_en17A,   
output                       ch_valid_en17B,   
output                       ch_valid_en17C,   
output                       ch_valid_en17D,   
output                       ch_valid_en17E,   
output                       ch_valid_en17F,   
output                       ch_valid_en180,   
output                       ch_valid_en181,   
output                       ch_valid_en182,   
output                       ch_valid_en183,   
output                       ch_valid_en184,   
output                       ch_valid_en185,   
output                       ch_valid_en186,   
output                       ch_valid_en187,   
output                       ch_valid_en188,   
output                       ch_valid_en189,   
output                       ch_valid_en18A,   
output                       ch_valid_en18B,   
output                       ch_valid_en18C,   
output                       ch_valid_en18D,   
output                       ch_valid_en18E,   
output                       ch_valid_en18F,   
output                       ch_valid_en190,   
output                       ch_valid_en191,   
output                       ch_valid_en192,   
output                       ch_valid_en193,   
output                       ch_valid_en194,   
output                       ch_valid_en195,   
output                       ch_valid_en196,   
output                       ch_valid_en197,   
output                       ch_valid_en198,   
output                       ch_valid_en199,   
output                       ch_valid_en19A,   
output                       ch_valid_en19B,   
output                       ch_valid_en19C,   
output                       ch_valid_en19D,   
output                       ch_valid_en19E,   
output                       ch_valid_en19F,   
output                       ch_valid_en1A0,   
output                       ch_valid_en1A1,   
output                       ch_valid_en1A2,   
output                       ch_valid_en1A3,   
output                       ch_valid_en1A4,   
output                       ch_valid_en1A5,   
output                       ch_valid_en1A6,   
output                       ch_valid_en1A7,   
output                       ch_valid_en1A8,   
output                       ch_valid_en1A9,   
output                       ch_valid_en1AA,   
output                       ch_valid_en1AB,   
output                       ch_valid_en1AC,   
output                       ch_valid_en1AD,   
output                       ch_valid_en1AE,   
output                       ch_valid_en1AF,   
output                       ch_valid_en1B0,   
output                       ch_valid_en1B1,   
output                       ch_valid_en1B2,   
output                       ch_valid_en1B3,   
output                       ch_valid_en1B4,   
output                       ch_valid_en1B5,   
output                       ch_valid_en1B6,   
output                       ch_valid_en1B7,   
output                       ch_valid_en1B8,   
output                       ch_valid_en1B9,   
output                       ch_valid_en1BA,   
output                       ch_valid_en1BB,   
output                       ch_valid_en1BC,   
output                       ch_valid_en1BD,   
output                       ch_valid_en1BE,   
output                       ch_valid_en1BF,   
output                       ch_valid_en1C0,   
output                       ch_valid_en1C1,   
output                       ch_valid_en1C2,   
output                       ch_valid_en1C3,   
output                       ch_valid_en1C4,   
output                       ch_valid_en1C5,   
output                       ch_valid_en1C6,   
output                       ch_valid_en1C7,   
output                       ch_valid_en1C8,   
output                       ch_valid_en1C9,   
output                       ch_valid_en1CA,   
output                       ch_valid_en1CB,   
output                       ch_valid_en1CC,   
output                       ch_valid_en1CD,   
output                       ch_valid_en1CE,   
output                       ch_valid_en1CF,   
output                       ch_valid_en1D0,   
output                       ch_valid_en1D1,   
output                       ch_valid_en1D2,   
output                       ch_valid_en1D3,   
output                       ch_valid_en1D4,   
output                       ch_valid_en1D5,   
output                       ch_valid_en1D6,   
output                       ch_valid_en1D7,   
output                       ch_valid_en1D8,   
output                       ch_valid_en1D9,   
output                       ch_valid_en1DA,   
output                       ch_valid_en1DB,   
output                       ch_valid_en1DC,   
output                       ch_valid_en1DD,   
output                       ch_valid_en1DE,   
output                       ch_valid_en1DF,   
output                       ch_valid_en1E0,   
output                       ch_valid_en1E1,   
output                       ch_valid_en1E2,   
output                       ch_valid_en1E3,   
output                       ch_valid_en1E4,   
output                       ch_valid_en1E5,   
output                       ch_valid_en1E6,   
output                       ch_valid_en1E7,   
output                       ch_valid_en1E8,   
output                       ch_valid_en1E9,   
output                       ch_valid_en1EA,   
output                       ch_valid_en1EB,   
output                       ch_valid_en1EC,   
output                       ch_valid_en1ED,   
output                       ch_valid_en1EE,   
output                       ch_valid_en1EF,   
output                       ch_valid_en1F0,   
output                       ch_valid_en1F1,   
output                       ch_valid_en1F2,   
output                       ch_valid_en1F3,   
output                       ch_valid_en1F4,   
output                       ch_valid_en1F5,   
output                       ch_valid_en1F6,   
output                       ch_valid_en1F7,   
output                       ch_valid_en1F8,   
output                       ch_valid_en1F9,   
output                       ch_valid_en1FA,   
output                       ch_valid_en1FB,   
output                       ch_valid_en1FC,   
output                       ch_valid_en1FD,   
output                       ch_valid_en1FE,   
output                       ch_valid_en1FF,   
output                       ch_valid_en200,   
output                       ch_valid_en201,   
output                       ch_valid_en202,   
output                       ch_valid_en203,   
output                       ch_valid_en204,   
output                       ch_valid_en205,   
output                       ch_valid_en206,   
output                       ch_valid_en207,   
output                       ch_valid_en208,   
output                       ch_valid_en209,   
output                       ch_valid_en20A,   
output                       ch_valid_en20B,   
output                       ch_valid_en20C,   
output                       ch_valid_en20D,   
output                       ch_valid_en20E,   
output                       ch_valid_en20F,   
output                       ch_valid_en210,   
output                       ch_valid_en211,   
output                       ch_valid_en212,   
output                       ch_valid_en213,   
output                       ch_valid_en214,   
output                       ch_valid_en215,   
output                       ch_valid_en216,   
output                       ch_valid_en217,   
output                       ch_valid_en218,   
output                       ch_valid_en219,   
output                       ch_valid_en21A,   
output                       ch_valid_en21B,   
output                       ch_valid_en21C,   
output                       ch_valid_en21D,   
output                       ch_valid_en21E,   
output                       ch_valid_en21F,   
output                       ch_valid_en220,   
output                       ch_valid_en221,   
output                       ch_valid_en222,   
output                       ch_valid_en223,   
output                       ch_valid_en224,   
output                       ch_valid_en225,   
output                       ch_valid_en226,   
output                       ch_valid_en227,   
output                       ch_valid_en228,   
output                       ch_valid_en229,   
output                       ch_valid_en22A,   
output                       ch_valid_en22B,   
output                       ch_valid_en22C,   
output                       ch_valid_en22D,   
output                       ch_valid_en22E,   
output                       ch_valid_en22F,   
output                       ch_valid_en230,   
output                       ch_valid_en231,   
output                       ch_valid_en232,   
output                       ch_valid_en233,   
output                       ch_valid_en234,   
output                       ch_valid_en235,   
output                       ch_valid_en236,   
output                       ch_valid_en237,   
output                       ch_valid_en238,   
output                       ch_valid_en239,   
output                       ch_valid_en23A,   
output                       ch_valid_en23B,   
output                       ch_valid_en23C,   
output                       ch_valid_en23D,   
output                       ch_valid_en23E,   
output                       ch_valid_en23F
                       
    );
  
 
reg spi_valid_reg; 
  
always @(posedge ref_clk)
begin
	  spi_valid_reg<=spi_valid;	
end 

reg send_en;
reg [9:0] count;
reg cont_en;


always @(posedge ref_clk)
begin
	 if({spi_valid_reg,spi_valid} ==2'b10)
	 begin
		 send_en <= 0;
		 cont_en <= 1;
		 count   <= 10'd0;
	 end
	 if(cont_en == 1 && count<10'd100)
	 begin
		count <= count +1'd1;
		send_en <= 1'b1;
	 end
	 else if(count>=10'd100)
	 begin
	 	 send_en<=0;
	 end
end





//以下保留
assign ch_valid_en000=(  spi_all_data[spi_width-1:spi_width-12]==12'h000 ) ? send_en :0;
assign ch_valid_en001=(  spi_all_data[spi_width-1:spi_width-12]==12'h001 ) ? send_en :0;
assign ch_valid_en002=(  spi_all_data[spi_width-1:spi_width-12]==12'h002 ) ? send_en :0;
//以下可以使用
assign ch_valid_en003=(  spi_all_data[spi_width-1:spi_width-12]==12'h003 ) ? send_en :0; 
assign ch_valid_en004=(  spi_all_data[spi_width-1:spi_width-12]==12'h004 ) ? send_en :0; 
assign ch_valid_en005=(  spi_all_data[spi_width-1:spi_width-12]==12'h005 ) ? send_en :0; 
assign ch_valid_en006=(  spi_all_data[spi_width-1:spi_width-12]==12'h006 ) ? send_en :0; 
assign ch_valid_en007=(  spi_all_data[spi_width-1:spi_width-12]==12'h007 ) ? send_en :0; 
assign ch_valid_en008=(  spi_all_data[spi_width-1:spi_width-12]==12'h008 ) ? send_en :0; 
assign ch_valid_en009=(  spi_all_data[spi_width-1:spi_width-12]==12'h009 ) ? send_en :0; 
assign ch_valid_en00A=(  spi_all_data[spi_width-1:spi_width-12]==12'h00A ) ? send_en :0; 
assign ch_valid_en00B=(  spi_all_data[spi_width-1:spi_width-12]==12'h00B ) ? send_en :0; 
assign ch_valid_en00C=(  spi_all_data[spi_width-1:spi_width-12]==12'h00C ) ? send_en :0; 
assign ch_valid_en00D=(  spi_all_data[spi_width-1:spi_width-12]==12'h00D ) ? send_en :0; 
assign ch_valid_en00E=(  spi_all_data[spi_width-1:spi_width-12]==12'h00E ) ? send_en :0; 
assign ch_valid_en00F=(  spi_all_data[spi_width-1:spi_width-12]==12'h00F ) ? send_en :0; 
assign ch_valid_en010=(  spi_all_data[spi_width-1:spi_width-12]==12'h010 ) ? send_en :0; 
assign ch_valid_en011=(  spi_all_data[spi_width-1:spi_width-12]==12'h011 ) ? send_en :0; 
assign ch_valid_en012=(  spi_all_data[spi_width-1:spi_width-12]==12'h012 ) ? send_en :0; 
assign ch_valid_en013=(  spi_all_data[spi_width-1:spi_width-12]==12'h013 ) ? send_en :0; 
assign ch_valid_en014=(  spi_all_data[spi_width-1:spi_width-12]==12'h014 ) ? send_en :0; 
assign ch_valid_en015=(  spi_all_data[spi_width-1:spi_width-12]==12'h015 ) ? send_en :0; 
assign ch_valid_en016=(  spi_all_data[spi_width-1:spi_width-12]==12'h016 ) ? send_en :0; 
assign ch_valid_en017=(  spi_all_data[spi_width-1:spi_width-12]==12'h017 ) ? send_en :0; 
assign ch_valid_en018=(  spi_all_data[spi_width-1:spi_width-12]==12'h018 ) ? send_en :0; 
assign ch_valid_en019=(  spi_all_data[spi_width-1:spi_width-12]==12'h019 ) ? send_en :0; 
assign ch_valid_en01A=(  spi_all_data[spi_width-1:spi_width-12]==12'h01A ) ? send_en :0; 
assign ch_valid_en01B=(  spi_all_data[spi_width-1:spi_width-12]==12'h01B ) ? send_en :0; 
assign ch_valid_en01C=(  spi_all_data[spi_width-1:spi_width-12]==12'h01C ) ? send_en :0; 
assign ch_valid_en01D=(  spi_all_data[spi_width-1:spi_width-12]==12'h01D ) ? send_en :0; 
assign ch_valid_en01E=(  spi_all_data[spi_width-1:spi_width-12]==12'h01E ) ? send_en :0; 
assign ch_valid_en01F=(  spi_all_data[spi_width-1:spi_width-12]==12'h01F ) ? send_en :0; 
assign ch_valid_en020=(  spi_all_data[spi_width-1:spi_width-12]==12'h020 ) ? send_en :0; 
assign ch_valid_en021=(  spi_all_data[spi_width-1:spi_width-12]==12'h021 ) ? send_en :0; 
assign ch_valid_en022=(  spi_all_data[spi_width-1:spi_width-12]==12'h022 ) ? send_en :0; 
assign ch_valid_en023=(  spi_all_data[spi_width-1:spi_width-12]==12'h023 ) ? send_en :0; 
assign ch_valid_en024=(  spi_all_data[spi_width-1:spi_width-12]==12'h024 ) ? send_en :0; 
assign ch_valid_en025=(  spi_all_data[spi_width-1:spi_width-12]==12'h025 ) ? send_en :0; 
assign ch_valid_en026=(  spi_all_data[spi_width-1:spi_width-12]==12'h026 ) ? send_en :0; 
assign ch_valid_en027=(  spi_all_data[spi_width-1:spi_width-12]==12'h027 ) ? send_en :0; 
assign ch_valid_en028=(  spi_all_data[spi_width-1:spi_width-12]==12'h028 ) ? send_en :0; 
assign ch_valid_en029=(  spi_all_data[spi_width-1:spi_width-12]==12'h029 ) ? send_en :0; 
assign ch_valid_en02A=(  spi_all_data[spi_width-1:spi_width-12]==12'h02A ) ? send_en :0; 
assign ch_valid_en02B=(  spi_all_data[spi_width-1:spi_width-12]==12'h02B ) ? send_en :0; 
assign ch_valid_en02C=(  spi_all_data[spi_width-1:spi_width-12]==12'h02C ) ? send_en :0; 
assign ch_valid_en02D=(  spi_all_data[spi_width-1:spi_width-12]==12'h02D ) ? send_en :0; 
assign ch_valid_en02E=(  spi_all_data[spi_width-1:spi_width-12]==12'h02E ) ? send_en :0; 
assign ch_valid_en02F=(  spi_all_data[spi_width-1:spi_width-12]==12'h02F ) ? send_en :0; 
assign ch_valid_en030=(  spi_all_data[spi_width-1:spi_width-12]==12'h030 ) ? send_en :0; 
assign ch_valid_en031=(  spi_all_data[spi_width-1:spi_width-12]==12'h031 ) ? send_en :0; 
assign ch_valid_en032=(  spi_all_data[spi_width-1:spi_width-12]==12'h032 ) ? send_en :0; 
assign ch_valid_en033=(  spi_all_data[spi_width-1:spi_width-12]==12'h033 ) ? send_en :0; 
assign ch_valid_en034=(  spi_all_data[spi_width-1:spi_width-12]==12'h034 ) ? send_en :0; 
assign ch_valid_en035=(  spi_all_data[spi_width-1:spi_width-12]==12'h035 ) ? send_en :0; 
assign ch_valid_en036=(  spi_all_data[spi_width-1:spi_width-12]==12'h036 ) ? send_en :0; 
assign ch_valid_en037=(  spi_all_data[spi_width-1:spi_width-12]==12'h037 ) ? send_en :0; 
assign ch_valid_en038=(  spi_all_data[spi_width-1:spi_width-12]==12'h038 ) ? send_en :0; 
assign ch_valid_en039=(  spi_all_data[spi_width-1:spi_width-12]==12'h039 ) ? send_en :0; 
assign ch_valid_en03A=(  spi_all_data[spi_width-1:spi_width-12]==12'h03A ) ? send_en :0; 
assign ch_valid_en03B=(  spi_all_data[spi_width-1:spi_width-12]==12'h03B ) ? send_en :0; 
assign ch_valid_en03C=(  spi_all_data[spi_width-1:spi_width-12]==12'h03C ) ? send_en :0; 
assign ch_valid_en03D=(  spi_all_data[spi_width-1:spi_width-12]==12'h03D ) ? send_en :0; 
assign ch_valid_en03E=(  spi_all_data[spi_width-1:spi_width-12]==12'h03E ) ? send_en :0; 
assign ch_valid_en03F=(  spi_all_data[spi_width-1:spi_width-12]==12'h03F ) ? send_en :0; 
assign ch_valid_en040=(  spi_all_data[spi_width-1:spi_width-12]==12'h040 ) ? send_en :0; 
assign ch_valid_en041=(  spi_all_data[spi_width-1:spi_width-12]==12'h041 ) ? send_en :0; 
assign ch_valid_en042=(  spi_all_data[spi_width-1:spi_width-12]==12'h042 ) ? send_en :0; 
assign ch_valid_en043=(  spi_all_data[spi_width-1:spi_width-12]==12'h043 ) ? send_en :0; 
assign ch_valid_en044=(  spi_all_data[spi_width-1:spi_width-12]==12'h044 ) ? send_en :0; 
assign ch_valid_en045=(  spi_all_data[spi_width-1:spi_width-12]==12'h045 ) ? send_en :0; 
assign ch_valid_en046=(  spi_all_data[spi_width-1:spi_width-12]==12'h046 ) ? send_en :0; 
assign ch_valid_en047=(  spi_all_data[spi_width-1:spi_width-12]==12'h047 ) ? send_en :0; 
assign ch_valid_en048=(  spi_all_data[spi_width-1:spi_width-12]==12'h048 ) ? send_en :0; 
assign ch_valid_en049=(  spi_all_data[spi_width-1:spi_width-12]==12'h049 ) ? send_en :0; 
assign ch_valid_en04A=(  spi_all_data[spi_width-1:spi_width-12]==12'h04A ) ? send_en :0; 
assign ch_valid_en04B=(  spi_all_data[spi_width-1:spi_width-12]==12'h04B ) ? send_en :0; 
assign ch_valid_en04C=(  spi_all_data[spi_width-1:spi_width-12]==12'h04C ) ? send_en :0; 
assign ch_valid_en04D=(  spi_all_data[spi_width-1:spi_width-12]==12'h04D ) ? send_en :0; 
assign ch_valid_en04E=(  spi_all_data[spi_width-1:spi_width-12]==12'h04E ) ? send_en :0; 
assign ch_valid_en04F=(  spi_all_data[spi_width-1:spi_width-12]==12'h04F ) ? send_en :0;   
assign ch_valid_en050=(  spi_all_data[spi_width-1:spi_width-12]==12'h050 ) ? send_en :0;
assign ch_valid_en051=(  spi_all_data[spi_width-1:spi_width-12]==12'h051 ) ? send_en :0;   
assign ch_valid_en052=(  spi_all_data[spi_width-1:spi_width-12]==12'h052 ) ? send_en :0;   
assign ch_valid_en053=(  spi_all_data[spi_width-1:spi_width-12]==12'h053 ) ? send_en :0;   
assign ch_valid_en054=(  spi_all_data[spi_width-1:spi_width-12]==12'h054 ) ? send_en :0;   
assign ch_valid_en055=(  spi_all_data[spi_width-1:spi_width-12]==12'h055 ) ? send_en :0;   
assign ch_valid_en056=(  spi_all_data[spi_width-1:spi_width-12]==12'h056 ) ? send_en :0;   
assign ch_valid_en057=(  spi_all_data[spi_width-1:spi_width-12]==12'h057 ) ? send_en :0;   
assign ch_valid_en058=(  spi_all_data[spi_width-1:spi_width-12]==12'h058 ) ? send_en :0;   
assign ch_valid_en059=(  spi_all_data[spi_width-1:spi_width-12]==12'h059 ) ? send_en :0;   
assign ch_valid_en05A=(  spi_all_data[spi_width-1:spi_width-12]==12'h05A ) ? send_en :0;   
assign ch_valid_en05B=(  spi_all_data[spi_width-1:spi_width-12]==12'h05B ) ? send_en :0;   
assign ch_valid_en05C=(  spi_all_data[spi_width-1:spi_width-12]==12'h05C ) ? send_en :0;   
assign ch_valid_en05D=(  spi_all_data[spi_width-1:spi_width-12]==12'h05D ) ? send_en :0;   
assign ch_valid_en05E=(  spi_all_data[spi_width-1:spi_width-12]==12'h05E ) ? send_en :0;   
assign ch_valid_en05F=(  spi_all_data[spi_width-1:spi_width-12]==12'h05F ) ? send_en :0;   
assign ch_valid_en060=(  spi_all_data[spi_width-1:spi_width-12]==12'h060 ) ? send_en :0;   
assign ch_valid_en061=(  spi_all_data[spi_width-1:spi_width-12]==12'h061 ) ? send_en :0;   
assign ch_valid_en062=(  spi_all_data[spi_width-1:spi_width-12]==12'h062 ) ? send_en :0;   
assign ch_valid_en063=(  spi_all_data[spi_width-1:spi_width-12]==12'h063 ) ? send_en :0;   
assign ch_valid_en064=(  spi_all_data[spi_width-1:spi_width-12]==12'h064 ) ? send_en :0;   
assign ch_valid_en065=(  spi_all_data[spi_width-1:spi_width-12]==12'h065 ) ? send_en :0;   
assign ch_valid_en066=(  spi_all_data[spi_width-1:spi_width-12]==12'h066 ) ? send_en :0;   
assign ch_valid_en067=(  spi_all_data[spi_width-1:spi_width-12]==12'h067 ) ? send_en :0;   
assign ch_valid_en068=(  spi_all_data[spi_width-1:spi_width-12]==12'h068 ) ? send_en :0;   
assign ch_valid_en069=(  spi_all_data[spi_width-1:spi_width-12]==12'h069 ) ? send_en :0;   
assign ch_valid_en06A=(  spi_all_data[spi_width-1:spi_width-12]==12'h06A ) ? send_en :0;   
assign ch_valid_en06B=(  spi_all_data[spi_width-1:spi_width-12]==12'h06B ) ? send_en :0;   
assign ch_valid_en06C=(  spi_all_data[spi_width-1:spi_width-12]==12'h06C ) ? send_en :0;   
assign ch_valid_en06D=(  spi_all_data[spi_width-1:spi_width-12]==12'h06D ) ? send_en :0;   
assign ch_valid_en06E=(  spi_all_data[spi_width-1:spi_width-12]==12'h06E ) ? send_en :0;   
assign ch_valid_en06F=(  spi_all_data[spi_width-1:spi_width-12]==12'h06F ) ? send_en :0;   
assign ch_valid_en070=(  spi_all_data[spi_width-1:spi_width-12]==12'h070 ) ? send_en :0;   
assign ch_valid_en071=(  spi_all_data[spi_width-1:spi_width-12]==12'h071 ) ? send_en :0;   
assign ch_valid_en072=(  spi_all_data[spi_width-1:spi_width-12]==12'h072 ) ? send_en :0;   
assign ch_valid_en073=(  spi_all_data[spi_width-1:spi_width-12]==12'h073 ) ? send_en :0;   
assign ch_valid_en074=(  spi_all_data[spi_width-1:spi_width-12]==12'h074 ) ? send_en :0;   
assign ch_valid_en075=(  spi_all_data[spi_width-1:spi_width-12]==12'h075 ) ? send_en :0;   
assign ch_valid_en076=(  spi_all_data[spi_width-1:spi_width-12]==12'h076 ) ? send_en :0;   
assign ch_valid_en077=(  spi_all_data[spi_width-1:spi_width-12]==12'h077 ) ? send_en :0;   
assign ch_valid_en078=(  spi_all_data[spi_width-1:spi_width-12]==12'h078 ) ? send_en :0;   
assign ch_valid_en079=(  spi_all_data[spi_width-1:spi_width-12]==12'h079 ) ? send_en :0;   
assign ch_valid_en07A=(  spi_all_data[spi_width-1:spi_width-12]==12'h07A ) ? send_en :0;   
assign ch_valid_en07B=(  spi_all_data[spi_width-1:spi_width-12]==12'h07B ) ? send_en :0;   
assign ch_valid_en07C=(  spi_all_data[spi_width-1:spi_width-12]==12'h07C ) ? send_en :0;   
assign ch_valid_en07D=(  spi_all_data[spi_width-1:spi_width-12]==12'h07D ) ? send_en :0;   
assign ch_valid_en07E=(  spi_all_data[spi_width-1:spi_width-12]==12'h07E ) ? send_en :0;   
assign ch_valid_en07F=(  spi_all_data[spi_width-1:spi_width-12]==12'h07F ) ? send_en :0;   
assign ch_valid_en080=(  spi_all_data[spi_width-1:spi_width-12]==12'h080 ) ? send_en :0;   
assign ch_valid_en081=(  spi_all_data[spi_width-1:spi_width-12]==12'h081 ) ? send_en :0;   
assign ch_valid_en082=(  spi_all_data[spi_width-1:spi_width-12]==12'h082 ) ? send_en :0;   
assign ch_valid_en083=(  spi_all_data[spi_width-1:spi_width-12]==12'h083 ) ? send_en :0;   
assign ch_valid_en084=(  spi_all_data[spi_width-1:spi_width-12]==12'h084 ) ? send_en :0;   
assign ch_valid_en085=(  spi_all_data[spi_width-1:spi_width-12]==12'h085 ) ? send_en :0;   
assign ch_valid_en086=(  spi_all_data[spi_width-1:spi_width-12]==12'h086 ) ? send_en :0;   
assign ch_valid_en087=(  spi_all_data[spi_width-1:spi_width-12]==12'h087 ) ? send_en :0;   
assign ch_valid_en088=(  spi_all_data[spi_width-1:spi_width-12]==12'h088 ) ? send_en :0;   
assign ch_valid_en089=(  spi_all_data[spi_width-1:spi_width-12]==12'h089 ) ? send_en :0;   
assign ch_valid_en08A=(  spi_all_data[spi_width-1:spi_width-12]==12'h08A ) ? send_en :0;   
assign ch_valid_en08B=(  spi_all_data[spi_width-1:spi_width-12]==12'h08B ) ? send_en :0;   
assign ch_valid_en08C=(  spi_all_data[spi_width-1:spi_width-12]==12'h08C ) ? send_en :0;   
assign ch_valid_en08D=(  spi_all_data[spi_width-1:spi_width-12]==12'h08D ) ? send_en :0;   
assign ch_valid_en08E=(  spi_all_data[spi_width-1:spi_width-12]==12'h08E ) ? send_en :0;   
assign ch_valid_en08F=(  spi_all_data[spi_width-1:spi_width-12]==12'h08F ) ? send_en :0;   
assign ch_valid_en090=(  spi_all_data[spi_width-1:spi_width-12]==12'h090 ) ? send_en :0;   
assign ch_valid_en091=(  spi_all_data[spi_width-1:spi_width-12]==12'h091 ) ? send_en :0;   
assign ch_valid_en092=(  spi_all_data[spi_width-1:spi_width-12]==12'h092 ) ? send_en :0;   
assign ch_valid_en093=(  spi_all_data[spi_width-1:spi_width-12]==12'h093 ) ? send_en :0;   
assign ch_valid_en094=(  spi_all_data[spi_width-1:spi_width-12]==12'h094 ) ? send_en :0;   
assign ch_valid_en095=(  spi_all_data[spi_width-1:spi_width-12]==12'h095 ) ? send_en :0;   
assign ch_valid_en096=(  spi_all_data[spi_width-1:spi_width-12]==12'h096 ) ? send_en :0;   
assign ch_valid_en097=(  spi_all_data[spi_width-1:spi_width-12]==12'h097 ) ? send_en :0;   
assign ch_valid_en098=(  spi_all_data[spi_width-1:spi_width-12]==12'h098 ) ? send_en :0;   
assign ch_valid_en099=(  spi_all_data[spi_width-1:spi_width-12]==12'h099 ) ? send_en :0;   
assign ch_valid_en09A=(  spi_all_data[spi_width-1:spi_width-12]==12'h09A ) ? send_en :0;   
assign ch_valid_en09B=(  spi_all_data[spi_width-1:spi_width-12]==12'h09B ) ? send_en :0;   
assign ch_valid_en09C=(  spi_all_data[spi_width-1:spi_width-12]==12'h09C ) ? send_en :0;   
assign ch_valid_en09D=(  spi_all_data[spi_width-1:spi_width-12]==12'h09D ) ? send_en :0;   
assign ch_valid_en09E=(  spi_all_data[spi_width-1:spi_width-12]==12'h09E ) ? send_en :0;   
assign ch_valid_en09F=(  spi_all_data[spi_width-1:spi_width-12]==12'h09F ) ? send_en :0;   
assign ch_valid_en0A0=(  spi_all_data[spi_width-1:spi_width-12]==12'h0A0 ) ? send_en :0;   
assign ch_valid_en0A1=(  spi_all_data[spi_width-1:spi_width-12]==12'h0A1 ) ? send_en :0;   
assign ch_valid_en0A2=(  spi_all_data[spi_width-1:spi_width-12]==12'h0A2 ) ? send_en :0;   
assign ch_valid_en0A3=(  spi_all_data[spi_width-1:spi_width-12]==12'h0A3 ) ? send_en :0;   
assign ch_valid_en0A4=(  spi_all_data[spi_width-1:spi_width-12]==12'h0A4 ) ? send_en :0;   
assign ch_valid_en0A5=(  spi_all_data[spi_width-1:spi_width-12]==12'h0A5 ) ? send_en :0;   
assign ch_valid_en0A6=(  spi_all_data[spi_width-1:spi_width-12]==12'h0A6 ) ? send_en :0;   
assign ch_valid_en0A7=(  spi_all_data[spi_width-1:spi_width-12]==12'h0A7 ) ? send_en :0;   
assign ch_valid_en0A8=(  spi_all_data[spi_width-1:spi_width-12]==12'h0A8 ) ? send_en :0;   
assign ch_valid_en0A9=(  spi_all_data[spi_width-1:spi_width-12]==12'h0A9 ) ? send_en :0;   
assign ch_valid_en0AA=(  spi_all_data[spi_width-1:spi_width-12]==12'h0AA ) ? send_en :0;   
assign ch_valid_en0AB=(  spi_all_data[spi_width-1:spi_width-12]==12'h0AB ) ? send_en :0;   
assign ch_valid_en0AC=(  spi_all_data[spi_width-1:spi_width-12]==12'h0AC ) ? send_en :0;   
assign ch_valid_en0AD=(  spi_all_data[spi_width-1:spi_width-12]==12'h0AD ) ? send_en :0;   
assign ch_valid_en0AE=(  spi_all_data[spi_width-1:spi_width-12]==12'h0AE ) ? send_en :0;   
assign ch_valid_en0AF=(  spi_all_data[spi_width-1:spi_width-12]==12'h0AF ) ? send_en :0;   
assign ch_valid_en0B0=(  spi_all_data[spi_width-1:spi_width-12]==12'h0B0 ) ? send_en :0;   
assign ch_valid_en0B1=(  spi_all_data[spi_width-1:spi_width-12]==12'h0B1 ) ? send_en :0;   
assign ch_valid_en0B2=(  spi_all_data[spi_width-1:spi_width-12]==12'h0B2 ) ? send_en :0;   
assign ch_valid_en0B3=(  spi_all_data[spi_width-1:spi_width-12]==12'h0B3 ) ? send_en :0;   
assign ch_valid_en0B4=(  spi_all_data[spi_width-1:spi_width-12]==12'h0B4 ) ? send_en :0;   
assign ch_valid_en0B5=(  spi_all_data[spi_width-1:spi_width-12]==12'h0B5 ) ? send_en :0;   
assign ch_valid_en0B6=(  spi_all_data[spi_width-1:spi_width-12]==12'h0B6 ) ? send_en :0;   
assign ch_valid_en0B7=(  spi_all_data[spi_width-1:spi_width-12]==12'h0B7 ) ? send_en :0;   
assign ch_valid_en0B8=(  spi_all_data[spi_width-1:spi_width-12]==12'h0B8 ) ? send_en :0;   
assign ch_valid_en0B9=(  spi_all_data[spi_width-1:spi_width-12]==12'h0B9 ) ? send_en :0;   
assign ch_valid_en0BA=(  spi_all_data[spi_width-1:spi_width-12]==12'h0BA ) ? send_en :0;   
assign ch_valid_en0BB=(  spi_all_data[spi_width-1:spi_width-12]==12'h0BB ) ? send_en :0;   
assign ch_valid_en0BC=(  spi_all_data[spi_width-1:spi_width-12]==12'h0BC ) ? send_en :0;   
assign ch_valid_en0BD=(  spi_all_data[spi_width-1:spi_width-12]==12'h0BD ) ? send_en :0;   
assign ch_valid_en0BE=(  spi_all_data[spi_width-1:spi_width-12]==12'h0BE ) ? send_en :0;   
assign ch_valid_en0BF=(  spi_all_data[spi_width-1:spi_width-12]==12'h0BF ) ? send_en :0;   
assign ch_valid_en0C0=(  spi_all_data[spi_width-1:spi_width-12]==12'h0C0 ) ? send_en :0;   
assign ch_valid_en0C1=(  spi_all_data[spi_width-1:spi_width-12]==12'h0C1 ) ? send_en :0;   
assign ch_valid_en0C2=(  spi_all_data[spi_width-1:spi_width-12]==12'h0C2 ) ? send_en :0;   
assign ch_valid_en0C3=(  spi_all_data[spi_width-1:spi_width-12]==12'h0C3 ) ? send_en :0;   
assign ch_valid_en0C4=(  spi_all_data[spi_width-1:spi_width-12]==12'h0C4 ) ? send_en :0;   
assign ch_valid_en0C5=(  spi_all_data[spi_width-1:spi_width-12]==12'h0C5 ) ? send_en :0;   
assign ch_valid_en0C6=(  spi_all_data[spi_width-1:spi_width-12]==12'h0C6 ) ? send_en :0;   
assign ch_valid_en0C7=(  spi_all_data[spi_width-1:spi_width-12]==12'h0C7 ) ? send_en :0;   
assign ch_valid_en0C8=(  spi_all_data[spi_width-1:spi_width-12]==12'h0C8 ) ? send_en :0;   
assign ch_valid_en0C9=(  spi_all_data[spi_width-1:spi_width-12]==12'h0C9 ) ? send_en :0;   
assign ch_valid_en0CA=(  spi_all_data[spi_width-1:spi_width-12]==12'h0CA ) ? send_en :0;   
assign ch_valid_en0CB=(  spi_all_data[spi_width-1:spi_width-12]==12'h0CB ) ? send_en :0;   
assign ch_valid_en0CC=(  spi_all_data[spi_width-1:spi_width-12]==12'h0CC ) ? send_en :0;   
assign ch_valid_en0CD=(  spi_all_data[spi_width-1:spi_width-12]==12'h0CD ) ? send_en :0;   
assign ch_valid_en0CE=(  spi_all_data[spi_width-1:spi_width-12]==12'h0CE ) ? send_en :0;   
assign ch_valid_en0CF=(  spi_all_data[spi_width-1:spi_width-12]==12'h0CF ) ? send_en :0;   
assign ch_valid_en0D0=(  spi_all_data[spi_width-1:spi_width-12]==12'h0D0 ) ? send_en :0;   
assign ch_valid_en0D1=(  spi_all_data[spi_width-1:spi_width-12]==12'h0D1 ) ? send_en :0;   
assign ch_valid_en0D2=(  spi_all_data[spi_width-1:spi_width-12]==12'h0D2 ) ? send_en :0;   
assign ch_valid_en0D3=(  spi_all_data[spi_width-1:spi_width-12]==12'h0D3 ) ? send_en :0;   
assign ch_valid_en0D4=(  spi_all_data[spi_width-1:spi_width-12]==12'h0D4 ) ? send_en :0;   
assign ch_valid_en0D5=(  spi_all_data[spi_width-1:spi_width-12]==12'h0D5 ) ? send_en :0;   
assign ch_valid_en0D6=(  spi_all_data[spi_width-1:spi_width-12]==12'h0D6 ) ? send_en :0;   
assign ch_valid_en0D7=(  spi_all_data[spi_width-1:spi_width-12]==12'h0D7 ) ? send_en :0;   
assign ch_valid_en0D8=(  spi_all_data[spi_width-1:spi_width-12]==12'h0D8 ) ? send_en :0;   
assign ch_valid_en0D9=(  spi_all_data[spi_width-1:spi_width-12]==12'h0D9 ) ? send_en :0;   
assign ch_valid_en0DA=(  spi_all_data[spi_width-1:spi_width-12]==12'h0DA ) ? send_en :0;   
assign ch_valid_en0DB=(  spi_all_data[spi_width-1:spi_width-12]==12'h0DB ) ? send_en :0;   
assign ch_valid_en0DC=(  spi_all_data[spi_width-1:spi_width-12]==12'h0DC ) ? send_en :0;   
assign ch_valid_en0DD=(  spi_all_data[spi_width-1:spi_width-12]==12'h0DD ) ? send_en :0;   
assign ch_valid_en0DE=(  spi_all_data[spi_width-1:spi_width-12]==12'h0DE ) ? send_en :0;   
assign ch_valid_en0DF=(  spi_all_data[spi_width-1:spi_width-12]==12'h0DF ) ? send_en :0;   
assign ch_valid_en0E0=(  spi_all_data[spi_width-1:spi_width-12]==12'h0E0 ) ? send_en :0;   
assign ch_valid_en0E1=(  spi_all_data[spi_width-1:spi_width-12]==12'h0E1 ) ? send_en :0;   
assign ch_valid_en0E2=(  spi_all_data[spi_width-1:spi_width-12]==12'h0E2 ) ? send_en :0;   
assign ch_valid_en0E3=(  spi_all_data[spi_width-1:spi_width-12]==12'h0E3 ) ? send_en :0;   
assign ch_valid_en0E4=(  spi_all_data[spi_width-1:spi_width-12]==12'h0E4 ) ? send_en :0;   
assign ch_valid_en0E5=(  spi_all_data[spi_width-1:spi_width-12]==12'h0E5 ) ? send_en :0;   
assign ch_valid_en0E6=(  spi_all_data[spi_width-1:spi_width-12]==12'h0E6 ) ? send_en :0;   
assign ch_valid_en0E7=(  spi_all_data[spi_width-1:spi_width-12]==12'h0E7 ) ? send_en :0;   
assign ch_valid_en0E8=(  spi_all_data[spi_width-1:spi_width-12]==12'h0E8 ) ? send_en :0;   
assign ch_valid_en0E9=(  spi_all_data[spi_width-1:spi_width-12]==12'h0E9 ) ? send_en :0;   
assign ch_valid_en0EA=(  spi_all_data[spi_width-1:spi_width-12]==12'h0EA ) ? send_en :0;   
assign ch_valid_en0EB=(  spi_all_data[spi_width-1:spi_width-12]==12'h0EB ) ? send_en :0;   
assign ch_valid_en0EC=(  spi_all_data[spi_width-1:spi_width-12]==12'h0EC ) ? send_en :0;   
assign ch_valid_en0ED=(  spi_all_data[spi_width-1:spi_width-12]==12'h0ED ) ? send_en :0;   
assign ch_valid_en0EE=(  spi_all_data[spi_width-1:spi_width-12]==12'h0EE ) ? send_en :0;   
assign ch_valid_en0EF=(  spi_all_data[spi_width-1:spi_width-12]==12'h0EF ) ? send_en :0;   
assign ch_valid_en0F0=(  spi_all_data[spi_width-1:spi_width-12]==12'h0F0 ) ? send_en :0;   
assign ch_valid_en0F1=(  spi_all_data[spi_width-1:spi_width-12]==12'h0F1 ) ? send_en :0;   
assign ch_valid_en0F2=(  spi_all_data[spi_width-1:spi_width-12]==12'h0F2 ) ? send_en :0;   
assign ch_valid_en0F3=(  spi_all_data[spi_width-1:spi_width-12]==12'h0F3 ) ? send_en :0;   
assign ch_valid_en0F4=(  spi_all_data[spi_width-1:spi_width-12]==12'h0F4 ) ? send_en :0;   
assign ch_valid_en0F5=(  spi_all_data[spi_width-1:spi_width-12]==12'h0F5 ) ? send_en :0;   
assign ch_valid_en0F6=(  spi_all_data[spi_width-1:spi_width-12]==12'h0F6 ) ? send_en :0;   
assign ch_valid_en0F7=(  spi_all_data[spi_width-1:spi_width-12]==12'h0F7 ) ? send_en :0;   
assign ch_valid_en0F8=(  spi_all_data[spi_width-1:spi_width-12]==12'h0F8 ) ? send_en :0;   
assign ch_valid_en0F9=(  spi_all_data[spi_width-1:spi_width-12]==12'h0F9 ) ? send_en :0;   
assign ch_valid_en0FA=(  spi_all_data[spi_width-1:spi_width-12]==12'h0FA ) ? send_en :0;   
assign ch_valid_en0FB=(  spi_all_data[spi_width-1:spi_width-12]==12'h0FB ) ? send_en :0;   
assign ch_valid_en0FC=(  spi_all_data[spi_width-1:spi_width-12]==12'h0FC ) ? send_en :0;   
assign ch_valid_en0FD=(  spi_all_data[spi_width-1:spi_width-12]==12'h0FD ) ? send_en :0;   
assign ch_valid_en0FE=(  spi_all_data[spi_width-1:spi_width-12]==12'h0FE ) ? send_en :0;   
assign ch_valid_en0FF=(  spi_all_data[spi_width-1:spi_width-12]==12'h0FF ) ? send_en :0;   
assign ch_valid_en100=(  spi_all_data[spi_width-1:spi_width-12]==12'h100 ) ? send_en :0;   
assign ch_valid_en101=(  spi_all_data[spi_width-1:spi_width-12]==12'h101 ) ? send_en :0;   
assign ch_valid_en102=(  spi_all_data[spi_width-1:spi_width-12]==12'h102 ) ? send_en :0;   
assign ch_valid_en103=(  spi_all_data[spi_width-1:spi_width-12]==12'h103 ) ? send_en :0;   
assign ch_valid_en104=(  spi_all_data[spi_width-1:spi_width-12]==12'h104 ) ? send_en :0;   
assign ch_valid_en105=(  spi_all_data[spi_width-1:spi_width-12]==12'h105 ) ? send_en :0;   
assign ch_valid_en106=(  spi_all_data[spi_width-1:spi_width-12]==12'h106 ) ? send_en :0;   
assign ch_valid_en107=(  spi_all_data[spi_width-1:spi_width-12]==12'h107 ) ? send_en :0;   
assign ch_valid_en108=(  spi_all_data[spi_width-1:spi_width-12]==12'h108 ) ? send_en :0;   
assign ch_valid_en109=(  spi_all_data[spi_width-1:spi_width-12]==12'h109 ) ? send_en :0;   
assign ch_valid_en10A=(  spi_all_data[spi_width-1:spi_width-12]==12'h10A ) ? send_en :0;   
assign ch_valid_en10B=(  spi_all_data[spi_width-1:spi_width-12]==12'h10B ) ? send_en :0;   
assign ch_valid_en10C=(  spi_all_data[spi_width-1:spi_width-12]==12'h10C ) ? send_en :0;   
assign ch_valid_en10D=(  spi_all_data[spi_width-1:spi_width-12]==12'h10D ) ? send_en :0;   
assign ch_valid_en10E=(  spi_all_data[spi_width-1:spi_width-12]==12'h10E ) ? send_en :0;   
assign ch_valid_en10F=(  spi_all_data[spi_width-1:spi_width-12]==12'h10F ) ? send_en :0;   
assign ch_valid_en110=(  spi_all_data[spi_width-1:spi_width-12]==12'h110 ) ? send_en :0;   
assign ch_valid_en111=(  spi_all_data[spi_width-1:spi_width-12]==12'h111 ) ? send_en :0;   
assign ch_valid_en112=(  spi_all_data[spi_width-1:spi_width-12]==12'h112 ) ? send_en :0;   
assign ch_valid_en113=(  spi_all_data[spi_width-1:spi_width-12]==12'h113 ) ? send_en :0;   
assign ch_valid_en114=(  spi_all_data[spi_width-1:spi_width-12]==12'h114 ) ? send_en :0;   
assign ch_valid_en115=(  spi_all_data[spi_width-1:spi_width-12]==12'h115 ) ? send_en :0;   
assign ch_valid_en116=(  spi_all_data[spi_width-1:spi_width-12]==12'h116 ) ? send_en :0;   
assign ch_valid_en117=(  spi_all_data[spi_width-1:spi_width-12]==12'h117 ) ? send_en :0;   
assign ch_valid_en118=(  spi_all_data[spi_width-1:spi_width-12]==12'h118 ) ? send_en :0;   
assign ch_valid_en119=(  spi_all_data[spi_width-1:spi_width-12]==12'h119 ) ? send_en :0;   
assign ch_valid_en11A=(  spi_all_data[spi_width-1:spi_width-12]==12'h11A ) ? send_en :0;   
assign ch_valid_en11B=(  spi_all_data[spi_width-1:spi_width-12]==12'h11B ) ? send_en :0;   
assign ch_valid_en11C=(  spi_all_data[spi_width-1:spi_width-12]==12'h11C ) ? send_en :0;   
assign ch_valid_en11D=(  spi_all_data[spi_width-1:spi_width-12]==12'h11D ) ? send_en :0;   
assign ch_valid_en11E=(  spi_all_data[spi_width-1:spi_width-12]==12'h11E ) ? send_en :0;   
assign ch_valid_en11F=(  spi_all_data[spi_width-1:spi_width-12]==12'h11F ) ? send_en :0;   
assign ch_valid_en120=(  spi_all_data[spi_width-1:spi_width-12]==12'h120 ) ? send_en :0;   
assign ch_valid_en121=(  spi_all_data[spi_width-1:spi_width-12]==12'h121 ) ? send_en :0;   
assign ch_valid_en122=(  spi_all_data[spi_width-1:spi_width-12]==12'h122 ) ? send_en :0;   
assign ch_valid_en123=(  spi_all_data[spi_width-1:spi_width-12]==12'h123 ) ? send_en :0;   
assign ch_valid_en124=(  spi_all_data[spi_width-1:spi_width-12]==12'h124 ) ? send_en :0;   
assign ch_valid_en125=(  spi_all_data[spi_width-1:spi_width-12]==12'h125 ) ? send_en :0;   
assign ch_valid_en126=(  spi_all_data[spi_width-1:spi_width-12]==12'h126 ) ? send_en :0;   
assign ch_valid_en127=(  spi_all_data[spi_width-1:spi_width-12]==12'h127 ) ? send_en :0;   
assign ch_valid_en128=(  spi_all_data[spi_width-1:spi_width-12]==12'h128 ) ? send_en :0;   
assign ch_valid_en129=(  spi_all_data[spi_width-1:spi_width-12]==12'h129 ) ? send_en :0;   
assign ch_valid_en12A=(  spi_all_data[spi_width-1:spi_width-12]==12'h12A ) ? send_en :0;   
assign ch_valid_en12B=(  spi_all_data[spi_width-1:spi_width-12]==12'h12B ) ? send_en :0;   
assign ch_valid_en12C=(  spi_all_data[spi_width-1:spi_width-12]==12'h12C ) ? send_en :0;   
assign ch_valid_en12D=(  spi_all_data[spi_width-1:spi_width-12]==12'h12D ) ? send_en :0;   
assign ch_valid_en12E=(  spi_all_data[spi_width-1:spi_width-12]==12'h12E ) ? send_en :0;   
assign ch_valid_en12F=(  spi_all_data[spi_width-1:spi_width-12]==12'h12F ) ? send_en :0;   
assign ch_valid_en130=(  spi_all_data[spi_width-1:spi_width-12]==12'h130 ) ? send_en :0;   
assign ch_valid_en131=(  spi_all_data[spi_width-1:spi_width-12]==12'h131 ) ? send_en :0;   
assign ch_valid_en132=(  spi_all_data[spi_width-1:spi_width-12]==12'h132 ) ? send_en :0;   
assign ch_valid_en133=(  spi_all_data[spi_width-1:spi_width-12]==12'h133 ) ? send_en :0;   
assign ch_valid_en134=(  spi_all_data[spi_width-1:spi_width-12]==12'h134 ) ? send_en :0;   
assign ch_valid_en135=(  spi_all_data[spi_width-1:spi_width-12]==12'h135 ) ? send_en :0;   
assign ch_valid_en136=(  spi_all_data[spi_width-1:spi_width-12]==12'h136 ) ? send_en :0;   
assign ch_valid_en137=(  spi_all_data[spi_width-1:spi_width-12]==12'h137 ) ? send_en :0;   
assign ch_valid_en138=(  spi_all_data[spi_width-1:spi_width-12]==12'h138 ) ? send_en :0;   
assign ch_valid_en139=(  spi_all_data[spi_width-1:spi_width-12]==12'h139 ) ? send_en :0;   
assign ch_valid_en13A=(  spi_all_data[spi_width-1:spi_width-12]==12'h13A ) ? send_en :0;   
assign ch_valid_en13B=(  spi_all_data[spi_width-1:spi_width-12]==12'h13B ) ? send_en :0;   
assign ch_valid_en13C=(  spi_all_data[spi_width-1:spi_width-12]==12'h13C ) ? send_en :0;   
assign ch_valid_en13D=(  spi_all_data[spi_width-1:spi_width-12]==12'h13D ) ? send_en :0;   
assign ch_valid_en13E=(  spi_all_data[spi_width-1:spi_width-12]==12'h13E ) ? send_en :0;   
assign ch_valid_en13F=(  spi_all_data[spi_width-1:spi_width-12]==12'h13F ) ? send_en :0;   
assign ch_valid_en140=(  spi_all_data[spi_width-1:spi_width-12]==12'h140 ) ? send_en :0;   
assign ch_valid_en141=(  spi_all_data[spi_width-1:spi_width-12]==12'h141 ) ? send_en :0;   
assign ch_valid_en142=(  spi_all_data[spi_width-1:spi_width-12]==12'h142 ) ? send_en :0;   
assign ch_valid_en143=(  spi_all_data[spi_width-1:spi_width-12]==12'h143 ) ? send_en :0;   
assign ch_valid_en144=(  spi_all_data[spi_width-1:spi_width-12]==12'h144 ) ? send_en :0;   
assign ch_valid_en145=(  spi_all_data[spi_width-1:spi_width-12]==12'h145 ) ? send_en :0;   
assign ch_valid_en146=(  spi_all_data[spi_width-1:spi_width-12]==12'h146 ) ? send_en :0;   
assign ch_valid_en147=(  spi_all_data[spi_width-1:spi_width-12]==12'h147 ) ? send_en :0;   
assign ch_valid_en148=(  spi_all_data[spi_width-1:spi_width-12]==12'h148 ) ? send_en :0;   
assign ch_valid_en149=(  spi_all_data[spi_width-1:spi_width-12]==12'h149 ) ? send_en :0;   
assign ch_valid_en14A=(  spi_all_data[spi_width-1:spi_width-12]==12'h14A ) ? send_en :0;   
assign ch_valid_en14B=(  spi_all_data[spi_width-1:spi_width-12]==12'h14B ) ? send_en :0;   
assign ch_valid_en14C=(  spi_all_data[spi_width-1:spi_width-12]==12'h14C ) ? send_en :0;   
assign ch_valid_en14D=(  spi_all_data[spi_width-1:spi_width-12]==12'h14D ) ? send_en :0;   
assign ch_valid_en14E=(  spi_all_data[spi_width-1:spi_width-12]==12'h14E ) ? send_en :0;   
assign ch_valid_en14F=(  spi_all_data[spi_width-1:spi_width-12]==12'h14F ) ? send_en :0;   
assign ch_valid_en150=(  spi_all_data[spi_width-1:spi_width-12]==12'h150 ) ? send_en :0;   
assign ch_valid_en151=(  spi_all_data[spi_width-1:spi_width-12]==12'h151 ) ? send_en :0;   
assign ch_valid_en152=(  spi_all_data[spi_width-1:spi_width-12]==12'h152 ) ? send_en :0;   
assign ch_valid_en153=(  spi_all_data[spi_width-1:spi_width-12]==12'h153 ) ? send_en :0;   
assign ch_valid_en154=(  spi_all_data[spi_width-1:spi_width-12]==12'h154 ) ? send_en :0;   
assign ch_valid_en155=(  spi_all_data[spi_width-1:spi_width-12]==12'h155 ) ? send_en :0;   
assign ch_valid_en156=(  spi_all_data[spi_width-1:spi_width-12]==12'h156 ) ? send_en :0;   
assign ch_valid_en157=(  spi_all_data[spi_width-1:spi_width-12]==12'h157 ) ? send_en :0;   
assign ch_valid_en158=(  spi_all_data[spi_width-1:spi_width-12]==12'h158 ) ? send_en :0;   
assign ch_valid_en159=(  spi_all_data[spi_width-1:spi_width-12]==12'h159 ) ? send_en :0;   
assign ch_valid_en15A=(  spi_all_data[spi_width-1:spi_width-12]==12'h15A ) ? send_en :0;   
assign ch_valid_en15B=(  spi_all_data[spi_width-1:spi_width-12]==12'h15B ) ? send_en :0;   
assign ch_valid_en15C=(  spi_all_data[spi_width-1:spi_width-12]==12'h15C ) ? send_en :0;   
assign ch_valid_en15D=(  spi_all_data[spi_width-1:spi_width-12]==12'h15D ) ? send_en :0;   
assign ch_valid_en15E=(  spi_all_data[spi_width-1:spi_width-12]==12'h15E ) ? send_en :0;   
assign ch_valid_en15F=(  spi_all_data[spi_width-1:spi_width-12]==12'h15F ) ? send_en :0;   
assign ch_valid_en160=(  spi_all_data[spi_width-1:spi_width-12]==12'h160 ) ? send_en :0;   
assign ch_valid_en161=(  spi_all_data[spi_width-1:spi_width-12]==12'h161 ) ? send_en :0;   
assign ch_valid_en162=(  spi_all_data[spi_width-1:spi_width-12]==12'h162 ) ? send_en :0;   
assign ch_valid_en163=(  spi_all_data[spi_width-1:spi_width-12]==12'h163 ) ? send_en :0;   
assign ch_valid_en164=(  spi_all_data[spi_width-1:spi_width-12]==12'h164 ) ? send_en :0;   
assign ch_valid_en165=(  spi_all_data[spi_width-1:spi_width-12]==12'h165 ) ? send_en :0;   
assign ch_valid_en166=(  spi_all_data[spi_width-1:spi_width-12]==12'h166 ) ? send_en :0;   
assign ch_valid_en167=(  spi_all_data[spi_width-1:spi_width-12]==12'h167 ) ? send_en :0;   
assign ch_valid_en168=(  spi_all_data[spi_width-1:spi_width-12]==12'h168 ) ? send_en :0;   
assign ch_valid_en169=(  spi_all_data[spi_width-1:spi_width-12]==12'h169 ) ? send_en :0;   
assign ch_valid_en16A=(  spi_all_data[spi_width-1:spi_width-12]==12'h16A ) ? send_en :0;   
assign ch_valid_en16B=(  spi_all_data[spi_width-1:spi_width-12]==12'h16B ) ? send_en :0;   
assign ch_valid_en16C=(  spi_all_data[spi_width-1:spi_width-12]==12'h16C ) ? send_en :0;   
assign ch_valid_en16D=(  spi_all_data[spi_width-1:spi_width-12]==12'h16D ) ? send_en :0;   
assign ch_valid_en16E=(  spi_all_data[spi_width-1:spi_width-12]==12'h16E ) ? send_en :0;   
assign ch_valid_en16F=(  spi_all_data[spi_width-1:spi_width-12]==12'h16F ) ? send_en :0;   
assign ch_valid_en170=(  spi_all_data[spi_width-1:spi_width-12]==12'h170 ) ? send_en :0;   
assign ch_valid_en171=(  spi_all_data[spi_width-1:spi_width-12]==12'h171 ) ? send_en :0;   
assign ch_valid_en172=(  spi_all_data[spi_width-1:spi_width-12]==12'h172 ) ? send_en :0;   
assign ch_valid_en173=(  spi_all_data[spi_width-1:spi_width-12]==12'h173 ) ? send_en :0;   
assign ch_valid_en174=(  spi_all_data[spi_width-1:spi_width-12]==12'h174 ) ? send_en :0;   
assign ch_valid_en175=(  spi_all_data[spi_width-1:spi_width-12]==12'h175 ) ? send_en :0;   
assign ch_valid_en176=(  spi_all_data[spi_width-1:spi_width-12]==12'h176 ) ? send_en :0;   
assign ch_valid_en177=(  spi_all_data[spi_width-1:spi_width-12]==12'h177 ) ? send_en :0;   
assign ch_valid_en178=(  spi_all_data[spi_width-1:spi_width-12]==12'h178 ) ? send_en :0;   
assign ch_valid_en179=(  spi_all_data[spi_width-1:spi_width-12]==12'h179 ) ? send_en :0;   
assign ch_valid_en17A=(  spi_all_data[spi_width-1:spi_width-12]==12'h17A ) ? send_en :0;   
assign ch_valid_en17B=(  spi_all_data[spi_width-1:spi_width-12]==12'h17B ) ? send_en :0;   
assign ch_valid_en17C=(  spi_all_data[spi_width-1:spi_width-12]==12'h17C ) ? send_en :0;   
assign ch_valid_en17D=(  spi_all_data[spi_width-1:spi_width-12]==12'h17D ) ? send_en :0;   
assign ch_valid_en17E=(  spi_all_data[spi_width-1:spi_width-12]==12'h17E ) ? send_en :0;   
assign ch_valid_en17F=(  spi_all_data[spi_width-1:spi_width-12]==12'h17F ) ? send_en :0;   
assign ch_valid_en180=(  spi_all_data[spi_width-1:spi_width-12]==12'h180 ) ? send_en :0;   
assign ch_valid_en181=(  spi_all_data[spi_width-1:spi_width-12]==12'h181 ) ? send_en :0;   
assign ch_valid_en182=(  spi_all_data[spi_width-1:spi_width-12]==12'h182 ) ? send_en :0;   
assign ch_valid_en183=(  spi_all_data[spi_width-1:spi_width-12]==12'h183 ) ? send_en :0;   
assign ch_valid_en184=(  spi_all_data[spi_width-1:spi_width-12]==12'h184 ) ? send_en :0;   
assign ch_valid_en185=(  spi_all_data[spi_width-1:spi_width-12]==12'h185 ) ? send_en :0;   
assign ch_valid_en186=(  spi_all_data[spi_width-1:spi_width-12]==12'h186 ) ? send_en :0;   
assign ch_valid_en187=(  spi_all_data[spi_width-1:spi_width-12]==12'h187 ) ? send_en :0;   
assign ch_valid_en188=(  spi_all_data[spi_width-1:spi_width-12]==12'h188 ) ? send_en :0;   
assign ch_valid_en189=(  spi_all_data[spi_width-1:spi_width-12]==12'h189 ) ? send_en :0;   
assign ch_valid_en18A=(  spi_all_data[spi_width-1:spi_width-12]==12'h18A ) ? send_en :0;   
assign ch_valid_en18B=(  spi_all_data[spi_width-1:spi_width-12]==12'h18B ) ? send_en :0;   
assign ch_valid_en18C=(  spi_all_data[spi_width-1:spi_width-12]==12'h18C ) ? send_en :0;   
assign ch_valid_en18D=(  spi_all_data[spi_width-1:spi_width-12]==12'h18D ) ? send_en :0;   
assign ch_valid_en18E=(  spi_all_data[spi_width-1:spi_width-12]==12'h18E ) ? send_en :0;   
assign ch_valid_en18F=(  spi_all_data[spi_width-1:spi_width-12]==12'h18F ) ? send_en :0;   
assign ch_valid_en190=(  spi_all_data[spi_width-1:spi_width-12]==12'h190 ) ? send_en :0;   
assign ch_valid_en191=(  spi_all_data[spi_width-1:spi_width-12]==12'h191 ) ? send_en :0;   
assign ch_valid_en192=(  spi_all_data[spi_width-1:spi_width-12]==12'h192 ) ? send_en :0;   
assign ch_valid_en193=(  spi_all_data[spi_width-1:spi_width-12]==12'h193 ) ? send_en :0;   
assign ch_valid_en194=(  spi_all_data[spi_width-1:spi_width-12]==12'h194 ) ? send_en :0;   
assign ch_valid_en195=(  spi_all_data[spi_width-1:spi_width-12]==12'h195 ) ? send_en :0;   
assign ch_valid_en196=(  spi_all_data[spi_width-1:spi_width-12]==12'h196 ) ? send_en :0;   
assign ch_valid_en197=(  spi_all_data[spi_width-1:spi_width-12]==12'h197 ) ? send_en :0;   
assign ch_valid_en198=(  spi_all_data[spi_width-1:spi_width-12]==12'h198 ) ? send_en :0;   
assign ch_valid_en199=(  spi_all_data[spi_width-1:spi_width-12]==12'h199 ) ? send_en :0;   
assign ch_valid_en19A=(  spi_all_data[spi_width-1:spi_width-12]==12'h19A ) ? send_en :0;   
assign ch_valid_en19B=(  spi_all_data[spi_width-1:spi_width-12]==12'h19B ) ? send_en :0;   
assign ch_valid_en19C=(  spi_all_data[spi_width-1:spi_width-12]==12'h19C ) ? send_en :0;   
assign ch_valid_en19D=(  spi_all_data[spi_width-1:spi_width-12]==12'h19D ) ? send_en :0;   
assign ch_valid_en19E=(  spi_all_data[spi_width-1:spi_width-12]==12'h19E ) ? send_en :0;   
assign ch_valid_en19F=(  spi_all_data[spi_width-1:spi_width-12]==12'h19F ) ? send_en :0;   
assign ch_valid_en1A0=(  spi_all_data[spi_width-1:spi_width-12]==12'h1A0 ) ? send_en :0;   
assign ch_valid_en1A1=(  spi_all_data[spi_width-1:spi_width-12]==12'h1A1 ) ? send_en :0;   
assign ch_valid_en1A2=(  spi_all_data[spi_width-1:spi_width-12]==12'h1A2 ) ? send_en :0;   
assign ch_valid_en1A3=(  spi_all_data[spi_width-1:spi_width-12]==12'h1A3 ) ? send_en :0;   
assign ch_valid_en1A4=(  spi_all_data[spi_width-1:spi_width-12]==12'h1A4 ) ? send_en :0;   
assign ch_valid_en1A5=(  spi_all_data[spi_width-1:spi_width-12]==12'h1A5 ) ? send_en :0;   
assign ch_valid_en1A6=(  spi_all_data[spi_width-1:spi_width-12]==12'h1A6 ) ? send_en :0;   
assign ch_valid_en1A7=(  spi_all_data[spi_width-1:spi_width-12]==12'h1A7 ) ? send_en :0;   
assign ch_valid_en1A8=(  spi_all_data[spi_width-1:spi_width-12]==12'h1A8 ) ? send_en :0;   
assign ch_valid_en1A9=(  spi_all_data[spi_width-1:spi_width-12]==12'h1A9 ) ? send_en :0;   
assign ch_valid_en1AA=(  spi_all_data[spi_width-1:spi_width-12]==12'h1AA ) ? send_en :0;   
assign ch_valid_en1AB=(  spi_all_data[spi_width-1:spi_width-12]==12'h1AB ) ? send_en :0;   
assign ch_valid_en1AC=(  spi_all_data[spi_width-1:spi_width-12]==12'h1AC ) ? send_en :0;   
assign ch_valid_en1AD=(  spi_all_data[spi_width-1:spi_width-12]==12'h1AD ) ? send_en :0;   
assign ch_valid_en1AE=(  spi_all_data[spi_width-1:spi_width-12]==12'h1AE ) ? send_en :0;   
assign ch_valid_en1AF=(  spi_all_data[spi_width-1:spi_width-12]==12'h1AF ) ? send_en :0;   
assign ch_valid_en1B0=(  spi_all_data[spi_width-1:spi_width-12]==12'h1B0 ) ? send_en :0;   
assign ch_valid_en1B1=(  spi_all_data[spi_width-1:spi_width-12]==12'h1B1 ) ? send_en :0;   
assign ch_valid_en1B2=(  spi_all_data[spi_width-1:spi_width-12]==12'h1B2 ) ? send_en :0;   
assign ch_valid_en1B3=(  spi_all_data[spi_width-1:spi_width-12]==12'h1B3 ) ? send_en :0;   
assign ch_valid_en1B4=(  spi_all_data[spi_width-1:spi_width-12]==12'h1B4 ) ? send_en :0;   
assign ch_valid_en1B5=(  spi_all_data[spi_width-1:spi_width-12]==12'h1B5 ) ? send_en :0;   
assign ch_valid_en1B6=(  spi_all_data[spi_width-1:spi_width-12]==12'h1B6 ) ? send_en :0;   
assign ch_valid_en1B7=(  spi_all_data[spi_width-1:spi_width-12]==12'h1B7 ) ? send_en :0;   
assign ch_valid_en1B8=(  spi_all_data[spi_width-1:spi_width-12]==12'h1B8 ) ? send_en :0;   
assign ch_valid_en1B9=(  spi_all_data[spi_width-1:spi_width-12]==12'h1B9 ) ? send_en :0;   
assign ch_valid_en1BA=(  spi_all_data[spi_width-1:spi_width-12]==12'h1BA ) ? send_en :0;   
assign ch_valid_en1BB=(  spi_all_data[spi_width-1:spi_width-12]==12'h1BB ) ? send_en :0;   
assign ch_valid_en1BC=(  spi_all_data[spi_width-1:spi_width-12]==12'h1BC ) ? send_en :0;   
assign ch_valid_en1BD=(  spi_all_data[spi_width-1:spi_width-12]==12'h1BD ) ? send_en :0;   
assign ch_valid_en1BE=(  spi_all_data[spi_width-1:spi_width-12]==12'h1BE ) ? send_en :0;   
assign ch_valid_en1BF=(  spi_all_data[spi_width-1:spi_width-12]==12'h1BF ) ? send_en :0;   
assign ch_valid_en1C0=(  spi_all_data[spi_width-1:spi_width-12]==12'h1C0 ) ? send_en :0;   
assign ch_valid_en1C1=(  spi_all_data[spi_width-1:spi_width-12]==12'h1C1 ) ? send_en :0;   
assign ch_valid_en1C2=(  spi_all_data[spi_width-1:spi_width-12]==12'h1C2 ) ? send_en :0;   
assign ch_valid_en1C3=(  spi_all_data[spi_width-1:spi_width-12]==12'h1C3 ) ? send_en :0;   
assign ch_valid_en1C4=(  spi_all_data[spi_width-1:spi_width-12]==12'h1C4 ) ? send_en :0;   
assign ch_valid_en1C5=(  spi_all_data[spi_width-1:spi_width-12]==12'h1C5 ) ? send_en :0;   
assign ch_valid_en1C6=(  spi_all_data[spi_width-1:spi_width-12]==12'h1C6 ) ? send_en :0;   
assign ch_valid_en1C7=(  spi_all_data[spi_width-1:spi_width-12]==12'h1C7 ) ? send_en :0;   
assign ch_valid_en1C8=(  spi_all_data[spi_width-1:spi_width-12]==12'h1C8 ) ? send_en :0;   
assign ch_valid_en1C9=(  spi_all_data[spi_width-1:spi_width-12]==12'h1C9 ) ? send_en :0;   
assign ch_valid_en1CA=(  spi_all_data[spi_width-1:spi_width-12]==12'h1CA ) ? send_en :0;   
assign ch_valid_en1CB=(  spi_all_data[spi_width-1:spi_width-12]==12'h1CB ) ? send_en :0;   
assign ch_valid_en1CC=(  spi_all_data[spi_width-1:spi_width-12]==12'h1CC ) ? send_en :0;   
assign ch_valid_en1CD=(  spi_all_data[spi_width-1:spi_width-12]==12'h1CD ) ? send_en :0;   
assign ch_valid_en1CE=(  spi_all_data[spi_width-1:spi_width-12]==12'h1CE ) ? send_en :0;   
assign ch_valid_en1CF=(  spi_all_data[spi_width-1:spi_width-12]==12'h1CF ) ? send_en :0;   
assign ch_valid_en1D0=(  spi_all_data[spi_width-1:spi_width-12]==12'h1D0 ) ? send_en :0;   
assign ch_valid_en1D1=(  spi_all_data[spi_width-1:spi_width-12]==12'h1D1 ) ? send_en :0;   
assign ch_valid_en1D2=(  spi_all_data[spi_width-1:spi_width-12]==12'h1D2 ) ? send_en :0;   
assign ch_valid_en1D3=(  spi_all_data[spi_width-1:spi_width-12]==12'h1D3 ) ? send_en :0;   
assign ch_valid_en1D4=(  spi_all_data[spi_width-1:spi_width-12]==12'h1D4 ) ? send_en :0;   
assign ch_valid_en1D5=(  spi_all_data[spi_width-1:spi_width-12]==12'h1D5 ) ? send_en :0;   
assign ch_valid_en1D6=(  spi_all_data[spi_width-1:spi_width-12]==12'h1D6 ) ? send_en :0;   
assign ch_valid_en1D7=(  spi_all_data[spi_width-1:spi_width-12]==12'h1D7 ) ? send_en :0;   
assign ch_valid_en1D8=(  spi_all_data[spi_width-1:spi_width-12]==12'h1D8 ) ? send_en :0;   
assign ch_valid_en1D9=(  spi_all_data[spi_width-1:spi_width-12]==12'h1D9 ) ? send_en :0;   
assign ch_valid_en1DA=(  spi_all_data[spi_width-1:spi_width-12]==12'h1DA ) ? send_en :0;   
assign ch_valid_en1DB=(  spi_all_data[spi_width-1:spi_width-12]==12'h1DB ) ? send_en :0;   
assign ch_valid_en1DC=(  spi_all_data[spi_width-1:spi_width-12]==12'h1DC ) ? send_en :0;   
assign ch_valid_en1DD=(  spi_all_data[spi_width-1:spi_width-12]==12'h1DD ) ? send_en :0;   
assign ch_valid_en1DE=(  spi_all_data[spi_width-1:spi_width-12]==12'h1DE ) ? send_en :0;   
assign ch_valid_en1DF=(  spi_all_data[spi_width-1:spi_width-12]==12'h1DF ) ? send_en :0;   
assign ch_valid_en1E0=(  spi_all_data[spi_width-1:spi_width-12]==12'h1E0 ) ? send_en :0;   
assign ch_valid_en1E1=(  spi_all_data[spi_width-1:spi_width-12]==12'h1E1 ) ? send_en :0;   
assign ch_valid_en1E2=(  spi_all_data[spi_width-1:spi_width-12]==12'h1E2 ) ? send_en :0;   
assign ch_valid_en1E3=(  spi_all_data[spi_width-1:spi_width-12]==12'h1E3 ) ? send_en :0;   
assign ch_valid_en1E4=(  spi_all_data[spi_width-1:spi_width-12]==12'h1E4 ) ? send_en :0;   
assign ch_valid_en1E5=(  spi_all_data[spi_width-1:spi_width-12]==12'h1E5 ) ? send_en :0;   
assign ch_valid_en1E6=(  spi_all_data[spi_width-1:spi_width-12]==12'h1E6 ) ? send_en :0;   
assign ch_valid_en1E7=(  spi_all_data[spi_width-1:spi_width-12]==12'h1E7 ) ? send_en :0;   
assign ch_valid_en1E8=(  spi_all_data[spi_width-1:spi_width-12]==12'h1E8 ) ? send_en :0;   
assign ch_valid_en1E9=(  spi_all_data[spi_width-1:spi_width-12]==12'h1E9 ) ? send_en :0;   
assign ch_valid_en1EA=(  spi_all_data[spi_width-1:spi_width-12]==12'h1EA ) ? send_en :0;   
assign ch_valid_en1EB=(  spi_all_data[spi_width-1:spi_width-12]==12'h1EB ) ? send_en :0;   
assign ch_valid_en1EC=(  spi_all_data[spi_width-1:spi_width-12]==12'h1EC ) ? send_en :0;   
assign ch_valid_en1ED=(  spi_all_data[spi_width-1:spi_width-12]==12'h1ED ) ? send_en :0;   
assign ch_valid_en1EE=(  spi_all_data[spi_width-1:spi_width-12]==12'h1EE ) ? send_en :0;   
assign ch_valid_en1EF=(  spi_all_data[spi_width-1:spi_width-12]==12'h1EF ) ? send_en :0;   
assign ch_valid_en1F0=(  spi_all_data[spi_width-1:spi_width-12]==12'h1F0 ) ? send_en :0;   
assign ch_valid_en1F1=(  spi_all_data[spi_width-1:spi_width-12]==12'h1F1 ) ? send_en :0;   
assign ch_valid_en1F2=(  spi_all_data[spi_width-1:spi_width-12]==12'h1F2 ) ? send_en :0;   
assign ch_valid_en1F3=(  spi_all_data[spi_width-1:spi_width-12]==12'h1F3 ) ? send_en :0;   
assign ch_valid_en1F4=(  spi_all_data[spi_width-1:spi_width-12]==12'h1F4 ) ? send_en :0;   
assign ch_valid_en1F5=(  spi_all_data[spi_width-1:spi_width-12]==12'h1F5 ) ? send_en :0;   
assign ch_valid_en1F6=(  spi_all_data[spi_width-1:spi_width-12]==12'h1F6 ) ? send_en :0;   
assign ch_valid_en1F7=(  spi_all_data[spi_width-1:spi_width-12]==12'h1F7 ) ? send_en :0;   
assign ch_valid_en1F8=(  spi_all_data[spi_width-1:spi_width-12]==12'h1F8 ) ? send_en :0;   
assign ch_valid_en1F9=(  spi_all_data[spi_width-1:spi_width-12]==12'h1F9 ) ? send_en :0;   
assign ch_valid_en1FA=(  spi_all_data[spi_width-1:spi_width-12]==12'h1FA ) ? send_en :0;   
assign ch_valid_en1FB=(  spi_all_data[spi_width-1:spi_width-12]==12'h1FB ) ? send_en :0;   
assign ch_valid_en1FC=(  spi_all_data[spi_width-1:spi_width-12]==12'h1FC ) ? send_en :0;   
assign ch_valid_en1FD=(  spi_all_data[spi_width-1:spi_width-12]==12'h1FD ) ? send_en :0;   
assign ch_valid_en1FE=(  spi_all_data[spi_width-1:spi_width-12]==12'h1FE ) ? send_en :0;   
assign ch_valid_en1FF=(  spi_all_data[spi_width-1:spi_width-12]==12'h1FF ) ? send_en :0;   
assign ch_valid_en200=(  spi_all_data[spi_width-1:spi_width-12]==12'h200 ) ? send_en :0;   
assign ch_valid_en201=(  spi_all_data[spi_width-1:spi_width-12]==12'h201 ) ? send_en :0;   
assign ch_valid_en202=(  spi_all_data[spi_width-1:spi_width-12]==12'h202 ) ? send_en :0;   
assign ch_valid_en203=(  spi_all_data[spi_width-1:spi_width-12]==12'h203 ) ? send_en :0;   
assign ch_valid_en204=(  spi_all_data[spi_width-1:spi_width-12]==12'h204 ) ? send_en :0;   
assign ch_valid_en205=(  spi_all_data[spi_width-1:spi_width-12]==12'h205 ) ? send_en :0;   
assign ch_valid_en206=(  spi_all_data[spi_width-1:spi_width-12]==12'h206 ) ? send_en :0;   
assign ch_valid_en207=(  spi_all_data[spi_width-1:spi_width-12]==12'h207 ) ? send_en :0;   
assign ch_valid_en208=(  spi_all_data[spi_width-1:spi_width-12]==12'h208 ) ? send_en :0;   
assign ch_valid_en209=(  spi_all_data[spi_width-1:spi_width-12]==12'h209 ) ? send_en :0;   
assign ch_valid_en20A=(  spi_all_data[spi_width-1:spi_width-12]==12'h20A ) ? send_en :0;   
assign ch_valid_en20B=(  spi_all_data[spi_width-1:spi_width-12]==12'h20B ) ? send_en :0;   
assign ch_valid_en20C=(  spi_all_data[spi_width-1:spi_width-12]==12'h20C ) ? send_en :0;   
assign ch_valid_en20D=(  spi_all_data[spi_width-1:spi_width-12]==12'h20D ) ? send_en :0;   
assign ch_valid_en20E=(  spi_all_data[spi_width-1:spi_width-12]==12'h20E ) ? send_en :0;   
assign ch_valid_en20F=(  spi_all_data[spi_width-1:spi_width-12]==12'h20F ) ? send_en :0;   
assign ch_valid_en210=(  spi_all_data[spi_width-1:spi_width-12]==12'h210 ) ? send_en :0;   
assign ch_valid_en211=(  spi_all_data[spi_width-1:spi_width-12]==12'h211 ) ? send_en :0;   
assign ch_valid_en212=(  spi_all_data[spi_width-1:spi_width-12]==12'h212 ) ? send_en :0;   
assign ch_valid_en213=(  spi_all_data[spi_width-1:spi_width-12]==12'h213 ) ? send_en :0;   
assign ch_valid_en214=(  spi_all_data[spi_width-1:spi_width-12]==12'h214 ) ? send_en :0;   
assign ch_valid_en215=(  spi_all_data[spi_width-1:spi_width-12]==12'h215 ) ? send_en :0;   
assign ch_valid_en216=(  spi_all_data[spi_width-1:spi_width-12]==12'h216 ) ? send_en :0;   
assign ch_valid_en217=(  spi_all_data[spi_width-1:spi_width-12]==12'h217 ) ? send_en :0;   
assign ch_valid_en218=(  spi_all_data[spi_width-1:spi_width-12]==12'h218 ) ? send_en :0;   
assign ch_valid_en219=(  spi_all_data[spi_width-1:spi_width-12]==12'h219 ) ? send_en :0;   
assign ch_valid_en21A=(  spi_all_data[spi_width-1:spi_width-12]==12'h21A ) ? send_en :0;   
assign ch_valid_en21B=(  spi_all_data[spi_width-1:spi_width-12]==12'h21B ) ? send_en :0;   
assign ch_valid_en21C=(  spi_all_data[spi_width-1:spi_width-12]==12'h21C ) ? send_en :0;   
assign ch_valid_en21D=(  spi_all_data[spi_width-1:spi_width-12]==12'h21D ) ? send_en :0;   
assign ch_valid_en21E=(  spi_all_data[spi_width-1:spi_width-12]==12'h21E ) ? send_en :0;   
assign ch_valid_en21F=(  spi_all_data[spi_width-1:spi_width-12]==12'h21F ) ? send_en :0;   
assign ch_valid_en220=(  spi_all_data[spi_width-1:spi_width-12]==12'h220 ) ? send_en :0;   
assign ch_valid_en221=(  spi_all_data[spi_width-1:spi_width-12]==12'h221 ) ? send_en :0;   
assign ch_valid_en222=(  spi_all_data[spi_width-1:spi_width-12]==12'h222 ) ? send_en :0;   
assign ch_valid_en223=(  spi_all_data[spi_width-1:spi_width-12]==12'h223 ) ? send_en :0;   
assign ch_valid_en224=(  spi_all_data[spi_width-1:spi_width-12]==12'h224 ) ? send_en :0;   
assign ch_valid_en225=(  spi_all_data[spi_width-1:spi_width-12]==12'h225 ) ? send_en :0;   
assign ch_valid_en226=(  spi_all_data[spi_width-1:spi_width-12]==12'h226 ) ? send_en :0;   
assign ch_valid_en227=(  spi_all_data[spi_width-1:spi_width-12]==12'h227 ) ? send_en :0;   
assign ch_valid_en228=(  spi_all_data[spi_width-1:spi_width-12]==12'h228 ) ? send_en :0;   
assign ch_valid_en229=(  spi_all_data[spi_width-1:spi_width-12]==12'h229 ) ? send_en :0;   
assign ch_valid_en22A=(  spi_all_data[spi_width-1:spi_width-12]==12'h22A ) ? send_en :0;   
assign ch_valid_en22B=(  spi_all_data[spi_width-1:spi_width-12]==12'h22B ) ? send_en :0;   
assign ch_valid_en22C=(  spi_all_data[spi_width-1:spi_width-12]==12'h22C ) ? send_en :0;   
assign ch_valid_en22D=(  spi_all_data[spi_width-1:spi_width-12]==12'h22D ) ? send_en :0;   
assign ch_valid_en22E=(  spi_all_data[spi_width-1:spi_width-12]==12'h22E ) ? send_en :0;   
assign ch_valid_en22F=(  spi_all_data[spi_width-1:spi_width-12]==12'h22F ) ? send_en :0;   
assign ch_valid_en230=(  spi_all_data[spi_width-1:spi_width-12]==12'h230 ) ? send_en :0;   
assign ch_valid_en231=(  spi_all_data[spi_width-1:spi_width-12]==12'h231 ) ? send_en :0;   
assign ch_valid_en232=(  spi_all_data[spi_width-1:spi_width-12]==12'h232 ) ? send_en :0;   
assign ch_valid_en233=(  spi_all_data[spi_width-1:spi_width-12]==12'h233 ) ? send_en :0;   
assign ch_valid_en234=(  spi_all_data[spi_width-1:spi_width-12]==12'h234 ) ? send_en :0;   
assign ch_valid_en235=(  spi_all_data[spi_width-1:spi_width-12]==12'h235 ) ? send_en :0;   
assign ch_valid_en236=(  spi_all_data[spi_width-1:spi_width-12]==12'h236 ) ? send_en :0;   
assign ch_valid_en237=(  spi_all_data[spi_width-1:spi_width-12]==12'h237 ) ? send_en :0;   
assign ch_valid_en238=(  spi_all_data[spi_width-1:spi_width-12]==12'h238 ) ? send_en :0;   
assign ch_valid_en239=(  spi_all_data[spi_width-1:spi_width-12]==12'h239 ) ? send_en :0;   
assign ch_valid_en23A=(  spi_all_data[spi_width-1:spi_width-12]==12'h23A ) ? send_en :0;   
assign ch_valid_en23B=(  spi_all_data[spi_width-1:spi_width-12]==12'h23B ) ? send_en :0;   
assign ch_valid_en23C=(  spi_all_data[spi_width-1:spi_width-12]==12'h23C ) ? send_en :0;   
assign ch_valid_en23D=(  spi_all_data[spi_width-1:spi_width-12]==12'h23D ) ? send_en :0;   
assign ch_valid_en23E=(  spi_all_data[spi_width-1:spi_width-12]==12'h23E ) ? send_en :0;   
assign ch_valid_en23F=(  spi_all_data[spi_width-1:spi_width-12]==12'h23F ) ? send_en :0;   

                         
endmodule                
                         