//--------------------------------------------------------------------------------
//--
//-- This file is owned and controlled by Xilinx and must be used solely
//-- for design, simulation, implementation and creation of design files
//-- limited to Xilinx devices or technologies. Use with non-Xilinx
//-- devices or technologies is expressly prohibited and immediately
//-- terminates your license.
//--
//-- Xilinx products are not intended for use in life support
//-- appliances, devices, or systems. Use in such applications is
//-- expressly prohibited.
//--
//--            **************************************
//--            ** Copyright (C) 2005, Xilinx, Inc. **
//--            ** All Rights Reserved.             **
//--            **************************************
//--
//--------------------------------------------------------------------------------
//-- Filename: BMD_64_TX_ENGINE.v
//--
//-- Description: 64 bit Local-Link Transmit Unit.
//--
//--------------------------------------------------------------------------------

`timescale 1ns/1ns

`define BMD_64_CPLD_FMT_TYPE   7'b10_01010
`define BMD_64_MWR_FMT_TYPE    7'b10_00000
`define BMD_64_MWR64_FMT_TYPE  7'b11_00000
`define BMD_64_MRD_FMT_TYPE    7'b00_00000
`define BMD_64_MRD64_FMT_TYPE  7'b01_00000

`define BMD_64_TX_RST_STATE    8'b00000001      //8'h01
`define BMD_64_TX_CPLD_QW1     8'b00000010      //8'h02
`define BMD_64_TX_CPLD_WIT     8'b00000100      //8'h04
`define BMD_64_TX_MWR_QW1      8'b00001000      //8'h08
`define BMD_64_TX_MWR64_QW1    8'b00010000      //8'h10
`define BMD_64_TX_MWR_QWN      8'b00100000      //8'h20 
`define BMD_64_TX_MRD_QW1      8'b01000000			//8'h40
`define BMD_64_TX_MRD_QWN      8'b10000000			//8'h80

