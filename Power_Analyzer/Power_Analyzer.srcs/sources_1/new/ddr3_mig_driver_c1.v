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
      
      
      output            wr_burst_data_req,
      output            rd_burst_finish, 
      output            wr_burst_finish, 
      
      //////////////////////////
			//input 			 auto_rd_en                ,//�߶���д��ʱ��Ķ�ʹ�� fifo_real_auto_ren 
			input [4:0]  DIMMdepth_ctrl           ,
			input [31:0] predepth                 ,
			
			input        DIMMdepth_mode             ,
			output[29:0] addr_trig_ddr3            ,//����Ĵ�����ַ�ź�
      input  			 wen_ddr3                  ,         
      input  			 ren_ddr3                  , 
      input [29:0] addr_wr_init              ,
      input [29:0] addr_rd_init             ,                         
      input [3:0]  ch_num ,                  //ģ�⼸ͨ����1����ֵ
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
	//ģ��
	reg  app_en_r; 
	reg [2:0] app_cmd_r;
	reg [29:0] app_addr_r;
	wire syn_en_addr_wr;
	wire [29:0]addr_wr_out;
	
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
	
	assign wr_burst_finish=data_wr_stop_r2;
	assign rd_burst_finish=(app_rd_data_valid_count>=10'd63)? 1'b1:0;
	
	
	
                                                        /////////////////////////////////////////////////////////////////        
                                                        //����init_calib_complete�����أ���������״̬����ʼ��ת�ؼ��ź�
                                                        /////////////////////////////////////////////////////////////////                                                                                                                                                                      
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
	
	
				                                               
                                                        /////////////////////////////////////////////////////////
	                                                      ///////////////DDR3״̬������ת�ܹ�ƪ////////////////////
	                                                      /////////////////////////////////////////////////////////  	 
	 
  reg[9:0] rd_addr_cnt; 	      //�滮д��ַ������д���ݼ���
	reg[9:0] rd_data_cnt;         //�滮����ַ�����������ݼ���
	reg[9:0] wr_addr_cnt;  
	reg[9:0] wr_data_cnt;  
	reg data_rd_stop;
	assign wr_burst_data_req = (DDR3_state == DDR3_WRITE) & app_wdf_rdy ;
	
	
                                                      
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
	  	    	if(wen_ddr3_r1 == 1'b1 && wen_ddr3_r2 == 1'b0)//дʹ�ܵ���λ���������ж�
	  	    	  begin
	  	    	  	DDR3_state    <= DDR3_WRITE;
	  	    	  	app_cmd_r     <= 3'b000;//app_cmd_r=3'b000д
				        begin_wr_ddr3 <= 1'b1;
				        ddr_c1_wr1 <=1'b1;
				      end
				    else
				      begin
				      	if(ren_ddr3_r1 == 1'b1 && ren_ddr3_r2 == 1'b0) //��ʹ�ܵ���λ���������ж�
				      	  begin
				      	  	ddr_c1_wr1 <=0;
				      	  	DDR3_state    <= DDR3_READ;
				      	  	app_cmd_r     <= 3'b001;//app_cmd_r=3'b001��
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
				    //if(data_wr_stop_r2 == 1'b0)       //��Ϊaddr_wr_stopû�д��ģ����Ի����ε�һ������
				    if(data_wr_stop_r2 == 1'b0)  				    
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
				  	ddr_c1_wr1 <=0;
				  	app_cmd_r <= 3'b001;           //������Ϊ3'b001��Ϊ������
				  	begin_rd_ddr3 <= 1'b1;
          
         // if(rd_burst_finish== 1 ) 
            if(rd_burst_addr_reg >= rd_init_length+5'd8)  //�û���Ҫ����ͻ��������
              begin                                    //������õĶ��������꣬��ֹͣ����        
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
            	  app_addr_r <= rd_burst_addr_reg + {addr_rd_init};//����ַ����           
                rd_burst_addr_reg <= rd_burst_addr_reg + 29'd8;//��ַ              	  
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
	                                                      ///////////////////////DDR3ͻ�������ź�ƪ////////////////////
	                                                      /////////////////////////////////////////////////////////  
     
  //--------��ui_clk����2��Ƶ������app_wdf_end-----------//app_wdf_endΪUI_clk��2��Ƶ����Ϊѡ��ʹ��2:1ģʽ��APP_wdf_dataλ��Ϊ4����DDR3оƬλ��=32bit��
                                                         //��һ�ε�ͻ������Ϊ64bit����Ҫ��app_wdf_end��ʾһ��ͻ���������
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
	
	
	
	
	
	
	
	//��ַFIFO�˿�
	//assign wr_en_addr = (DDR3_state == DDR3_READ) ? app_en_r : 1'b0;  //дʹ��
	assign wr_en_addr =  ((DDR3_state == DDR3_READ) | (data_rd_stop == 1'b1)) ? app_en_r:1'b0; //дʹ��
	assign addr_din   = {app_cmd_r[2:0],app_addr_r[29:0]};            //д��ĵ�ַ������
	//assign rd_en_addr = (~empty_addr) & app_rdy&(~pcie_prog_full) ;                     //��ʹ��
	assign rd_en_addr = (~empty_addr)&app_rdy&(!c0_c1_fifo_prog_full);
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
  
  reg fenliu_stream_flag_r1;
  reg [15:0] ddr_data_reg;
  
  always @(posedge ui_clk) 
  begin
  	fenliu_stream_flag_r1 <= fenliu_stream_flag;
  
  	ddr_data_reg <= ddr_data;
  	
  end
  
  
  
  
  
  
  
  assign data_wr_en = (DDR3_state == DDR3_WRITE) ? (sync_en_r3 & data_wr_on) : 1'b0 ;   //����FIFOдʹ��   
  assign data_din   = {{addr_din[32:0]},{ddr_data_r3[15:0]}};                           //�ڶ�����FIFO��������˿ڣ�������33λ��ַ��16λ����  
  assign data_rd_en = (~empty_data) & app_wdf_rdy & app_rdy;

                                                 ///////////////////////////////////////////////////////// 
                                                 ///////////////////////DDR3MIG�˵��û���ӿ��źŶ���/////////////////// 
                                                 ///////////////////////////////////////////////////////// 
    

	//ddr3�û��˽ӿڣ�app�ӿڣ�
	assign  app_wdf_wren = valid_data;

	assign  app_wdf_data = {data_out[64:49],data_out[15:0]};
	//�ź�app_wdf_end�Ĳ���     4:1ģʽ�£�app_wdf_end�źŵ�ͬ��app_wdf_wren
	assign app_wdf_end = app_wdf_end_r;        //2:1ģʽ��
	//assign  app_wdf_end  = valid_data;    //2:1ģʽ�£�app_wdf_endΪui_clkʱ�ӵĶ���Ƶ
	//ddr3��ַ�����
	////assign  app_en   = valid_addr;          
	assign  app_en   = (addr_dout[32:30] == 3'd1) ? rd_en_addr : addr_valid;
	assign  app_addr = (addr_dout[32:30] == 3'd1) ? addr_dout[29:0] : data_out[45:16];        //K7��DDR3��2GB�ģ���ַλ��Ϊ28��ԭ��29��ȡ��28λ
	assign  app_cmd  = (addr_dout[32:30] == 3'd1) ? addr_dout[32:30] : data_out[48:46];
  // assign  app_cmd  =  app_cmd_r;
	// assign  app_en   =  app_en_r; 
	// assign  app_addr =  app_addr_r;
	                                       ///////////////////////////////////////
	                                       //////�����DDR3�������������Ƿ���ȷ///
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
		else if(app_rd_data_valid) ///���MIG�����������Ч���Զ���������app_rd_data���д��Ĵ����õ�app_rd_data_r2
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
	
	
	
	
	
	//Ϊ��ȥ��app_rd_error��ʼ�ĸߵ�ƽ������һ�������ź�check_up <= 1'b1;
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
	
	
	
	
	//////��MIGǰ����fifo����������ݽ��м���������valid_data��
	
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
	

	
       
       //�ڶ�����ʱ����ת����ʱ�Ӵ�clk_100M��ui_clk������λ����16bit��32bit,��ַ��33bit��33bit		
       	//��ʱ����д�����ݡ���ʱ����д�������ַ 
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
       	
       		////��ʱ����д�������ַ  
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
				.DIMMdepth_ctrl    (DIMMdepth_ctrl),      //I,��λ������
				.addr_wr_init      (addr_wr_init),        //I,��λ������
				.ddr3_wr_begin     (begin_wr_ddr3),       //I,��ƪ��״̬������
				.sync_en           (sync_en_adc),         //I,д��ַ����ʹ�ܵ���Чʹ�ܣ�����Ч�������ݵ�ͬ��ʹ��,��̬FIFO��������Ч�ź�
				.DIMMdepth_mode    (DIMMdepth_mode),      //I,��λ������
				.predepth          (predepth),            //I,��λ������
				
				.num_DIMM_depth    (num_DIMM_depth),  //o,��λ������
				.depth_ctrl_out    (),      //O  ѡ����ȷ�����δ��ʹ��
				.app_addr_r2       (addr_wr_out),         //O
				.app_en_r2         (syn_en_addr_wr),      //O ��ַģ������ĺ�ʹ���ź�
				.flag_pos_tri			 (),        //O  δ��
				.addr_wr_stop      (addr_wr_stop),        // ��ַдstop�ź�
				.data_wr_stop_r2   (data_wr_stop_r2),     // ����дstop�ź�
			  .addr_trig         (),           //O  δ��
			  .addr_again_started(),  //O  δ��
			  .data_wr_on        (data_wr_on),    
			  .sync_valid        (sync_valid),   //ͬ����һ��fifo��16bit�������,������4��sync_valid��1����Ϊͻ�����Ϊ64bit
			  .pc_stop_ddr       (0),
			  .fifo_ddr3_scan    (0)
			  
			);
					
	  	
		//���´������������������Ƿ�ƥ��
		//����FIFO�ļ���
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
		
		//�ж϶����˶��ٸ���Чλ	
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