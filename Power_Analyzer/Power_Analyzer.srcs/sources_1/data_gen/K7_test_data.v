`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:23:53 10/26/2016 
// Design Name: 
// Module Name:    V6_test_data 
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
module K7_test_data(
    input           adc_tx_clk,
    input           CLK_5M,
    input           UI_fifo_reset_L,
	  input  [15:0]	  delay_dat,
    input  [31:0]   add_dat_s12, 
    input  [31:0]   add_dat_s34,
    input  [31:0]   add_dat_s56, 
    input  [31:0]   add_dat_s78,
    input  [31:0]   delay_dat2, 
    output          data_valid,
		output [31:0]   data_from_serdes_s1,      //��λͨ��1����λͨ��2
		output [31:0]   data_from_serdes_s2,      //��λͨ��3����λͨ��4
		output [31:0]   data_from_serdes_s3,      //��λͨ��5����λͨ��6
		output [31:0]   data_from_serdes_s4       //��λͨ��5����λͨ��6

    );

//�����������valid�ź�
reg data_valid;
reg [15:0] delay_cnt;

always @(posedge adc_tx_clk )	
  begin
  	if(!UI_fifo_reset_L)
  		begin
  			data_valid <= 1'b0;
  			delay_cnt <= 16'd0;
  		end
  	else if(delay_cnt >= delay_dat2)	
  		begin
  			data_valid <= 1'b1;
  			delay_cnt <= 16'd0;
  		end
  	else
  		begin
  			delay_cnt <= delay_cnt + 1'b1;
  			data_valid <= 1'b0;
  		end
  end



data_gen data_gen_s10(
   .clk( adc_tx_clk ),
   .rst_L( UI_fifo_reset_L ),
	 .delay_dat( delay_dat[15:0]  ),
   .add_dat( add_dat_s12[31:0] ),
   .ch00_inst( 16'd1 ),//���ݹ̶�����     ÿ��������ͨ��
   .ch01_inst( 16'd2 ),
   .adc_dat( data_from_serdes_s1 ) 
    );

data_gen data_gen_s20(
   .clk( adc_tx_clk ),
   .rst_L( UI_fifo_reset_L ),
	 .delay_dat( delay_dat[15:0]  ),
   .add_dat(add_dat_s34[31:0] ),
   .ch00_inst( 16'd1 ),//���ݹ̶�����
   .ch01_inst( 16'd2 ),
   .adc_dat( data_from_serdes_s2 ) 
    );

data_gen data_gen_s30(
   .clk( adc_tx_clk ),
   .rst_L( UI_fifo_reset_L ),
 	 .delay_dat( delay_dat[15:0]  ),
	 .add_dat( add_dat_s56[31:0] ),
   .ch00_inst( 16'd1 ),//���ݹ̶�����
   .ch01_inst( 16'd2 ),
   .adc_dat( data_from_serdes_s3 ) 
    );
    
    
data_gen data_gen_s40(
   .clk( adc_tx_clk ),
   .rst_L( UI_fifo_reset_L ),
 	 .delay_dat( delay_dat[15:0]  ),
	 .add_dat( add_dat_s78[31:0] ),
   .ch00_inst( 16'd1 ),//���ݹ̶�����
   .ch01_inst( 16'd2 ),
   .adc_dat( data_from_serdes_s4 ) 
    );



endmodule
