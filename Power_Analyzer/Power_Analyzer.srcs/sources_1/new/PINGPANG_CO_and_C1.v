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


module ddr3_mig_driver(
      input              clk_100M,
      //input              sys_rst,
      input              clk_f,                         //����ͬ����ʱ�ӣ���̬�ģ�
      
      input 					 	 ui_clk,
      input 					 	 rst_n,                            //����Ч          
      //input app      	 
      input            	 init_calib_complete,               //ddr3��ʼ������źţ�����׼��������
      input            	 app_rdy,                				    //UI�ӿ� ��ʾUI׼���������app_enʹ�ܺ����ȴ�app_rdy��λ
      input [31:0]    	 app_rd_data,            				    //UI�ӿ� ddr3���������
      input            	 app_rd_data_valid,      				    //UI�ӿ� ddr3��������Ч
      input            	 app_rd_data_end,        				    //UI�ӿ� ����ź��ǿ��Բ���Ҫ��
      input            	 app_wdf_rdy,            				    //UI�ӿ�            д׼���ź�  
                       	                         				             				           
      output     [2:0]   app_cmd,                           //UI�ӿ�
      output             app_en,                            //UI�ӿ�
      output     [29:0]  app_addr,//�û��ӿڶ�д��ַ        //UI�ӿ�
      output     [31:0]  app_wdf_data,//дddr3����          //UI�ӿ�
      output             app_wdf_wren,                      //UI�ӿ�
      output             app_wdf_end,                       //UI�ӿ�
      output     [3:0]   app_wdf_mask,//д��Ĥ�ź�          //UI�ӿ�
      
      //////////////////////////
			input 			 auto_rd_en                ,//�߶���д��ʱ��Ķ�ʹ�� fifo_real_auto_ren 
			input [4:0]  DIMMdepth_ctrl           ,
			input [31:0] predepth                 ,
			input [28:0] num_DIMM_depth_dsp        ,
			input        DIMMdepth_mode             ,
			output[29:0] addr_trig_ddr3            ,//����Ĵ�����ַ�ź�
      input  			 wen_ddr3                  ,         
      input  			 ren_ddr3                  , 
      input [29:0] addr_wr_init              ,
      input [29:0] addr_rd_init             ,                         
      input [3:0]  ch_num
                                      
                   ); 
   
  parameter rd_init_length = 28'h0_1000;                 	
	//---------����DDR3��4��״̬-------------//
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
  //���ݡ���ַFIFO�˿�
  wire [48:0] data_din;
  wire data_wr_en;      //дʹ��
  wire data_rd_en;     //��ʹ��
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
	
	wire sync_en_adc;
	reg [3:0] count_sync1;
	wire [15:0] ddr_data;
	reg wen_ddr3_r1;
	reg wen_ddr3_r2;
	reg ren_ddr3_r1;
	reg ren_ddr3_r2;
	wire addr_wr_stop;  
	wire data_wr_on;
	wire sync_valid;
	//reg auto_rd_en;
	//ģ��
	reg  app_en_r; 
	reg [2:0] app_cmd_r;
	reg [29:0] app_addr_r;
	wire syn_en_addr_wr;
	wire [29:0]addr_wr_out;
	wire flag_pos_tri;
	wire data_wr_stop_r2;
	
	wire valid_data; 
	wire wr_en_addr;
	wire [32:0] addr_dout; 
	assign app_wdf_mask = 4'h0;         //������Ĥֵ������ź�������ʾ��Щ��������Ҫ
	                                     //���εģ���64bit��ÿ��bit�������ݵ�һ���ֽڣ�
	                                    //�����ܹ�����64���ֽڣ�����512Bit���ݣ���0��ʾ������
	reg [29:0] rd_burst_addr_reg;
	
	reg init_calib_complete_r1;
	reg init_calib_complete_r2;
	reg init_calib_complete_r3;
	reg init_done;
	reg app_rd_error;		
	
	reg [127:0]ddr_data1;
	reg sync_en_adc1;
	wire empty_2;
	wire full_2;
	wire wr_ack_2;
	wire prog_full_2;			
	wire prog_empty_2;
	reg rd_en_2; 	

