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
// Description:   LTC2830驱动模块，该模块有三个时钟信号，分别是100M，50M和变频率的采样时钟sample_clk。
//                采样时钟sample_clk在本模块中直接输出到adc的采样使能端 adc_cnv引脚上，本模块内不做任何处理
//                100M时钟是模块的工作时钟 。
//                50M时钟是adc数据输出的时钟，通过bufgce原语对50M时钟进行使能，并通过adc_sck引脚输出到adc，sck使能信号adc_sck_enable高有效，该信号在检测到adc_busy信号
//                下降沿时有效，在result_en 上升沿时（一次转换的数据传输完毕）复位。
//
//                adc数据的接收使用状态机实现，adc在sck上升沿数据端输出数据，sck下降沿数据稳定，状态机在sck下降沿读取数据，当16位数据读取完毕后，result_en置高有效，
//                并将读取数据更新到result_data中，result_en信号高有效时间为2个时钟周期(100M时钟)。
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ADC_LTC2830(
    input                   clk_100M ,       // 100M 模块工作时钟
    input                   clk_50M  ,      // 50M adc 数据传输时钟
    input                   rst_n,          //模块复位，低电平有效
    input                   sample_clk,     //采样时钟，直接给出到adc的cnv端口
    
    input                   adc_busy,       //adc 忙信号，高电平为ad转换中，下降沿为转换完成
    input                   adc_sdo,        // adc 数据输出端

    output                  adc_sck,        //adc读数据时钟  
    output                  adc_cnv,        //adc转换使能信号，上升沿出发adc转换

    output                    adc_data_en,
    output reg [ADC_BIT-1:0]  adc_data

    );

parameter ADC_BIT = 16;

reg                result_en;   
reg [ADC_BIT-1:0]  result_data;

//将外部模块传送的采样时钟直接连到adc——cnv
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




//检测adc——busy信号下降沿，该信号下降沿adc输出数据有效
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
assign adc_busy_negedge_step2 = (~busy2) && busy3 ; // 将再延迟一个周期的额busy下降沿作为sck使能的控制信号，保证在sck时钟使能前，能够读取到sdo上的数据

//检测adc-sck的下降沿，adc在sck上升沿输出数据，在下降沿数据稳定。
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

// 接收数据状态机
reg [7:0]         adc_bit_count=0;  //对接收串行位计数
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
        if (adc_busy_negedge == 1'b1) begin    // adc 在busy下降沿就开始输出第一个数据，这里在idle状态检测到busy信号就直接读取一位数据
          adc_buf[0] <= adc_sdo;
          adc_buf[ADC_BIT-1:1]<=adc_buf[ADC_BIT-2:0];
          //adc_buf[15:1]<=adc_buf[14:0];
          Status <= status_receiving;
        end else begin
          Status <= status_idle;
        end
      end 

      status_receiving:   //状态 receiving 对 剩下的15位数据进行读取，sck上升沿adc在sdo上输出数据，sck下降沿fpga读取sdo数据
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
            trans_done <= 1'b1;   // trans_done 信号用于 停止使能 sck时钟输出
            Status <= status_received1;
        end

      end

      status_received1:  //将移位得到的16位ad数据更新到输出端口 result_data上，并将输出使能 result_en 置位
      begin
        result_data <= adc_buf;
        result_en   <= 1'b1;
        Status <= status_received2;
      end

      status_received2:   //该状态主要就是 让 输出使能 result_en 延长一个模块工作时钟（目前100M模块工作时钟）周期
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


reg adc_sck_enable = 1'b0; //adc_sck使能信号，为高时sck输出时钟
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

// busy信号下降沿 sck开始使能，trans_done上升沿，sck停止使能
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
