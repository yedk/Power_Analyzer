`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:50:39 03/27/2017 
// Design Name: 
// Module Name:    detect_freq_period 
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
module detect_freq_period(

input					    rst_n,
input					    clk,
input  [31:0]     sel_ch,
input	 [127:0]		comp_level,
input  [31:0]     gate_vaule,             //闸门时间设置
input  [31:0]     cnt_cycle,               //测周法的周期个数设置

input      [31:0] data_from_serdes_s1,    //待测数据，通道一 
input      [31:0] data_from_serdes_s2,		//待测数据，通道二
input      [31:0] data_from_serdes_s3,
input      [31:0] data_from_serdes_s4,


output		[39:0]	cnt_period0,			  //测周期计数
output		[31:0]	cnt_freq_fx0,			  //被测信号测频率计数
output		[31:0]	cnt_freq_fs0,			  //标准时钟测频率计数
                                    
output					  per_full_flag0,		  	//测周期计数溢出
output						per_mea_flag0,		  	//测周期完成
output						fre_mea_flag0,		  	//测频率完成
						                        
output		[39:0]	cnt_period1,		    //测周期计数
output		[31:0]	cnt_freq_fx1,			  //被测信号测频率计数
output		[31:0]	cnt_freq_fs1,			  //标准时钟测频率计数
                                    
output			      per_full_flag1,		  	//测周期计数溢出
output						per_mea_flag1,		  	//测周期完成
output						fre_mea_flag1,		  	//测频率完成 
						                        
output		[39:0]	cnt_period2,		    //测周期计数
output		[31:0]	cnt_freq_fx2,			  //被测信号测频率计数
output		[31:0]	cnt_freq_fs2,			  //标准时钟测频率计数
                                    
output			      per_full_flag2,		  	//测周期计数溢出
output						per_mea_flag2,		  	//测周期完成
output						fre_mea_flag2,		  	//测频率完成 	
						                        
output		[39:0]	cnt_period3,		    //测周期计数
output		[31:0]	cnt_freq_fx3,			  //被测信号测频率计数
output		[31:0]	cnt_freq_fs3,			  //标准时钟测频率计数
                                    
output					  per_full_flag3,		  	//测周期计数溢出
output						per_mea_flag3,		  	//测周期完成
output						fre_mea_flag3			  //测频率完成 					
						                        
						                        
							                      
    );
    

wire		[3:0]		nomal_mode_data; 
wire		[63:0]		data_selected;


select_4ch select_4ch_inst(
	.adc_tx_clk(clk),
	.data_from_serdes_s1(data_from_serdes_s1),
	.data_from_serdes_s2(data_from_serdes_s2),
	.data_from_serdes_s3(data_from_serdes_s3),
	.data_from_serdes_s4(data_from_serdes_s4),

	.set_channel_id0(sel_ch),

	.data_16ch(data_selected)
    );








Trig_single_change Trig_single_change_ch0(

	//.data(data_selected[15:0]),
	.data(data_selected[15:0]),
	.trig_level_l(comp_level[15:0]),
	.trig_level_h(comp_level[31:16]),
	.trig_clk(clk),
	.rst_n(rst_n),
 
    .in_data_out(),
    .out_data_out(),
	.nomal_data_out(nomal_mode_data[0])
    );	
    
  Trig_single_change Trig_single_change_ch1(

	.data(data_selected[31:16]),
	.trig_level_l(comp_level[47:32]),
	.trig_level_h(comp_level[63:48]),
	.trig_clk(clk),
	.rst_n(rst_n),
 
    .in_data_out(),
    .out_data_out(),
	.nomal_data_out(nomal_mode_data[1])
    );	
    
  Trig_single_change Trig_single_change_ch2(

	.data(data_selected[47:32]),
	.trig_level_l(comp_level[79:64]),
	.trig_level_h(comp_level[95:80]),
	.trig_clk(clk),
	.rst_n(rst_n),
 
    .in_data_out(),
    .out_data_out(),
	.nomal_data_out(nomal_mode_data[2])
    );
    
  Trig_single_change Trig_single_change_ch3(

	.data(data_selected[63:48]),
	.trig_level_l(comp_level[111:96]),
	.trig_level_h(comp_level[127:112]),
	.trig_clk(clk),
	.rst_n(rst_n),
 
    .in_data_out(),
    .out_data_out(),
	.nomal_data_out(nomal_mode_data[3])
    );
    
    
    
    //测频模块
    freq_with_period 
    	freq_with_period_i0 (
    .clkinx(nomal_mode_data[0]),	    
    .rst_n(rst_n),    
    .clkin_10m_ref(clk),	//10MHz Fref clk_ref_bufgp   
    .cnt_cycle( cnt_cycle[7:0] ), //[5:0] N 表示N个被测信号周期，最大可测64个周期                       
    .gate_vaule(gate_vaule), //[31:0]N 表示N*10ns	                                
    .cnt_period(cnt_period0), //[31:0]测周法最大计数位宽  
    .cnt_freq_fx(cnt_freq_fx0),
    .cnt_freq_fs(cnt_freq_fs0),	
    .per_full_flag(per_full_flag0), 
    .per_mea_flag(per_mea_flag0), 
    .fre_mea_flag(fre_mea_flag0)
    ); 
    
    freq_with_period 
    	freq_with_period_i1 (
    .clkinx(nomal_mode_data[1]),	    
    .rst_n(rst_n),    
    .clkin_10m_ref(clk),	//10MHz Fref clk_ref_bufgp   
    .cnt_cycle( cnt_cycle[15:8] ), //[5:0] N 表示N个被测信号周期，最大可测64个周期                       
    .gate_vaule(gate_vaule), //[31:0]N 表示N*10ns	                                
    .cnt_period(cnt_period1), //[39:0]测周法最大计数位宽  
    .cnt_freq_fx(cnt_freq_fx1),
    .cnt_freq_fs(cnt_freq_fs1),	
    .per_full_flag(per_full_flag1), 
    .per_mea_flag(per_mea_flag1), 
    .fre_mea_flag(fre_mea_flag1)
    );
    
    freq_with_period 
    	freq_with_period_i2 (
    .clkinx(nomal_mode_data[2]),	    
    .rst_n(rst_n),    
    .clkin_10m_ref(clk),	//10MHz Fref clk_ref_bufgp   
    .cnt_cycle( cnt_cycle[23:16] ), //[5:0] N 表示N个被测信号周期，最大可测64个周期                       
    .gate_vaule(gate_vaule), //[31:0]N 表示N*10ns	                                
    .cnt_period(cnt_period2), //[39:0]测周法最大计数位宽  
    .cnt_freq_fx(cnt_freq_fx2),
    .cnt_freq_fs(cnt_freq_fs2),	
    .per_full_flag(per_full_flag2), 
    .per_mea_flag(per_mea_flag2), 
    .fre_mea_flag(fre_mea_flag2)
    ); 
    
    freq_with_period 
    	freq_with_period_i3 (
    .clkinx(nomal_mode_data[3]),	    
    .rst_n(rst_n),    
    .clkin_10m_ref(clk),	//10MHz Fref clk_ref_bufgp   
    .cnt_cycle( cnt_cycle[31:24] ), //[5:0] N 表示N个被测信号周期，最大可测64个周期                       
    .gate_vaule(gate_vaule), //[31:0]N 表示N*10ns	                                
    .cnt_period(cnt_period3), //[39:0]测周法最大计数位宽  
    .cnt_freq_fx(cnt_freq_fx3),
    .cnt_freq_fs(cnt_freq_fs3),	
    .per_full_flag(per_full_flag3), 
    .per_mea_flag(per_mea_flag3), 
    .fre_mea_flag(fre_mea_flag3)
    );
    
    
       
/*
always@(posedge clk)
 	 begin
 	 	 if(!rst_n)
 	 	 	   GATE_TIME <= 32'd99_999_999;	  
 	 	 else
 	 	 	 begin	
 	 	 	 	case(select_parameter)
 	 	 	 		4'd0:
 	 	 	 				GATE_TIME <= 32'd9_999;     //10M时钟下，1ms
 	 	 	 		4'd1:
 	 	 	 				GATE_TIME <= 32'd99_999;   //10M时钟下，10ms
 	 	 	 		3'd2:
 	 	 	 				GATE_TIME <= 32'd999_999;   //10M时钟下，100ms
 	 	 	 		3'd3:
 	 	 	 				GATE_TIME <= 32'd999_999;   //10M时钟下，100ms
 	 	 	 		3'd4:
 	 	 	 				GATE_TIME <= 32'd1_999_999;   //10M时钟下，200ms
 	 	 	 		3'd5:
 	 	 	 				GATE_TIME <= 32'd2_999_999;   //10M时钟下，300ms
 	 	 	 		3'd6:
 	 	 	 				GATE_TIME <= 32'd3_999_999;   //10M时钟下，400ms
 	 	 	 		3'd7:
 	 	 	 				GATE_TIME <= 32'd4_999_999;   //10M时钟下，500ms
 	 	 	 		3'd8:
 	 	 	 				GATE_TIME <= 32'd9_999_999;   //10M时钟下，1s
 	 	 	 		3'd9:
 	 	 	 				GATE_TIME <= 32'd19_999_999;      //10M时钟下，2s
 	 	 	 		3'd10:
 	 	 	 				GATE_TIME <= 32'd99_999_999;    //10M时钟下，10s
 	 	 	 		default:
 	 	 	 				GATE_TIME <= 32'd99_999_999;
 	 	 	 	endcase
 	 	 	 end	 	 	 		
 	 end
*/    
endmodule
