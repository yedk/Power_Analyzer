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
//-- Filename: BMD_EP_MEM.v
//--
//-- Description: Endpoint control and status registers
//--
//--------------------------------------------------------------------------------

`timescale 1ns/1ns

module BMD_EP_MEM  #( parameter NUM_GP_PORTS = 20 ) (
                      
                      clk_2M_f,
                      clk,                   // I
                      rst_n,                 // I

                      cfg_cap_max_lnk_width, // I [5:0]
                      cfg_neg_max_lnk_width, // I [5:0]

                      cfg_cap_max_payload_size,  // I [2:0]
                      cfg_prg_max_payload_size,  // I [2:0]
                      cfg_max_rd_req_size,   // I [2:0]

                      a_i,                   // I [8:0]
                      wr_en_i,               // I 
                      rd_d_o,                // O [31:0]
                      wr_d_i,                // I [31:0]
                      
                      fpga_to_pc_data, 
                      pc_to_fpga_data,
                      data_wr_en,   
                        
                      init_rst_o,            // O

                      mrd_start_o,           // O
                      mrd_int_dis_o,         // O
                      mrd_done_o,            // O
                      mrd_addr_o,            // O [31:0]
                      mrd_len_o,             // O [31:0]
                      mrd_tlp_tc_o,          // O [2:0]
                      mrd_64b_en_o,          // O
                      mrd_phant_func_dis1_o,  // O
                      mrd_up_addr_o,         // O [7:0]
                      mrd_count_o,           // O [31:0]
                      mrd_relaxed_order_o,   // O
                      mrd_nosnoop_o,         // O
                      mrd_wrr_cnt_o,         // O [7:0]

                      mwr_start_o,           // O
                      mwr_int_dis_o,         // O 
                      mwr_done_i,            // I
                      mwr_addr_o,            // O [31:0]
                      mwr_len_o,             // O [31:0]
                      mwr_tlp_tc_o,          // O [2:0]
                      mwr_64b_en_o,          // O
                      mwr_phant_func_dis1_o, // O
                      mwr_up_addr_o,         // O [7:0]
                      mwr_count_o,           // O [31:0]
                      mwr_data_o,            // O [31:0]
                      mwr_relaxed_order_o,   // O
                      mwr_nosnoop_o,         // O
                      mwr_wrr_cnt_o,         // O [7:0]
                      mwr_zerolen_en_o,      // O

                      cpl_ur_found_i,        // I [7:0] 
                      cpl_ur_tag_i,          // I [7:0]

                      cpld_data_o,           // O [31:0]
                      cpld_found_i,          // I [31:0]
                      cpld_data_size_i,      // I [31:0]
                      cpld_malformed_i,      // I
                      cpld_data_err_i,       // I
                      cpl_streaming_o,       // O
                      rd_metering_o,         // O
                      cfg_interrupt_di,      // O
                      cfg_interrupt_do,      // I
                      cfg_interrupt_mmenable,   // I
                      cfg_interrupt_msienable,  // I
                      cfg_interrupt_legacyclr,  // O
`ifdef PCIE2_0
                      pl_directed_link_change,
                      pl_ltssm_state,
                      pl_directed_link_width,
                      pl_directed_link_speed,
                      pl_directed_link_auton,
                      pl_upstream_preemph_src,
                      pl_sel_link_width,
                      pl_sel_link_rate,
                      pl_link_gen2_capable,
                      pl_link_partner_gen2_supported,
                      pl_initial_link_width,
                      pl_link_upcfg_capable,
                      pl_lane_reversal_mode,
                      pl_width_change_err_i,
                      pl_speed_change_err_i,
                      clr_pl_width_change_err,
                      clr_pl_speed_change_err,
                      clear_directed_speed_change_i,