//����init_calib_complete������
	always @(posedge clk_100M )
	begin
		init_calib_complete_r1 <= init_calib_complete;   
		init_calib_complete_r2 <= init_calib_complete_r1;	
		init_calib_complete_r3 <= init_calib_complete_r2;		
		if((init_calib_complete_r3 == 1'b0) && (init_calib_complete_r2 == 1'b0)) 
			init_done <= 1'b0;
		else if((init_calib_complete_r3 == 1'b0) && (init_calib_complete_r2 == 1'b1)) //������
			init_done <= 1'b1;
		else
			init_done <= init_done;
	end
	//�������ݲ�����һ��λ���Ϳ���*************************************************
	reg [15:0]card1_data,card2_data,card3_data,card4_data,card5_data,card6_data,card7_data,card8_data;
	always @(posedge clk_f)
	begin
		if(!rst_n)
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
		//else if(count_sync1 == 4'd0 )     //ģ��8ͨ��ģʽ
    //else if(count_sync1 == 4'd1 )     //ģ��4ͨ��ģʽ
    //else if(count_sync1 == 4'd3 )     //ģ��2ͨ��ģʽ
    //else if(count_sync1 == 4'd7 )     //ģ��1ͨ��ģʽ
		else if(count_sync1 == ch_num )
		  begin
		    card1_data <= card1_data + 16'd1;
		    card2_data <= card2_data + 16'd1;
		    card3_data <= card3_data + 16'd1;
		    card4_data <= card4_data + 16'd1;
		    card5_data <= card5_data + 16'd1;
		    card6_data <= card6_data + 16'd1;
		    card7_data <= card7_data + 16'd1;
		    card8_data <= card8_data + 16'd1;
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
  
  always @(posedge clk_f)
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
    else if(count_sync1 == ch_num )
    	begin
    		count_sync1 <= 4'd0;
    		sync_en_adc1 <= 1'b1;
    		ddr_data1 <= {card1_data,card2_data,card3_data,card4_data,card5_data,card6_data,card7_data,card8_data};
    	end
    else
    	begin
    		count_sync1 <= count_sync1 + 1'b1;
    		sync_en_adc1 <= 1'b0; 
    		ddr_data1 <= ddr_data1;     //����һ��ʱ�ӣ���֤һ�����ݣ�ռ������ʱ�ӿ��
    	end                         
  end
  
  //����ʹ�ܺ�дʹ�ܴ�����
	always@(posedge clk_100M)
	begin
		wen_ddr3_r1 <= wen_ddr3;
		wen_ddr3_r2 <= wen_ddr3_r1;//����fifoдʹ��wen_ddr3_r2
	  ren_ddr3_r1 <= ren_ddr3;
	  ren_ddr3_r2 <= ren_ddr3_r1;  
	end
    
 	always @(posedge clk_100M)
	begin
	if(!rst_n)
	  begin
	  	//phy_init_done_r <= 1'b0;
	  	DDR3_state      <= DDR3_IDLE;
	  	app_cmd_r       <= 3'b000;
	  	app_addr_r      <= 30'h0;
	  	app_en_r        <= 1'b0;
	  	begin_wr_ddr3   <= 1'b0;
	  	begin_rd_ddr3   <= 1'b0;
	  	rd_burst_addr_reg <= 29'd0;
	  end
	else
	  begin
	  //	phy_init_done_r <= phy_init_done_r2;
	  	case(DDR3_state)
	  		DDR3_IDLE:
	  		  begin
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
	  	    	app_addr_r <= 30'h0;
	  	    	app_en_r   <= 1'b0;
	  	    	if(wen_ddr3_r1 == 1'b1 && wen_ddr3_r2 == 1'b0)
	  	    	  begin
	  	    	  	DDR3_state    <= DDR3_WRITE;
	  	    	  	app_cmd_r     <= 3'b000;//app_cmd_r=3'b000д
				        begin_wr_ddr3 <= 1'b1;
				      end
				    else
				      begin
				      	if(ren_ddr3_r1 == 1'b1 && ren_ddr3_r2 == 1'b0)
				      	  begin
				      	  	DDR3_state    <= DDR3_READ;
				      	  	app_cmd_r     <= 3'b001;
				      	  	begin_rd_ddr3 <= 1'b1;
				      	  	// begin_rd_ddr3 <=(scan_en)? scan_read : 1'b1;
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
				    app_cmd_r <= 3'b000;
				    //if(addr_wr_stop == 1'b0)  
				    if(data_wr_stop_r2 == 1'b0)       //��Ϊaddr_wr_stopû�д��ģ����Ի����ε�һ������
				      begin                           //��data_wr_stop_r2������
				      	begin_wr_ddr3 <= 1'b1;
				      	DDR3_state    <= DDR3_WRITE;
								app_addr_r <= {addr_wr_out};////��Ӧд����ͻ������Ϊ8*64bit
								app_en_r   <= syn_en_addr_wr;  //��ʱ�൱������1�ģ���sync_valid��3�ģ�����ֱ����FIFO�˿���
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
				  	app_cmd_r <= 3'b001;           //������Ϊ3'b001��Ϊ������
				  	begin_rd_ddr3 <= 1'b1;
            if(rd_burst_addr_reg >= rd_init_length )  //�û���Ҫ����ͻ��������
              begin                                    //������õĶ��������꣬��ֹͣ����            	 
            	  app_en_r <= 1'b0;
            	  app_addr_r <= 30'd0;
            	  rd_burst_addr_reg <= 29'd0;
            	  DDR3_state <= DDR3_WAIT;
              end
            else if(sync_valid)
            	begin
            	  app_en_r <= 1'b1;
            	  app_addr_r <= rd_burst_addr_reg + {addr_rd_init};//����ַ����           
                rd_burst_addr_reg <= rd_burst_addr_reg + 29'd8;//��ַ              	  
            	  DDR3_state <= DDR3_READ;
            	end 
            else
            	begin
            		app_en_r <= 1'b0;
            		app_addr_r <= app_addr_r;
            		rd_burst_addr_reg <= rd_burst_addr_reg;
            		DDR3_state <= DDR3_READ;
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
  
  //--------��ui_clk����2��Ƶ������app_wdf_end-----------//
	reg app_wdf_end_r;
	reg [1:0]cnt_app_wdf_wren;
	always @(posedge ui_clk)
	begin
		if(!rst_n)
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
	
	//��ַFIFO�˿�
	assign wr_en_addr = (DDR3_state == DDR3_READ) ? app_en_r : 1'b0;  //дʹ��
	assign addr_din   = {app_cmd_r[2:0],app_addr_r[29:0]};  //д��ĵ�ַ������
	assign rd_en_addr = (~empty_addr) & app_rdy ;    //��ʹ��
	//assign rd_en_addr = app_rdy;
	
	
	//����FIFO�˿�
	//��sync_en��ddr_data[127:0]������
  always @(posedge clk_100M) 
  begin
  	sync_en_r1 <= sync_en_adc;
  	sync_en_r2 <= sync_en_r1;
  	sync_en_r3 <= sync_en_r2;
  	ddr_data_r1 <= ddr_data;
  	ddr_data_r2 <= ddr_data_r1;
  	ddr_data_r3 <= ddr_data_r2;
  end
  
  assign data_wr_en = (DDR3_state == DDR3_WRITE) ? (sync_en_r3 & data_wr_on) : 1'b0 ;   //����FIFOдʹ��   
  assign data_din   = {{addr_din[32:0]},{ddr_data_r3[15:0]}};               //���ݶ˿�
  
  assign data_rd_en = (~empty_data) & app_wdf_rdy & app_rdy;
  //assign data_rd_en = app_wdf_rdy;
  

	//ddr3�û��˽ӿڣ�app�ӿڣ�
	assign  app_wdf_wren = valid_data;
	//assign  app_wdf_wren = data_rd_en;
	assign  app_wdf_data = {data_out[64:49],data_out[15:0]};
	//�ź�app_wdf_end�Ĳ���     4:1ģʽ�£�app_wdf_end�źŵ�ͬ��app_wdf_wren
	assign app_wdf_end = app_wdf_end_r;        //2:1ģʽ��
	//assign  app_wdf_end  = valid_data;    //2:1ģʽ�£�app_wdf_endΪui_clkʱ�ӵĶ���Ƶ
	//ddr3��ַ�����
	//assign  app_en   = valid_addr;          
	assign  app_en   = (addr_dout[32:30] == 3'd1) ? valid_addr : addr_valid;
	assign  app_addr = (addr_dout[32:30] == 3'd1) ? addr_dout[29:0] : data_out[45:16];        //K7��DDR3��2GB�ģ���ַλ��Ϊ28��ԭ��29��ȡ��28λ
	assign  app_cmd  = (addr_dout[32:30] == 3'd1) ? addr_dout[32:30] : data_out[48:46];
	//assign  app_cmd = app_cmd_r;
	
	//�����DDR3�������������Ƿ���ȷ
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
		else if(app_rd_data_valid)
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
	  		if({app_rd_data_r1[31:16]} - {app_rd_data_r2[31:16]} == 2'd2)  //�տ�ʼ���ڻ�û�ж�������
					app_rd_error <= 1'b0;                                              //�տ�ʼ���Ǹߵ�ƽ������
				else       
					app_rd_error <= 1'b1;
			end
		else
			app_rd_error <= 1'b0;
	end
	//Ϊ��ȥ��app_rd_error��ʼ�ĸߵ�ƽ������һ�������ź�
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
	
	
	always @(posedge clk_100M )
	begin
		if(!rst_n)
			rd_en_2 <= 1'd0;
		else if(!empty_2 == 1'b1)
			rd_en_2 <= 1'b1;
		else
			rd_en_2 <= 1'b0;
	end

//��һ����ʱ����ת����ʱ�Ӵ�clk_f��clk_100M������λ���16*8bit��16bit			
	fifo_ddr3_first 
		fifo_data_i (
  .rst(!rst_n),                              // input wire rst
  .wr_clk(clk_f),                        // input wire wr_clk
  .rd_clk(clk_100M),                        // input wire rd_clk
  .din(ddr_data1),                              // input wire [127 : 0] din
  .wr_en(sync_en_adc1),                          // input wire wr_en
  .rd_en(rd_en_2),                          // input wire rd_en
  .prog_empty_thresh(10'd10),               // input wire [9 : 0] prog_empty_thresh
  .prog_full_thresh(7'd100),              // input wire [6 : 0] prog_full_thresh
  .dout(ddr_data),                            // output wire [15 : 0] dout
  .full(full_2),                            // output wire full
  .wr_ack(wr_ack_2),                        // output wire wr_ack
  .empty(empty_2),                          // output wire empty
  .valid(sync_en_adc),                          // output wire valid
  .rd_data_count(),                     // output wire [9 : 0] rd_data_count
  .wr_data_count(),                     // output wire [6 : 0] wr_data_count
  .prog_full(prog_full_2),                   // output wire prog_full
  .prog_empty(prog_empty_2)                // output wire prog_empty
);	

//�ڶ�����ʱ����ת����ʱ�Ӵ�clk_100M��ui_clk������λ���16bit��32bit,��ַ��33bit��33bit		
	//��ʱ����д�����ݡ���ʱ����д�������ַ 
  fifo_ddr3_second 
  	data_to_ddr3 (
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
	
		////��ʱ����д�������ַ  
    fifo_ddr3_third 
    	addr_to_ddr3 (
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

		ddr3_wr_addr
			ddr3_wr_addr_i (
				.clk_100M          (clk_100M),
				.rst_n             (rst_n),
				.DIMMdepth_ctrl    (DIMMdepth_ctrl),
				.addr_wr_init      (addr_wr_init),
				.ddr3_wr_begin     (begin_wr_ddr3),
				.sync_en           (sync_en_adc),
				.DIMMdepth_mode    (DIMMdepth_mode),
				.predepth          (predepth),
				.auto_rd_en        (auto_rd_en),
				.num_DIMM_depth_dsp(num_DIMM_depth_dsp),
				.depth_ctrl_out    (depth_ctrl_out),     //O  
				.app_addr_r2       (addr_wr_out),         //O
				.app_en_r2         (syn_en_addr_wr),      //O
				.flag_pos_tri			 (flag_pos_tri),       //O
				.addr_wr_stop      (addr_wr_stop),       //O
				.data_wr_stop_r2   (data_wr_stop_r2),
			  .addr_trig         (addr_trig),          //O
			  .addr_again_started(addr_again_started), //O 
			  .data_wr_on        (data_wr_on),
			  .sync_valid        (sync_valid),
			  .pc_stop_ddr       (0),
			  .fifo_ddr3_scan    (0)
			);
					
				
		//���´������������������Ƿ�ƥ��
		//����FIFO�ļ���
		reg [31:0]data_en_r_count;
		reg [31:0]addr_en_r_count;
		reg [31:0]app_en_count;
		reg [31:0]app_wdy_wren_count;
		
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

//�ⲿ���߼���DDR3�Ķ� 
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
  
  assign sync_valid2 = (count_sync2[0] & sync_en_adc) ;    //ʹ��ÿ�������ݲ���һ������sync_valid2

/*
	ila_0 
			mig_driver_UI_CLK (
			.clk(ui_clk), // input wire clk	
			.probe0({
			         rst_n,
			         begin_wr_ddr3, 
			         addr_wr_stop,
			         data_wr_on,
			         sync_valid,			      			         
			         init_done,  
			         ren_ddr3,        
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
			         valid_data,
			         valid_addr,
			         sync_valid2
			         		         			                                
						}), // input wire [31:0]  probe0                    
			.probe1({                                                   					    	          					    			    	      
					    	DDR3_state[3:0],				    	
					    	app_rd_data[31:16],
					    	app_addr[29:0],
					    	app_wdf_data[31:16],					    
					    	app_cmd[2:0],
					    	app_en_count[31:0],             
					    	app_wdy_wren_count[31:0],
					    	app_rd_data_r1[31:16],        
					    	app_rd_data_r2[31:16],
					    	ch_num[3:0],
					    	data_out[48:16],
					    	data_out[97:65],
					    	addr_dout[32:30]  					    	  			    
							}) // input wire [311:0]  probe1
		); 

	ila_0 
			mig_driver_100M (
			.clk(clk_100M), // input wire clk	
			.probe0({
			         rst_n,
			         begin_wr_ddr3, 
			         sync_en_adc,      
			         DIMMdepth_mode,
			         auto_rd_en, 
			         app_en_r    ,
			         flag_pos_tri,
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
					    	ddr_data[15:0],
					    	data_en_r_count[31:0],
					    	addr_en_r_count[31:0], 
					    	ch_num[3:0]
					    						    	  			    
							}) // input wire [311:0]  probe1
		); 
*/

endmodule
