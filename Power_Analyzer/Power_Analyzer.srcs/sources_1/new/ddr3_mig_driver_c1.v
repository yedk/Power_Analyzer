`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/13 10:39:21
// Design Name: 
// Module Name: mig_driver1
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


module ddr3_mig_driver_c1(
      input              clk_100M,
      //input              sys_rst,
      input              clk_f,                         //数据同步的时钟，动态的，
      
      input 					 	 ui_clk,
      input 					 	 rst_n,                            //低有效          
      //input app      	 
      input            	 init_calib_complete,               //ddr3初始化完成信号，可以准备工作了
      input            	 app_rdy,                				    //UI接口 表示UI准备接收命令，app_en使能后必须等待app_rdy置位
      input [31:0]    	 app_rd_data,            				    //UI接口 ddr3读数据输出
      input            	 app_rd_data_valid,      				    //UI接口 ddr3读数据有效
      input            	 app_rd_data_end,        				    //UI接口 这个信号是可以不需要的
      input            	 app_wdf_rdy,            				    //UI接口            写准备信号  
                       	                         				             				           
      output     [2:0]   app_cmd,                           //UI接口
      output             app_en,                            //UI接口
      output     [29:0]  app_addr,//用户接口读写地址        //UI接口
      output     [31:0]  app_wdf_data,//写ddr3数据          //UI接口
      output             app_wdf_wren,                      //UI接口
      output             app_wdf_end,                       //UI接口
      output     [3:0]   app_wdf_mask,//写掩膜信号          //UI接口     
      
      
      output            wr_burst_data_req,
      output            rd_burst_finish, 
      output            wr_burst_finish, 
      
      //////////////////////////
			//input 			 auto_rd_en                ,//边读边写的时候的读使能 fifo_real_auto_ren 
			input [4:0]  DIMMdepth_ctrl           ,
			input [31:0] predepth                 ,
			
			input        DIMMdepth_mode             ,
			output[29:0] addr_trig_ddr3            ,//输出的触发地址信号
      input  			 wen_ddr3                  ,         
      input  			 ren_ddr3                  , 
      input [29:0] addr_wr_init              ,
      input [29:0] addr_rd_init             ,                         
      input [3:0]  ch_num ,                  //模拟几通道的1个数值
      input [15:0] ddr_data,
      input   sync_en_adc,
      input  fenliu_stream_flag,
      input c0_c1_fifo_prog_full,
      input pcie_prog_full,
      output init_done,
      
      input [28:0] rd_init_length,
      output ddr_c1_wr,
      output rd_done1,
      output [28:0]num_DIMM_depth
      

                                      
                   ); 
 // wire [28:0]rd_init_length;               
//  assign rd_init_length = num_DIMM_depth[28:0];    
 // parameter rd_init_length = 29'h00F8;    
 // assign rd_init_length = depth_ctrl_r;    
   reg ddr_c1_wr1;
  reg rd_done;
 assign ddr_c1_wr =ddr_c1_wr1;
 assign rd_done1 = rd_done;
             	
	//---------定义DDR3的4种状态-------------//
	localparam [3:0]DDR3_IDLE  = 4'b0001;
	localparam [3:0]DDR3_WAIT  = 4'b0010;
	localparam [3:0]DDR3_WRITE = 4'b0100;
	localparam [3:0]DDR3_READ  = 4'b1000;
	parameter prog_empty_thresh_0 = 8;  
  parameter prog_full_thresh_0  = 200;
  parameter prog_empty_thresh_1 = 8;  
  parameter prog_full_thresh_1  = 500;
  
  

  
  reg [3:0]DDR3_state;
  reg begin_wr_ddr3;
  reg begin_rd_ddr3;
  //数据、地址FIFO端口
  wire [48:0] data_din;
  wire data_wr_en;      //写使能
  wire data_rd_en;     //读使能
  wire rd_en_addr;
  wire [32:0]addr_din;
  wire [97:0] data_out;
  wire full_data; 
  wire wr_ack_data;
  wire empty_data;
  wire valid_data;
  wire prog_full_d;
  wire prog_empty_d;
  wire [8:0]rd_data_count_0;
  wire [9:0]wr_data_count_0;
  wire [9:0]rd_data_count_1;
  wire [9:0]wr_data_count_1;
  wire  prog_full_a ;
  wire  prog_empty_a;
  
  reg sync_en_r1; 
  reg sync_en_r2;
  reg sync_en_r3; 
  reg [15:0] ddr_data_r1;
  reg [15:0] ddr_data_r2;
	reg [15:0] ddr_data_r3;
	
	//wire sync_en_adc;
	reg [3:0] count_sync1;
	
	reg wen_ddr3_r1;
	reg wen_ddr3_r2;
	reg ren_ddr3_r1;
	reg ren_ddr3_r2;
	wire addr_wr_stop;  
	wire data_wr_on;
	wire sync_valid;
	//reg auto_rd_en;
	//模块
	reg  app_en_r; 
	reg [2:0] app_cmd_r;
	reg [29:0] app_addr_r;
	wire syn_en_addr_wr;
	wire [29:0]addr_wr_out;
	
	wire data_wr_stop_r2;
	
	wire valid_data; 
	wire wr_en_addr;
	wire [32:0] addr_dout; 
	assign app_wdf_mask = 4'h0;         //定义掩膜值，这个信号用来表示哪些数据是需要
	                                     //屏蔽的，共64bit，每个bit控制数据的一个字节，
	                                    //这样总共就是64个字节，共有512Bit数据，置0表示不屏蔽
	reg [29:0] rd_burst_addr_reg;
	
	reg init_calib_complete_r1;
	reg init_calib_complete_r2;
	reg init_calib_complete_r3;
	reg init_done;
	reg app_rd_error;		
	
	assign wr_burst_finish=data_wr_stop_r2;
	assign rd_burst_finish=(app_rd_data_valid_count>=10'd63)? 1'b1:0;
	
	
	
                                                        /////////////////////////////////////////////////////////////////        
                                                        //捕获init_calib_complete上升沿，决定整个状态机开始运转关键信号
                                                        /////////////////////////////////////////////////////////////////                                                                                                                                                                      
	always @(posedge clk_100M )
	begin
		init_calib_complete_r1 <= init_calib_complete;   
		init_calib_complete_r2 <= init_calib_complete_r1;	
		init_calib_complete_r3 <= init_calib_complete_r2;		
		if((init_calib_complete_r3 == 1'b0) && (init_calib_complete_r2 == 1'b0)) 
			init_done <= 1'b0;
		else if((init_calib_complete_r3 == 1'b0) && (init_calib_complete_r2 == 1'b1)) //上升沿
			init_done <= 1'b1;
		else
			init_done <= init_done;
	end
	
	
				                                               
                                                        /////////////////////////////////////////////////////////
	                                                      ///////////////DDR3状态机的运转架构篇////////////////////
	                                                      /////////////////////////////////////////////////////////  	 
	 
  reg[9:0] rd_addr_cnt; 	      //规划写地址计数，写数据计数
	reg[9:0] rd_data_cnt;         //规划读地址计数，读数据计数
	reg[9:0] wr_addr_cnt;  
	reg[9:0] wr_data_cnt;  
	reg data_rd_stop;
	assign wr_burst_data_req = (DDR3_state == DDR3_WRITE) & app_wdf_rdy ;
	
	
                                                      
  //将读使能和写使能打两拍
	always@(posedge clk_100M)
	begin
		wen_ddr3_r1 <= wen_ddr3;
		wen_ddr3_r2 <= wen_ddr3_r1;//数据fifo写使能wen_ddr3_r2
	  ren_ddr3_r1 <= ren_ddr3;
	  ren_ddr3_r2 <= ren_ddr3_r1;  
	end
    
 	always @(posedge clk_100M)
	begin
	if(!rst_n)
	  begin
	  	
	  	DDR3_state      <= DDR3_IDLE;
	  	app_cmd_r       <= 3'b000;
	  	app_addr_r      <= 30'h0;
	  	app_en_r        <= 1'b0;
	  	begin_wr_ddr3   <= 1'b0;
	  	begin_rd_ddr3   <= 1'b0;
	  	rd_burst_addr_reg <= 29'd0;
	  	rd_addr_cnt <= 0;
	  	rd_data_cnt <= 0;
	  	wr_addr_cnt <= 0;
	  	wr_data_cnt <= 0;
	  	data_rd_stop<= 0;
	  	ddr_c1_wr1 <=0;
	  	
	  end
	else
	  begin
	  
	  	case(DDR3_state)
	  		DDR3_IDLE:
	  		  begin
	  		  	rd_done <=1;
	  		  	app_cmd_r   <= 3'b000;
	  		  	app_addr_r  <= 30'h0;
	         	app_en_r    <= 1'b0;
	         	begin_rd_ddr3   <= 1'b0;
	         	rd_burst_addr_reg <= 28'd0;
	  		  	//if(phy_init_done_r)
						if( init_done )
	  		  	  begin
	  		  	  	DDR3_state <= DDR3_WAIT;
	  		  	  end
	  		  end
	  	  DDR3_WAIT:
	  	    begin
	  	    	rd_done <=0;
	  	    	app_addr_r <= 30'h0;
	  	    	app_en_r   <= 1'b0;
	  	    	app_cmd_r   <= 3'b000;
	  	    	if(wen_ddr3_r1 == 1'b1 && wen_ddr3_r2 == 1'b0)//写使能的上位机上升沿判断
	  	    	  begin
	  	    	  	DDR3_state    <= DDR3_WRITE;
	  	    	  	app_cmd_r     <= 3'b000;//app_cmd_r=3'b000写
				        begin_wr_ddr3 <= 1'b1;
				        ddr_c1_wr1 <=1'b1;
				      end
				    else
				      begin
				      	if(ren_ddr3_r1 == 1'b1 && ren_ddr3_r2 == 1'b0) //读使能的上位机上升沿判断
				      	  begin
				      	  	ddr_c1_wr1 <=0;
				      	  	DDR3_state    <= DDR3_READ;
				      	  	app_cmd_r     <= 3'b001;//app_cmd_r=3'b001读
				      	  	begin_rd_ddr3 <= 1'b1;				      	  	
				      	  end
				      	else
				      	  begin
				      	  	DDR3_state    <= DDR3_WAIT;
				      	  	app_cmd_r     <= 3'b000;
				      	  	begin_wr_ddr3 <= 1'b0;
				      	  	begin_rd_ddr3 <= 1'b0;
				      	  end
				      end
				  end
				DDR3_WRITE:
				  begin
				  	rd_done <=0;
				    app_cmd_r <= 3'b000;
				    ddr_c1_wr1 <=1;
				    //if(addr_wr_stop == 1'b0)  
				    //if(data_wr_stop_r2 == 1'b0)       //因为addr_wr_stop没有打拍，所以会屏蔽掉一个脉冲
				    if(data_wr_stop_r2 == 1'b0)  				    
				      begin                           //用data_wr_stop_r2更稳妥
				      	begin_wr_ddr3 <= 1'b1;
				      	DDR3_state    <= DDR3_WRITE;
								app_addr_r <= {addr_wr_out};////对应写数据突发长度为8*64bit
								app_en_r   <= syn_en_addr_wr;  //此时相当于又晚1拍，比sync_valid慢3拍，可以直接送FIFO端口了
				     			    			   				    			     
				      end
				    else
				      begin
				      	begin_wr_ddr3 <= 1'b0;
				      	DDR3_state    <= DDR3_WAIT;
								app_addr_r <= 0;
								app_en_r   <= 1'b0;
				      end
				  end
				DDR3_READ:
				  begin
				  	ddr_c1_wr1 <=0;
				  	app_cmd_r <= 3'b001;           //命令置为3'b001，为读操作
				  	begin_rd_ddr3 <= 1'b1;
          
         // if(rd_burst_finish== 1 ) 
            if(rd_burst_addr_reg >= rd_init_length+5'd8)  //用户需要设置突发读长度
              begin                                    //如果设置的读长度用完，就停止操作        
              rd_done <=1;    	 
            	  app_en_r <= 1'b0;
            	  app_addr_r <= 30'd0;
            	  rd_burst_addr_reg <= 29'd0;
            	  data_rd_stop <= 1'd1;
            	  DDR3_state <= DDR3_IDLE;
              end
            else if((~fenliu_stream_flag)&&(~prog_full_a))//~fenliu_stream_flag          
            	begin
            	  app_en_r <= 1'b1;
            	  app_addr_r <= rd_burst_addr_reg + {addr_rd_init};//读地址更新           
                rd_burst_addr_reg <= rd_burst_addr_reg + 29'd8;//地址              	  
            	  DDR3_state <= DDR3_READ;
            	  data_rd_stop <= 1'd0;
            	end 
            else
            	begin
            		app_en_r <= 1'b0;
            		app_addr_r <= app_addr_r;
            		rd_burst_addr_reg <= rd_burst_addr_reg;
            		DDR3_state <= DDR3_READ;
            		data_rd_stop <= 1'd0;
            	end  
				  end	
			default:
				begin
					DDR3_state <= DDR3_IDLE;
					app_cmd_r <= 3'b000;
					app_addr_r <= 30'h0;
					app_en_r <= 1'b0;
					begin_wr_ddr3 <= 1'b0;
					begin_rd_ddr3 <= 1'b0;
				end	
      endcase
    end
end
   
                                                        /////////////////////////////////////////////////////////
	                                                      ///////////////////////DDR3突发结束信号篇////////////////////
	                                                      /////////////////////////////////////////////////////////  
     
  //--------将ui_clk进行2分频，产生app_wdf_end-----------//app_wdf_end为UI_clk的2分频，因为选择使用2:1模式，APP_wdf_data位宽为4倍的DDR3芯片位宽=32bit，
                                                         //而一次的突发长度为64bit，需要用app_wdf_end表示一次突发长度完成
	reg app_wdf_end_r;
	reg [1:0]cnt_app_wdf_wren;
	always @(posedge ui_clk)
	begin
		if((!rst_n)|(DDR3_state==DDR3_READ))
		  begin
		  	app_wdf_end_r     <= 1'b0;
		  	cnt_app_wdf_wren <= 2'b01;
		  end
		else
		  begin
		  	if(data_rd_en == 1'b1)
		  	  begin
		  	  	cnt_app_wdf_wren <= cnt_app_wdf_wren +1'b1;
		  	  	if(cnt_app_wdf_wren[0] == 1'b1)
		  	  	  app_wdf_end_r <= 1'b0;
		  	  	else
		  	  	  app_wdf_end_r <= 1'b1;
		  	  end
		  end
	end	
	
	
	
	
	
	
	
	//地址FIFO端口
	//assign wr_en_addr = (DDR3_state == DDR3_READ) ? app_en_r : 1'b0;  //写使能
	assign wr_en_addr =  ((DDR3_state == DDR3_READ) | (data_rd_stop == 1'b1)) ? app_en_r:1'b0; //写使能
	assign addr_din   = {app_cmd_r[2:0],app_addr_r[29:0]};            //写入的地址和命令
	//assign rd_en_addr = (~empty_addr) & app_rdy&(~pcie_prog_full) ;                     //读使能
	assign rd_en_addr = (~empty_addr)&app_rdy&(!c0_c1_fifo_prog_full);
	//assign rd_en_addr = app_rdy;
	
	
	//数据FIFO端口
	//将sync_en和ddr_data[127:0]打两拍
  always @(posedge clk_100M) 
  begin
  	sync_en_r1 <= sync_en_adc;
  	sync_en_r2 <= sync_en_r1;
  	sync_en_r3 <= sync_en_r2;
  	ddr_data_r1 <= ddr_data;
  	ddr_data_r2 <= ddr_data_r1;
  	ddr_data_r3 <= ddr_data_r2;
  end
  
  reg fenliu_stream_flag_r1;
  reg [15:0] ddr_data_reg;
  
  always @(posedge ui_clk) 
  begin
  	fenliu_stream_flag_r1 <= fenliu_stream_flag;
  
  	ddr_data_reg <= ddr_data;
  	
  end
  
  
  
  
  
  
  
  assign data_wr_en = (DDR3_state == DDR3_WRITE) ? (sync_en_r3 & data_wr_on) : 1'b0 ;   //数据FIFO写使能   
  assign data_din   = {{addr_din[32:0]},{ddr_data_r3[15:0]}};                           //第二级的FIFO数据输入端口，包括了33位地址和16位数据  
  assign data_rd_en = (~empty_data) & app_wdf_rdy & app_rdy;

                                                 ///////////////////////////////////////////////////////// 
                                                 ///////////////////////DDR3MIG核的用户层接口信号定义/////////////////// 
                                                 ///////////////////////////////////////////////////////// 
    

	//ddr3用户端接口（app接口）
	assign  app_wdf_wren = valid_data;

	assign  app_wdf_data = {data_out[64:49],data_out[15:0]};
	//信号app_wdf_end的产生     4:1模式下，app_wdf_end信号等同于app_wdf_wren
	assign app_wdf_end = app_wdf_end_r;        //2:1模式下
	//assign  app_wdf_end  = valid_data;    //2:1模式下，app_wdf_end为ui_clk时钟的二分频
	//ddr3地址命令部分
	////assign  app_en   = valid_addr;          
	assign  app_en   = (addr_dout[32:30] == 3'd1) ? rd_en_addr : addr_valid;
	assign  app_addr = (addr_dout[32:30] == 3'd1) ? addr_dout[29:0] : data_out[45:16];        //K7里DDR3是2GB的，地址位宽为28，原来29，取低28位
	assign  app_cmd  = (addr_dout[32:30] == 3'd1) ? addr_dout[32:30] : data_out[48:46];
  // assign  app_cmd  =  app_cmd_r;
	// assign  app_en   =  app_en_r; 
	// assign  app_addr =  app_addr_r;
	                                       ///////////////////////////////////////
	                                       //////检验从DDR3读出来的数据是否正确///
	                                       ///////////////////////////////////////
	reg [31:0]app_rd_data_r1;
	reg [31:0]app_rd_data_r2; 
	reg app_rd_data_valid_r1;
	always @(posedge ui_clk )
	begin
		if(!rst_n)
			begin	
				app_rd_data_r1 <= 32'd0;
				app_rd_data_r2 <= 32'd0;
			end
		else if(app_rd_data_valid) ///如果MIG输出的数据有效，对读出的数据app_rd_data进行打拍处理得到app_rd_data_r2
			begin
				app_rd_data_r1 <= app_rd_data;
				app_rd_data_r2 <= app_rd_data_r1;
		  end
		else
			begin
				app_rd_data_r1 <= app_rd_data_r1;
				app_rd_data_r2 <= app_rd_data_r2;
			end
	end
		
	always @(posedge ui_clk )
	begin
		app_rd_data_valid_r1 <= app_rd_data_valid; 
	end        
	
	
	reg check_up;
	always @(posedge ui_clk )
	begin
		if(!rst_n)
			app_rd_error <= 1'b0;	
		else if(check_up == 1'b1)		
	    begin
	  		if({app_rd_data_r1[31:16]} - {app_rd_data_r2[31:16]} == 2'd2)  //刚开始由于还没有读出数据
					app_rd_error <= 1'b0;                                              //刚开始会是高电平，正常
				else       
					app_rd_error <= 1'b1;
			end
		else
			app_rd_error <= 1'b0;
	end
	
	
	
	
	
	//为了去掉app_rd_error开始的高电平，产生一个开启信号check_up <= 1'b1;
	always @(posedge ui_clk )
	begin
		if(!rst_n)
			check_up <= 1'b0;
		else if(DDR3_state == DDR3_READ)
			begin
				if(app_rd_data_end)
					check_up <= 1'b1;
				else
					check_up <= check_up;
			end
		else
			check_up <= 1'b0;
	end
	reg [1:0] valid_count;
	wire addr_valid;
	
	
	
	
	//////对MIG前级的fifo输出来的数据进行计数（利用valid_data）
	
	always @(posedge ui_clk )
	begin
		if(!rst_n)
			valid_count <= 2'd0;
		else if(valid_data)
		//else if(data_rd_en)
			valid_count <= valid_count + 1'b1;
		else
			valid_count <= valid_count;
	end
	assign addr_valid = valid_count[0] & valid_data;
	//assign addr_valid = valid_count[0] & data_rd_en;
	

	
       
       //第二级跨时钟域转换，时钟从clk_100M到ui_clk，数据位宽从16bit到32bit,地址从33bit到33bit		
       	//跨时钟域写入数据、跨时钟域写入命令地址 
         fifo_ddr3_second_c1 
         	data_to_ddr3_c1 (
         .rst(!rst_n),                              // input wire rst
         .wr_clk(clk_100M),                        // input wire wr_clk
         .rd_clk(ui_clk),                        // input wire rd_clk
         .din(data_din),                              // input wire [48 : 0] din
         .wr_en(data_wr_en),                          // input wire wr_en
         .rd_en(data_rd_en),                          // input wire rd_en
         .prog_empty_thresh(prog_empty_thresh_0),  // input wire [8 : 0] prog_empty_thresh
         .prog_full_thresh(prog_full_thresh_0),    // input wire [9 : 0] prog_full_thresh
         .dout(data_out),                            // output wire [97 : 0] dout
         .full(full_data),                            // output wire full
         .wr_ack(wr_ack_data),                        // output wire wr_ack
         .empty(empty_data),                          // output wire empty
         .valid(valid_data),                          // output wire valid
         .rd_data_count(rd_data_count_0),          // output wire [8 : 0] rd_data_count
         .wr_data_count(wr_data_count_0),          // output wire [9 : 0] wr_data_count
         .prog_full(prog_full_d),                  // output wire prog_full
         .prog_empty(prog_empty_d)                // output wire prog_empty
       );
       	
       		////跨时钟域写入命令地址  
         fifo_ddr3_third_c1 
         	addr_to_ddr3_c1 (
        	.rst(!rst_n),                      // input wire rst
        	.wr_clk(clk_100M),                // input wire wr_clk
        	.rd_clk(ui_clk),                // input wire rd_clk
        	.din(addr_din),                      // input wire [32 : 0] din
        	.wr_en(wr_en_addr),                  // input wire wr_en
        	.rd_en(rd_en_addr),                  // input wire rd_en
        	.prog_empty_thresh(prog_empty_thresh_1),  // input wire [9 : 0] prog_empty_thresh
           .prog_full_thresh(prog_full_thresh_1),    // input wire [9 : 0] prog_full_thresh
        	.dout(addr_dout),                    // output wire [32 : 0] dout
        	.full(full),                    // output wire full
        	.wr_ack(wr_ack),                // output wire wr_ack
        	.empty(empty_addr),                  // output wire empty
        	.valid(valid_addr),                  // output wire valid
        	.rd_data_count(rd_data_count_1),  // output wire [9 : 0] rd_data_count
        	.wr_data_count(wr_data_count_1),  // output wire [9 : 0] wr_data_count
        	.prog_full(prog_full_a),          // output wire prog_full
        	.prog_empty(prog_empty_a)        // output wire prog_empty
       );
       
		ddr3_wr_addr_c1
			ddr3_wr_addr_i_c1 (
				.clk_100M          (clk_100M),            //I
				.rst_n             (rst_n),               //I
				.DIMMdepth_ctrl    (DIMMdepth_ctrl),      //I,上位机发送
				.addr_wr_init      (addr_wr_init),        //I,上位机发送
				.ddr3_wr_begin     (begin_wr_ddr3),       //I,本篇的状态机产生
				.sync_en           (sync_en_adc),         //I,写地址计数使能的有效使能，即有效采样数据的同步使能,动态FIFO的数据有效信号
				.DIMMdepth_mode    (DIMMdepth_mode),      //I,上位机发送
				.predepth          (predepth),            //I,上位机发送
				
				.num_DIMM_depth    (num_DIMM_depth),  //o,上位机发送
				.depth_ctrl_out    (),      //O  选择深度反馈，未曾使用
				.app_addr_r2       (addr_wr_out),         //O
				.app_en_r2         (syn_en_addr_wr),      //O 地址模块输出的核使能信号
				.flag_pos_tri			 (),        //O  未用
				.addr_wr_stop      (addr_wr_stop),        // 地址写stop信号
				.data_wr_stop_r2   (data_wr_stop_r2),     // 数据写stop信号
			  .addr_trig         (),           //O  未用
			  .addr_again_started(),  //O  未用
			  .data_wr_on        (data_wr_on),    
			  .sync_valid        (sync_valid),   //同步第一级fifo的16bit数据输出,当计满4，sync_valid置1，因为突发深度为64bit
			  .pc_stop_ddr       (0),
			  .fifo_ddr3_scan    (0)
			  
			);
					
	  	
		//以下代码用来检验脉冲数是否匹配
		//进入FIFO的检验
		reg [31:0]data_en_r_count;
		reg [31:0]addr_en_r_count;
		reg [31:0]app_en_count;
		reg [31:0]app_wdy_wren_count;
		reg [31:0]app_rd_data_valid_count;
		
		always @(posedge clk_100M)
		begin
			if(!rst_n)
				begin
					data_en_r_count <= 32'd0;
				end
			else if(begin_wr_ddr3 == 1'b1)
				begin
					if(data_wr_en)
						data_en_r_count <= data_en_r_count + 1'b1;
					else
						data_en_r_count <= data_en_r_count;
				end
			else
				data_en_r_count <= 32'd0;
		end
		
		always @(posedge clk_100M)
		begin
			if(!rst_n)
				begin
					addr_en_r_count <= 32'd0;
				end
			else if(begin_wr_ddr3 == 1'b1)
				begin
					if(wr_en_addr)
						addr_en_r_count <= addr_en_r_count +1'b1;
					else
						addr_en_r_count <= addr_en_r_count;
				end
			else
				addr_en_r_count <= 32'd0;
		end
		
		always @(posedge ui_clk)
		begin
			if(!rst_n)
				begin
					app_en_count <= 32'd0;
				end
			else if(begin_wr_ddr3 == 1'b1)
				begin
					if(app_en)
						app_en_count <= app_en_count +1'b1;
					else
						app_en_count <= app_en_count;
				end
			else
				app_en_count <= 32'd0;
		end
		
		//判断读出了多少个有效位	
			always @(posedge ui_clk)
		begin
			if(!rst_n)
				begin
					app_rd_data_valid_count <= 32'd0;
				end
			else if(begin_rd_ddr3 == 1'b1)
				begin
					if(app_rd_data_valid)
						app_rd_data_valid_count <= app_rd_data_valid_count +1'b1;
					else
						app_rd_data_valid_count <= app_rd_data_valid_count;
				end
			else
				app_rd_data_valid_count <= 32'd0;
		end
		
		
		
		
		
		
		always @(posedge ui_clk)
		begin
			if(!rst_n)
				begin
					app_wdy_wren_count <= 32'd0;
				end
			else if(begin_wr_ddr3 == 1'b1)
				begin
					if(app_wdf_wren)
						app_wdy_wren_count <= app_wdy_wren_count +1'b1;
					else
						app_wdy_wren_count <= app_wdy_wren_count;
				end
			else
				app_wdy_wren_count <= 32'd0;
		end

//这部分逻辑给DDR3的读 
	reg [2:0]count_sync2;
	wire sync_valid2;

	always@(posedge clk_100M)
  begin
  	if(!rst_n)
  			count_sync2 <= 2'd0;
  	else if(sync_en_adc == 1'b1)        
  		begin                         
  			if(count_sync2 == 2'd3 )
  				count_sync2 <= 2'd0;
  			else
  				count_sync2 <= count_sync2 + 1'b1;
  		end
  	else
  		count_sync2 <= count_sync2;
  end
  
  assign sync_valid2 = (count_sync2[0] & sync_en_adc) ;    //使得每两个数据产生一个脉冲sync_valid2

/*
	ila_4 
			mig_driver_UI_CLK_c1 (
			.clk(ui_clk), // input wire clk	
			.probe0({
			         rst_n,
			        
			         addr_wr_stop,
			         data_wr_on,
			         sync_valid,			      			         
			         init_done,
			         wen_ddr3,    
			         ren_ddr3, 
			         begin_wr_ddr3,         
			         data_wr_stop_r2,
			         data_rd_en,																		    			
			         empty_data,                                        			
			         rd_en_addr,                                        			
			         empty_addr,                                        			
			         app_rdy,                                                   			
			         app_wdf_rdy,                                                                        			
			         app_rd_data_end,
			         app_wdf_end,
			         app_wdf_wren,
			         app_en,
			         app_rd_data_valid,
			         app_rd_data_valid_r1,
			         app_rd_error,
			         check_up,			         			        
			         valid_addr,
			         valid_data,
			         sync_valid2,
			         data_rd_stop,
			         adc_refclk,
			         wr_burst_finish,
			         rd_burst_finish,
			         fenliu_stream_flag_r1,
			         init_calib_complete_r1,
			         init_calib_complete_r2,
			         init_calib_complete_r3,
			         begin_rd_ddr3,
			         addr_valid,
			         valid_addr
			         		         			                                
						}), // input wire [31:0]  probe0                    
			.probe1({                                                   					    	          					    			    	      
					    	DDR3_state[3:0],				    	
					    	app_rd_data[31:0],
					    	app_addr[29:0],
					    	app_wdf_data[31:0],					    
					    	app_cmd[2:0],
					    	app_en_count[31:0],             
					    	app_wdy_wren_count[31:0],
					    //	app_rd_data_r1[31:16],        
					    //	app_rd_data_r2[31:16],
					    	ch_num[3:0],
					    //	data_out[48:16],
					    //	data_out[97:65],
					    	addr_dout[32:30],  	
					    	rd_burst_addr_reg[29:0],
					    	ddr_data_reg[15:0],
					    	app_rd_data_valid_count[31:0],
					    	app_cmd_r[2:0],
					    	addr_dout[32:30]
					    	
					    	    	  			    
							}) // input wire [311:0]  probe1
		); 
		
/*
	ila_1
			mig_driver_100M (
			.clk(clk_100M), // input wire clk	
			.probe0({
			         rst_n,
			         begin_wr_ddr3, 
			         sync_en_adc,      
			         DIMMdepth_mode,			       
			         app_en_r    ,			         
			         addr_wr_stop,
			         data_wr_on,
			         sync_valid,			      			         
			         init_done,
			         wen_ddr3,   
			         ren_ddr3,
			         sync_en_r1,   
			         sync_en_r2,	        
			         data_wr_en,
			         wr_en_addr,        
			         syn_en_addr_wr,
			         data_wr_stop_r2  

			                 
			         		         			
						}), // input wire [31:0]  probe0  
			.probe1({
							    					    	
					    	app_addr_r[29:0],					    	
					    	data_din[15:0],  					    			    	  
					    	addr_din[32:0], 
					    	DDR3_state[3:0],				    	
					    	count_sync1[3:0],
					    	ddr_data_r1[15:0],
					    	data_en_r_count[31:0],
					    	addr_en_r_count[31:0], 
					    	ch_num[3:0]
					    						    	  			    
							}) // input wire [311:0]  probe1
		); 

*/


endmodule