`endif
                      trn_rnp_ok_n_o,
                      trn_tstr_n_o,

                      gp_data_upstream,
                      gp_data_dnstream,
       
                      trn_wait_count
                    );

    input             clk_2M_f;
    input             clk;
    input             rst_n;

    input [5:0]       cfg_cap_max_lnk_width;
    input [5:0]       cfg_neg_max_lnk_width;

    input [2:0]       cfg_cap_max_payload_size;
    input [2:0]       cfg_prg_max_payload_size;
    input [2:0]       cfg_max_rd_req_size;

    //input [6:0]       a_i;
    input [11:0]       a_i;
    input             wr_en_i;
    output [31:0]     rd_d_o;
    input  [31:0]     wr_d_i;
    
    input  [31:0] fpga_to_pc_data;
		output [31:0] pc_to_fpga_data;
		output        data_wr_en     ;
    // CSR bits

    output            init_rst_o;

    output            mrd_start_o;
    output            mrd_int_dis_o;
    output            mrd_done_o;
    output [31:0]     mrd_addr_o;
    output [31:0]     mrd_len_o;
    output [2:0]      mrd_tlp_tc_o;
    output            mrd_64b_en_o;
    output            mrd_phant_func_dis1_o;
    output [7:0]      mrd_up_addr_o;
    output [31:0]     mrd_count_o;
    output            mrd_relaxed_order_o;
    output            mrd_nosnoop_o;
    output [7:0]      mrd_wrr_cnt_o;

    output            mwr_start_o;
    output            mwr_int_dis_o;
    input             mwr_done_i;
    output [31:0]     mwr_addr_o;
    output [31:0]     mwr_len_o;
    output [2:0]      mwr_tlp_tc_o;
    output            mwr_64b_en_o;
    output            mwr_phant_func_dis1_o;
    output [7:0]      mwr_up_addr_o;
    output [31:0]     mwr_count_o;
    output [31:0]     mwr_data_o;
    output            mwr_relaxed_order_o;
    output            mwr_nosnoop_o;
    output [7:0]      mwr_wrr_cnt_o;
    output            mwr_zerolen_en_o;
    input  [7:0]      cpl_ur_found_i;
    input  [7:0]      cpl_ur_tag_i;

    output [31:0]     cpld_data_o;
    input  [31:0]     cpld_found_i;
    input  [31:0]     cpld_data_size_i;
    input             cpld_malformed_i;
    input             cpld_data_err_i;
    output            cpl_streaming_o;
    output            rd_metering_o;

    output            trn_rnp_ok_n_o;
    output            trn_tstr_n_o;
    output [7:0]      cfg_interrupt_di;
    input  [7:0]      cfg_interrupt_do;
    input  [2:0]      cfg_interrupt_mmenable;
    input             cfg_interrupt_msienable;
    output            cfg_interrupt_legacyclr;

`ifdef PCIE2_0

    output [1:0]      pl_directed_link_change;
    input  [5:0]      pl_ltssm_state;
    output [1:0]      pl_directed_link_width;
    output            pl_directed_link_speed;
    output            pl_directed_link_auton;
    output            pl_upstream_preemph_src;
    input  [1:0]      pl_sel_link_width;
    input             pl_sel_link_rate;
    input             pl_link_gen2_capable;
    input             pl_link_partner_gen2_supported;
    input  [2:0]      pl_initial_link_width;
    input             pl_link_upcfg_capable;
    input  [1:0]      pl_lane_reversal_mode;

    input             pl_width_change_err_i;
    input             pl_speed_change_err_i;
    output            clr_pl_width_change_err;
    output            clr_pl_speed_change_err;
    input             clear_directed_speed_change_i;
`endif

    input  [(NUM_GP_PORTS*32-1):0] gp_data_upstream;
    output [(NUM_GP_PORTS*32-1):0] gp_data_dnstream;
    output [3:0] trn_wait_count;
    
    
    
    wire [31:0] fpga_to_pc_data;
    wire [31:0] pc_to_fpga_data;
    wire data_wr_en;

    // Local Regs

    reg [31:0]        rd_d_o /* synthesis syn_direct_enable = 0 */;   
    
    assign pc_to_fpga_data = wr_d_i;
    assign data_wr_en      = wr_en_i;
 
    

    reg               init_rst_o;
   
    reg               mrd_start_o;
    reg               mrd_int_dis_o;
    reg [31:0]        mrd_addr_o;
    reg [31:0]        mrd_len_o;
    reg [31:0]        mrd_count_o;
    reg [2:0]         mrd_tlp_tc_o;
    reg               mrd_64b_en_o;
    reg               mrd_phant_func_dis1_o;
    reg [7:0]         mrd_up_addr_o;
    reg               mrd_relaxed_order_o;
    reg               mrd_nosnoop_o;
    reg [7:0]         mrd_wrr_cnt_o;

    reg               mwr_start_o;
    reg               mwr_int_dis_o;
    reg [31:0]        mwr_addr_o;
    reg [31:0]        mwr_len_o;
    reg [31:0]        mwr_count_o;
    reg [31:0]        mwr_data_o;
    reg [2:0]         mwr_tlp_tc_o;
    reg               mwr_64b_en_o;
    reg               mwr_phant_func_dis1_o;
    reg [7:0]         mwr_up_addr_o;
    reg               mwr_relaxed_order_o;
    reg               mwr_nosnoop_o;
    reg [7:0]         mwr_wrr_cnt_o;
    reg               mwr_zerolen_en_o;
    reg [3:0]         trn_wait_count;
    reg [31:0]        mrd_perf;
    reg [31:0]        mwr_perf;

    reg               mrd_done_o;

    reg [31:0]        cpld_data_o;
    reg [20:0]        expect_cpld_data_size;  // 2 GB max
    reg [20:0]        cpld_data_size;         // 2 GB max
    reg               cpld_done;

    reg               cpl_streaming_o;
    reg               rd_metering_o;
    reg               trn_rnp_ok_n_o;
    reg               trn_tstr_n_o;

    reg [7:0]         INTDI;
    reg               LEGACYCLR;
    
    //�����Ĵ��Զ���д��������
    reg [31:0] auto_rd_wr;   
   
`ifdef PCIE2_0

    reg [1:0]         pl_directed_link_change;
    reg [1:0]         pl_directed_link_width;
    wire              pl_directed_link_speed;
    reg [1:0]         pl_directed_link_speed_binary;
    reg               pl_directed_link_auton;
    reg               pl_upstream_preemph_src;
    reg               pl_width_change_err;
    reg               pl_speed_change_err;
    reg               clr_pl_width_change_err;
    reg               clr_pl_speed_change_err;
    wire [1:0]        pl_sel_link_rate_binary;

`endif  
   
    wire [7:0]        fpga_family;
    wire [3:0]        interface_type;
    wire [7:0]        version_number;


    assign version_number = 8'h16;
`ifdef BMD_64
    assign interface_type = 4'b0010;     //��ʾΪ64bits
