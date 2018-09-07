`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/28 11:26:30
// Design Name: 
// Module Name: PCIe_FIFO_control
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


module PCIe_FIFO_control(
		
		input          clk_100M,
		input          rst_trans_fifo, 
    input          pc_dma_read_en,
	  input          pc_dma_read_en_ddr,	
		input [4:0]    trans_id,               //trans_id表示传输的数据源，示波模式/DDR3/其他
		//示波模式接口
		input          fifo_full,
		input          fifo_empty,
		output         fifo_rd_s0,
		input          fifo_dout_8ch_valid,
		input  [127:0] fifo_dout_8ch,  
		//功率模式接口
		                 
		                              
		input  [127:0] power_dout_8ch,       
		input          power_dout_8ch_valid, 
		input          power_fifo_full,      
		input          power_fifo_empty,       
		output         power_rd_en2,
		
		//PCIe FIFO端口
		output [127:0] tx_fifo_in_data,
		output         tx_fifo_wr_en,
		output			ddr3_rd_en,
		
		input [127:0]ddr_fifo_dout_8ch,
		input             ddr_fifo_valid,
		input             ddr_fifo_empty,
		input          pcie_wr_fifo_full,
		input          pcie_prog_full


    );
  
  reg         power_rd_en2;
  reg         fifo_rd_s0;
  reg [127:0] tx_fifo_in_data;
  reg         tx_fifo_wr_en; 
  reg 		ddr3_rd_en;
    
  
  always @(posedge clk_100M )
	begin
		if(!rst_trans_fifo)
			begin	
				fifo_rd_s0 <= 1'b0;
				tx_fifo_wr_en <= 1'b0;
				tx_fifo_in_data <= 128'b0;
								
			end
		else
			begin	
				case(trans_id)
					5'd1 :                          //为1时，传输示波模式的数据
						begin
							fifo_rd_s0 <= pc_dma_read_en & (!fifo_empty) & (!pcie_prog_full);		    //开启采集FIFO的读使能，后级FIFO反馈到前级FIFO	
							tx_fifo_wr_en <= pc_dma_read_en & fifo_dout_8ch_valid & (!pcie_wr_fifo_full);   //开启PCIe FIFO的写使能
							tx_fifo_in_data <= 	fifo_dout_8ch;			
						end
					5'd2 :                         //为2时，传输功率模式的数据
						begin
							power_rd_en2 <= pc_dma_read_en & (!power_fifo_empty) & (!pcie_prog_full);		    //开启采集FIFO的读使能，后级FIFO反馈到前级FIFO	
							tx_fifo_wr_en <= pc_dma_read_en & power_dout_8ch_valid & (!pcie_wr_fifo_full);   //开启PCIe FIFO的写使能
							tx_fifo_in_data <= 	power_dout_8ch;
						end
					5'd3 :                      //为3时，启用ddr3实时传输数据缓存
						begin
							ddr3_rd_en <=pc_dma_read_en &(!ddr_fifo_empty)&(!pcie_prog_full);
							tx_fifo_wr_en <= pc_dma_read_en &ddr_fifo_valid&(!pcie_wr_fifo_full);
							tx_fifo_in_data <= ddr_fifo_dout_8ch;
					
						end
					5'd4 : 
						begin
			
						end
					5'd5 : 
						begin
						
						end
					5'd6 : 
						begin
						
						end
					5'd7 : 
						begin
						
						end
					5'd8 : 
						begin
						
						end
					default: 
					  begin
							fifo_rd_s0 <= 1'b0;
							tx_fifo_wr_en <= 1'b0;
				    	tx_fifo_in_data <= 128'b0;	
				    end
				endcase				
			end	
	end
    
    
   ila_5 PCIe_FIFO_control(
   .clk(clk_100M),
   .probe0({
   tx_fifo_in_data[127:0],
   ddr3_rd_en,
   tx_fifo_wr_en,
   pc_dma_read_en,
   ddr_fifo_valid,
   pcie_prog_full,
   ddr_fifo_empty,
   pcie_wr_fifo_full
   }
   
   ),
   .probe1( {
   ddr_fifo_dout_8ch[127:0]
   })
   );
    
    
    
    
    
endmodule
