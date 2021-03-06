`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 10:10:29
// Design Name: 
// Module Name: power_mode_modele
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


module power_mode_modele(
		input 				 clk_100M,
		input 				 power_mode_rst_n,
		input [31:0]   power_mode_predepth,
		input          power_mode_begin,
		input          trigger_in,
		input [31:0]   data_from_serdes_s1,     //低位：ch1  高位：ch2
		input [31:0]   data_from_serdes_s2,     // ch3  ch4
		input [31:0]   data_from_serdes_s3,     // ch5  ch6
		input [31:0]   data_from_serdes_s4,     // ch7  ch8
		input          data_ch1_6_valid,        //板卡的6个通道为同一个valid信号		
		input          power_rd_en2,
		
    output [127:0] power_dout_8ch,          //高位：ch1  ... 低位：ch8		
		output         power_dout_8ch_valid,
    output [12:0]  power_fifo_data_count,
		output         power_fifo_full,    
    output         power_prog_full,
    output         power_fifo_empty   

    );
    
  reg  power_wr_en ;
  reg  power_rd_en1;
  reg  trigger_pos;
  wire power_rd_en2; 
  wire power_prog_full;
  wire power_fifo_empty;
  wire power_fifo_full;
  wire [12:0] prog_empty_thresh; 
  wire power_mode_begin;
  wire trigger_in; 
  wire wr_ack;
  wire power_fifo_empty; 
  wire [12:0] power_fifo_data_count;
      
  wire [127:0] data_ch1_8;
  reg  [127:0] power_data_din;
  //调整顺序
  assign data_ch1_8 = {data_from_serdes_s1[15:0],data_from_serdes_s1[31:16],data_from_serdes_s2[15:0],data_from_serdes_s2[31:16],
  									data_from_serdes_s3[15:0],data_from_serdes_s3[31:16],data_from_serdes_s4[15:0],data_from_serdes_s4[31:16]};
  									 
  always @(posedge clk_100M )	
  begin
  	power_data_din <= data_ch1_8;	
  end
  
  always @(posedge clk_100M )	
  begin
  	if(!power_mode_rst_n)
  		trigger_pos <= 1'b0;
  	else if(power_prog_full == 1'b1)	
  		begin
  			if(trigger_in == 1'b1)
  				trigger_pos <= 1'b1;
  			else
  				trigger_pos <= trigger_pos;
  		end
  	else
  		trigger_pos <= 1'b0;
  end
  
  //读写控制 
  always @(posedge clk_100M )
	begin
		if(!power_mode_rst_n)
			begin	
				power_wr_en <= 1'b0;
				power_rd_en1 <= 1'b0;							
			end
		else if(!power_fifo_full == 1'b1)   //FIFO未写满
			begin
				if(!power_prog_full == 1'b1) 
					begin
						power_wr_en <= power_mode_begin & data_ch1_6_valid;
            power_rd_en1 <= 1'b0;
					end
				else
					begin
						if(trigger_pos == 1'b1)	  //触发到来
							begin
								power_wr_en <= power_mode_begin & data_ch1_6_valid;
								power_rd_en1 <= 1'b0;
							end
						else
							begin
								power_wr_en <= power_mode_begin & data_ch1_6_valid;
								power_rd_en1 <= power_mode_begin & data_ch1_6_valid;
							end
					end
			end
		else    //FIFO写满
			begin
				power_wr_en <= 1'b0;
				power_rd_en1 <= 1'b0;
			end							
	end
    
     
    	
	fifo_power_mode 
		fifo_power_mode_i (
  .clk(clk_100M),                              // input wire clk
  .srst(!power_mode_rst_n),                            // input wire srst
  .din(power_data_din),                              // input wire [127 : 0] din
  .wr_en(power_wr_en),                          // input wire wr_en
  .rd_en(power_rd_en1 | power_rd_en2),                          // input wire rd_en
  .prog_empty_thresh(prog_empty_thresh),  // input wire [12 : 0] prog_empty_thresh
  .prog_full_thresh(power_mode_predepth[12:0]),    // input wire [12 : 0] prog_full_thresh
  .dout(power_dout_8ch),                            // output wire [127 : 0] dout
  .full(power_fifo_full),                            // output wire full
  .wr_ack(wr_ack),                        // output wire wr_ack
  .empty(power_fifo_empty),                          // output wire empty
  .valid(power_dout_8ch_valid),                          // output wire valid
  .data_count(power_fifo_data_count),                // output wire [12 : 0] data_count
  .prog_full(power_prog_full),                  // output wire prog_full
  .prog_empty(prog_empty)                // output wire prog_empty
);
    
       
    
endmodule
