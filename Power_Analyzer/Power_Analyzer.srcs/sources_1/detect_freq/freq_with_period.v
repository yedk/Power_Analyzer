`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:32:46 12/20/2017 
// Design Name: 
// Module Name:    freq_with_period 
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
module freq_with_period
	(//input
	input	              clkinx,
	input	              rst_n,
	input	              clkin_10m_ref,
	input      [5:0]    cnt_cycle,   //N 表示N个被测信号周期，最大可测64个周期
  input		   [31:0]	  gate_vaule,   //N 表示N*10ns	
	//output
	output     [39:0]		cnt_period,  //测周法最大计数位宽
	output	   [31:0]   cnt_freq_fx,
	output	   [31:0]   cnt_freq_fs,
	output	            per_full_flag,
	output	            per_mea_flag,
	output	            fre_mea_flag

	);

wire clkin;
/*
   BUFG BUFG_inst (
      .O(clkin), // 1-bit output: Clock output
      .I(clkin_10m_ref)  // 1-bit input: Clock input
   );
*/
wire fx_in;
  /*
   BUFG BUFG_fx (
      .O(fx_in), // 1-bit output: Clock output
      .I(clkinx)  // 1-bit input: Clock input
   );
*/
assign fx_in = clkinx;
assign clkin = clkin_10m_ref; 
//测量高频
	freq_detect	
		freq_detect_i ( 
      .clkinx(fx_in),
			.rst_n(rst_n),
			.clkin(clkin),
			.gate_vaule(gate_vaule),//N 表示N*10ns
			
			.mea_cnt_fx(cnt_freq_fx),
			.mea_cnt_fs(cnt_freq_fs),
			.mea_flag(fre_mea_flag)
				);

	//测量低频时使用
	period_detect  
		period_detect_i( 
	     .clkinx( fx_in ),
	     .rst_n( rst_n ), 
	     .clkin( clkin ), 
	     .cnt_cycle( cnt_cycle ), 
		   .cnt_period( cnt_period ), 
	     .full_flag( per_full_flag ), 
	     .mea_flag( per_mea_flag )	
			);
				
endmodule
