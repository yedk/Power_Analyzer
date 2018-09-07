`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: HXS
// 
// Create Date: 2018/06/07 11:06:41
// Design Name: 
// Module Name: PINGPANG_CO_and_C1
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


module PINPAN_CO_and_C1(    
    input clk_f,
    input rst_n,
    input clk_100M,
    input c0_wr_burst_req,
 //   output [15:0]ddr_data_out,
    output  sync_en_adc_c0,   //待存入c0中的数据有效位，这个信号很关键，决定了DDR3的突发地址加8的操作
    output  sync_en_adc_c1,   //待存入c1中的数据有效位
    
    output reg [15:0]ddr3_c0, //待存入c0中的数据
    output reg [15:0]ddr3_c1, //待存入c1中的数据
    output fenliu_stream_flag,//对流入数据的分流标志
    input  init_done_c0,      //c0初始化完成信号
    input  init_done_c1,      //c1初始化完成信号
    input  [28:0]count_depth,
        
    output reg wen_ddr3_c0,//读写c0的控制信号线
    output reg ren_ddr3_c0,
    output reg wen_ddr3_c1,//读写C1的控制信号线
    output reg ren_ddr3_c1,
       
    input  start_pingpang
    
   
    );
    
    reg [3:0] count_sync1; 
   //assign   adc_refclk=clk_f;
    
    	//对1M的时钟进行模拟
	reg [10:0]cnt_1M;
	reg adc_refclk;
 
	
	always @(posedge clk_f )
	begin	   	
      if(cnt_1M==11'd960)//25KB/s
       begin
		      adc_refclk<=~adc_refclk;//////adc_refclk为1M时钟；
		      cnt_1M<=11'd0;
		    end
		else
			cnt_1M <= cnt_1M+1'd1;
	end
	
	
 reg rd_en_2; 	
  	  
	always @(posedge clk_100M )
	begin
		if(!rst_n)
			rd_en_2 <= 1'd0;
		else if(!empty_2 == 1'b1)
			rd_en_2 <= 1'b1;
		else
			rd_en_2 <= 1'b0;
	end

  	   
    
	                                                      /////////////////////////////////////////////////////////
	                                                      ///仿真数据的来源篇//////////////////////////////////////
	                                                      /////////////////////////////////////////////////////////
	
	//测试数据产生，一复位，就开跑*************************************************
	reg [15:0]card0_data,card1_data,card2_data,card3_data,card4_data,card5_data,card6_data,card7_data,card8_data;
	always @(posedge adc_refclk)
	begin
		if(!rst_n)
		  begin
		    card1_data <= 16'd1;
		    card2_data <= 16'd2;
		    card3_data <= 16'd3;
		    card4_data <= 16'd4;
		    card5_data <= 16'd5;
		    card6_data <= 16'd6;
		    card7_data <= 16'd7;
		    card8_data <= 16'd8;
		    card0_data <= 16'd0;
		  end
		//else if(count_sync1 == 4'd0 )     //模拟8通道模式
    //else if(count_sync1 == 4'd1 )     //模拟4通道模式
    //else if(count_sync1 == 4'd3 )     //模拟2通道模式
    //else if(count_sync1 == 4'd7 )     //模拟1通道模式
		else if(count_sync1 == 4'd0 )
		  begin
		  	card0_data <= card0_data + 16'd8;
		    card1_data <= card0_data + 16'd9;
		    card2_data <= card1_data + 16'd9;
		    card3_data <= card2_data + 16'd9;
		    card4_data <= card3_data + 16'd9;
		    card5_data <= card4_data + 16'd9;
		    card6_data <= card5_data + 16'd9;
		    card7_data <= card6_data + 16'd9;
		    card8_data <= card7_data + 16'd9;
		  end
		else
		 	begin
		 		card1_data <= card1_data;
		 		card2_data <= card2_data;
		 		card3_data <= card3_data;
		 		card4_data <= card4_data;
		 		card5_data <= card5_data;
		 		card6_data <= card6_data;
		 		card7_data <= card7_data;
		 		card8_data <= card8_data;
		 	end
	end
  
  always @(posedge adc_refclk)
  begin
    if(!rst_n)
    	begin
    		sync_en_adc1 <= 1'b0;
    		count_sync1  <= 4'd0;
    		ddr_data1    <= 128'd0;
    	end
    //else if(count_sync1 == 4'd0 )     //模拟8通道模式
    //else if(count_sync1 == 4'd1 )     //模拟4通道模式             //改为串口发送。方便调试
    //else if(count_sync1 == 4'd3 )     //模拟2通道模式
    //else if(count_sync1 == 4'd7 )     //模拟1通道模式
    else if(count_sync1 == 4'd0 )
    	begin
    		count_sync1 <= 4'd0;
    		sync_en_adc1 <= 1'b1;            //sync_en_adc1为第一级FIFO的写使能信号
    		ddr_data1 <= {card1_data,card2_data,card3_data,card4_data,card5_data,card6_data,card7_data,card8_data}; //ddr_data1为第一级fifo的写入数据
    	end
    else
    	begin
    		count_sync1 <= count_sync1 + 1'b1;
    		sync_en_adc1 <= 1'b0; 
    		ddr_data1 <= ddr_data1;     //保持一个时钟，保证一个数据，占用两个时钟宽度
    	end                         
  end
  
   reg [127:0]ddr_data1;
	reg sync_en_adc1;
	wire empty_2;
	wire full_2;
	wire wr_ack_2;
	wire prog_full_2;			
	wire prog_empty_2;
	reg rd_en_2; 	
  wire [15:0] ddr_data_out;
  
 
  
     //第一级跨时钟域转换，时钟从clk_f到clk_100M，数据位宽从16*8bit到16bit			
       	fifo_ddr3_first 
       		fifo_data_i (
         .rst(!rst_n),                              // input wire rst
         .wr_clk(adc_refclk),                        // input wire wr_clk
         .rd_clk(clk_100M),                        // input wire rd_clk
         .din(ddr_data1),                              // input wire [127 : 0] din
         .wr_en(sync_en_adc1),                          // input wire wr_en
         .rd_en(rd_en_2),                          // input wire rd_en
         .prog_empty_thresh(10'd10),               // input wire [9 : 0] prog_empty_thresh
         .prog_full_thresh(7'd100),              // input wire [6 : 0] prog_full_thresh
         .dout(ddr_data_out),                            // output wire [15 : 0] dout
         .full(full_2),                            // output wire full
         .wr_ack(wr_ack_2),                        // output wire wr_ack
         .empty(empty_2),                          // output wire empty
         .valid(sync_en_adc),                          // output wire valid
         .rd_data_count(),                     // output wire [9 : 0] rd_data_count
         .wr_data_count(),                     // output wire [6 : 0] wr_data_count
         .prog_full(prog_full_2),                   // output wire prog_full
         .prog_empty(prog_empty_2)                // output wire prog_empty
       );	
  
   ///对数据流输出fifo的16bits进行计数,以及数据流的标志
      reg [28:0]count_pinpang; 
      reg c0_ping_wr;
      reg c1_pang_wr;
      reg fenliu_stream_flag; 
            
     always@(posedge clk_100M)
       begin
       	if(!rst_n)
       			count_pinpang <= 29'd0;
       	else if(sync_en_adc == 1'b1&start_pingpang)        
       		begin                         
       			if(count_pinpang == (count_depth[28:1]+3'b011))//计满了128个16bit的数据，搞好把一对数据写入单片的ddr3中
       			   begin       			
       			    	count_pinpang <= 29'd0;
       			    	fenliu_stream_flag  <= ~fenliu_stream_flag;     			    	
       			   end 	
       			else
       				count_pinpang <= count_pinpang + 1'b1;
       		end
       	else
       		count_pinpang <= count_pinpang;
       end
    //根据fenliu_stream_flag进行对数据流的输出和数据的有效标志位同步
     always@(posedge clk_100M) 
       begin
       	if(fenliu_stream_flag==1'd1)//当单片c0处于写状态且计数个数达标时，就把数据分留给ddr3_c0
       	    ddr3_c0<=  ddr_data_out;       	
       else
       	    ddr3_c1<=  ddr_data_out;  
      end                 
    assign sync_en_adc_c0=  sync_en_adc&fenliu_stream_flag;
    assign sync_en_adc_c1=  sync_en_adc&(~fenliu_stream_flag);
    
       
    //控制写信号和读信号的输出wen_ddr3_c0 ; ren_ddr3_c0;
    
   always@(posedge clk_100M) 
     begin
     	  if(!rst_n)   
     	    	  begin              
     	    			wen_ddr3_c0<=  1'b0;   
     	          ren_ddr3_c0<=  1'b0;  
     	        end 
        else if (~start_pingpang)
              begin
                wen_ddr3_c0<=  1'b0;
                ren_ddr3_c0<=  1'b0;    
             end
        else if ((init_done_c0&init_done_c1)==1'd1&start_pingpang)//当两片DDR3颗粒初始化完成的状态下时，开启了start_pingpang操作，根据对流入的数据的计数值进行读写控制
         
          	    begin     	    
          	    wen_ddr3_c0<= fenliu_stream_flag; 
      	        ren_ddr3_c0<= rd_singnal_c0;      
      	        wen_ddr3_c1<= ~fenliu_stream_flag; 
      	        ren_ddr3_c1<= rd_singnal_c1;       	       
      	        end
          else
              begin
        	    wen_ddr3_c0<=  wen_ddr3_c0; 
        	    ren_ddr3_c0<=  ren_ddr3_c0;
        	    wen_ddr3_c1<=  wen_ddr3_c1; 
        	    ren_ddr3_c1<=  ren_ddr3_c1;       	   
        	   end
        end  
        
                
   
//产生一个虚拟仿真的读信号用于c0
  reg [31:0]ism_rd_cnt_c0;
  reg  rd_singnal_c0;
 
   always@(posedge clk_100M) 
    begin 
    		  if(!rst_n)   
     	    	  begin              
     	    			ism_rd_cnt_c0 <=  32'd0;        	       
     	        end    	
        else if(~fenliu_stream_flag)//下降沿的到来                
               ism_rd_cnt_c0 <= ism_rd_cnt_c0+1'b1;                
          else 
                ism_rd_cnt_c0 <= 32'd0;
     end
 
    always@(posedge clk_100M) 
      begin
      	  if(!rst_n)   
     	    	  begin              
     	    			rd_singnal_c0 <= 1'b0;        	       
     	        end 
           else if(ism_rd_cnt_c0>=5'd10&& ism_rd_cnt_c0<31'd1024)
               rd_singnal_c0 <= 1'b1;   
           else 
             rd_singnal_c0 <=  1'b0;
 
      end
      
//产生一个虚拟仿真的读信号用于c1    
  reg [31:0]ism_rd_cnt_c1;
  reg  rd_singnal_c1;
   always@(posedge clk_100M) 
    begin 
    		  if(!rst_n)   
     	    	  begin              
     	    			ism_rd_cnt_c1 <=  32'd0;        	       
     	        end    	
        else if(fenliu_stream_flag)//下降沿的到来                
               ism_rd_cnt_c1 <= ism_rd_cnt_c1+1'b1;                
          else 
                ism_rd_cnt_c1 <= 32'd0;
     end
 
    always@(posedge clk_100M) 
      begin
      	  if(!rst_n)   
     	    	  begin              
     	    			rd_singnal_c1 <= 1'b0;        	       
     	        end 
           else if(ism_rd_cnt_c1>=5'd10&& ism_rd_cnt_c1<31'd1024)
               rd_singnal_c1 <= 1'b1;   
           else 
             rd_singnal_c1 <=  1'b0;
 
      end
       
          
    	ila_3 
			pingpang (
			.clk(clk_100M), // input wire clk
		
		
			.probe0({
			         rst_n,
			         adc_refclk,
			         sync_en_adc1,
			         fenliu_stream_flag,
			         sync_en_adc,
			         c0_wr_burst_req,
			         init_done_c0,
			         start_pingpang,
			         ren_ddr3_c0_r,
			         ren_ddr3_c0,
			         rd_singnal_c0,
			         rd_singnal_c1
			        		         		         		        			         		         			
						}), // input wire [31:0]  probe0  
			.probe1({
			
							  ddr_data1     [127:0],		    	  
					    	ddr_data_out  [15:0],
					    	count_pinpang [28:0],					    						  
					    	ddr3_c0[15:0], 
					    	sync_en_adc_c0,
					    	ddr3_c1[15:0],
					    	sync_en_adc_c0,
					    	ism_rd_cnt_c0[31:0],  
					    	ism_rd_cnt_c1[31:0]
					    				    
							}) // input wire [311:0]  probe1
		);   
   
    
    
    
    
    
    
    
    
    
endmodule
