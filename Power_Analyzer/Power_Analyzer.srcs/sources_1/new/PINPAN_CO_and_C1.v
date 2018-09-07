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
    output  sync_en_adc_c0,   //������c0�е�������Чλ������źźܹؼ���������DDR3��ͻ����ַ��8�Ĳ���
    output  sync_en_adc_c1,   //������c1�е�������Чλ
    
    output reg [15:0]ddr3_c0, //������c0�е�����
    output reg [15:0]ddr3_c1, //������c1�е�����
    output fenliu_stream_flag,//���������ݵķ�����־
    input  init_done_c0,      //c0��ʼ������ź�
    input  init_done_c1,      //c1��ʼ������ź�
    input  [28:0]count_depth,
        
    output reg wen_ddr3_c0,//��дc0�Ŀ����ź���
    output reg ren_ddr3_c0,
    output reg wen_ddr3_c1,//��дC1�Ŀ����ź���
    output reg ren_ddr3_c1,
       
    input  start_pingpang
    
   
    );
    
    reg [3:0] count_sync1; 
   //assign   adc_refclk=clk_f;
    
    	//��1M��ʱ�ӽ���ģ��
	reg [10:0]cnt_1M;
	reg adc_refclk;
 
	
	always @(posedge clk_f )
	begin	   	
      if(cnt_1M==11'd960)//25KB/s
       begin
		      adc_refclk<=~adc_refclk;//////adc_refclkΪ1Mʱ�ӣ�
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
	                                                      ///�������ݵ���Դƪ//////////////////////////////////////
	                                                      /////////////////////////////////////////////////////////
	
	//�������ݲ�����һ��λ���Ϳ���*************************************************
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
		//else if(count_sync1 == 4'd0 )     //ģ��8ͨ��ģʽ
    //else if(count_sync1 == 4'd1 )     //ģ��4ͨ��ģʽ
    //else if(count_sync1 == 4'd3 )     //ģ��2ͨ��ģʽ
    //else if(count_sync1 == 4'd7 )     //ģ��1ͨ��ģʽ
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
    //else if(count_sync1 == 4'd0 )     //ģ��8ͨ��ģʽ
    //else if(count_sync1 == 4'd1 )     //ģ��4ͨ��ģʽ             //��Ϊ���ڷ��͡��������
    //else if(count_sync1 == 4'd3 )     //ģ��2ͨ��ģʽ
    //else if(count_sync1 == 4'd7 )     //ģ��1ͨ��ģʽ
    else if(count_sync1 == 4'd0 )
    	begin
    		count_sync1 <= 4'd0;
    		sync_en_adc1 <= 1'b1;            //sync_en_adc1Ϊ��һ��FIFO��дʹ���ź�
    		ddr_data1 <= {card1_data,card2_data,card3_data,card4_data,card5_data,card6_data,card7_data,card8_data}; //ddr_data1Ϊ��һ��fifo��д������
    	end
    else
    	begin
    		count_sync1 <= count_sync1 + 1'b1;
    		sync_en_adc1 <= 1'b0; 
    		ddr_data1 <= ddr_data1;     //����һ��ʱ�ӣ���֤һ�����ݣ�ռ������ʱ�ӿ��
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
  
 
  
     //��һ����ʱ����ת����ʱ�Ӵ�clk_f��clk_100M������λ���16*8bit��16bit			
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
  
   ///�����������fifo��16bits���м���,�Լ��������ı�־
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
       			if(count_pinpang == (count_depth[28:1]+3'b011))//������128��16bit�����ݣ���ð�һ������д�뵥Ƭ��ddr3��
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
    //����fenliu_stream_flag���ж�����������������ݵ���Ч��־λͬ��
     always@(posedge clk_100M) 
       begin
       	if(fenliu_stream_flag==1'd1)//����Ƭc0����д״̬�Ҽ����������ʱ���Ͱ����ݷ�����ddr3_c0
       	    ddr3_c0<=  ddr_data_out;       	
       else
       	    ddr3_c1<=  ddr_data_out;  
      end                 
    assign sync_en_adc_c0=  sync_en_adc&fenliu_stream_flag;
    assign sync_en_adc_c1=  sync_en_adc&(~fenliu_stream_flag);
    
       
    //����д�źźͶ��źŵ����wen_ddr3_c0 ; ren_ddr3_c0;
    
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
        else if ((init_done_c0&init_done_c1)==1'd1&start_pingpang)//����ƬDDR3������ʼ����ɵ�״̬��ʱ��������start_pingpang���������ݶ���������ݵļ���ֵ���ж�д����
         
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
        
                
   
//����һ���������Ķ��ź�����c0
  reg [31:0]ism_rd_cnt_c0;
  reg  rd_singnal_c0;
 
   always@(posedge clk_100M) 
    begin 
    		  if(!rst_n)   
     	    	  begin              
     	    			ism_rd_cnt_c0 <=  32'd0;        	       
     	        end    	
        else if(~fenliu_stream_flag)//�½��صĵ���                
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
      
//����һ���������Ķ��ź�����c1    
  reg [31:0]ism_rd_cnt_c1;
  reg  rd_singnal_c1;
   always@(posedge clk_100M) 
    begin 
    		  if(!rst_n)   
     	    	  begin              
     	    			ism_rd_cnt_c1 <=  32'd0;        	       
     	        end    	
        else if(fenliu_stream_flag)//�½��صĵ���                
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
