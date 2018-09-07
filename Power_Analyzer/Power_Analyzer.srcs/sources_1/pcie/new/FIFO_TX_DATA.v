`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/08/24 17:28:42
// Design Name: 
// Module Name: FIFO_TX_DATA
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
module FIFO_TX_DATA#(
			parameter prog_empty_thresh = 11'd20,
			parameter prog_full_thresh = 10'd1000			
							)
(

		input 			 			 tx_fifo_wr_clk,
		input 			 			 tx_fifo_rst_n,
		//input              trn_tsof_n,           //TLP包起始信号，低电平有效
		//input              trn_teof_n,           //TLP包结束信号，低电平有效	
		//input              compl_done,	         //一次TLP包发送完成的标志信号，用来控制TLP包的连续发送
		input      [127:0] tx_fifo_in_data,
		input              tx_fifo_wr_en,
		input        			 tx_fifo_rd_clk,		
		input              tx_fifo_data_rd_en,	     //有效数据负载使能，“1”表示当前读出的数据要发送给发送引擎
		input              fifo_tx_wr_begin,		
		
		output             tx_fifo_data_valid,   //数据的同步有效使能
		output wire [63:0] tx_fifo_data_out,         //心中要有时序，由于tx_fifo_data_rd_en为1后，下一个时钟才会出数据，
		output      [9:0]  pcie_wr_data_count,
		output             pcie_wr_fifo_full,
		output             pcie_prog_full
						
    );
                                  //现在的tx_fifo_data_rd_en为FIFO读使能信号，不能再打拍了，必须为读使能
  //reg [31:0] din;
  //reg [31:0] dout;
  reg wr_en;
  //reg rd_en;
  
  wire pcie_wr_fifo_full;
  wire empty; 
  wire pcie_prog_full;
  wire prog_empty;
  //wire valid;
  wire wr_ack; 
  wire [10:0] rd_data_count;
  wire [9:0] pcie_wr_data_count;
  
  reg [127:0] tx_fifo_in_data1;
  reg [2:0]cnt;
/*	
	always@( posedge tx_fifo_wr_clk  )
	begin
		if(!tx_fifo_rst_n)
			tx_fifo_in_data1 <= 128'h0;
		else
			case(cnt)
				3'd0:
					tx_fifo_in_data1 <= 128'h1111_1111_2222_2222_3333_3333_4444_4444;
				3'd1:
					tx_fifo_in_data1 <= 128'h5555_5555_6666_6666_7777_7777_8888_8888;
				3'd2:
					tx_fifo_in_data1 <= 128'h9999_9999_aaaa_aaaa_bbbb_bbbb_cccc_cccc;
				3'd3:
					tx_fifo_in_data1 <= 128'hdddd_dddd_eeee_eeee_ffff_ffff_0000_0000;
				3'd4:
					tx_fifo_in_data1 <= 128'h1122_1122_2233_2233_3344_3344_4455_4455;					
				3'd5:
					tx_fifo_in_data1 <= 128'h5566_5566_6677_6677_7788_7788_8899_8899;
				3'd6:
					tx_fifo_in_data1 <= 128'h99aa_99aa_aabb_aabb_bbcc_bbcc_ccdd_ccdd;
				3'd7:
					tx_fifo_in_data1 <= 128'hddee_ddee_eeff_eeff_ff00_ff00_0011_0011;
				default:
					tx_fifo_in_data1 <= 128'h1111_1111_2222_2222_3333_3333_4444_4444;
			endcase
	end
*/	
	//测试数据产生，一复位，就开跑*************************************************
	reg [15:0]card1_data,card2_data,card3_data,card4_data,card5_data,card6_data,card7_data,card8_data;

	always @(posedge tx_fifo_wr_clk)
	begin
		if(!tx_fifo_rst_n)
		  begin
		    card1_data <= 16'd0;
		    card2_data <= 16'd1;
		    card3_data <= 16'd2;
		    card4_data <= 16'd3;
		    card5_data <= 16'd4;
		    card6_data <= 16'd5;
		    card7_data <= 16'd6;
		    card8_data <= 16'd7;
		  end
		else 
		  begin
		    card1_data <= card1_data + 16'd1;
		    card2_data <= card2_data + 16'd2;
		    card3_data <= card3_data + 16'd3;
		    card4_data <= card4_data + 16'd4;
		    card5_data <= card5_data + 16'd5;
		    card6_data <= card6_data + 16'd6;
		    card7_data <= card7_data + 16'd7;
		    card8_data <= card8_data + 16'd8;
		  end		
	end
  
  always @(posedge tx_fifo_wr_clk)
  begin
    if(!tx_fifo_rst_n)
    	begin
				tx_fifo_in_data1 <= 128'h0;
    	end
    else
    	begin
    		tx_fifo_in_data1 <= {card1_data,card2_data,card3_data,card4_data,card5_data,card6_data,card7_data,card8_data};
    	end                      
  end
	
  /***控制FIFO写入数据***/              
  always@( posedge tx_fifo_wr_clk  )
  begin                                           //FIFO给写使能后，下一个时钟，数据才会被写进去
  	if(!tx_fifo_rst_n)                             
  		begin 
  				wr_en <= 1'b0;
  				//cnt <= 3'd0;
  		end
  	else
  		begin
	 			if( (pcie_wr_fifo_full == 1'b0) && (fifo_tx_wr_begin == 1'b1) )
	 				begin
	 					wr_en <= 1'b1;
	 					//cnt <= cnt + 1'b1;
	 				end
	 			else
	 				begin
	 					wr_en <= 1'b0;	
	 					//cnt <= cnt;
	 				end
	 		end
	end
  
  /********控制FIFO读数据*******/
  /**这里要特别注意FIFO读出来的数据，一定要和TX引擎的发送端对齐，
     保证把FIFO 读出来的数据发送出去**/
/*
	always @(posedge tx_fifo_rd_clk ) 
	begin
   if(!tx_fifo_rst_n)
       begin
         rd_en <= 1'b0;
       end
   else
       begin
         if((prog_empty == 1'b0) && (trn_tsof_n == 1'b0) && (trn_teof_n == 1'b1))
           begin
               rd_en <= 1'b1;
           end
         else
           begin
               rd_en <= 1'b0;
           end
       end
  end   
*/    
    
    
    
    fifo_pice_to_pc 
    		FIFO_DMA_TX_DATA_i (
  .rst(!tx_fifo_rst_n),                   // input wire rst
  .wr_clk(tx_fifo_wr_clk),                // input wire wr_clk
  .rd_clk(tx_fifo_rd_clk),                // input wire rd_clk
  .din(tx_fifo_in_data),                  // input wire [127 : 0] din
  .wr_en(tx_fifo_wr_en),                          // input wire wr_en
  .rd_en(tx_fifo_data_rd_en),                          // input wire rd_en
  .prog_empty_thresh(prog_empty_thresh),  // input wire [14 : 0] prog_empty_thresh
  .prog_full_thresh(prog_full_thresh),    // input wire [13 : 0] prog_full_thresh
  .dout(tx_fifo_data_out),                // output wire [63 : 0] dout
  .full(pcie_wr_fifo_full),                            // output wire full
  .wr_ack(wr_ack),                        // output wire wr_ack
  .empty(empty),                          // output wire empty
  .valid(tx_fifo_data_valid),                          // output wire valid
  .rd_data_count(rd_data_count),          // output wire [14 : 0] rd_data_count
  .wr_data_count(pcie_wr_data_count),          // output wire [13 : 0] wr_data_count
  .prog_full(pcie_prog_full),                  // output wire prog_full
  .prog_empty(prog_empty)                // output wire prog_empty
);
fifo_ila_1
	TX_FIFO_i (
.clk(tx_fifo_rd_clk),
.probe0(
{
pcie_wr_fifo_full,
tx_fifo_data_valid,
pcie_prog_full,
tx_fifo_data_valid,
tx_fifo_data_out[63:0]

})
);
/*
ILA_PCIE_TOP 
		TX_FIFO_i (
	.clk(tx_fifo_wr_clk), // input wire clk


	.probe0({            
	          tx_fifo_in_data1[127:0]
	          
	}), // input wire [127:0]  probe0  
	.probe1({
    		  	wr_en,
    		  	prog_full,
    		  	full,
    		  	cnt[2:0],
    		  	tx_fifo_rst_n   		  	
				  				  
	}) // input wire [15:0]  probe1
);
*/
/*
 ILA_PCIE_TOP 
		TX_FIFO_j (
	.clk(tx_fifo_rd_clk), // input wire clk


	.probe0({
       	   tx_fifo_data_out[63:0]          
	
	}), // input wire [127:0]  probe0  
	.probe1({
    		  	tx_fifo_data_rd_en,
    		  	tx_fifo_data_valid,
    		  	prog_empty,
    		  	empty,
    		  	tx_fifo_rst_n,
    		  	pcie_wr_data_count[14:0],
    		  	pcie_wr_fifo_full,
    		  	wr_en,
    		  	fifo_tx_wr_begin,
    		  	pcie_prog_full
    		  				  				  
	}) // input wire [15:0]  probe1
);
*/


endmodule