module BMD_64_TX_ENGINE (

                        clk,
                        rst_n,

                        trn_td,
                        trn_trem_n,
                        trn_tsof_n,
                        trn_teof_n,
                        trn_tsrc_rdy_n,
                        trn_tsrc_dsc_n,
                        trn_tdst_rdy_n,
                        trn_tdst_dsc_n,
                        trn_tbuf_av,

                        req_compl_i,    
                        compl_done_o,  

                        req_tc_i,     
                        req_td_i,    
                        req_ep_i,   
                        req_attr_i,
                        req_len_i,         
                        req_rid_i,        
                        req_tag_i,       
                        req_be_i,
                        req_addr_i,     

                        // BMD Read Access

                        rd_addr_o,   
                        rd_be_o,    
                        rd_data_i,
												//FIFO�ӿ�
												fifo_tx_data,             //�û�����Ч����
                        fifo_tx_data_valid,          //�û�����Ч����ʹ��
                        fifo_tx_data_rd_en,
                        trn_trem_en,

                        // Initiator Reset
          
                        init_rst_i,

                        // Write Initiator

                        mwr_start_i,
                        mwr_int_dis_i,
                        mwr_len_i,
                        mwr_tag_i,
                        mwr_lbe_i,
                        mwr_fbe_i,
                        mwr_addr_i,
                        mwr_data_i,
                        mwr_count_i,
                        mwr_done_o,
                        mwr_tlp_tc_i,
                        mwr_64b_en_i,
                        mwr_phant_func_dis1_i,
                        mwr_up_addr_i,
                        mwr_relaxed_order_i,
                        mwr_nosnoop_i,
                        mwr_wrr_cnt_i,

                        // Read Initiator

                        mrd_start_i,
                        mrd_int_dis_i,
                        mrd_len_i,
                        mrd_tag_i,
                        mrd_lbe_i,
                        mrd_fbe_i,
                        mrd_addr_i,
                        mrd_count_i,
                        mrd_done_i,
                        mrd_tlp_tc_i,
                        mrd_64b_en_i,
                        mrd_phant_func_dis1_i,
                        mrd_up_addr_i,
                        mrd_relaxed_order_i,
                        mrd_nosnoop_i,
                        mrd_wrr_cnt_i,

                        cur_mrd_count_o,

                        cfg_msi_enable_i,
                        cfg_interrupt_n_o,
                        cfg_interrupt_assert_n_o,
                        cfg_interrupt_rdy_n_i,
                        cfg_interrupt_legacyclr,

                        completer_id_i,
                        cfg_ext_tag_en_i,
                        cfg_bus_mstr_enable_i,
                        cfg_phant_func_en_i,
                        cfg_phant_func_supported_i


                        );

    input               clk;
    input               rst_n;
    
    input fifo_tx_data_valid;    
    input [63:0] fifo_tx_data;
    output fifo_tx_data_rd_en;
    output trn_trem_en;
 
    output [63:0]       trn_td;
    //output [7:0]        trn_trem_n;    //���ԣ��޸�
    output [0:0]        trn_trem_n;     //trn_trem_n=1'b1,tkeep=8'hFF,tkeep=8'h0F
    output              trn_tsof_n;
    output              trn_teof_n;
    output              trn_tsrc_rdy_n;
    output              trn_tsrc_dsc_n;
    input               trn_tdst_rdy_n;
    input               trn_tdst_dsc_n;
    input [5:0]         trn_tbuf_av;

    input               req_compl_i;
    output              compl_done_o;

    input [2:0]         req_tc_i;
    input               req_td_i;
    input               req_ep_i;
    input [1:0]         req_attr_i;
    input [9:0]         req_len_i;
    input [15:0]        req_rid_i;
    input [7:0]         req_tag_i;
    input [7:0]         req_be_i;
    //input [10:0]        req_addr_i;
    input [11:0]        req_addr_i;
    
    output [6:0]        rd_addr_o;
    output [3:0]        rd_be_o;
    input  [31:0]       rd_data_i;

    input               init_rst_i;

    input               mwr_start_i;
    input               mwr_int_dis_i;
    input  [31:0]       mwr_len_i;
    input  [7:0]        mwr_tag_i;
    input  [3:0]        mwr_lbe_i;
    input  [3:0]        mwr_fbe_i;
    input  [31:0]       mwr_addr_i;
    input  [31:0]       mwr_data_i;
    input  [31:0]       mwr_count_i;
    output              mwr_done_o;
    input  [2:0]        mwr_tlp_tc_i;
    input               mwr_64b_en_i;
    input               mwr_phant_func_dis1_i;
    input  [7:0]        mwr_up_addr_i;
    input               mwr_relaxed_order_i;
    input               mwr_nosnoop_i;
    input  [7:0]        mwr_wrr_cnt_i;


    input               mrd_start_i;
    input               mrd_int_dis_i;
    input  [31:0]       mrd_len_i;
    input  [7:0]        mrd_tag_i;
    input  [3:0]        mrd_lbe_i;
    input  [3:0]        mrd_fbe_i;
    input  [31:0]       mrd_addr_i;
    input  [31:0]       mrd_count_i;
    input               mrd_done_i;
    input  [2:0]        mrd_tlp_tc_i;
    input               mrd_64b_en_i;
    input               mrd_phant_func_dis1_i;
    input  [7:0]        mrd_up_addr_i;
    input               mrd_relaxed_order_i;
    input               mrd_nosnoop_i;
    input  [7:0]        mrd_wrr_cnt_i;

    output [15:0]       cur_mrd_count_o;

    input               cfg_msi_enable_i;
    output              cfg_interrupt_n_o;
    output              cfg_interrupt_assert_n_o;
    input               cfg_interrupt_rdy_n_i;
    input               cfg_interrupt_legacyclr;

    input [15:0]        completer_id_i;
    input               cfg_ext_tag_en_i;
    input               cfg_bus_mstr_enable_i;

    input               cfg_phant_func_en_i;
    input [1:0]         cfg_phant_func_supported_i;


    // Local registers
    reg fifo_tx_data_rd_en; 
    reg payload_valid; 
    reg trn_trem_en;         
    reg [63:0]          trn_td;
    //reg [7:0]           trn_trem_n;    //�޸ģ�����
    reg [0:0]           trn_trem_n;       
    reg                 trn_tsof_n;
    reg                 trn_teof_n;
    reg                 trn_tsrc_rdy_n;
    reg                 trn_tsrc_dsc_n;
 
    reg [11:0]          byte_count;
    //reg [7:0]          byte_count;
    reg [06:0]          lower_addr;
    //reg [07:0]          lower_addr; 
    //reg [13:0]          lower_addr;

    reg                 req_compl_q;                 

    reg [7:0]           bmd_64_tx_state;

    reg                 compl_done_o;
    reg                 mwr_done_o;

    reg                 mrd_done;

    reg [15:0]          cur_wr_count;
    reg [15:0]          cur_rd_count;
   
    reg [9:0]           cur_mwr_dw_count;
  
    reg [12:0]          mwr_len_byte;
    reg [12:0]          mrd_len_byte;

    reg [31:0]          pmwr_addr;
    reg [31:0]          pmrd_addr;

    reg [31:0]          tmwr_addr;
    reg [31:0]          tmrd_addr;

    reg [15:0]          rmwr_count;
    reg [15:0]          rmrd_count;

    reg                 serv_mwr;
    reg                 serv_mrd;

    reg  [7:0]          tmwr_wrr_cnt;
    reg  [7:0]          tmrd_wrr_cnt;

    // Local wires
   
    wire [15:0]         cur_mrd_count_o = cur_rd_count;
    wire                cfg_bm_en = cfg_bus_mstr_enable_i;
    wire [31:0]         mwr_addr  = mwr_addr_i;
    wire [31:0]         mrd_addr  = mrd_addr_i;
    wire [31:0]         mwr_data_i_sw = {mwr_data_i[07:00],
                                         mwr_data_i[15:08],
                                         mwr_data_i[23:16],
                                         mwr_data_i[31:24]};

    wire  [2:0]         mwr_func_num = (!mwr_phant_func_dis1_i && cfg_phant_func_en_i) ? 
                                       ((cfg_phant_func_supported_i == 2'b00) ? 3'b000 : 
                                        (cfg_phant_func_supported_i == 2'b01) ? {cur_wr_count[8], 2'b00} : 
                                        (cfg_phant_func_supported_i == 2'b10) ? {cur_wr_count[9:8], 1'b0} : 
                                        (cfg_phant_func_supported_i == 2'b11) ? {cur_wr_count[10:8]} : 3'b000) : 3'b000;

    wire  [2:0]         mrd_func_num = (!mrd_phant_func_dis1_i && cfg_phant_func_en_i) ? 
                                       ((cfg_phant_func_supported_i == 2'b00) ? 3'b000 : 
                                        (cfg_phant_func_supported_i == 2'b01) ? {cur_rd_count[8], 2'b00} : 
                                        (cfg_phant_func_supported_i == 2'b10) ? {cur_rd_count[9:8], 1'b0} : 
                                        (cfg_phant_func_supported_i == 2'b11) ? {cur_rd_count[10:8]} : 3'b000) : 3'b000;

    /*
     * Present address and byte enable to memory module
     */

    assign rd_addr_o = req_addr_i[10:2];
    assign rd_be_o =   req_be_i[3:0];

    /*
     * Calculate byte count based on byte enable
     */

    always @ (rd_be_o) begin

      casex (rd_be_o[3:0])
      
        4'b1xx1 : byte_count = 12'h004;     //����1111
        4'b01x1 : byte_count = 12'h003;     //��0111
        4'b1x10 : byte_count = 12'h003;			//��1110			
        4'b0011 : byte_count = 12'h002;
        4'b0110 : byte_count = 12'h002;
        4'b1100 : byte_count = 12'h002;
        4'b0001 : byte_count = 12'h001;
        4'b0010 : byte_count = 12'h001;
        4'b0100 : byte_count = 12'h001;
        4'b1000 : byte_count = 12'h001;
        4'b0000 : byte_count = 12'h001;

      endcase

    end

    /*
     * Calculate lower address based on  byte enable
     */

    always @ (rd_be_o or req_addr_i) begin

      casex (rd_be_o[3:0])
      
        4'b0000 : lower_addr = {req_addr_i[4:0], 2'b00};
        4'bxxx1 : lower_addr = {req_addr_i[4:0], 2'b00};
        4'bxx10 : lower_addr = {req_addr_i[4:0], 2'b01};
        4'bx100 : lower_addr = {req_addr_i[4:0], 2'b10};
        4'b1000 : lower_addr = {req_addr_i[4:0], 2'b11}; 
        //4'b0000 : lower_addr = {req_addr_i[11:0], 2'b00};      
        //4'bxxx1 : lower_addr = {req_addr_i[11:0], 2'b00};     //һ������£��϶������֣�PIOģʽ���DWȫ����Ч��rd_be_o
        //4'bxx10 : lower_addr = {req_addr_i[11:0], 2'b01};
        //4'bx100 : lower_addr = {req_addr_i[11:0], 2'b10};
        //4'b1000 : lower_addr = {req_addr_i[11:0], 2'b11};
        

      endcase

    end

    always @ ( posedge clk ) begin

        if (!rst_n ) begin

          req_compl_q <= 1'b0;

        end else begin 

          req_compl_q <= req_compl_i;

        end

    end

    /*
     *  Interrupt Controller
     */

    BMD_INTR_CTRL BMD_INTR_CTRL  (

      .clk(clk),                                     // I
      .rst_n(rst_n),                                 // I

      .init_rst_i(init_rst_i),                       // I

      .mrd_done_i(mrd_done_i & !mrd_int_dis_i),      // I
      .mwr_done_i(mwr_done_o & !mwr_int_dis_i),      // I

      .msi_on(cfg_msi_enable_i),                     // I

      .cfg_interrupt_rdy_n_i(cfg_interrupt_rdy_n_i), // I
      .cfg_interrupt_assert_n_o(cfg_interrupt_assert_n_o), // O
      .cfg_interrupt_n_o(cfg_interrupt_n_o),        // O
      .cfg_interrupt_legacyclr(cfg_interrupt_legacyclr) // I

    );


    /*
     *  Tx State Machine 
     */

    always @ ( posedge clk ) begin

        if (!rst_n ) begin

          trn_tsof_n        <= 1'b1;
          trn_teof_n        <= 1'b1;
          trn_tsrc_rdy_n    <= 1'b1;
          trn_tsrc_dsc_n    <= 1'b1;
          trn_td            <= 64'b0;
          //trn_trem_n        <= 8'b0;
          trn_trem_n        <= 1'b1;  
          
          fifo_tx_data_rd_en <= 1'b0;
          payload_valid <= 1'b0;
          
          trn_trem_en <= 1'b0;
          
 
          cur_mwr_dw_count  <= 10'b0;

          compl_done_o      <= 1'b0;
          mwr_done_o        <= 1'b0;

          mrd_done          <= 1'b0;

          cur_wr_count      <= 16'b0;
          cur_rd_count      <= 16'b1;

          mwr_len_byte      <= 13'b0;
          mrd_len_byte      <= 13'b0;

          pmwr_addr         <= 32'b0;
          pmrd_addr         <= 32'b0;

          rmwr_count        <= 16'b0;
          rmrd_count        <= 16'b0;

          serv_mwr          <= 1'b1;
          serv_mrd          <= 1'b1;

          tmwr_wrr_cnt      <= 8'h00;
          tmrd_wrr_cnt      <= 8'h00;

          bmd_64_tx_state   <= `BMD_64_TX_RST_STATE;

        end else begin 

         
          if (init_rst_i ) begin

            trn_tsof_n        <= 1'b1;
            trn_teof_n        <= 1'b1;
            trn_tsrc_rdy_n    <= 1'b1;
            trn_tsrc_dsc_n    <= 1'b1;
            trn_td            <= 64'b0;
            //trn_trem_n        <= 8'b0;
            trn_trem_n        <= 1'b1;
            
            fifo_tx_data_rd_en <= 1'b0;
            payload_valid <= 1'b0;
            trn_trem_en <= 1'b0;
   
            cur_mwr_dw_count  <= 10'b0;
  
            compl_done_o      <= 1'b0;
            mwr_done_o        <= 1'b0;

            mrd_done          <= 1'b0;
  
            cur_wr_count      <= 16'b0;
            cur_rd_count      <= 16'b1;

            mwr_len_byte      <= 13'b0;
            mrd_len_byte      <= 13'b0;

            pmwr_addr         <= 32'b0;
            pmrd_addr         <= 32'b0;

            rmwr_count        <= 16'b0;
            rmrd_count        <= 16'b0;

            serv_mwr          <= 1'b1;
            serv_mrd          <= 1'b1;

            tmwr_wrr_cnt      <= 8'h00;
            tmrd_wrr_cnt      <= 8'h00;

            bmd_64_tx_state   <= `BMD_64_TX_RST_STATE;

          end

          mwr_len_byte        <= 4 * mwr_len_i[10:0];      //��ʾһ��TLP���������ֽڣ���������ڵ�ַƫ����Ҫʹ��
          mrd_len_byte        <= 4 * mrd_len_i[10:0];
          rmwr_count          <= mwr_count_i[15:0];
          rmrd_count          <= mrd_count_i[15:0];

          case ( bmd_64_tx_state ) 

            `BMD_64_TX_RST_STATE : begin

              compl_done_o       <= 1'b0;

              // PIO read completions always get highest priority

              if (req_compl_q && 
                  !compl_done_o &&
                  !trn_tdst_rdy_n &&
                  trn_tdst_dsc_n) begin

                trn_tsof_n       <= 1'b0;
                trn_teof_n       <= 1'b1;
                trn_tsrc_rdy_n   <= 1'b0;
                trn_td           <= { {1'b0}, 
                                      `BMD_64_CPLD_FMT_TYPE, 
                                      {1'b0}, 
                                      req_tc_i, 
                                      {4'b0}, 
                                      req_td_i, 
                                      req_ep_i, 
                                      req_attr_i, 
                                      {2'b0}, 
                                      req_len_i,
                                      completer_id_i,     //��ɰ�ID  [15:0]
                                      {3'b0},  
                                      {1'b0},
                                      //req_tag_i,
                                      byte_count
                                      //{8'h0F}
                                       };       // [11:0]
                trn_trem_n        <= 8'b0;
                //trn_trem_n        <= 1'b0;

                bmd_64_tx_state   <= `BMD_64_TX_CPLD_QW1;
              end
              //DMAд����
              else if (mwr_start_i &&                //mwr_start_iΪPC��������DMAд�����ź�
                           !mwr_done_o &&           //mwr_done_oΪдDMA����źţ�һ��Ϊ1����ʾ��ɣ����ټ���
                           serv_mwr &&
                           !trn_tdst_rdy_n &&       //trn_tdst_rdy_nΪIP׼���õ��ź�
                           trn_tdst_dsc_n && 
                           cfg_bm_en)            //cfg_bm_en=cfg_command[2]����ʾ��������ֻ�ܣ���������������ÿռ��ͷ������Ĵ���        
                begin             
                	trn_tsof_n       <= 1'b0;
                	trn_teof_n       <= 1'b1;
                	trn_tsrc_rdy_n   <= 1'b0;        //����Դ׼���źţ�����׺n��ʾ����Ч
                	//fifo_tx_data_rd_en <= 1'b0;      //fifo����ʹ�ܣ�
                	fifo_tx_data_rd_en <= 1'b1;        //ͨ��ʱ�������Ҫ��ǰ����ʱ��
                	trn_td           <= {          
                			{1'b0}, 
                			{mwr_64b_en_i ? 
                			 `BMD_64_MWR64_FMT_TYPE :  
                			 `BMD_64_MWR_FMT_TYPE}, 
                			{1'b0},      //У��λR��Ϊ0
                			mwr_tlp_tc_i,  //TC����Դ��PC���͹���DMAд����
                			{4'b0},       //4bitУ��λ
                			1'b0,          //TD
                			1'b0,          //EP
                			{mwr_relaxed_order_i, mwr_nosnoop_i}, // 2'b00,attr��PC�����͹������豸���� 
                			{2'b0},         //2bitУ��λ
                			mwr_len_i[9:0],   //DMAд��������ݳ��ȣ�PC������������    SIZE
                			{completer_id_i[15:3], mwr_func_num},     //��һ�鲻��
                			cfg_ext_tag_en_i ? cur_wr_count[7:0] : {3'b0, cur_wr_count[4:0]},     //���Ϊ1DW֮�ڣ�Last beȫΪ0
                			(mwr_len_i[9:0] == 1'b1) ? 4'b0 : mwr_lbe_i,   //�������Ϊ1DW����ô��һ��˫��ȫ��Ч����Last beΪ0��mwr_lbe_i
                			mwr_fbe_i};    //�����ȴ���1DWʱ��mwr_fbe_iȫΪ1��С��1DWʱ�������ֽ�ʹ�ܣ���һ���ļ�ֱ����ΪF����ʾ����1��DW
                	//trn_trem_n        <= 8'h00;      //ȫΪ0��ȡ����ΪFF����ʾȫʹ��    //�����⣬����axi_trn_txʱ��Ϊ1bit
                	trn_trem_n        <= 1'b0;          //trn_trem_nΪ0��ʾtkeepΪFF��Ϊ1��ʾtkeepΪ0F
                	trn_trem_en       <= 1'b1;       //�������ӣ�������ʾtkeepΪFF����0F
                	cur_mwr_dw_count  <= mwr_len_i[9:0];  //�����غɵĸ���  SIZE              
                	// Weighted Round Robin
                	if (mwr_start_i && !mwr_done_o && (tmwr_wrr_cnt != mwr_wrr_cnt_i))    //��ʱδ֪
                		begin                                             //mwr_wrr_cnt_i��Դ�ڼĴ���ģ��
                		  serv_mwr        <= 1'b1;
                		  serv_mrd        <= 1'b0;            //������DMAд�����һ�û��ɣ���ô����DMAд                 
                		  tmwr_wrr_cnt    <= tmwr_wrr_cnt + 1'b1;
                		end 
                	else if (mrd_start_i && !mrd_done)    
                		begin
                	  	serv_mwr        <= 1'b0;
                	  	serv_mrd        <= 1'b1;
                	  	tmwr_wrr_cnt    <= 8'h00;
                		end 
                	else 
                		begin
                		  serv_mwr        <= 1'b0;
                		  serv_mrd        <= 1'b0;
                		  tmwr_wrr_cnt    <= 8'h00;
                		end               
                	if (mwr_64b_en_i)
				  					bmd_64_tx_state   <= `BMD_64_TX_MWR64_QW1;
                	else
				 					 	bmd_64_tx_state   <= `BMD_64_TX_MWR_QW1;                
              	end                 
								//DMA��������FPGA��PC�����Ͷ�TLP������������
               else if (mrd_start_i &&           //mwr_start_i=wr_d_i[16]ΪPC��������DMA�������źţ�Ϊ����״̬�Ĵ���
                           !mrd_done &&          //mrd_doneΪDMA������ź�
                           serv_mrd &&
                           !trn_tdst_rdy_n &&
                           trn_tdst_dsc_n && 
                           cfg_bm_en) 
               	 begin
             
                	 trn_tsof_n       <= 1'b0;
                	 trn_teof_n       <= 1'b1;
                	 trn_tsrc_rdy_n   <= 1'b0;
                	 trn_td           <= { {1'b0}, 
                	                       {mrd_64b_en_i ? 
                	                        `BMD_64_MRD64_FMT_TYPE : 
                	                        `BMD_64_MRD_FMT_TYPE}, 
                	                       {1'b0}, 
                	                       mrd_tlp_tc_i, 
                	                       {4'b0}, 
                	                       1'b0, 
                	                       1'b0, 
                	                       {mrd_relaxed_order_i, mrd_nosnoop_i}, // 2'b00, 
                	                       {2'b0}, 
                	                       mrd_len_i[9:0],             //DMA����������ݳ��ȣ�PC������������
                	                       {completer_id_i[15:3], mrd_func_num}, 
                	                       cfg_ext_tag_en_i ? cur_rd_count[7:0] : {3'b0, cur_rd_count[4:0]},
                	                       (mrd_len_i[9:0] == 1'b1) ? 4'b0 : mrd_lbe_i,
                	                       mrd_fbe_i};
                	 //trn_trem_n        <= 8'b0;
									 trn_trem_n        <= 1'b0;
									 trn_trem_en       <= 1'b1;
                	 // Weighted Round Robin
                	 if (mrd_start_i && !mrd_done && (tmrd_wrr_cnt != mrd_wrr_cnt_i)) 
                	 	begin
                	 	  serv_mrd        <= 1'b1;
                	 	  serv_mwr        <= 1'b0;
                	 	  tmrd_wrr_cnt    <= tmrd_wrr_cnt + 1'b1;
                	 	end 
                	 else if (mwr_start_i && !mwr_done_o) 
                	 	begin
                	 	  serv_mrd        <= 1'b0;
                	 	  serv_mwr        <= 1'b1;
                	 	  tmrd_wrr_cnt    <= 8'h00;
                	 	end
                	 else 
                	 	begin
                	   	serv_mrd        <= 1'b0;
                	   	serv_mwr        <= 1'b0;
                	   	tmrd_wrr_cnt    <= 8'h00;
                	 	end
                	 bmd_64_tx_state   <= `BMD_64_TX_MRD_QW1;              
              	 end 
              else  
              	begin
              	  if(!trn_tdst_rdy_n) 
              	  	begin             	  	
              	  	  trn_tsof_n        <= 1'b1;
              	  	  trn_teof_n        <= 1'b1;
              	  	  trn_tsrc_rdy_n    <= 1'b1;
              	  	  trn_tsrc_dsc_n    <= 1'b1;
              	  	  trn_td            <= 64'b0;
              	  	  trn_trem_n        <= 8'b0;
              	  	
              	  	  serv_mwr          <= ~serv_mwr;
              	  	  serv_mrd          <= ~serv_mrd;              	
              			end 
                	bmd_64_tx_state   <= `BMD_64_TX_RST_STATE;
                	fifo_tx_data_rd_en <= 1'b0;         //һֱ���ڳ�ʼ״̬��ҲҪ��������
              	end

            end

            `BMD_64_TX_CPLD_QW1 : begin

              if ((!trn_tdst_rdy_n) && (trn_tdst_dsc_n)) begin

                trn_tsof_n       <= 1'b1;
                trn_teof_n       <= 1'b0;
                trn_tsrc_rdy_n   <= 1'b0;
                trn_td           <= { req_rid_i,              //������ID  [15:0] 
                                      req_tag_i,              //������
                                      {1'b0},
                                      //{16'hfddf},
                                      //{2'b11},
                                      lower_addr,              //��ַ
                                      rd_data_i };             //����
                trn_trem_n       <= 8'h00;
                compl_done_o     <= 1'b1;

                bmd_64_tx_state  <= `BMD_64_TX_CPLD_WIT;

              end else if (!trn_tdst_dsc_n) begin

                trn_tsrc_dsc_n   <= 1'b0;

                bmd_64_tx_state  <= `BMD_64_TX_CPLD_WIT;

              end else
                bmd_64_tx_state  <= `BMD_64_TX_CPLD_QW1;

            end

            `BMD_64_TX_CPLD_WIT : begin

              if ( (!trn_tdst_rdy_n) || (!trn_tdst_dsc_n) ) begin

                trn_tsof_n       <= 1'b1;
                trn_teof_n       <= 1'b1;
                trn_tsrc_rdy_n   <= 1'b1;
                trn_tsrc_dsc_n   <= 1'b1;

                bmd_64_tx_state  <= `BMD_64_TX_RST_STATE;

              end else
                bmd_64_tx_state  <= `BMD_64_TX_CPLD_WIT;

            end

            `BMD_64_TX_MWR_QW1 :             //DMAд�����ĵڶ���״̬����ʼ����TLP���ĵڶ����֣������ݺ͵�ַ
            begin
              if ((!trn_tdst_rdy_n) && (trn_tdst_dsc_n))    //trn_tdst_dsc_n=1��ʾ����Դ��Ҫ������Ϊ0��ʾ������
              	begin
                	trn_tsof_n       <= 1'b1;
                	//fifo_tx_data_rd_en <= 1'b1;
                	trn_tsrc_rdy_n   <= 1'b0;             //�����Ѿ����͵�TLP������������PC��д�����ʼ��ַtmwr_addr
                	if (cur_wr_count == 0)                //���ݼ���ĵ�ַ���͵ڶ���DW��Ȼ�����дһ��״̬BMD_64_TX_MWR_QWN
                	  tmwr_addr       = mwr_addr;   //��һ����ִ����䣬������ֵ��������Ч������ķ�������ֵ���Եõ����ֵ         
                	else                            //mwr_addrΪPC���͵İ�����ַ��TLP����Ҳ����PC�����ǵ�ַ���������������ַ������
                	  tmwr_addr       = pmwr_addr + mwr_len_byte;  //ʣ�µİ�ִ�����  
                	//trn_td           <= {{tmwr_addr[31:2], 2'b00}, 32'h0520_1314};  //2'b00ΪУ��λR��mwr_data_i_swΪ�û�����Ҫ���͵�����
                	trn_td           <= {{tmwr_addr[31:2], 2'b00}, mwr_data_i_sw};
                	pmwr_addr        <= tmwr_addr;    //��һ�ģ���������           	
                	cur_wr_count <= cur_wr_count + 1'b1;   //��ʼ�������Ѿ����͵�TLP������             	
                	if (cur_mwr_dw_count == 1'h1)     //cur_mwr_dw_count��ʾ�������ݵĸ�������λΪDW��
                		begin               	           //Ϊ1ʱ����ʾֻ����һ��DW������һ�ξͷ����ˣ�Ȼ����븴λ״̬
                	  	trn_teof_n       <= 1'b0;      //��ʾTLP��������
                	  	fifo_tx_data_rd_en <= 1'b0;    //���ֻ����һ��DW�����ݣ�FIFO�������ݣ�Ҳ���ǲ������ݣ��˷���һ��DW
                	  	cur_mwr_dw_count <= cur_mwr_dw_count - 1'h1;  //������ϣ���������Ϊ0 
                	  	//trn_trem_n       <= 8'h00; 
                	  	trn_trem_n       <= 1'b0;
                	  	trn_trem_en       <= 1'b1;              	  	
                	  	if (cur_wr_count == (rmwr_count - 1'b1))    //rmwr_count��ʾԤ�跢�͵�TLP��������PC����
                	  		begin               	  	                //�����ж��ѷ���TLP�������Ƿ����Ԥ���ĸ���
                	  	  	cur_wr_count <= 0;                    //����Ҫ�����ˣ���0
                	  	  	mwr_done_o   <= 1'b1;                 //��ʾDMAд�����             	  	
                	  		end               	  	
                	  	bmd_64_tx_state  <= `BMD_64_TX_RST_STATE;              	
                		end 
                	else               //������ݸ��صĳ��ȴ���1DW���������һ״̬������������
                		begin                	
                	  	fifo_tx_data_rd_en <= 1'b1;    //FIFO��ʹ�ܣ���һ��ʱ�ӳ�����
                	  	cur_mwr_dw_count <= cur_mwr_dw_count - 1'h1;    //�����1����ʾ�Ѿ�������1��DW��
                	  	//trn_trem_n       <= 8'hFF;                    //���Ա�ʾtrn_td���ֽ�ʹ��
                	  	trn_trem_n       <= 1'b0;
                	  	trn_trem_en       <= 1'b1;
                	  	bmd_64_tx_state  <= `BMD_64_TX_MWR_QWN;               	
                		end
              	end 
              else if (!trn_tdst_dsc_n)      //trn_tdst_dsc_nһֱΪ1
              	begin
              	  bmd_64_tx_state    <= `BMD_64_TX_RST_STATE;
              	  trn_tsrc_dsc_n     <= 1'b0;
              	  fifo_tx_data_rd_en <= 1'b0;
              	end 
              else
                begin
                	bmd_64_tx_state    <= `BMD_64_TX_MWR_QW1;  
                	fifo_tx_data_rd_en <= 1'b0;                //���trn_tdst_rdy_nΪ�ߣ��ͻ������״̬һֱѭ��������
                end                                          //��ʹ��Ҫ����
            end

            `BMD_64_TX_MWR64_QW1 : begin

              if ((!trn_tdst_rdy_n) && (trn_tdst_dsc_n)) begin

                trn_tsof_n       <= 1'b1;
                trn_tsrc_rdy_n   <= 1'b0;
                if (cur_wr_count == 0)
                  tmwr_addr       = mwr_addr;
                else 
                  tmwr_addr       = {pmwr_addr[31:24], pmwr_addr[23:0] + mwr_len_byte};
                trn_td           <= {{24'b0},mwr_up_addr_i,tmwr_addr[31:2],{2'b0}};
                pmwr_addr        <= tmwr_addr;

                cur_wr_count <= cur_wr_count + 1'b1;

                bmd_64_tx_state  <= `BMD_64_TX_MWR_QWN;

              end else if (!trn_tdst_dsc_n) begin

                bmd_64_tx_state    <= `BMD_64_TX_RST_STATE;
                trn_tsrc_dsc_n     <= 1'b0;

              end else
                bmd_64_tx_state    <= `BMD_64_TX_MWR64_QW1;

            end

             `BMD_64_TX_MWR_QWN : begin                 					     //�������״̬���ж�һ��TLP�������ݳ����Ƕ��٣�    														
                                                                 //�����1����������һ��DW�󣬽��븴λ״̬              
              if ((!trn_tdst_rdy_n) && (trn_tdst_dsc_n)) 
              	begin                                                                   
              	  trn_tsrc_rdy_n   <= 1'b0;                        
              	  if (cur_mwr_dw_count == 1'h1)     //cur_mwr_dw_count���ж���DWû�з���,�����ʣ��һ��DWû��
              	   	begin     
              	   	 	//trn_td           <= {mwr_data_i_sw, 32'hd0_da_d0_da};   //���﷢�Ĺ̶�����
              	   	 	//trn_td           <= {32'h1213_1415, 32'hd0_da_d0_da};
              	   	 	if(fifo_tx_data_valid == 1'b1)                //һ����˵��������PC�����õ�DW���������������
                  			begin
                  				trn_td <= fifo_tx_data;
                  				payload_valid  <=1'b1;
                  			end
                  		else
                  			begin
                  				trn_td <= 64'd0;  
                  				payload_valid  <=1'b0;
                  			end           	   	 	
              	   	 	trn_trem_n       <= 8'h0F;      //��ʾ��32λ��Ч����32λ��Ч
              	   	 	trn_trem_n       <= 1'b1;
              	   	 	trn_trem_en       <= 1'b0;
              	   	 	trn_teof_n       <= 1'b0;              	   	 	
              	   	 	fifo_tx_data_rd_en <= 1'b0;      //�������һ��TLP�Ĵ��������FIFO��������
              	   	 	cur_mwr_dw_count <= cur_mwr_dw_count - 1'h1; 
              	   	 	bmd_64_tx_state  <= `BMD_64_TX_RST_STATE;               	
              	  		if (cur_wr_count == rmwr_count)  
              	   			begin                      	
              	   			  cur_wr_count <= 0; 
              	   			  mwr_done_o   <= 1'b1;              	
              	   			end 
              	   		/*else      //һ����˵��һ��DMA����ᴫ�Ͷ��TLP������֤Ч�ʣ�Ҳ���Դﵽһ��DMA�����������
                  			begin
                  				cur_wr_count <= cur_wr_count + 1'b1;      //û����һ��TLP���ۼ�һ��
                  				mwr_done_o   <= 1'b0;
                  			end*/
              			end 
                	else if (cur_mwr_dw_count == 2'h2)       //�����2������һ��DW������������ݣ��������
                  	begin																				//���븴λ״̬
                  		//trn_td           <= {mwr_data_i_sw, mwr_data_i_sw};
                  		if(fifo_tx_data_valid == 1'b1)
                  			begin
                  				trn_td <= fifo_tx_data;
                  				payload_valid  <=1'b1;
                  			end
                  		else
                  			begin
                  				trn_td <= 64'd0; 
                  				payload_valid  <=1'b0;
                  			end   
                  		//trn_trem_n       <= 8'h00;
                  		trn_trem_n       <= 1'b0;
                  		trn_trem_en       <= 1'b1;
                  		trn_teof_n       <= 1'b0;               //��ʾ���ͽ���
                  		fifo_tx_data_rd_en <= 1'b0;             //�������һ��TLP�Ĵ��������FIFO��������
                  		cur_mwr_dw_count <= cur_mwr_dw_count - 2'h2;         //�����ǰ���͵����ݳ��ȴ���2����һֱ�������ݣ�
                  		bmd_64_tx_state  <= `BMD_64_TX_RST_STATE;         //ֱ�����µ����ݳ���С��2��Ȼ������������ڣ�
                  		if (cur_wr_count == rmwr_count)             //��������ʣ�µ����ݣ��ص���λ״̬
                  		  begin //�жϷ���TLP�ĸ����Ƿ���Ԥ�������
                  		  	cur_wr_count <= 0;                   //�ڽ��뵽��λ֮ǰ�����жϣ��Ѿ����͵�TLP�����Ƿ��
                  		  	mwr_done_o   <= 1'b1;              //Ԥ������ȣ������ȣ��ͻ᷵���ź�mwr_done_o                	
                  			end
                  		/*else      //һ����˵��һ��DMA����ᴫ�Ͷ��TLP������֤Ч�ʣ�Ҳ���Դﵽһ��DMA�����������
                  			begin
                  				cur_wr_count <= cur_wr_count + 1'b1;      //û����һ��TLP���ۼ�һ��
                  				mwr_done_o   <= 1'b0;   //һ��DMA��û���
                  			end*/
                  	end                                       //���ǣ���ÿ��TLP�����ݳ��ȴ���2ʱ����ô����PC�˵ĵ�ַ
                  else                                        //��˭�����ۼ��أ����﷢�������DMA��������ģ�DMA���͵�
                  	begin                                    //���ݲ������ڴ��ȡ�����ģ�����һ��ʼ�ղ������
                  		//fifo_tx_data_rd_en <= 1'b1;  //ʵ���ϣ�Ϊ�˴���Ч�ʣ����ٷ���16��DW
                  		//trn_td           <= {mwr_data_i_sw, mwr_data_i_sw};   //����������DW��
                  		//if((cur_mwr_dw_count == 3'd3) || (cur_mwr_dw_count == 3'h4))
                  		if((cur_mwr_dw_count == 3'd5) || (cur_mwr_dw_count == 3'd3) || (cur_mwr_dw_count == 3'h4))
                  			fifo_tx_data_rd_en <= 1'b0;
                  		else
                  			fifo_tx_data_rd_en <= 1'b1;
                  		if(fifo_tx_data_valid == 1'b1)
                  			trn_td <= fifo_tx_data;
                  		else
                  			trn_td <= fifo_tx_data;    //ȡfifo_tx_data��һ��ʱ�ӵ�ֵ
                  			//trn_td <= 64'd0;
                  		//trn_trem_n       <= 8'hFF;               //��0����ʾȫ������Ч
                  		trn_trem_n       <= 1'b0;
                  		trn_trem_en       <= 1'b1;
                  		payload_valid     <=1'b1;
                  		cur_mwr_dw_count <= cur_mwr_dw_count - 2'h2; //����Ҫ����5��DW�������Ǹ�״̬���Ѿ�����1��DW,��ʣ4��
                  		bmd_64_tx_state  <= `BMD_64_TX_MWR_QWN;    //��һ�ν�������󣬷���2��DW����ʣ2��DW��  //���������if��䷢��ʣ�µ�2��DW
               			end																					 
              	end 
              else if (!trn_tdst_dsc_n) 
              	begin
                	bmd_64_tx_state    <= `BMD_64_TX_RST_STATE;
                	trn_tsrc_dsc_n     <= 1'b0;
                	fifo_tx_data_rd_en <= 1'b0;
                end 
              else
                begin
                	bmd_64_tx_state    <= `BMD_64_TX_MWR_QWN;
                	fifo_tx_data_rd_en <= 1'b0;
                end
            end

            `BMD_64_TX_MRD_QW1 : 
            	begin
            	
            	  if ((!trn_tdst_rdy_n) && (trn_tdst_dsc_n)) 
            	  	begin       	
            	  	  trn_tsof_n       <= 1'b1;
            	  	  trn_teof_n       <= 1'b0;
            	  	  trn_tsrc_rdy_n   <= 1'b0;
            	  	  if (cur_rd_count == 1)        //cur_rd_count��ʼֵΪ1
            	  	    tmrd_addr       = mrd_addr;   //��һ��TLP��ִ��
            	  	  else 
            	  	    tmrd_addr       = {pmrd_addr[31:24], pmrd_addr[23:0] + mrd_len_byte};   //ʣ��TLP��ִ��
            	  	  if (mrd_64b_en_i)        //���ʹ����64bit�洢����
            	  	  	begin
            	  	  	  trn_td         <= {{24'b0},{mrd_up_addr_i},{tmrd_addr[31:2],2'b0}};
            	  	  	  trn_trem_n     <= 8'h00;
            	  	  	end 
            	  	  else 
            	  	  	begin
            	  	  	  //trn_td         <= {{tmrd_addr[31:2], 2'b00}, 32'hd0_da_d0_da};
            	  	  	  //trn_trem_n     <= 8'h0F;
            	  	  	  trn_td         <= {{tmrd_addr[31:2], 2'b00}, 32'h12_34_56_78}; 
            	  	  	  trn_trem_n     <= 1'b1;      //keep=8'h0F
            						trn_trem_en    <= 1'b0;                               
            	  	  	end
            	  	  pmrd_addr        <= tmrd_addr;          	
            	  	  if (cur_rd_count == rmrd_count) 
            	  	  	begin            	
            	  	  	  cur_rd_count   <= 0; 
            	  	  	  mrd_done       <= 1'b1;            	
            	  	  	end
            	  	  else 
            	  	    cur_rd_count <= cur_rd_count + 1'b1;           	
            	  	  bmd_64_tx_state  <= `BMD_64_TX_RST_STATE;   //�ص���ʼ״̬���ٽ�����һ������         	
            	  	end 
            	  		else if (!trn_tdst_dsc_n) 
            	  			begin            	  	
            	  	  		bmd_64_tx_state  <= `BMD_64_TX_RST_STATE;
            	  	  		trn_tsrc_dsc_n   <= 1'b0;            	  	
            	  	end else
            	  	  bmd_64_tx_state  <= `BMD_64_TX_MRD_QW1;
            	  	
            	end

          endcase

        end

    end


//�����DDR3�������������Ƿ���ȷ
	reg [63:0]trn_td_r1;
	reg [63:0]trn_td_r2; 
	reg payload_valid_r1;
	reg payload_valid_r2;
	
	always @(posedge clk )
	begin
		if(!rst_n)
			begin	
				trn_td_r1 <= 64'd0;
				trn_td_r2 <= 64'd0;
			end
		else if(payload_valid)
			begin
				trn_td_r1 <= trn_td;
				trn_td_r2 <= trn_td_r1;
		  end
		else
			begin
				trn_td_r1 <= trn_td_r1;
				trn_td_r2 <= trn_td_r2;
			end
	end
	always @(posedge clk )
	begin
		payload_valid_r1 <= payload_valid; 
		payload_valid_r2 <= payload_valid_r1;
	end
	reg trn_td_error;
	always @(posedge clk )
	begin
		if(!rst_n)
			trn_td_error <= 1'b0;	
		else if(payload_valid_r2 & payload_valid )		
	    begin
	  		if( ({trn_td[63:48]} - {trn_td_r2[63:48]} == 2'd1) || ({trn_td[63:48]} - {trn_td_r2[63:48]} == 3'd5))	  		  
					trn_td_error <= 1'b0;                                              
				else       
					trn_td_error <= 1'b1;
			end
		else
			trn_td_error <= 1'b0;
	end	

/*
	ILA_PCIE_TOP 
		BMD_64_TX_ENGINE_i (
	.clk(clk), // input wire clk


	.probe0({
					trn_td[63:0],
	        //rd_addr_o[6:0],   	          
	        mwr_addr[31:0],
	        //lower_addr[6:0],
	        
	        cur_wr_count[15:0],
	        rmwr_count[15:0]        	               
	
	}), // input wire [127:0]  probe0  
	.probe1({
    			trn_tsof_n,    
	        trn_teof_n,
	        rd_be_o[3:0],    
	        trn_tsrc_rdy_n,
	        trn_tsrc_dsc_n,
	        trn_tdst_rdy_n,
	        trn_tdst_dsc_n,
	        req_compl_i,
				  compl_done_o,
				  trn_trem_n[0:0],
				  fifo_tx_data_valid,
				  fifo_tx_data_rd_en,
				  trn_trem_en, 
				  mwr_start_i,
				  mwr_done_o,
				  cfg_bm_en,
				  cur_mwr_dw_count[9:0],
	        bmd_64_tx_state[7:0],
	        mrd_start_i,
	        mrd_len_i[9:0],
				  mrd_count_i[15:0],
				  lower_addr[6:0],     
				  trn_td_error
				  	
				  				  
	}) // input wire [79:0]  probe1
);
*/



endmodule // BMD_64_TX_ENGINE
