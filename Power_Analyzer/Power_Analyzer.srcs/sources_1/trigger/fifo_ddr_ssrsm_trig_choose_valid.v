`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:38:12 06/17/2017 
// Design Name: 
// Module Name:    fifo_ddr_ssrsm_trig_choose_valid 
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
module fifo_ddr_ssrsm_trig_choose_valid(
input adc_tx_clk,
input wen_fifo_ddr,
input wen_fifo_adc3,
input adc_Rxdat_valid,
input adc_Rxdat_valid_f,
input sys_arrange_en,
input ddr3_en,
input wen_ddr3,
input scan_mode_en,
input ssram_mode_en,
input UI_fifo_write,
input [3:0] sram_state,
output reg fifo_wen_tri,
output reg wen_fifo_adc4,
output  wen_fifo_adc5,
output  wen_fifo_adc6
    );
 reg ssram_scan_en,ddr_scan_en;
always @ (posedge adc_tx_clk)
begin
		if(ddr3_en==1)
	  	begin
	  		if(scan_mode_en)
	  		begin
	  			fifo_wen_tri <= ddr_scan_en&sys_arrange_en;
	  			wen_fifo_adc4<= wen_fifo_adc3;
	  		end
	  	else
	  	 begin
			  fifo_wen_tri <= wen_fifo_ddr;//for trigger_module counting
			  wen_fifo_adc4<= wen_fifo_adc3;
		   end
	   	end
	  else if (ssram_mode_en==1)
	   begin
	   fifo_wen_tri <= adc_Rxdat_valid&ssram_scan_en ; 	
	   end
	 else if((ddr3_en==0)||(ssram_mode_en==0))
	   begin
			fifo_wen_tri <= adc_Rxdat_valid&UI_fifo_write ;
		 end
end 
assign wen_fifo_adc6= ssram_scan_en; 
assign wen_fifo_adc5= ddr_scan_en;

always @ (posedge adc_tx_clk)
begin
if (ssram_mode_en==1)
		begin
			if(sram_state[2])
			ssram_scan_en <= 1'b1  ;
		else 
		  ssram_scan_en <= ssram_scan_en  ;	
		end
	else 
	   ssram_scan_en <= 1'b0  ;
end 


always @ (posedge adc_tx_clk)
begin
if (ddr3_en==1)
		begin
			if(wen_fifo_adc3)
			ddr_scan_en <= 1'b1  ;
		else 
		  ddr_scan_en <= ddr_scan_en  ;	
		end
else 
	   ddr_scan_en <= 1'b0  ;
end 

endmodule