`else // BMD_32
    assign interface_type = 4'b0001;    //��ʾΪ32bits
`endif // BMD_64

`ifdef VIRTEX2P 
    assign fpga_family = 8'h11;
`endif // VIRTEX2P 

`ifdef VIRTEX4FX
    assign fpga_family = 8'h12;
`endif // VIRTEX4FX

`ifdef PCIEBLK
    assign fpga_family = 8'h13;
`endif // PCIEBLK

`ifdef SPARTAN3
    assign fpga_family = 8'h18;
`endif // SPARTAN3

`ifdef SPARTAN3E
    assign fpga_family = 8'h28;
`endif // SPARTAN3E

`ifdef SPARTAN3A
    assign fpga_family = 8'h38;
`endif // SPARTAN3A

assign fpga_family = 8'h14;


assign cfg_interrupt_di[7:0] = INTDI[7:0];
assign cfg_interrupt_legacyclr = LEGACYCLR;
//assign cfg_interrupt_di = 8'haa;


`ifdef PCIE2_0

   assign pl_sel_link_rate_binary = (pl_sel_link_rate == 0) ? 2'b01 : 2'b10;
   assign pl_directed_link_speed = (pl_directed_link_speed_binary == 2'b01) ?
                                                0 : 1;
`endif

   // Create general purpose I/O. The function of these registers varies by core, and consist of:
   //  - an upstream data flow (originating from core user app, consumed by BMD software)
   //  - a downstream data flow (originating from BMD software, consumed by core user app)

   // Create downstream registers. These will be read by core user app
   reg  [31:0]   gp_data_dn0;
   reg  [31:0]   gp_data_dn1;
   reg  [31:0]   gp_data_dn2;
   reg  [31:0]   gp_data_dn3;
   reg  [31:0]   gp_data_dn4;
   reg  [31:0]   gp_data_dn5;
   reg  [31:0]   gp_data_dn6;
   reg  [31:0]   gp_data_dn7;
   reg  [31:0]   gp_data_dn8;
   reg  [31:0]   gp_data_dn9;
   reg  [31:0]   gp_data_dn10;
   reg  [31:0]   gp_data_dn11;
   reg  [31:0]   gp_data_dn12;
   reg  [31:0]   gp_data_dn13;
   reg  [31:0]   gp_data_dn14;
   reg  [31:0]   gp_data_dn15;
   reg  [31:0]   gp_data_dn16;
   reg  [31:0]   gp_data_dn17;
   reg  [31:0]   gp_data_dn18;
   reg  [31:0]   gp_data_dn19;

   // Concatinate all registers together into one downstream port for simplicity
   assign gp_data_dnstream = {gp_data_dn19, gp_data_dn18, gp_data_dn17, gp_data_dn16,
                              gp_data_dn15, gp_data_dn14, gp_data_dn13, gp_data_dn12,
                              gp_data_dn11, gp_data_dn10, gp_data_dn9,  gp_data_dn8, 
                              gp_data_dn7,  gp_data_dn6,  gp_data_dn5,  gp_data_dn4, 
                              gp_data_dn3,  gp_data_dn2,  gp_data_dn1,  gp_data_dn0};


   // Wire in upstream registers. THe registers themselves lie in core user app.
   // Again, concatenate into one big port for simplicity
   wire [31:0]  gp_data_up0  = gp_data_upstream[31:0];
   wire [31:0]  gp_data_up1  = gp_data_upstream[63:32];
   wire [31:0]  gp_data_up2  = gp_data_upstream[95:64];
   wire [31:0]  gp_data_up3  = gp_data_upstream[127:96];
   wire [31:0]  gp_data_up4  = gp_data_upstream[159:128];
   wire [31:0]  gp_data_up5  = gp_data_upstream[191:160];
   wire [31:0]  gp_data_up6  = gp_data_upstream[223:192];
   wire [31:0]  gp_data_up7  = gp_data_upstream[255:224];
   wire [31:0]  gp_data_up8  = gp_data_upstream[287:256];
   wire [31:0]  gp_data_up9  = gp_data_upstream[319:288];
   wire [31:0]  gp_data_up10 = gp_data_upstream[351:320];
   wire [31:0]  gp_data_up11 = gp_data_upstream[383:352];
   wire [31:0]  gp_data_up12 = gp_data_upstream[415:384];
   wire [31:0]  gp_data_up13 = gp_data_upstream[447:416];
   wire [31:0]  gp_data_up14 = gp_data_upstream[479:448];
   wire [31:0]  gp_data_up15 = gp_data_upstream[511:480];
   wire [31:0]  gp_data_up16 = gp_data_upstream[543:512];
   wire [31:0]  gp_data_up17 = gp_data_upstream[575:544];
   wire [31:0]  gp_data_up18 = gp_data_upstream[607:576];
   wire [31:0]  gp_data_up19 = gp_data_upstream[639:608];

    always @(posedge clk ) begin
    
        if ( !rst_n ) begin
          init_rst_o  <= 1'b0;
          trn_wait_count<=4'b0;
          mrd_start_o <= 1'b0;
          mrd_int_dis_o <= 1'b0;
          mrd_addr_o  <= 32'b0;
          mrd_len_o   <= 32'b0;
          mrd_count_o <= 32'b0;
          mrd_tlp_tc_o <= 3'b0;
          mrd_64b_en_o <= 1'b0;
          mrd_up_addr_o <= 8'b0;
          mrd_relaxed_order_o <= 1'b0;
          mrd_nosnoop_o <= 1'b0;
          
          auto_rd_wr <= 32'd0;
          
          //pc_to_fpga_data <= 32'd0;
          //data_wr_en <= 1'b0;    

          mwr_start_o <= 1'b0;
          mwr_int_dis_o <= 1'b0;
          mwr_addr_o  <= 32'b0;
          mwr_len_o   <= 32'b0;
          mwr_count_o <= 32'b0;
          mwr_data_o  <= 32'b0;
          mwr_tlp_tc_o <= 3'b0;
          mwr_64b_en_o <= 1'b0;
          mwr_up_addr_o <= 8'b0;
          mwr_relaxed_order_o <= 1'b0;
          mwr_nosnoop_o <= 1'b0;

          cpld_data_o <= 32'b0;
          cpl_streaming_o <= 1'b1;
          rd_metering_o <= 1'b0;
          trn_rnp_ok_n_o <= 1'b0;
          trn_tstr_n_o <= 1'b0;
          mwr_wrr_cnt_o <= 8'h08;
          mrd_wrr_cnt_o <= 8'h08;

