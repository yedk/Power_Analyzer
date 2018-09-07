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

		input 				clk_100M              ,//为adc同步时钟
	  input 				rst_n                 ,///复位，0有效
	  input [4:0] 	DIMMdepth_ctrl        ,//存储深度控制
	  input [29:0] 	addr_wr_init          , 
	  input 				ddr3_wr_begin         ,///写地址计数使能 ，ddr状态机产生
	  input 				sync_en               ,///写地址计数使能的有效使能，即有效采样数据的同步使能
		input 				DIMMdepth_mode        ,
		input [31:0] 	predepth              ,
		
		output [28:0] 	num_DIMM_depth    ,//29位，设置存储深度的实际值，反馈到读和写的精确计数
		
		output reg [28:0] depth_ctrl_out    , //no used
		output reg [29:0] app_addr_r2        ,///写地址输出,共28位
		output reg 				app_en_r2          ,
		output reg 				flag_pos_tri			,
		output reg 				addr_wr_stop      ,      //写地址结束信号 
		output            data_wr_stop_r2,
		output reg [29:0] addr_trig         ,         ///触发地址
		output reg [29:0]	addr_again_started,
		output data_wr_on,
		output sync_valid,	
		input   pc_stop_ddr                 , //0:系统处于ddr3扫描模式时pc_stop_ddr为高时停止写操作
		input   fifo_ddr3_scan               //0:ddr3扫描模式
		 
    );
    
  
  localparam START       = 4'b0001;
	localparam PRE_TRIG    = 4'b0010;
	localparam WAIT_TRIG   = 4'b0100;//READY
	localparam POS_TRIG    = 4'b1000;
	(* FSM_ENCODING="ONE-HOT", SAFE_IMPLEMENTATION="NO" *) 
	reg [3:0] state;                 //先在K7上跑，不加(*KEEP="TRUE"*)
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
     
  reg addr_wr_stop;      //写地址结束信号
  reg data_wr_stop;  
  wire data_wr_on;  
  //真正赋给DDR3状态机的信号 
  //reg [28:0]app_addr_r2;
  //reg app_en_r2;
  wire [29:0] addr_wr_out_r;
  //reg flag_pos_tri;
  reg [29:0] addr_trigged;
  reg [28:0] half_depth_burst_addr;
  reg [27:0]addr_again_started_dly;
      
	always @(posedge clk_100M) //设置存储深度的实际值，以64bit数据为基础，共2^28*64bit=2GB
	begin
		if(!rst_n)
			depth_ctrl_reg[28:0] <= 29'b11111111111111111111111111111;///2G
		else
			begin
				case(DIMMdepth_ctrl_r1)
				5'b00000 : depth_ctrl_reg[28:0] <=  {1'b0,28'b1111111111111111111111111000};///256M   地址变化以8位基准
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
				5'b01110 : depth_ctrl_reg[28:0] <= {15'b000000000000000,14'b11111111111000};///16K    2048个突发长度
				5'b01111 : depth_ctrl_reg[28:0] <= {16'b0000000000000000,13'b1111111111000};///8K     1014个突发长度
				5'b10000 : depth_ctrl_reg[28:0] <= {17'b00000000000000000,12'b111111111000};///4K     512个突发长度 
				5'b10001 : depth_ctrl_reg[28:0] <= {18'b000000000000000000,11'b11111111000};///2K 	  256个突发长度
				5'b10010 : depth_ctrl_reg[28:0] <= {19'b0000000000000000000,10'b1111111000};///1K  	  128个突发长度
				5'b10011 : depth_ctrl_reg[28:0] <= {20'b00000000000000000000, 9'b111111000};///0.5K  	  64个突发长度
				5'b10100 : depth_ctrl_reg[28:0] <= {21'b000000000000000000000, 8'b11111000};///0.25K  	  32个突发长度
				5'b10101 : depth_ctrl_reg[28:0] <= {22'b0000000000000000000000, 7'b1111000};///0.125K  	 128/8=16个突发长度---16*64bit=1024bits=1/8KB
				5'b10110 : depth_ctrl_reg[28:0] <= {29'b11111111111111111111111111000};///512M
				default: depth_ctrl_reg[28:0] <=   {22'b000000000000000000000, 7'b1111000};///1K
			endcase
		end
	end                                               //对于depth_ctrl_reg[28:0]变化1个单位，数据变化64bit
                                                  //predepth[31:0]变化一个单位，数据变化128bit
	///DIMM写地址与写使能的输出控制                   //统一转换为实际地址的量级就行，即一个地址64bit
	always @(posedge clk_100M)                        //8个地址512bit
	//begin                                             //将predepth左移一位，转换为与depth_ctrl_reg一个量级
	//  DIMMdepth_ctrl_r1 <=DIMMdepth_ctrl;
	//  num_DIMM_depth_reg <= num_DIMM_depth_dsp;
	//  if(DIMMdepth_mode == 0)
	  	begin 
	  		DIMMdepth_ctrl_r1 <=DIMMdepth_ctrl;
	  	  num_DIMM_depth <= depth_ctrl_reg;
			  //half_depth_ctrl_reg <= {num_DIMM_depth[28:1]} - {predepth[27:2],2'b00};//对应128bit来换算(突发长度8)，触发后深度=总存储深度-预触发深度
	  		half_depth_ctrl_reg <= {num_DIMM_depth[28:0]}; 
	  	end                //上位机发来的预触发深度每变化1次，引起触发后深度变化为512bit

  
  /**DDR3突发长度为8，8个地址可以装64bit数据，那么写入FIFO数据为128bit，为1:4关系
    也就是说，写入FIFO的4个数据，DDR3只需要写一次**/     

    //FIFO一次时钟下是16bits,突发长度为64bits
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
    assign sync_valid = count_sync[1] & count_sync[0] & sync_en;   //count_sync计数为3时的同步有效
    
    
    
    
    
    reg addr_wr_up;
    reg data_wr_up;                                         //并且sync_valid和sync_en是同一拍的          
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
    
  

    
    //开启app_en_r2和app_addr_r2
    always@(posedge clk_100M)
    begin
    	if(!rst_n)
    		begin
    			app_en_r1 <= 1'b0; 
    			addr_burst <= 30'd0;
    			app_addr_burst_r <= 30'd0;
    			
    		end                      //&& (addr_wr_stop == 1'b0)
    	else if((ddr3_wr_begin == 1'b1) && (addr_wr_up == 1'b1) )  //addr_wr_stop拉高之后，才能拉低ddr3_wr_begin
    		begin                                     //其实也可以不加addr_wr_stop
    			if(sync_valid == 1'b1)
    				begin
    					app_en_r1 <= 1'b1;   //注意比sync_valid慢一拍
    					app_addr_burst_r <= {addr_burst[29:0]} ;  //可以保证一个脉冲赋给偏移地址0，即偏移地址从0开始
    					addr_burst <= {addr_burst + 30'd8} & {depth_ctrl_reg[28:0]}; 
    				    //第一个脉冲来了FIFO写使能开启, //数据的正式启动信号    				
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
    //分析时序，来产生数据的正式结束信号data_wr_stop
    always @(posedge clk_100M)          
    begin
    	if(!rst_n)                       
    			data_wr_stop <= 1'b0;
    else if((app_en_r2_count >= half_depth_ctrl_reg[28:3]) && (count_sync == 2'd0))
    		data_wr_stop <= 1'b1;                //注意：此时data_wr_stop与app_en_r1、fifo_wr_up同拍
    	else
    		data_wr_stop <= 1'b0;     //fifo_wr_up与data_wr_stop一起控制数据的开启和接收
    end 
    //由于app_en_r1延迟了两个时钟才送入FIFO写端口，那么fifo_wr_up、data_wr_stop也要延迟两个时钟  
    
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
    
    
    //assign data_wr_on =  fifo_wr_up_r2 ^ data_wr_stop_r2 ; //fifo_wr_up与data_wr_stop异或
    assign data_wr_on =  data_wr_up_r2 ^ data_wr_stop_r2 ;
		//解决地址问题，上述产生变化的是app_addr_burst_r为偏移地址，不允许让其超越depth_ctrl_reg
		//必须让其在实际地址{addr_wr_init} ——> {addr_wr_init+depth_ctrl_reg}内转圈圈
		///DIMM写地址与写使能的输出控制，对应64bit的地址
		always @(posedge clk_100M) 
		begin
			//app_addr_r2 <= {app_addr_burst_r[28:0]} & {depth_ctrl_reg[28:0]} + {addr_wr_init[28:0]}; 
			app_addr_r2 <= {app_addr_burst_r[29:0]}  + {addr_wr_init[29:0]};
			app_en_r2   <= app_en_r1;    
		end     //{app_addr_burst_r[28:0]} & {depth_ctrl_reg[28:0]} 仍然是偏移地址
  	        //app_addr_r2为实际地址，注意：此时，app_addr_r比app_en_r1慢一拍，调整为app_en_r2
  	        //现在app_en_r2、app_addr_r2比sync_en慢两拍
  	assign addr_wr_out_r = {app_addr_burst_r[29:0]} ;  
 
 //对写入的个数进行计数 	
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
  	//将sync_en和ddr_data[127:0]打两拍
  	always @(posedge clk_100M) 
  	begin
  		sync_en_r1 <= sync_en;
  		sync_en_r2 <= sync_en_r1;
  		ddr_data_r1 <= ddr_data;
  		ddr_data_r2 <= ddr_data_r1;
  	end
*/  	
/*
		///触发地址输出控制
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
								if(ddr3_wr_begin == 1'b1 )       //应该改为上升沿，若是每次写进行复位，也是OK的
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
								if(auto_rd_en == 1'b1 & fifo_ddr3_scan == 0)//ddr3模式
									begin
										state <= WAIT_TRIG;
									end							
								else 
									begin
										state <= POS_TRIG;
										addr_trigged <= addr_wr_out_r[29:0];    //这个地址为8的整数倍，所以需要上位机修改一下
										//flag_pos_tri <= 1'b1;            //暂时不修改flag_pos_tri   
									end
								end
						POS_TRIG:
							begin
								flag_pos_tri <= 1'b1;
								if(half_depth_burst_addr[27:0] >= half_depth_ctrl_reg[28:1])      //停止判断条件
									begin
										addr_wr_stop <= 1'b1; //如果把addr_wr_stop反馈给主状态机，那么app_en_r无法把最后一个脉冲给出去
										half_depth_burst_addr <= 29'd0;		//主状态机建议还是使用data_wr_stop信号							   
										addr_again_started_dly <= app_addr_burst_r[29:0];
										state <= START;
									end
								else if(sync_valid == 1'b1)         //分析后，sync_valid不可能一直为高，不用担心跳不出这个判断
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
