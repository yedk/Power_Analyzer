`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/13 19:00:23
// Design Name: 
// Module Name: DDR3_test
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


module DDR3_test
(
	input clk_100M,
	input rst_n,
	input ddr3_rd_en,
	input ddr_wr_en,
	input [14:0]prog_full_thresh,
	output[127:0] app_rd_data_to_pcie,
	output ddr_fifo_full,
	output ddr_fifo_empty,
    output ddr_fifo_valid

    );
    
    parameter prog_empty_thresh = 15'd0;
//	parameter prog_full_thresh = 13'd8191;
   // reg ddr_fifo_full;
   // reg ddr_fifo_empty;
   // reg ddr_fifo_valid;
  //  reg [127:0]app_rd_data_to_pcie;
    
    reg [127:0] data_test;
 (* KEEP = "TRUE" *)   reg  wr_en;
    
    always @(posedge clk_100M)
    begin
    	if(!rst_n)
    	begin
    		data_test <=128'd0;
    		wr_en <=1'b0;
    	end  
      else if(ddr_wr_en&&(~ddr_fifo_full))
    	begin
    		data_test <=data_test + 128'd1;
    		wr_en <=1'b1;
    	end
        else
    	begin
    		data_test <=data_test;
    		wr_en <=1'b0;
    	end
    end
    
    ddr3_test_fifo ddr3_test_fifo_i(
    .wr_clk(clk_100M),
    .rd_clk(clk_100M),
    .rst(!rst_n),
    .din(data_test),
    .wr_en(wr_en),
    .rd_en(ddr3_rd_en),
    .dout(app_rd_data_to_pcie),
    .full(),
    .prog_full(ddr_fifo_full),
    .prog_empty(ddr_fifo_empty),
    .prog_full_thresh(prog_full_thresh[14:0]),    
    .prog_empty_thresh(prog_empty_thresh),   
    .valid(ddr_fifo_valid)
    );
  
      ila_dde30824 PCIe_FIFO(
   .clk(clk_100M),
   .probe0({
   rst_n,
   data_test[127:0],
   ddr_wr_en,
   ddr3_rd_en,
   ddr_fifo_empty,
   ddr_fifo_full,
   ddr_fifo_valid,
   app_rd_data_to_pcie[127:0],
   prog_full_thresh[14:0]
 
 
   } )
   
   ); 
    
    
endmodule
