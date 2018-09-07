`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/13 10:39:53
// Design Name: 
// Module Name: wr_addr1
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


module ddr3_wr_addr(

		input 				clk_100M              ,//Ϊadcͬ��ʱ��
	  input 				rst_n                 ,///��λ��0��Ч
	  input [4:0] 	DIMMdepth_ctrl        ,//�洢��ȿ���
	  input [29:0] 	addr_wr_init          , 
	  input 				ddr3_wr_begin         ,///д��ַ����ʹ�� ��ddr״̬������
	  input 				sync_en               ,///д��ַ����ʹ�ܵ���Чʹ�ܣ�����Ч�������ݵ�ͬ��ʹ��
		input 				DIMMdepth_mode        ,
		input [31:0] 	predepth              ,
		
		output [28:0] 	num_DIMM_depth    ,//29λ�����ô洢��ȵ�ʵ��ֵ������������д�ľ�ȷ����
		
		output reg [28:0] depth_ctrl_out    , //no used
		output reg [29:0] app_addr_r2        ,///д��ַ���,��28λ
		output reg 				app_en_r2          ,
		output reg 				flag_pos_tri			,
		output reg 				addr_wr_stop      ,      //д��ַ�����ź� 
		output            data_wr_stop_r2,
		output reg [29:0] addr_trig         ,         ///������ַ
		output reg [29:0]	addr_again_started,
		output data_wr_on,
		output sync_valid,	
		input   pc_stop_ddr                 , //0:ϵͳ����ddr3ɨ��ģʽʱpc_stop_ddrΪ��ʱֹͣд����
		input   fifo_ddr3_scan               //0:ddr3ɨ��ģʽ
		 
    );
    
  
  localparam START       = 4'b0001;
	localparam PRE_TRIG    = 4'b0010;
	localparam WAIT_TRIG   = 4'b0100;//READY
	localparam POS_TRIG    = 4'b1000;
	(* FSM_ENCODING="ONE-HOT", SAFE_IMPLEMENTATION="NO" *) 
	reg [3:0] state;                 //����K7���ܣ�����(*KEEP="TRUE"*)
//	wire auto_rd_en;

  reg [28:0] num_DIMM_depth;
  reg [28:0]half_depth_ctrl_reg;  
  reg [28:0]depth_ctrl_reg; 
  reg [28:0]num_DIMM_depth_reg;
  reg  [4:0]DIMMdepth_ctrl_r1;
  reg [2:0] count_sync;
  wire sync_valid;
  reg app_en_r1;
  reg [29:0]addr_burst;  
  reg [29:0]app_addr_burst_r;
     
  reg addr_wr_stop;      //д��ַ�����ź�
  reg data_wr_stop;  
  wire data_wr_on;  
  //��������DDR3״̬�����ź� 
  //reg [28:0]app_addr_r2;
  //reg app_en_r2;
  wire [29:0] addr_wr_out_r;
  //reg flag_pos_tri;
  reg [29:0] addr_trigged;
  reg [28:0] half_depth_burst_addr;
  reg [27:0]addr_again_started_dly;
      
	always @(posedge clk_100M) //���ô洢��ȵ�ʵ��ֵ����64bit����Ϊ��������2^28*64bit=2GB
	begin
		if(!rst_n)
			depth_ctrl_reg[28:0] <= 29'b11111111111111111111111111111;///2G
		else
			begin
				case(DIMMdepth_ctrl_r1)
				5'b00000 : depth_ctrl_reg[28:0] <=  {1'b0,28'b1111111111111111111111111000};///256M   ��ַ�仯��8λ��׼
				5'b00001 : depth_ctrl_reg[28:0] <= { 2'b00,27'b111111111111111111111111000};///128M
				5'b00010 : depth_ctrl_reg[28:0] <= { 3'b000,26'b11111111111111111111111000};///64M
				5'b00011 : depth_ctrl_reg[28:0] <= { 4'b0000,25'b1111111111111111111111000};///32M
				5'b00100 : depth_ctrl_reg[28:0] <= { 5'b00000,24'b111111111111111111111000};///16M
				5'b00101 : depth_ctrl_reg[28:0] <= { 6'b000000,23'b11111111111111111111000};///8M
				5'b00110 : depth_ctrl_reg[28:0] <= { 7'b0000000,22'b1111111111111111111000};///4M
				5'b00111 : depth_ctrl_reg[28:0] <= { 8'b00000000,21'b111111111111111111000};///2M
				5'b01000 : depth_ctrl_reg[28:0] <= { 9'b000000000,20'b11111111111111111000};///1M
				5'b01001 : depth_ctrl_reg[28:0] <= {10'b0000000000,19'b1111111111111111000};///512K
				5'b01010 : depth_ctrl_reg[28:0] <= {11'b00000000000,18'b111111111111111000};///256k
				5'b01011 : depth_ctrl_reg[28:0] <= {12'b000000000000,17'b11111111111111000};///128K
				5'b01100 : depth_ctrl_reg[28:0] <= {13'b0000000000000,16'b1111111111111000};///64K
				5'b01101 : depth_ctrl_reg[28:0] <= {14'b00000000000000,15'b111111111111000};///32K
				5'b01110 : depth_ctrl_reg[28:0] <= {15'b000000000000000,14'b11111111111000};///16K    2048��ͻ������
				5'b01111 : depth_ctrl_reg[28:0] <= {16'b0000000000000000,13'b1111111111000};///8K     1014��ͻ������
				5'b10000 : depth_ctrl_reg[28:0] <= {17'b00000000000000000,12'b111111111000};///4K     512��ͻ������ 
				5'b10001 : depth_ctrl_reg[28:0] <= {18'b000000000000000000,11'b11111111000};///2K 	  256��ͻ������
				5'b10010 : depth_ctrl_reg[28:0] <= {19'b0000000000000000000,10'b1111111000};///1K  	  128��ͻ������
				5'b10011 : depth_ctrl_reg[28:0] <= {20'b00000000000000000000, 9'b111111000};///0.5K  	  64��ͻ������
				5'b10100 : depth_ctrl_reg[28:0] <= {21'b000000000000000000000, 8'b11111000};///0.25K  	  32��ͻ������
				5'b10101 : depth_ctrl_reg[28:0] <= {22'b0000000000000000000000, 7'b1111000};///0.125K  	 128/8=16��ͻ������---16*64bit=1024bits=1/8KB
				5'b10110 : depth_ctrl_reg[28:0] <= {29'b11111111111111111111111111000};///512M
				default: depth_ctrl_reg[28:0] <=   {22'b000000000000000000000, 7'b1111000};///1K
			endcase
		end
	end                                               //����depth_ctrl_reg[28:0]�仯1����λ�����ݱ仯64bit
                                                  //predepth[31:0]�仯һ����λ�����ݱ仯128bit
	///DIMMд��ַ��дʹ�ܵ��������                   //ͳһת��Ϊʵ�ʵ�ַ���������У���һ����ַ64bit
	always @(posedge clk_100M)                        //8����ַ512bit
	//begin                                             //��predepth����һλ��ת��Ϊ��depth_ctrl_regһ������
	//  DIMMdepth_ctrl_r1 <=DIMMdepth_ctrl;
	//  num_DIMM_depth_reg <= num_DIMM_depth_dsp;
	//  if(DIMMdepth_mode == 0)
	  	begin 
	  		DIMMdepth_ctrl_r1 <=DIMMdepth_ctrl;
	  	  num_DIMM_depth <= depth_ctrl_reg;
			  //half_depth_ctrl_reg <= {num_DIMM_depth[28:1]} - {predepth[27:2],2'b00};//��Ӧ128bit������(ͻ������8)�����������=�ܴ洢���-Ԥ�������
	  		half_depth_ctrl_reg <= {num_DIMM_depth[28:0]}; 
	  	end                //��λ��������Ԥ�������ÿ�仯1�Σ����𴥷�����ȱ仯Ϊ512bit

  
  /**DDR3ͻ������Ϊ8��8����ַ����װ64bit���ݣ���ôд��FIFO����Ϊ128bit��Ϊ1:4��ϵ
    Ҳ����˵��д��FIFO��4�����ݣ�DDR3ֻ��Ҫдһ��**/     

    //FIFOһ��ʱ������16bits,ͻ������Ϊ64bits
    always@(posedge clk_100M)
    begin
    	if(!rst_n)
    			count_sync <= 2'd0;
    	else if(sync_en == 1'b1)        
    		begin                         
    			if(count_sync == 2'd3 )
    				count_sync <= 2'd0;
    			else
    				count_sync <= count_sync + 1'b1;
    		end
    	else
    		count_sync <= count_sync;
    end
    assign sync_valid = count_sync[1] & count_sync[0] & sync_en;   //count_sync����Ϊ3ʱ��ͬ����Ч
    
    
    
    
    
    reg addr_wr_up;
    reg data_wr_up;                                         //����sync_valid��sync_en��ͬһ�ĵ�          
    always @(posedge clk_100M)
    begin
    	if(!rst_n)
    			begin
    				addr_wr_up <= 1'b0;
    				data_wr_up <= 1'b0;
    			end    
    	else if((ddr3_wr_begin == 1'b1) && (count_sync == 2'd0))
    			begin
    				addr_wr_up <= 1'b1;
    				data_wr_up <= 1'b1;
    			end                
    	else
    			begin
    				addr_wr_up <= addr_wr_up;
    				data_wr_up <= data_wr_up;
    			end     
    end 
    
  

    
    //����app_en_r2��app_addr_r2
    always@(posedge clk_100M)
    begin
    	if(!rst_n)
    		begin
    			app_en_r1 <= 1'b0; 
    			addr_burst <= 30'd0;
    			app_addr_burst_r <= 30'd0;
    			
    		end                      //&& (addr_wr_stop == 1'b0)
    	else if((ddr3_wr_begin == 1'b1) && (addr_wr_up == 1'b1) )  //addr_wr_stop����֮�󣬲�������ddr3_wr_begin
    		begin                                     //��ʵҲ���Բ���addr_wr_stop
    			if(sync_valid == 1'b1)
    				begin
    					app_en_r1 <= 1'b1;   //ע���sync_valid��һ��
    					app_addr_burst_r <= {addr_burst[29:0]} ;  //���Ա�֤һ�����帳��ƫ�Ƶ�ַ0����ƫ�Ƶ�ַ��0��ʼ
    					addr_burst <= {addr_burst + 30'd8} & {depth_ctrl_reg[28:0]}; 
    				    //��һ����������FIFOдʹ�ܿ���, //���ݵ���ʽ�����ź�    				
    				end
    			else
    				begin
    					app_en_r1 <= 1'b0;
    					app_addr_burst_r <= app_addr_burst_r;
    					addr_burst <= addr_burst;   				    					
    				end
    		end
    	else
    		begin
    			app_en_r1 <= 1'b0;
    			app_addr_burst_r <= 30'd0;
    			addr_burst <= 30'd0;
    	
    		end
    end
    //����ʱ�����������ݵ���ʽ�����ź�data_wr_stop
    always @(posedge clk_100M)          
    begin
    	if(!rst_n)                       
    			data_wr_stop <= 1'b0;
    else if((app_en_r2_count >= half_depth_ctrl_reg[28:3]) && (count_sync == 2'd0))
    		data_wr_stop <= 1'b1;                //ע�⣺��ʱdata_wr_stop��app_en_r1��fifo_wr_upͬ��
    	else
    		data_wr_stop <= 1'b0;     //fifo_wr_up��data_wr_stopһ��������ݵĿ����ͽ���
    end 
    //����app_en_r1�ӳ�������ʱ�Ӳ�����FIFOд�˿ڣ���ôfifo_wr_up��data_wr_stopҲҪ�ӳ�����ʱ��  
    
   wire data_wr_stop_second;
  assign  data_wr_stop_second=(app_en_r2_count==(half_depth_ctrl_reg[28:3]))? 1'b1:0;  
  
                             
    reg data_wr_up_r1;
    reg data_wr_up_r2;
    reg data_wr_stop_r1;
    reg data_wr_stop_r2;
    always @(posedge clk_100M)
    begin
    	data_wr_up_r1 <= data_wr_up;
    	data_wr_up_r2 <= data_wr_up_r1;
    	data_wr_stop_r1 <= data_wr_stop;
    	data_wr_stop_r2 <= data_wr_stop_r1;
    end
    
    
    //assign data_wr_on =  fifo_wr_up_r2 ^ data_wr_stop_r2 ; //fifo_wr_up��data_wr_stop���
    assign data_wr_on =  data_wr_up_r2 ^ data_wr_stop_r2 ;
		//�����ַ���⣬���������仯����app_addr_burst_rΪƫ�Ƶ�ַ�����������䳬Խdepth_ctrl_reg
		//����������ʵ�ʵ�ַ{addr_wr_init} ����> {addr_wr_init+depth_ctrl_reg}��תȦȦ
		///DIMMд��ַ��дʹ�ܵ�������ƣ���Ӧ64bit�ĵ�ַ
		always @(posedge clk_100M) 
		begin
			//app_addr_r2 <= {app_addr_burst_r[28:0]} & {depth_ctrl_reg[28:0]} + {addr_wr_init[28:0]}; 
			app_addr_r2 <= {app_addr_burst_r[29:0]}  + {addr_wr_init[29:0]};
			app_en_r2   <= app_en_r1;    
		end     //{app_addr_burst_r[28:0]} & {depth_ctrl_reg[28:0]} ��Ȼ��ƫ�Ƶ�ַ
  	        //app_addr_r2Ϊʵ�ʵ�ַ��ע�⣺��ʱ��app_addr_r��app_en_r1��һ�ģ�����Ϊapp_en_r2
  	        //����app_en_r2��app_addr_r2��sync_en������
  	assign addr_wr_out_r = {app_addr_burst_r[29:0]} ;  
 
 //��д��ĸ������м��� 	
 reg[31:0] 	app_en_r2_count;
 	always @(posedge clk_100M)
		begin
			if(!rst_n)
				begin
					app_en_r2_count <= 32'd0;
				end
			else if(ddr3_wr_begin == 1'b1)
				begin
					if(app_en_r2)
						app_en_r2_count <= app_en_r2_count +1'b1;
					else
						app_en_r2_count <= app_en_r2_count;
				end
			else
				app_en_r2_count <= 32'd0;
		end
		 	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
/*  	
  	//��sync_en��ddr_data[127:0]������
  	always @(posedge clk_100M) 
  	begin
  		sync_en_r1 <= sync_en;
  		sync_en_r2 <= sync_en_r1;
  		ddr_data_r1 <= ddr_data;
  		ddr_data_r2 <= ddr_data_r1;
  	end
*/  	
/*
		///������ַ�������
		always @(posedge clk_100M) 
		begin
			addr_trig <= addr_trigged; 
			addr_again_started <= addr_again_started_dly;
			depth_ctrl_out <= depth_ctrl_reg;
		end

 	 
  	 
		always @(posedge clk_100M) 
		begin
			if(!rst_n)
				begin			
					flag_pos_tri <= 1'b0;
					addr_wr_stop <= 1'b0;
					addr_trigged <= 29'h00000;
					half_depth_burst_addr <= 29'd0;
					state <= START;
				end
			else
				begin
					//(* FULL_CASE, PARALLEL_CASE *)
					case(state)
						START:
							begin
								flag_pos_tri <= 1'b0;
								if(ddr3_wr_begin == 1'b1 )       //Ӧ�ø�Ϊ�����أ�����ÿ��д���и�λ��Ҳ��OK��
									state <= PRE_TRIG;
								else
									state <= START;
							end
						PRE_TRIG:
							begin
								flag_pos_tri <= 1'b0;
								if(auto_rd_en == 1'b1)
									state <= WAIT_TRIG;
								else
									state <= PRE_TRIG;
							end
						WAIT_TRIG:
							begin
								flag_pos_tri <= 1'b0;
								if(auto_rd_en == 1'b1 & fifo_ddr3_scan == 0)//ddr3ģʽ
									begin
										state <= WAIT_TRIG;
									end							
								else 
									begin
										state <= POS_TRIG;
										addr_trigged <= addr_wr_out_r[29:0];    //�����ַΪ8����������������Ҫ��λ���޸�һ��
										//flag_pos_tri <= 1'b1;            //��ʱ���޸�flag_pos_tri   
									end
								end
						POS_TRIG:
							begin
								flag_pos_tri <= 1'b1;
								if(half_depth_burst_addr[27:0] >= half_depth_ctrl_reg[28:1])      //ֹͣ�ж�����
									begin
										addr_wr_stop <= 1'b1; //�����addr_wr_stop��������״̬������ôapp_en_r�޷������һ���������ȥ
										half_depth_burst_addr <= 29'd0;		//��״̬�����黹��ʹ��data_wr_stop�ź�							   
										addr_again_started_dly <= app_addr_burst_r[29:0];
										state <= START;
									end
								else if(sync_valid == 1'b1)         //������sync_valid������һֱΪ�ߣ����õ�������������ж�
									begin
										half_depth_burst_addr	<= half_depth_burst_addr + 29'd8;							
										flag_pos_tri <= 1'b1; 
										addr_wr_stop <= 1'b0;
										state <= POS_TRIG; 
									end
								end
						default:
							begin						
								flag_pos_tri <= 1'b0;
								state <= START;
							end
					endcase
				end
		end    
   */
   /*
 		ila_2 
			wr_addr_100M (
			.clk(clk_100M), // input wire clk
		
		
			.probe0({
			         rst_n,
			         ddr3_wr_begin, 
			         sync_en,      
			         DIMMdepth_mode,
			         auto_rd_en, 
			         app_en_r2    ,
			         flag_pos_tri,
			         addr_wr_stop,
			         data_wr_on,
			         sync_valid,
			         app_en_r1,
			       
			         data_wr_stop,
			         data_wr_stop_second
			         
			         		        
			         		         			
						}), // input wire [31:0]  probe0  
			.probe1({
							  DIMMdepth_ctrl_r1[4:0],
							  depth_ctrl_reg[28:0],
							  half_depth_ctrl_reg[28:0],
							  predepth[29:0],
							  app_addr_burst_r[29:0],  
					    	addr_burst[29:0],
					    	addr_wr_init[29:0],
					    	app_addr_r2[29:0],
					    	addr_wr_out_r[29:0],
					    	app_en_r2_count[31:0],
					    	state[3:0],
					    	count_sync[2:0],
					    	half_depth_burst_addr[28:0]			    	  
					    					    
							}) // input wire [311:0]  probe1
		);   
   */
    
endmodule