`ifdef PCIE2_0

          clr_pl_width_change_err <= 1'b0;
          clr_pl_speed_change_err <= 1'b0;
          pl_directed_link_change <= 2'h0;
          pl_directed_link_width  <= 2'h0;
          pl_directed_link_speed_binary  <= 2'b0; 
          pl_directed_link_auton  <= 1'b0;
          pl_upstream_preemph_src <= 1'b0;
          pl_width_change_err     <= 0;
          pl_speed_change_err     <= 0;

`endif          
          INTDI   <= 8'h00;
          LEGACYCLR  <=  1'b0;     

          gp_data_dn0  <= 0; 
          gp_data_dn1  <= 0; 
          gp_data_dn2  <= 0; 
          gp_data_dn3  <= 0; 
          gp_data_dn4  <= 0; 
          gp_data_dn5  <= 0; 
          gp_data_dn6  <= 0; 
          gp_data_dn7  <= 0; 
          gp_data_dn8  <= 0; 
          gp_data_dn9  <= 0; 
          gp_data_dn10 <= 0; 
          gp_data_dn11 <= 0; 
          gp_data_dn12 <= 0; 
          gp_data_dn13 <= 0; 
          gp_data_dn14 <= 0; 
          gp_data_dn15 <= 0; 
          gp_data_dn16 <= 0; 
          gp_data_dn17 <= 0; 
          gp_data_dn18 <= 0; 
          gp_data_dn19 <= 0; 
        end else begin

