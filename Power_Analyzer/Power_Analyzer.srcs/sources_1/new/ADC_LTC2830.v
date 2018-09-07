`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:33:53 04/17/2018 
// Design Name: 
// Module Name:    ADC_LTC2830 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:   LTC2830����ģ�飬��ģ��������ʱ���źţ��ֱ���100M��50M�ͱ�Ƶ�ʵĲ���ʱ��sample_clk��
//                ����ʱ��sample_clk�ڱ�ģ����ֱ�������adc�Ĳ���ʹ�ܶ� adc_cnv�����ϣ���ģ���ڲ����κδ���
//                100Mʱ����ģ��Ĺ���ʱ�� ��
//                50Mʱ����adc���������ʱ�ӣ�ͨ��bufgceԭ���50Mʱ�ӽ���ʹ�ܣ���ͨ��adc_sck���������adc��sckʹ���ź�adc_sck_enable����Ч�����ź��ڼ�⵽adc_busy�ź�
//                �½���ʱ��Ч����result_en ������ʱ��һ��ת�������ݴ�����ϣ���λ��
//
//                adc���ݵĽ���ʹ��״̬��ʵ�֣�adc��sck���������ݶ�������ݣ�sck�½��������ȶ���״̬����sck�½��ض�ȡ���ݣ���16λ���ݶ�ȡ��Ϻ�result_en�ø���Ч��
//                ������ȡ���ݸ��µ�result_data�У�result_en�źŸ���Чʱ��Ϊ2��ʱ������(100Mʱ��)��
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ADC_LTC2830(
    input                   clk_100M ,       // 100M ģ�鹤��ʱ��
    input                   clk_50M  ,      // 50M adc ���ݴ���ʱ��
    input                   rst_n,          //ģ�鸴λ���͵�ƽ��Ч
    input                   sample_clk,     //����ʱ�ӣ�ֱ�Ӹ�����adc��cnv�˿�
    
    input                   adc_busy,       //adc æ�źţ��ߵ�ƽΪadת���У��½���Ϊת�����
    input                   adc_sdo,        // adc ���������

    output                  adc_sck,        //adc������ʱ��  
    output                  adc_cnv,        //adcת��ʹ���źţ������س���adcת��

    output                    adc_data_en,
    output reg [ADC_BIT-1:0]  adc_data

    );

parameter ADC_BIT = 16;

reg                result_en;   
reg [ADC_BIT-1:0]  result_data;

//���ⲿģ�鴫�͵Ĳ���ʱ��ֱ������adc����cnv
assign adc_cnv = sample_clk;
/*
ila_0 ila_1 (
	.clk(clk_100M), // input wire clk


	.probe0({
	  
	  clk_50M  ,   
	  rst_n,                         
	  sample_clk,  	                                 
	  adc_busy,    
	  adc_sdo,     	                                 
	  adc_sck,     
	  adc_cnv,     	               
	  result_en,                     
	  result_data,
	  busy1,
	  busy2,
	  busy3,
	  adc_busy_negedge      , 
	  adc_busy_negedge_step2,
	  adc_sck_reg           ,
	  adc_sck_negedge       ,
	  adc_bit_count         ,
	  adc_buf               ,
	  adc_data              ,
	  trans_done            ,
	  Status                ,
	  adc_sck_enable        ,
	  trans_done_reg        ,
		trans_done_posedge		
	
	}) // input wire [999:0] probe0
);
*/




//���adc����busy�ź��½��أ����ź��½���adc���������Ч
reg busy1=0,busy2=0,busy3=0;
wire adc_busy_negedge,adc_busy_negedge_step2;  
always @(posedge clk_100M ) begin
    if (~rst_n) begin
        busy1 <= 1'b0;
        busy2 <= 1'b0;
        busy3 <= 1'b0;
    end else begin
        busy1 <= adc_busy;
        busy2 <= busy1;
        busy3 <= busy2;
    end
    
end
assign adc_busy_negedge = (~busy1) && busy2;
assign adc_busy_negedge_step2 = (~busy2) && busy3 ; // �����ӳ�һ�����ڵĶ�busy�½�����Ϊsckʹ�ܵĿ����źţ���֤��sckʱ��ʹ��ǰ���ܹ���ȡ��sdo�ϵ�����

//���adc-sck���½��أ�adc��sck������������ݣ����½��������ȶ���
reg adc_sck_reg=0;
wire adc_sck_negedge;
always @(posedge clk_100M ) begin
  if (~rst_n) begin
    adc_sck_reg <= 1'b0;
  end else begin
    adc_sck_reg<=adc_sck;
  end
end
assign adc_sck_negedge = (~adc_sck) && adc_sck_reg;

// ��������״̬��
reg [7:0]         adc_bit_count=0;  //�Խ��մ���λ����
reg [ADC_BIT-1:0] adc_buf=0;
reg               adc_data = 0;
reg               trans_done = 0;

reg [1:0] Status;
parameter   status_idle         = 2'b00  ,
            status_receiving    = 2'b01  ,
            status_received1    = 2'b10  ,
            status_received2    = 2'b11  ;

always @(posedge clk_100M ) begin
  if (~rst_n) begin
    adc_bit_count <= 8'd0;
    adc_buf       <= 0;
    result_data   <= 0;
    result_en     <= 0;
    trans_done    <= 0;
    Status        <= status_idle;
  end else begin
    case (Status)
      status_idle:
      begin
        adc_bit_count <= 8'd0;
        adc_buf       <= 0;
        result_en     <= 0;
        trans_done    <= 0;
        if (adc_busy_negedge == 1'b1) begin    // adc ��busy�½��ؾͿ�ʼ�����һ�����ݣ�������idle״̬��⵽busy�źž�ֱ�Ӷ�ȡһλ����
          adc_buf[0] <= adc_sdo;
          adc_buf[ADC_BIT-1:1]<=adc_buf[ADC_BIT-2:0];
          //adc_buf[15:1]<=adc_buf[14:0];
          Status <= status_receiving;
        end else begin
          Status <= status_idle;
        end
      end 

      status_receiving:   //״̬ receiving �� ʣ�µ�15λ���ݽ��ж�ȡ��sck������adc��sdo��������ݣ�sck�½���fpga��ȡsdo����
      begin
        // if (adc_sck_negedge == 1'b1) begin
        //   adc_buf[0] <= adc_sdo;
        //   //adc_buf[ADC_BIT-1:1]<=adc_buf[ADC_BIT-2:0];
        //   adc_buf[15:1]<=adc_buf[14:0];
        //   //adc_buf <= adc_buf << 1;
        //   //adc_bit_count <= adc_bit_count + 1'b1;
        //   if (adc_bit_count == 14/*ADC_BIT - 2*/) begin
        //     Status <= status_received1;
        //   end 
        //   else if (adc_bit_count < 14) begin
        //     adc_bit_count <= adc_bit_count + 1'b1;
        //     Status <= status_receiving;
        //   end
        //   else begin
        //     Status <= status_receiving;
        //   end
        // end else begin
        //   Status <= status_receiving;
        //   adc_buf <= adc_buf;
        //   adc_bit_count <= adc_bit_count;
        // end
        if (adc_bit_count<=14) begin
          if (adc_sck_negedge == 1'b1) begin
            adc_buf[0] <= adc_sdo;
            //adc_buf[15:1]<=adc_buf[14:0];
            adc_buf[ADC_BIT-1:1]<=adc_buf[ADC_BIT-2:0];
            adc_bit_count <= adc_bit_count + 1'b1;
          end 
          else begin
            adc_buf <= adc_buf;
            adc_bit_count <= adc_bit_count;
          end
        end 
        else begin
            //adc_buf[0] <= adc_sdo;
            trans_done <= 1'b1;   // trans_done �ź����� ֹͣʹ�� sckʱ�����
            Status <= status_received1;
        end

      end

      status_received1:  //����λ�õ���16λad���ݸ��µ�����˿� result_data�ϣ��������ʹ�� result_en ��λ
      begin
        result_data <= adc_buf;
        result_en   <= 1'b1;
        Status <= status_received2;
      end

      status_received2:   //��״̬��Ҫ���� �� ���ʹ�� result_en �ӳ�һ��ģ�鹤��ʱ�ӣ�Ŀǰ100Mģ�鹤��ʱ�ӣ�����
      begin
        result_en   <= 1'b1;
        Status <= status_idle;
      end

      default: 
      begin
        adc_bit_count <= 8'd0;
        adc_buf       <= 0;
        result_data   <= 0;
        result_en     <= 0;
        trans_done    <= 0;
        Status        <= status_idle;
      end
    endcase
  end
end


reg adc_sck_enable = 1'b0; //adc_sckʹ���źţ�Ϊ��ʱsck���ʱ��
/*
BUFGCE BUFGCE_ADCSCK (
      .O(adc_sck),   // 1-bit output: Clock output
      .CE(adc_sck_enable), // 1-bit input: Clock enable input for I0
      .I(clk_50M)    // 1-bit input: Primary clock
   );
*/

assign adc_sck = (adc_sck_enable == 1'b1)? clk_50M :0;

//reg resutlt_en_reg;
//wire result_en_posedge;
// always @(posedge clk_100M) begin
//   if (~rst_n) begin
//     resutlt_en_reg <= 1'b0;
//   end else begin
//     resutlt_en_reg <= result_en;
//   end
// end
// assign result_en_posedge = result_en && (~resutlt_en_reg);

reg trans_done_reg;
wire trans_done_posedge;
always @(posedge clk_100M) begin
  if (~rst_n) begin
    trans_done_reg <= 1'b0;
  end else begin
    trans_done_reg <= trans_done;
  end
end
assign trans_done_posedge = trans_done && (~trans_done_reg);

// busy�ź��½��� sck��ʼʹ�ܣ�trans_done�����أ�sckֹͣʹ��
always @(posedge clk_100M ) begin
    if (~rst_n) begin
      adc_sck_enable <= 1'b0;
    end else begin
      // if (adc_busy_negedge == 1'b1 && trans_done==1'b0) begin
      //   adc_sck_enable <= 1'b1;
      // end
      if (adc_busy_negedge_step2 == 1'b1 && trans_done==1'b0) begin
        adc_sck_enable <= 1'b1;
      end
      else if (trans_done_posedge == 1'b1) begin
        adc_sck_enable <= 1'b0;
      end
      else begin
        adc_sck_enable <= adc_sck_enable;
      end
    end
end



always@(posedge sample_clk ) 
begin
	adc_data <= result_data;
end
assign adc_data_en = result_en;	
	



endmodule
