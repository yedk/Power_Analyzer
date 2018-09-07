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
//-- Filename: BMD_64_RX_ENGINE.v
//--
//-- Description: 64 bit Local-Link Receive Unit.
//--
//--------------------------------------------------------------------------------

`timescale 1ns/1ns

`define BMD_64_RX_RST            8'b00000001   //01
`define BMD_64_RX_MEM_RD32_QW1   8'b00000010   //02
`define BMD_64_RX_MEM_RD32_WT    8'b00000100   //04
`define BMD_64_RX_MEM_WR32_QW1   8'b00001000   //08
`define BMD_64_RX_MEM_WR32_WT    8'b00010000   //10
`define BMD_64_RX_CPL_QW1        8'b00100000   //20
`define BMD_64_RX_CPLD_QW1       8'b01000000   //40
`define BMD_64_RX_CPLD_QWN       8'b10000000   //80
                                              
`define BMD_MEM_RD32_FMT_TYPE    7'b00_00000
`define BMD_MEM_WR32_FMT_TYPE    7'b10_00000
`define BMD_CPL_FMT_TYPE         7'b00_01010
`define BMD_CPLD_FMT_TYPE        7'b10_01010

module BMD_64_RX_ENGINE (

                        clk,
                        rst_n,

                        /*
                         * Initiator reset
                         */

                        init_rst_i,      
                        //接收端FIFO定义
                        rx_fifo_data_in,
                        rx_fifo_data_wr_en, 
                        
                        dma_read_addr, 
                        mrd_end,
                        
                        mrd_start_in,
                        mrd_int_dis_in,
                        mrd_done_in,
                        mrd_addr_in,
                        mrd_len_in,
                        mrd_count_in,                                                
                        /*
                         * Receive local link interface from PCIe core
                         */
                    
                        trn_rd,  
                        trn_rrem_n,
                        trn_rsof_n,
                        trn_reof_n,
                        trn_rsrc_rdy_n,
                        trn_rsrc_dsc_n,
                        trn_rdst_rdy_n,
                        trn_rbar_hit_n,

                        /*
                         * Memory Read data handshake with Completion 
                         * transmit unit. Transmit unit reponds to 
                         * req_compl assertion and responds with compl_done
                         * assertion when a Completion w/ data is transmitted. 
                         */

                        req_compl_o,
                        compl_done_i,

                        addr_o,                    // Memory Read Address

                        req_tc_o,                  // Memory Read TC
                        req_td_o,                  // Memory Read TD
                        req_ep_o,                  // Memory Read EP
                        req_attr_o,                // Memory Read Attribute
                        req_len_o,                 // Memory Read Length (1DW)
                        req_rid_o,                 // Memory Read Requestor ID
                        req_tag_o,                 // Memory Read Tag
                        req_be_o,                  // Memory Read Byte Enables

                        /* 
                         * Memory interface used to save 1 DW data received 
                         * on Memory Write 32 TLP. Data extracted from
                         * inbound TLP is presented to the Endpoint memory
                         * unit. Endpoint memory unit reacts to wr_en_o
                         * assertion and asserts wr_busy_i when it is 
                         * processing written information.
                         */

                        wr_be_o,                   // Memory Write Byte Enable
                        wr_data_o,                 // Memory Write Data
                        wr_en_o,                   // Memory Write Enable
                        wr_busy_i,                  // Memory Write Busy

                        /*
                         * Completion no Data
                         */

                        cpl_ur_found_o,
                        cpl_ur_tag_o,

                        /*
                         * Completion with Data
                         */
                        
                        cpld_data_i,
                        cpld_found_o,
                        cpld_data_size_o,
                        cpld_malformed_o,
                        cpld_data_err_o
                         

                       );

    input              clk;
    input              rst_n;

    input              init_rst_i;
    
    output reg [63:0]rx_fifo_data_in;
    output reg rx_fifo_data_wr_en;
    
    output reg [31:0]dma_read_addr;    //自定义循环地址，把每个DW的数据对号入座  
    output reg mrd_end;
    //DMA读参数
    input mrd_start_in;
    input mrd_int_dis_in;
    input mrd_done_in;
    input [31:0]mrd_addr_in;
    input [31:0]mrd_len_in;
    input [31:0]mrd_count_in;         

    input [63:0]       trn_rd;
    //input [7:0]        trn_rrem_n;
    input [0:0]        trn_rrem_n;
    input              trn_rsof_n;
    input              trn_reof_n;
    input              trn_rsrc_rdy_n;
    input              trn_rsrc_dsc_n;
    output             trn_rdst_rdy_n;
    input [6:0]        trn_rbar_hit_n;
 
    output             req_compl_o;
    input              compl_done_i;

    //output [10:0]      addr_o;
    output [31:0]      addr_o;

    output [2:0]       req_tc_o;
    output             req_td_o;
    output             req_ep_o;
    output [1:0]       req_attr_o;
    output [9:0]       req_len_o;
    output [15:0]      req_rid_o;
    output [7:0]       req_tag_o;
    output [7:0]       req_be_o;

    output [7:0]       wr_be_o;
    output [31:0]      wr_data_o;
    output             wr_en_o;
    input              wr_busy_i;

    output [7:0]       cpl_ur_found_o;
    output [7:0]       cpl_ur_tag_o;

    input  [31:0]      cpld_data_i;
    output [31:0]      cpld_found_o;
    output [31:0]      cpld_data_size_o;
		output             cpld_malformed_o;
    output             cpld_data_err_o;

    // Local wire

    wire   [31:0]      cpld_data_i_sw = {cpld_data_i[07:00],
                                         cpld_data_i[15:08],
                                         cpld_data_i[23:16],
                                         cpld_data_i[31:24]};

    // Local Registers

    reg [7:0]          bmd_64_rx_state;

    reg                trn_rdst_rdy_n;

    reg                req_compl_o;

    reg [2:0]          req_tc_o;
    reg                req_td_o;
    reg                req_ep_o;
    reg [1:0]          req_attr_o;
    reg [9:0]          req_len_o;
    reg [15:0]         req_rid_o;
    reg [7:0]          req_tag_o;
    reg [7:0]          req_be_o;

    //reg [10:0]         addr_o; 
    reg [31:0]         addr_o;
    reg [7:0]          wr_be_o;
    reg [31:0]         wr_data_o;
    reg                wr_en_o;

    reg [7:0]          cpl_ur_found_o;
    reg [7:0]          cpl_ur_tag_o;

    reg [31:0]         cpld_found_o;
    reg [31:0]         cpld_data_size_o;
    reg                cpld_malformed_o;
    reg                cpld_data_err_o;

    //reg [9:0]          cpld_real_size;
    //reg [9:0]          cpld_tlp_size;
    reg [6:0]          cpld_real_size;     //限制一个TLP包的数据载荷，理论上1024个DW，这里限制为2^7=128个DW
    reg [6:0]          cpld_tlp_size;     //限制一个TLP包的数据载荷，理论上1024个DW，这里限制为2^7=128个DW
 
    reg [7:0]          bmd_64_rx_state_q;
    reg [63:0]         trn_rd_q;
    reg [7:0]          trn_rrem_n_q;
    reg                trn_reof_n_q;
    reg                trn_rsrc_rdy_n_q;  
    
    wire [15:0]rmrd_count_value; 
    reg [15:0] cur_rd_count; 
    reg [31:0] addr_of_data;
     
    assign rmrd_count_value = mrd_count_in[15:0];

    always @ ( posedge clk ) begin
              
        if (!rst_n ) begin

          bmd_64_rx_state   <= `BMD_64_RX_RST;

          trn_rdst_rdy_n <= 1'b0;

          req_compl_o    <= 1'b0; 
          mrd_end       <= 1'b0; 
          
          rx_fifo_data_in <= 64'd0;
          rx_fifo_data_wr_en <= 1'b0;

          req_tc_o       <= 2'b0;
          req_td_o       <= 1'b0;
          req_ep_o       <= 1'b0;
          req_attr_o     <= 2'b0;
          req_len_o      <= 10'b0;
          req_rid_o      <= 16'b0;
          req_tag_o      <= 8'b0;
          req_be_o       <= 8'b0;
          addr_o         <= 31'b0;

          wr_be_o        <= 8'b0;
          wr_data_o      <= 31'b0;
          wr_en_o        <= 1'b0;
          
          cpl_ur_found_o   <= 8'b0;
          cpl_ur_tag_o     <= 8'b0;

          cpld_found_o     <= 32'b0;
          cpld_data_size_o <= 32'b0;
          cur_rd_count <= 16'd0;
          cpld_malformed_o <= 1'b0;

          cpld_real_size   <= 7'b0;
          cpld_tlp_size    <= 7'b0;

          bmd_64_rx_state_q <= `BMD_64_RX_RST;
          trn_rd_q          <= 64'b0;
          trn_rrem_n_q      <= 8'b0;
          trn_reof_n_q      <= 1'b1;
          trn_rsrc_rdy_n_q  <= 1'b1;

        end else begin

          wr_en_o        <= 1'b0;         //特别注意这块的信号，
          req_compl_o    <= 1'b0;
          trn_rdst_rdy_n <= 1'b0;
 
          if (init_rst_i) begin

            bmd_64_rx_state  <= `BMD_64_RX_RST;

            cpl_ur_found_o   <= 8'b0;
            cpl_ur_tag_o     <= 8'b0;
            
            mrd_end     <= 1'b0;
            
            rx_fifo_data_in <= 64'd0;
         	  rx_fifo_data_wr_en <= 1'b0;
   
            cpld_found_o     <= 32'b0;
            cpld_data_size_o <= 32'b0;
            cur_rd_count <= 16'd0;
            cpld_malformed_o <= 1'b0;

            cpld_real_size   <= 7'b0;
            cpld_tlp_size    <= 7'b0;

            bmd_64_rx_state_q <= `BMD_64_RX_RST;
            trn_rd_q          <= 64'b0;
            trn_rrem_n_q      <= 8'b0;
            trn_reof_n_q      <= 1'b1;
            trn_rsrc_rdy_n_q  <= 1'b1;

         end

         bmd_64_rx_state_q <= `BMD_64_RX_RST;
         trn_rd_q          <= 64'b0;
         trn_rrem_n_q      <= 8'b0;
         trn_reof_n_q      <= 1'b1;
         trn_rsrc_rdy_n_q  <= 1'b1;

         case (bmd_64_rx_state)

           `BMD_64_RX_RST : begin

             if ((!trn_rsof_n) && 
                 (!trn_rsrc_rdy_n) && 
                 (!trn_rdst_rdy_n)) begin
            
               case (trn_rd[62:56]) 

                 `BMD_MEM_RD32_FMT_TYPE : begin

                   if (trn_rd[41:32] == 10'b1) begin
    
                     req_tc_o     <= trn_rd[54:52];  
                     req_td_o     <= trn_rd[47];
                     req_ep_o     <= trn_rd[46]; 
                     req_attr_o   <= trn_rd[45:44]; 
                     req_len_o    <= trn_rd[41:32]; 
                     req_rid_o    <= trn_rd[31:16]; 
                     req_tag_o    <= trn_rd[15:08]; 
                     req_be_o     <= trn_rd[07:00];

                     bmd_64_rx_state <= `BMD_64_RX_MEM_RD32_QW1;
    
                   end else
                     bmd_64_rx_state <= `BMD_64_RX_RST;

                 end
             
                 `BMD_MEM_WR32_FMT_TYPE : begin
    
                   if (trn_rd[41:32] == 10'b1) begin
    
                     wr_be_o      <= trn_rd[07:00];
                     bmd_64_rx_state <= `BMD_64_RX_MEM_WR32_QW1;
                    
                   end else
                     bmd_64_rx_state <= `BMD_64_RX_RST;

    
                 end
    
                 `BMD_CPL_FMT_TYPE : begin
    
                   if (trn_rd[15:12] != 3'b000) begin
    
                     cpl_ur_found_o <= cpl_ur_found_o + 1'b1;
                     bmd_64_rx_state   <= `BMD_64_RX_CPL_QW1;
    
                   end else
                     bmd_64_rx_state   <= `BMD_64_RX_RST;
    
                 end
    
                 `BMD_CPLD_FMT_TYPE : begin                   //携带数据的完成包
                   
                   cpld_data_size_o <= cpld_data_size_o + trn_rd[41:32];  //trn_rd[41:32]为DW的个数，一次DMA读的累计总个数
                   cpld_tlp_size    <= trn_rd[38:32];          
                   cpld_found_o     <= cpld_found_o  + 1'b1;      //累计共发了多少TLP包
                   cpld_real_size   <= 7'b0;
                   //rx_fifo_data_in <= 64'd0;
                   rx_fifo_data_wr_en <= 1'b0;
                   bmd_64_rx_state  <= `BMD_64_RX_CPLD_QW1;
                   
                 end
                 
                 default : begin
    
                   bmd_64_rx_state   <= `BMD_64_RX_RST;
    
                 end
              
               endcase

             end else
               bmd_64_rx_state   <= `BMD_64_RX_RST;

           end

           `BMD_64_RX_MEM_RD32_QW1 : begin

             if ((!trn_reof_n) && 
                 (!trn_rsrc_rdy_n) && 
                 (!trn_rdst_rdy_n)) begin

               addr_o            <= trn_rd[63:34];
               req_compl_o       <= 1'b1;
               trn_rdst_rdy_n    <= 1'b1;
               bmd_64_rx_state   <= `BMD_64_RX_MEM_RD32_WT;

             end else
               bmd_64_rx_state   <= `BMD_64_RX_MEM_RD32_QW1;

           end

           `BMD_64_RX_MEM_RD32_WT: begin

             trn_rdst_rdy_n <= 1'b1;
             if (compl_done_i)
               bmd_64_rx_state   <= `BMD_64_RX_RST;
             else begin

               req_compl_o       <= 1'b1;
               trn_rdst_rdy_n    <= 1'b1;
               bmd_64_rx_state   <= `BMD_64_RX_MEM_RD32_WT;

             end

           end

           `BMD_64_RX_MEM_WR32_QW1 : begin

             if ((!trn_reof_n) && 
                 (!trn_rsrc_rdy_n) && 
                 (!trn_rdst_rdy_n)) begin

               //addr_o           <= trn_rd[44:34]; 
               addr_o           <= trn_rd[63:34];
               wr_data_o        <= trn_rd[31:00];
               wr_en_o          <= 1'b1;
               trn_rdst_rdy_n   <= 1'b1;
               bmd_64_rx_state  <= `BMD_64_RX_MEM_WR32_WT;

             end else
               bmd_64_rx_state  <= `BMD_64_RX_MEM_WR32_QW1;

           end

           `BMD_64_RX_MEM_WR32_WT: begin

             trn_rdst_rdy_n <= 1'b1;
             if (!wr_busy_i)
               bmd_64_rx_state  <= `BMD_64_RX_RST;
             else
               bmd_64_rx_state  <= `BMD_64_RX_MEM_WR32_WT;

           end

           `BMD_64_RX_CPL_QW1 : begin

             if ((!trn_reof_n) && 
                 (!trn_rsrc_rdy_n) && 
                 (!trn_rdst_rdy_n)) begin

               cpl_ur_tag_o     <= trn_rd[47:40];
               bmd_64_rx_state  <= `BMD_64_RX_RST;

             end else
               bmd_64_rx_state  <= `BMD_64_RX_CPL_QW1;

           end

           `BMD_64_RX_CPLD_QW1 : begin

             bmd_64_rx_state_q <= bmd_64_rx_state;
             trn_rd_q          <= trn_rd;
             trn_rrem_n_q      <= trn_rrem_n;
             trn_reof_n_q      <= trn_reof_n;
             trn_rsrc_rdy_n_q  <= trn_rsrc_rdy_n;

             if ((!trn_reof_n) &&         //若trn_reof_n为0，表示TLP包结束
                 (!trn_rsrc_rdy_n) && 
                 (!trn_rdst_rdy_n)) 
               begin
               	 rx_fifo_data_in <= {trn_rd[31:00],32'h1234_5678};
               	 rx_fifo_data_wr_en <= 1'b0;     //用于校准的数据，抛弃掉
               	 addr_of_data    <= trn_rd[63:34];              	 
               	 //if(cur_rd_count == rmrd_count_value - 1'b1)   //如果发送的TLP包个数等于预设值
               	 // cur_rd_count <= 16'd0;
               	 if(cpld_data_size_o == mrd_len_in[15:0] * mrd_count_in[15:0])     //若传输完预设的TLP包个数
               	   begin
               	   	 cur_rd_count <= 16'd0;   
               	   	 mrd_end     <= 1'b1;
               	   end
               	 cpld_real_size  <= cpld_real_size  + 1'b1;
               	 if (cpld_tlp_size != 1'b1)
               	   cpld_malformed_o <= 1'b1;
               	 //if (trn_rrem_n != 8'h00)
               	 if (trn_rrem_n != 1'b0)
               	   cpld_malformed_o <= 1'b1;               	 
               	 bmd_64_rx_state  <= `BMD_64_RX_RST;
               end 
             else if ((!trn_rsrc_rdy_n) && (!trn_rdst_rdy_n))                         
               begin
               	 rx_fifo_data_in <= {trn_rd[31:00],32'h1234_5678};     //注意数据的顺序要倒过来
               	 rx_fifo_data_wr_en <= 1'b0;
               	 addr_of_data    <= trn_rd[63:34];
               	 cur_rd_count    <= cur_rd_count + 1'b1;  
               	 cpld_real_size   <= cpld_real_size  + 1'b1;        //cpld_real_size累计数据DW个数
                 bmd_64_rx_state  <= `BMD_64_RX_CPLD_QWN;
               end 
             else
               bmd_64_rx_state   <= `BMD_64_RX_CPLD_QW1;

           end

           `BMD_64_RX_CPLD_QWN : begin

             bmd_64_rx_state_q <= bmd_64_rx_state;
             trn_rd_q          <= trn_rd;
             trn_rrem_n_q      <= trn_rrem_n;
             trn_reof_n_q      <= trn_reof_n;
             trn_rsrc_rdy_n_q  <= trn_rsrc_rdy_n;

             if ((!trn_reof_n) &&              //若trn_reof_n为0，表示TLP包结束，若当前还剩下一个64bit的数据
                 (!trn_rsrc_rdy_n) && 
                 (!trn_rdst_rdy_n)) 
               begin
               	 //if (trn_rrem_n == 8'h0F)   
               	 if (trn_rrem_n == 1'b1)           //trn_rrem_n == 1'b1表示AXI接口的低32bit数据有效，trn_rd的高32位有效
               	 	 begin
               	   	 //rx_fifo_data_in <= {trn_rd[63:32],32'h1234_5678};     //注意数据的顺序要倒过来,
               	   	 rx_fifo_data_in <= {32'h1234_5678,trn_rd[39:32],trn_rd[47:40],trn_rd[55:48],trn_rd[63:56]};
               	   	 rx_fifo_data_wr_en <= 1'b0;
               	 		 //addr_of_data    <= trn_rd[63:34];
               	   	 cpld_real_size   <= cpld_real_size  + 1'h1;
               	   	 if (cpld_tlp_size  != cpld_real_size  + 1'h1)   //若没有传输完预设的数据载荷大小
               	   	   cpld_malformed_o <= 1'b1;
               	   	 //if(cur_rd_count == rmrd_count_value)       //若传输完预设的TLP包个数
               	   	 //	 cur_rd_count <= 16'd0;
               	   	 if(cpld_data_size_o == mrd_len_in[15:0] * mrd_count_in[15:0])     //若传输完预设的TLP包个数
               	   	 	 begin
               	   	 	 	 cur_rd_count <= 16'd0;   
               	   	 	 	 mrd_end     <= 1'b1;
               	   	 	 end
               	   	 //dma_read_addr    <= dma_read_addr + 1'b1; 
               	   end 
               	 else                        //trn_rrem_n == 1'b0表示64bit数据均有效
               	 	 begin
               	   	 //rx_fifo_data_in <= trn_rd;
               	   	 rx_fifo_data_in <= {trn_rd[7:0],trn_rd[15:8],trn_rd[23:16],trn_rd[31:24],
                            trn_rd[39:32],trn_rd[47:40],trn_rd[55:48],trn_rd[63:56]};
               	   	 rx_fifo_data_wr_en <= 1'b1;    
               	   	 cpld_real_size  <= cpld_real_size  + 2'h2;              	   	 
               	   	 if (cpld_tlp_size  != cpld_real_size  + 2'h2)   //若没有传输完预设的数据载荷大小
               	   	   cpld_malformed_o <= 1'b1;
               	   	 if(cpld_data_size_o == mrd_len_in[15:0] * mrd_count_in[15:0])     //若传输完预设的TLP包个数
               	   	 	 begin
               	   	 	 	 cur_rd_count <= 16'd0;   
               	   	 	 	 mrd_end     <= 1'b1;
               	   	 	 end 
               	   	 dma_read_addr    <= dma_read_addr + 1'b1;                 
               	   end                 	                                             
               	 bmd_64_rx_state  <= `BMD_64_RX_RST;
               end 
             else if ((!trn_rsrc_rdy_n) &&       //若还未结束
                          (!trn_rdst_rdy_n)) 
               begin
                 //rx_fifo_data_in <= trn_rd;
                 rx_fifo_data_in <= {trn_rd[7:0],trn_rd[15:8],trn_rd[23:16],trn_rd[31:24],
                            trn_rd[39:32],trn_rd[47:40],trn_rd[55:48],trn_rd[63:56]};
               	 rx_fifo_data_wr_en <= 1'b1;
                 cpld_real_size   <= cpld_real_size  + 2'h2;
                 dma_read_addr    <= dma_read_addr + 1'b1;
                 bmd_64_rx_state  <= `BMD_64_RX_CPLD_QWN;
               end 
             else
               bmd_64_rx_state   <= `BMD_64_RX_CPLD_QWN;

           end

         endcase

      end   

    end       

  /*FPGA与PC间的校准过程，每接收一个CPLD包，都验证一下pattern*/
		always @ ( posedge clk ) 
		begin              
      if (!rst_n ) 
      	begin
      	  cpld_data_err_o <= 1'b0;
      	end 
      else 
      	begin
        	if (init_rst_i)
        	  cpld_data_err_o <= 1'b0;       	 
        	else if(bmd_64_rx_state_q == `BMD_64_RX_CPLD_QW1)        	  	  
        	  begin
        	    if (cpld_data_err_o == 1'b0)  
        	    	begin
        	      	if (trn_rd_q[31:00] != cpld_data_i_sw)
        	      	  cpld_data_err_o <= 1'b1;
        	      	else
        	      		cpld_data_err_o <= cpld_data_err_o; 
        	      end
        	    else
        	    	cpld_data_err_o <= cpld_data_err_o;
        	  end
        	else
        		cpld_data_err_o <= cpld_data_err_o;          	 
        end
    end 
    
    
    
/*
    always @ ( posedge clk ) begin
              
      if (!rst_n ) begin

        cpld_data_err_o <= 1'b0;

      end else begin

        if (init_rst_i)
          cpld_data_err_o <= 1'b0;
        else begin

          case (bmd_64_rx_state_q)

            `BMD_64_RX_CPLD_QW1 : 
            	begin
            	  if (cpld_data_err_o == 1'b0)
            	    if (trn_rd_q[31:00] != cpld_data_i_sw)
            	      cpld_data_err_o <= 1'b1;
            	end

            `BMD_64_RX_CPLD_QWN : 
            	begin            	
            	  if (!trn_reof_n_q) 
            	  	begin           	
           	    		if (trn_rrem_n_q == 8'h0F) 
            	  		  begin            	
            	  		    if (cpld_data_err_o == 1'b0)
            	  		      if (trn_rd_q[63:32] != cpld_data_i_sw)
            	  		        cpld_data_err_o <= 1'b1;           	     
            	  		  end                       
            	  	  else if (trn_rrem_n_q == 8'h00) 
            	  	  	begin            	
            	  	  	   if (cpld_data_err_o == 1'b0)
            	  	  	     if (trn_rd_q != {cpld_data_i_sw, cpld_data_i_sw})
            	  	  	       cpld_data_err_o <= 1'b1;           	
            	  	  	end 
            	  	  else  // Invalid remainder
            	  	     cpld_data_err_o <= 1'b1;           	
            	  	end 
            	  else 
            	  	begin           	
            	  	  if (cpld_data_err_o == 1'b0)
            	  	    if (trn_rd_q != {cpld_data_i_sw, cpld_data_i_sw})
            	  	      cpld_data_err_o <= 1'b1;           	
            	  	end            	
            	end
          endcase

        end

      end

    end
*/
/*
	ILA_PCIE_TOP 
		BMD_64_RX_ENGINE_i (
	.clk(clk), // input wire clk


	.probe0({
					trn_rd[63:0],	           	          
	        wr_data_o[31:0],
	        mrd_addr_in[31:0]        
	        
	               	               
	
	}), // input wire [127:0]  probe0  
	.probe1({
    
						    
				  	trn_rsrc_rdy_n,
				  	trn_rsrc_dsc_n,
				  	trn_rdst_rdy_n,
				  	rst_n, 
				  	wr_en_o,   
				  	init_rst_i,
				  	req_compl_o,
				  	compl_done_i,
				  	bmd_64_rx_state[7:0],
				  	trn_rrem_n,
	          trn_rsof_n,    
					  trn_reof_n,
					  mrd_start_in, 
				  	mrd_int_dis_in,
				  	mrd_done_in,
				  	addr_o[10:0],  
				  	wr_be_o[7:0],  
				  	rx_fifo_data_wr_en,
				  	cpld_data_err_o,
				  	cur_rd_count[15:0],
				  	cpld_real_size[6:0],
				  	mrd_end
				  	
				  				  
	}) // input wire [79:0]  probe1
);
*/

endmodule // BMD_64_RX_ENGINE