`ifdef PCIE2_0

         if (a_i[6:0] != 7'b010011)   // Reg#19
         begin
            pl_width_change_err <= pl_width_change_err_i;
            pl_speed_change_err <= pl_speed_change_err_i;
            pl_directed_link_change <=
                        clear_directed_speed_change_i ? 0 :    // 1
                        pl_directed_link_change;               // 0
         end

`endif

          //case (a_i[6:0]) 
          case (a_i[11:0])
        
            // 00-03H : Reg # 0                        Byte0[1:7]����
            // Byte0[0]: Initiator Reset (RW) 0= no reset 1=reset.    //�߸�λ
            // Byte2[19:16]: Data Path Width           4��b0010 = 64 bit    Byte1[8:15] Version Number
            // Byte3[31:24]: FPGA Family
            12'h000: begin                          //Device Control Register 1
          
              if (wr_en_i)
                init_rst_o  <= wr_d_i[0];     //ȡ����λֵ
        
              rd_d_o <= {fpga_family, {4'b0}, interface_type, version_number, {7'b0}, init_rst_o};
                                    //Reserved  //4��b0010 = 64 bit           Reserved 
              if (init_rst_o) begin       //���Ϊ1����ʾ���ڸ�λ״̬��mwr_start_o��mrd_start_o��Ϊ0
               
                mwr_start_o <= 1'b0;
                mrd_start_o <= 1'b0;

              end
             
            end
						//Device DMA Control Status Register (DDMACR) (004H, R/W)
            // 04-07H :  Reg # 1
            // Byte0[0]: Memory Write Start (RW) 0=no start, 1=start        //����дDMA������������д����
            // Byte0[7]: Memory Write Inter Disable (RW) 1=disable          //Ϊ1ʱ��д�жϲ�ʹ��
            // Byte1[0]: Memory Write Done  (RO) 0=not done, 1=done         //дDMA�������������
            // Byte2[0]: Memory Read Start (RW) 0=no start, 1=start         //�����Ƕ�����д����
            // Byte2[7]: Memory Read Inter Disable (RW) 1=disable
            // Byte3[0]: Memory Read Done  (RO) 0=not done, 1=done 
            //7'b0000001: begin
                                                               //Byte3[7]��DMA�������ݴ���
            12'h001: begin
            
              if (wr_en_i) begin
                mwr_start_o  <= wr_d_i[0];
                mwr_relaxed_order_o <=  wr_d_i[5];
                mwr_nosnoop_o <= wr_d_i[6];
                mwr_int_dis_o <= wr_d_i[7];
                mrd_start_o  <= wr_d_i[16];
                mrd_relaxed_order_o <=  wr_d_i[21];
                mrd_nosnoop_o <= wr_d_i[22];
                mrd_int_dis_o <= wr_d_i[23];
              end 
                                    
              rd_d_o <= {cpld_data_err_i, 6'b0, mrd_done_o,
                         mrd_int_dis_o, 4'b0, mrd_nosnoop_o, mrd_relaxed_order_o, mrd_start_o, 
                         7'b0, mwr_done_i,
                         mwr_int_dis_o, 4'b0, mwr_nosnoop_o, mwr_relaxed_order_o, mwr_start_o};

            end
						//Write DMA TLP Address (WDMATLPA) (008H, R/W) дDMA����TLP����ַ
            // 08-0BH : Reg # 2      [31:2]      �����ַ�������ڵ�һ��дTLP����
            // Memory Write DMA Address (RW)     ��ô��������TLP��ַ�ֶε�ֵ����Դ�������ַ��TLP��С
            //[12:0] ����TLP���Ĵ�С   01H<=Length<=1FFFH;
            //[18:16] TLP��TC�ֶ�
            //[19:19] 64λдTLP��ʹ��
            //[31:24] дDMA��λTLP��ַ
            //7'b0000010: begin
            12'h002: begin

              if (wr_en_i)
                mwr_addr_o  <= wr_d_i;
              
              rd_d_o <= mwr_addr_o;

            end

            //Write DMA TLP Size (WDMATLPS) (00CH, R/W)
            // 0C-0FH : Reg # 3
            // Memory Write length in DWORDs (RW)
            //7'b0000011: begin
            12'h003: begin

              if (wr_en_i) begin
                mwr_len_o  <= wr_d_i[15:0];
                mwr_tlp_tc_o  <= wr_d_i[18:16];
                mwr_64b_en_o <= wr_d_i[19];
                mwr_phant_func_dis1_o <= wr_d_i[20];
                mwr_up_addr_o <= wr_d_i[31:24];
                mwr_zerolen_en_o <= wr_d_i[21];
              end

              rd_d_o <= {mwr_up_addr_o, 
                          2'b0, mwr_zerolen_en_o, mwr_phant_func_dis1_o, mwr_64b_en_o, mwr_tlp_tc_o, 
                          mwr_len_o[15:0]};
            end
						
					  //Write DMA TLP Count (WDMATLPC) (0010H, R/W)
            //[15:0] 01D<=Count<=65535D
            // 10-13H : Reg # 4
            // Memory Write Packet Count (RW)
            //7'b0000100: begin
            12'h004: begin
        
              if (wr_en_i) begin
                mwr_count_o  <= wr_d_i[15:0];
                trn_wait_count<=wr_d_i[19:16];
              end
              rd_d_o <= {12'h0,trn_wait_count[3:0], 
                         mwr_count_o[15:0]};

            end

						//Write DMA Data Pattern (WDMATLPP) (014H, R/W)    //д���������ݣ������������Ч�������غ�
            // 14-17H : Reg # 5
            // Memory Write Packet DWORD Data (RW)
            //7'b000101: begin
            12'h005: begin

              if (wr_en_i)
                mwr_data_o  <= wr_d_i;
              
              rd_d_o <= mwr_data_o;

            end

            //Read DMA Expected Data Pattern (RDMATLPP) (018H, R/W)  ������DMA����
            // 18-1BH : Reg # 6                                      ��BAR�ռ��а����ݶ���
            // Completion Packet DWORD expected Data (RW)
            //7'b000110: begin
            12'h006: begin

              if (wr_en_i)
                cpld_data_o  <= wr_d_i;

              rd_d_o <= cpld_data_o;

            end

            
            //Read DMA TLP Address (RDMATLPA) (01CH, R/W)    ����������дģʽ�Ķ�Ӧ�Ĵ�������
            // 1C-1FH : Reg # 7
            // Read DMA Address (RW)
            //7'b000111: begin
            12'h007: begin

              if (wr_en_i)
                mrd_addr_o  <= wr_d_i;
              
              rd_d_o <= mrd_addr_o;

            end

            //Read DMA TLP Size (RDMATLPS) (020H, R/W)
            // 20-23H : Reg # 8
            // Read length in DWORDs (RW)
            //7'b001000: begin
            12'h008: begin

              if (wr_en_i) begin
                mrd_len_o  <= wr_d_i[15:0];
                mrd_tlp_tc_o  <= wr_d_i[18:16];
                mrd_64b_en_o <= wr_d_i[19];
                mrd_phant_func_dis1_o <= wr_d_i[20];
                mrd_up_addr_o <= wr_d_i[31:24];
              end
              
              rd_d_o <= {mrd_up_addr_o, 
                         3'b0, mrd_phant_func_dis1_o, mrd_64b_en_o, mrd_tlp_tc_o, 
                         mrd_len_o[15:0]};

            end

            //Read DMA TLP Count (RDMATLPC) (024H, R/W)
            // 24-27H : Reg # 9
            // Read Packet Count (RW)
            //7'b001001: begin
            12'h009: begin

              if (wr_en_i)
                mrd_count_o  <= wr_d_i;
              
              rd_d_o <= mrd_count_o;

            end

            //Write DMA Performance (WDMAPERF) (028H, R0)   //дDMA���ܼ���
            // 28-2BH : Reg # 10                           //дDMA�����ӷ��͵���ɣ�����Ҫ�Ľӿ�ʱ��������
            // Memory Write Performance (RO)               //����ȡ���ں����ݽӿ�ͨ·��ֵ
            //7'b001010: begin                         //x8 = 4 ns cycle time                           
            12'h00A: begin                                         //x4 = 8 ns cycle time for 64 bit, 4 ns cycle  
              rd_d_o <= mwr_perf;                    //  time for 32 bit                                
                                                     //x1 = 32 ns cycle time for 64 bit, 16 ns cycle
            end                                      //time or 32 bit                                 

           
            //Read DMA Performance (RDMAPERF) (02CH, R0)
            // 2C-2FH  : Reg # 11
            // Memory Read  Performance (RO)
            //7'b001011: begin
            12'h00B: begin

              rd_d_o <= mrd_perf;

            end

            //Read DMA Status (RDMASTAT) (030H, R0)
            // 30-33H  : Reg # 12
            // Memory Read Completion Status (RO)
            //7'b001100: begin
            12'h00C: begin

              rd_d_o <= {{15'b0}, cpld_malformed_i, cpl_ur_tag_i, cpl_ur_found_i};

            end

            
            // Number of Read Completion w/ Data (NRDCOMP) (034H, R0)
            // 34-37H  : Reg # 13
            // Memory Read Completion with Data Detected (RO)
            //7'b001101: begin
            12'h00D: begin

              rd_d_o <= {cpld_found_i};

            end

            
            //Read Completion Data Size (RCOMPDSIZW) (038H, R0)
            // 38-3BH  : Reg # 14
            // Memory Read Completion with Data Size (RO)
            //7'b001110: begin
            12'h00E: begin

              rd_d_o <= {cpld_data_size_i};

            end

            //Device Link Width Status (DLWSTAT) (03CH, R0)
            // 3C-3FH : Reg # 15
            // Link Width (RO)
            //7'b001111: begin
            12'h00F: begin

              rd_d_o <= {16'b0, 
                         2'b0, cfg_neg_max_lnk_width, 
                         2'b0, cfg_cap_max_lnk_width};

            end

            //Device Link Transaction Size Status (DLTRSSTAT) (040H, R0)
            // 40-43H : Reg # 16
            // Link Payload (RO)
            //7'b010000: begin
            12'h010: begin

              rd_d_o <= {8'b0,
                         5'b0, cfg_max_rd_req_size, 
                         5'b0, cfg_prg_max_payload_size,           //��λ����FPGAĬ��Ϊ128B����Ч�غɣ�ò�Ʋ����޸�
                         5'b0, cfg_cap_max_payload_size };

            end

            // Device Miscellaneous Control (DMISCCONT) (044H, RW)
            // 44-47H : Reg # 17
            // WRR MWr
            // WRR MRd
            // Rx NP TLP Control
            // Completion Streaming Control (RW)
            // Read Metering Control (RW)

            //7'b010001: begin
            12'h0011: begin

              if (wr_en_i) begin
                cpl_streaming_o <= wr_d_i[0];
                rd_metering_o <= wr_d_i[1];
                trn_rnp_ok_n_o <= wr_d_i[8];
                trn_tstr_n_o <= wr_d_i[9];
                mwr_wrr_cnt_o <= wr_d_i[23:16];
                mrd_wrr_cnt_o <= wr_d_i[31:24];
              end
        
              rd_d_o <= {mrd_wrr_cnt_o, 
                         mwr_wrr_cnt_o, 
                         6'b0, trn_tstr_n_o, trn_rnp_ok_n_o, 
                         6'b0, rd_metering_o, cpl_streaming_o};

            end


            // 48-4BH : Reg # 18
            // INTDI (RW)
            // INTDO
            // MMEN
            // MSIEN

            //7'b010010: begin
            12'h012: begin
               if (wr_en_i) begin
                  INTDI[7:0] <= wr_d_i[7:0];  
                  LEGACYCLR <= wr_d_i[8];
               end


               rd_d_o <= {4'h0, 
                          cfg_interrupt_msienable,
                          cfg_interrupt_mmenable[2:0],
                          cfg_interrupt_do[7:0],
                          7'h0,
                          LEGACYCLR,
                          INTDI[7:0]};
            end

`ifdef PCIE2_0
            // 4C-4FH : Reg # 19
            // CHG(RW), LTS, TW(RW), TS(RW), A(RW), P(RW), CW, CS, G2S, PG2S, 
            // LILW, LUC, SCE, WCE, LR

            //7'b010011: begin
            12'h013: begin
               if (wr_en_i) begin
                   clr_pl_width_change_err       <= wr_d_i[29];
                   clr_pl_speed_change_err       <= wr_d_i[28];
                   pl_upstream_preemph_src       <= wr_d_i[15];    // P
                   pl_directed_link_auton        <= wr_d_i[14];    // A
                   pl_directed_link_speed_binary <= wr_d_i[13:12]; // TS
                   pl_directed_link_width        <= wr_d_i[9:8];   // TW
                   pl_directed_link_change       <= wr_d_i[1:0];   // CHG
               end else
               begin
                   clr_pl_width_change_err          <= 1'b0;
                   clr_pl_speed_change_err          <= 1'b0;
                   
                   pl_directed_link_change <= clear_directed_speed_change_i ?
                                      0 : pl_directed_link_change;  

               end

               rd_d_o <= { 
                  pl_lane_reversal_mode[1:0],             //LR   31:30
                  pl_width_change_err,                    //WCE     29
                  pl_speed_change_err,                    //SCE     28
                  pl_link_upcfg_capable,                  //LUC     27
                  pl_initial_link_width[2:0],             //LILW 26:24
                  pl_link_partner_gen2_supported,         //PG2S    23
                  pl_link_gen2_capable,                   //G2S     22
                  pl_sel_link_rate_binary[1:0],           //CS   21:20
                  2'b0,                                   //R1   19:18
                  pl_sel_link_width[1:0],                 // CW  17:16
                  pl_upstream_preemph_src,                //P       15
                  pl_directed_link_auton,                 //A       14
                  pl_directed_link_speed_binary[1:0],     //TS   13:12
                  2'b0,                                   //R0   11:10 
                  pl_directed_link_width[1:0],            //TW    9: 8
                  pl_ltssm_state[5:0],                    //LTS   7: 2
                  pl_directed_link_change[1:0]            //CHG   1: 0
                          };
            end
`endif

            // 50-63H : Reg # 20-24 - Reserved for future use
            // 7'b010100 - 7'b011000


            // 64-B3H : Reg # 25-44 - GPIO Registers
            //  - These registers are used for error signaling,
            //    debug, etc. These vary by core, since different
            //    cores have different backend debug pins.
            //  - Data is passed TO the app via gp_data_dnstream
            //  - Data is read FROM the app via gp_data_upstream

            // 64-67H : Reg # 25 - General Purpose Register 0
/*
            7'b011001: begin
              if (wr_en_i) gp_data_dn0 <= wr_d_i;
              rd_d_o <= gp_data_up0;
            end

            // 68-6BH : Reg # 26 - General Purpose Register 1
            7'b011010: begin
              if (wr_en_i) gp_data_dn1 <= wr_d_i;
              rd_d_o <= gp_data_up1;
            end

            // 6C-6FH : Reg # 27 - General Purpose Register 2
            7'b011011: begin
              if (wr_en_i) gp_data_dn2 <= wr_d_i;
              rd_d_o <= gp_data_up2;
            end

            // 70-73H : Reg # 28 - General Purpose Register 3
            7'b011100: begin
              if (wr_en_i) gp_data_dn3 <= wr_d_i;
              rd_d_o <= gp_data_up3;
            end

            // 74-77H : Reg # 29 - General Purpose Register 4
            7'b011101: begin
              if (wr_en_i) gp_data_dn4 <= wr_d_i;
              rd_d_o <= gp_data_up4;
            end

            // 78-7BH : Reg # 30 - General Purpose Register 5
            7'b011110: begin
              if (wr_en_i) gp_data_dn5 <= wr_d_i;
              rd_d_o <= gp_data_up5;
            end

            // 7C-7FH : Reg # 31 - General Purpose Register 6
            7'b011111: begin
              if (wr_en_i) gp_data_dn6 <= wr_d_i;
              rd_d_o <= gp_data_up6;
            end

            // 80-83H : Reg # 32 - General Purpose Register 7
            7'b100000: begin
              if (wr_en_i) gp_data_dn7 <= wr_d_i;
              rd_d_o <= gp_data_up7;
            end

            // 84-87H : Reg # 33 - General Purpose Register 8
            7'b100001: begin
              if (wr_en_i) gp_data_dn8 <= wr_d_i;
              rd_d_o <= gp_data_up8;
            end

            // 88-8BH : Reg # 34 - General Purpose Register 9
            7'b100010: begin
              if (wr_en_i) gp_data_dn9 <= wr_d_i;
              rd_d_o <= gp_data_up9;
            end

            // 8C-8FH : Reg # 35 - General Purpose Register 10
            7'b100011: begin
              if (wr_en_i) gp_data_dn10 <= wr_d_i;
              rd_d_o <= gp_data_up10;
            end

            // 90-93H : Reg # 36 - General Purpose Register 11
            7'b100100: begin
              if (wr_en_i) gp_data_dn11 <= wr_d_i;
              rd_d_o <= gp_data_up11;
            end

            // 94-97H : Reg # 37 - General Purpose Register 12
            7'b100101: begin
              if (wr_en_i) gp_data_dn12 <= wr_d_i;
              rd_d_o <= gp_data_up12;
            end

            // 98-9BH : Reg # 38 - General Purpose Register 13
            7'b100110: begin
              if (wr_en_i) gp_data_dn13 <= wr_d_i;
              rd_d_o <= gp_data_up13;
            end

            // 9C-9FH : Reg # 39 - General Purpose Register 14
            7'b100111: begin
              if (wr_en_i) gp_data_dn14 <= wr_d_i;
              rd_d_o <= gp_data_up14;
            end

            // A0-A3H : Reg # 40 - General Purpose Register 15
            7'b101000: begin
              if (wr_en_i) gp_data_dn15 <= wr_d_i;
              rd_d_o <= gp_data_up15;
            end

            // A4-A7H : Reg # 41 - General Purpose Register 16
            7'b101001: begin
              if (wr_en_i) gp_data_dn16 <= wr_d_i;
              rd_d_o <= gp_data_up16;
            end

            // A8-ABH : Reg # 42 - General Purpose Register 17
            7'b101010: begin
              if (wr_en_i) gp_data_dn17 <= wr_d_i;
              rd_d_o <= gp_data_up17;
            end

            // AC-AFH : Reg # 43 - General Purpose Register 18
            7'b101011: begin
              if (wr_en_i) gp_data_dn18 <= wr_d_i;
              rd_d_o <= gp_data_up18;
            end

            // B0-B3H : Reg # 44 - General Purpose Register 19
            7'b101100: begin
              if (wr_en_i) gp_data_dn19 <= wr_d_i;
              rd_d_o <= gp_data_up19;
            end

            // B4-B7H  : Reg # 45
            // Fetch Add Detected (RO)
            7'b101101: begin

              rd_d_o <= {cpld_found_i};

            end
            
            // B8-BAH  : Reg # 46
            // �õ�ַ��Ź̶�ֵ��������λ����ȡ����
            7'b101110: begin

              rd_d_o <= {32'h1234_5678};

            end
            
            // BB-BEH  : Reg # 47
            // �õ�ַ�����λ��д������ֵ��������λ����д����
            7'b101111: begin

              if (wr_en_i)
                auto_rd_wr  <= wr_d_i;
              
              rd_d_o <= auto_rd_wr;

            end
*/
            // B4-200H : Reserved
            default: begin           //14H��ĵ�ַ����Ϊ�ӿ�

              //rd_d_o <= 32'b0; 
              //if (wr_en_i)
              //	pc_to_fpga_data <= wr_d_i;
              rd_d_o <= fpga_to_pc_data;      
            end

          endcase

        end

    end
		

    /*
     * Memory Write Performance Instrumentation
     */

    always @(posedge clk ) begin

        if ( !rst_n ) begin

          mwr_perf <= 32'b0;

        end else begin

          if (init_rst_o)
            mwr_perf <= 32'b0;
          else if (mwr_start_o && !mwr_done_i)
            mwr_perf <= mwr_perf + 1'b1;

        end

    end

    /*
     * Memory Read Performance Instrumentation
     */

    always @(posedge clk ) begin

        if ( !rst_n ) begin

          mrd_perf <= 32'b0;

        end else begin

          if (init_rst_o)
            mrd_perf <= 32'b0;
          else if (mrd_start_o && !mrd_done_o)
            mrd_perf <= mrd_perf + 1'b1;

        end

    end


    always @(posedge clk ) begin

        if ( !rst_n ) begin

          expect_cpld_data_size  <=  21'b0;
          cpld_data_size         <=  21'b0;
          cpld_done              <=  1'b0;

        end else begin

          if (init_rst_o) begin

            expect_cpld_data_size <=  21'b0;
            cpld_data_size        <=  21'b0;
            cpld_done             <=  1'b0;

          end else begin

            expect_cpld_data_size <= mrd_len_o[15:0] * mrd_count_o[15:0];
            cpld_data_size        <= cpld_data_size_i[20:0];
            cpld_done             <= (expect_cpld_data_size == cpld_data_size);

          end

        end

    end

    always @(posedge clk ) begin

        if ( !rst_n )
          mrd_done_o <= 1'b0;
        else
          if (init_rst_o)
            mrd_done_o <= 1'b0;
          else if ( (mrd_start_o) && (!mrd_done_o) && (cpld_done) )   //DMA�����
            mrd_done_o <= 1'b1;
    end
/*
	//DMAд:FPGA����>PC�����ٶȲ���
	reg mwr_start_r1;
	reg mwr_start_r2;
	reg [3:0]dma_cnt;
	reg [31:0] speed_cnt;
	always @(posedge clk_2M_f )
	begin
		mwr_start_r1 <= mwr_start_o;
		mwr_start_r2 <= mwr_start_r1;
	end
	
	always @(posedge clk_2M_f )
	begin
		if(!rst_n)
			dma_cnt <= 4'd0;
		else if((mwr_start_r1 == 1'b1) && (mwr_start_r2 == 1'b0))   //������
			dma_cnt <= dma_cnt + 1'b1;
		else
			dma_cnt <= dma_cnt;			
	end
	
	always @(posedge clk_2M_f )
	begin
		if(!rst_n)
			speed_cnt <= 32'd0;
		else if(dma_cnt == 4'd1)   
			speed_cnt <= speed_cnt + 1'b1;   //�Ե�һ��DMA���м���
		else
			speed_cnt <= speed_cnt;			
	end
*/

/*
	ILA_PCIE_TOP 
		MEM_i (
	.clk(clk), // input wire clk


	.probe0({
					                	          
	        rd_d_o[31:0],                
	        wr_d_i[31:0], 
	        fpga_to_pc_data[31:0],               
	        pc_to_fpga_data[31:0]
	             
	             	               
	
	}), // input wire [127:0]  probe0  
	.probe1({
    			a_i[11:0],                   
	        wr_en_i,   
				  data_wr_en,
				  rst_n,
				  init_rst_o,
				  mrd_start_o, 
				  mrd_int_dis_o,
				  mrd_done_o,
				  cfg_prg_max_payload_size[2:0],
				  cfg_cap_max_payload_size[2:0],
				  cfg_max_rd_req_size[2:0]  
				  	
				  				  
	}) // input wire [79:0]  probe1
);
*/








endmodule

