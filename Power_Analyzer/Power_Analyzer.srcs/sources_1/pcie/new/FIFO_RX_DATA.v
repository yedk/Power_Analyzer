`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:     UESTC
// Engineer:    Jia ShuLin
// 
// Create Date: 2017/08/15 15:41:44
// Design Name: 
// Module Name: FIFO_RX_DATA
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


module FIFO_RX_DATA#(
			parameter prog_empty_thresh = 7'd20,
			parameter prog_full_thresh = 8'd100				
							)
(
			
		input 	 			 rx_fifo_wr_clk,
		input 	 			 rx_fifo_rst_n,
		input   [63:0] rx_fifo_data_in,
		input          rx_fifo_data_wr_en,
		input          rx_fifo_rd_clk,
		output  [127:0]rx_fifo_data_out,
		output         rx_fifo_data_valid      
			
    );
  
  //reg [31:0] din;
  //reg [31:0] dout;
  //reg wr_en;
  reg rd_en;
  
  wire full;
  wire empty; 
  wire prog_full;
  wire prog_empty;
  //wire valid;
  wire wr_ack; 
  wire [8:0] rd_data_count;
  wire [7:0] wr_data_count;
  //有效地址信号
  //reg addr_en_r1;
  //reg addr_en_r2;
  //wire addr_en;
  //写使能与写数据同步打一拍
  //reg fifo_wr_en_r1;
  //reg [127:0]fifo_wr_data_r1;
  
  /*****写使能与写数据同步打一拍****/
/*
  always@( posedge fifo_wr_clk  )
  begin
  	fifo_wr_en_r1 <= fifo_wr_en;
  	fifo_wr_data_r1 <= fifo_wr_data;
  end
*/
	/*****根据具体的地址取数据*****/
/*  
  always@( posedge fifo_wr_clk  )     
  begin
  	if(wr_addr == 11'b000_0000_0101)     // 14-17H : Reg # 5
  		begin
  			addr_en_r1 <= 1'b1;
  			addr_en_r2 <= addr_en_r1; 
  		end
  	else
  		begin
  			addr_en_r1 <= 1'b0;
  			addr_en_r1 <= addr_en_r1;
  		end
  end
*/  
//  assign addr_en = addr_en_r1 & addr_en_r1;  //产生一个周期的脉冲就好
 /*
 这里动用两个使能信号，共同控制FIFO的写使能，
 一个是任何地址出现数据的使能信号fifo_wr_en，
 一个是某个特定地址所对应的使能信号addr_en，比fifo_wr_en
 慢一拍	 
 */
  
  /***控制FIFO写入数据***/ 
/*
  always@( posedge fifo_wr_clk  )
  begin
  	if(!fifo_rst_n)
  		begin
  				wr_en <= 1'b0;
  		end
  	else
  		begin
	 			if( (prog_full == 1'b0) && (fifo_wr_en_r1 == 1'b1) && (addr_en == 1'b1))
	 				begin
	 					wr_en <= 1'b1;
	 				end
	 			else
	 				begin
	 					wr_en <= 1'b0;	
	 				end
	 		end
	end
*/  
  /********控制FIFO读数据*******/
	always @(posedge rx_fifo_rd_clk ) 
	begin
   if(!rx_fifo_rst_n)
       begin
         rd_en <= 1'b0;
       end
   else
       begin
         if(empty == 1'b0)
           begin
               rd_en <= 1'b1;
           end
         else
           begin
               rd_en <= 1'b0;
           end
       end
  end    
    
/*    
    fifo_pcie_from_pc 
    	FIFO_DMA_RX_DATA_i (
  .rst(!rx_fifo_rst_n),                      // input wire rst
  .wr_clk(rx_fifo_wr_clk),                   // input wire wr_clk
  .rd_clk(rx_fifo_rd_clk),                   // input wire rd_clk
  .din(rx_fifo_data_in),                  // input wire [63 : 0] din
  .wr_en(rx_fifo_data_wr_en),                          // input wire wr_en
  .rd_en(rd_en),                          // input wire rd_en
  .prog_empty_thresh(prog_empty_thresh),  // input wire [7 : 0] prog_empty_thresh
  .prog_full_thresh(prog_full_thresh),    // input wire [8 : 0] prog_full_thresh
  .dout(rx_fifo_data_out),                   // output wire [127 : 0] dout
  .full(full),                            // output wire full
  .wr_ack(wr_ack),                        // output wire wr_ack
  .empty(empty),                          // output wire empty
  .valid(rx_fifo_data_valid),                          // output wire valid
  .rd_data_count(rd_data_count),          // output wire [7 : 0] rd_data_count
  .wr_data_count(wr_data_count),          // output wire [8 : 0] wr_data_count
  .prog_full(prog_full),                  // output wire prog_full
  .prog_empty(prog_empty)                // output wire prog_empty
);
*/
/*    
 ILA_PCIE_TOP 
		RX_FIFO_i (
	.clk(rx_fifo_wr_clk), // input wire clk


	.probe0({            
	          rx_fifo_data_in[63:0]
	                   
	          
	}), // input wire [127:0]  probe0  
	.probe1({
    		  	rx_fifo_data_wr_en,
    		  	prog_full,
    		  	full,
    		  	rx_fifo_rst_n    		  	
				  				  
	}) // input wire [15:0]  probe1
);
*/
/*
 ILA_PCIE_TOP 
		RX_FIFO_j (
	.clk(rx_fifo_rd_clk), // input wire clk


	.probe0({
       	   rx_fifo_data_out[127:0]          
	
	}), // input wire [127:0]  probe0  
	.probe1({
    		  	rd_en,
    		  	rx_fifo_data_valid,
    		  	prog_empty,
    		  	empty,
    		  	rx_fifo_rst_n			  				  
	}) // input wire [15:0]  probe1
);
*/

 
    
endmodule
