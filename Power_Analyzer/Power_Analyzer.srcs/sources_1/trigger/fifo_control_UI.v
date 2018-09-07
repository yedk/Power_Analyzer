`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:01:31 08/30/2016 
// Design Name: 
// Module Name:    fifo_control_UI 
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
module fifo_control_UI(
input	fifo_rxclk,//FIFO��ʱ��
input	fifo_rclk_sel,//FIFO���ź�ѡ��1��PC����0��FPGA��
input   pcFifo_reset_L,
input   fifo_wr_enable,//FIFO д�źţ�active high
input   fifo_wen_tri,
input    ddr3_en,
input   adc_Rxdat_valid,
input   ready,
input   triggered,
input   ssram_mode_en,
input    wen_fifo_adc6,
output  UI_fifo_reset_L,
output 	UI_fifo_write,
output 	UI_fifo_read

    );
    
reg fifo_read;
//reg wr_enable;
 
/*always @(posedge fifo_rxclk )
begin    
 UI_fifo_reset_L <= pcFifo_reset_L;
// UI_fifo_write <= fifo_wr_enable;
  UI_fifo_write <= wr_enable;
 UI_fifo_read <= fifo_read;
end*/
assign  UI_fifo_reset_L = pcFifo_reset_L;
assign  UI_fifo_write = wr_enable;
assign UI_fifo_read = fifo_read;
//assign wr_enable=(ddr3_en==0)?fifo_wr_enable:fifo_wen_tri;

reg ready_reg0,ready_reg1,wr_enable;
reg triggered_reg0,triggered_reg1;
reg ready_start;


always @ (posedge fifo_rxclk)
begin
		if(ddr3_en==1)
	  	begin
     wr_enable<= fifo_wen_tri;  
	   	end
	  else if (ssram_mode_en==1)
	   begin
	   wr_enable<= wen_fifo_adc6;   	
	   end
	 else if((ddr3_en==0)||(ssram_mode_en==0))
	   begin
			wr_enable <= fifo_wr_enable ;
		 end
end 
always @(posedge fifo_rxclk )
begin
	ready_reg0 <= ready;
	ready_reg1 <= ready_reg0;
	triggered_reg0 <= triggered;
	triggered_reg1 <=triggered_reg0;	
end

//FIFO��ʹ���źŲ���
always @(posedge fifo_rxclk )
begin
	if(!pcFifo_reset_L)//��λ�����ֻд����
	begin
		fifo_read <= 0;   
	end
  else if({ready_reg0,ready,triggered_reg0,triggered}== 4'b1100)//ready �����߶���д
  begin
  	   fifo_read <= adc_Rxdat_valid&wr_enable;//дʹ�����ʹ��ͬ��   
  end
  else if({ready_reg0,ready,triggered_reg0,triggered}== 4'b1111)//trigger ���ٴν���ֻд����
  begin
	  fifo_read <= 0; 
  end
  else if(fifo_rclk_sel)//FIFO���󣬽���PC������
  begin
  	fifo_read <= 1;  
  end
  else 
  begin
  	fifo_read <= 0;
  end
  
end
endmodule
