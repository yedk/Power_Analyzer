`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/04 17:01:14
// Design Name: 
// Module Name: Base_line_ad
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


module Base_line_ad(

        input                 clk_100M,
        input                 rst_n,        
        input          [15:0] idata,    //adc数据输入
        input                 idata_valid,   //adc数据输入有效        
        input          [31:0] coeff,   //32位乘法器的系数
        input                 coeff_valid,    //乘法器系数输入有效        
        input          [15:0] offset,  //16位偏移，offset[15] 为0表示向上偏移，为1表示向下偏移，offset[14:0]为偏移数值
        input                 offset_valid,   //偏移有效
        
        output     reg [15:0] data_limted       ,  
        output         [15:0] data_unsigned     , // 16位数据输出，无符号，0~65535
        output     reg        data_limited_valid    // 输出数据有效


    );

reg        coeff_valid_reg ;
reg        idata_valid_reg ;
reg        offset_valid_reg;
wire       coeff_en ;
wire       idata_en ;
wire       offset_en; 
reg  [31:0]coeff_reg ;
reg  [31:0]idata_reg ;
reg  [31:0]offset_reg;
reg  [31:0]idata_i2f ;

wire [31:0]idata_float;
wire [31:0]idata_mul_fl;
wire [31:0]odata_fix   ;

/*
ila_0 ila_base (
	.clk(clk_100M), // input wire clk


	.probe0({
	  
	  rst_n             ,       
    idata             ,    
    idata_valid       ,
    idata_en          ,
    coeff             ,   
    coeff_valid       , 
    offset            ,  
    offset_valid      ,                 
    data_limted       ,  
    data_limited_valid,
    idata_i2f       ,                   
    idata_float     ,
    idata_mul_fl    ,
    idata_mul_fl_tvalid,
    idata_mul_fl_tready,
    odata_fix_tvalid,
    odata_fix       ,
    data_unsigned
    

	
	}) // input wire [999:0] probe0
);
*/


//对coeff乘法器系数有效 ， 输入数据idata有效信号 和 偏移offset有效信号 缓存
always @(posedge clk_100M or negedge rst_n)
begin
		if(~rst_n) 
		  begin
				coeff_valid_reg   <= 1'b0; 
				idata_valid_reg   <= 1'b0;    
				offset_valid_reg  <= 1'b0;    
		  end
		else 
		  begin
				coeff_valid_reg   <=    coeff_valid   ;
				idata_valid_reg   <=    idata_valid   ;
				offset_valid_reg  <=    offset_valid  ;
		  end
end

assign coeff_en  = coeff_valid  && (~coeff_valid_reg) ;   //对使能信号进行上升沿检测
assign idata_en  = idata_valid  && (~idata_valid_reg) ;
assign offset_en = offset_valid && (~offset_valid_reg);


always @(posedge clk_100M or negedge rst_n)
begin
		if(~rst_n) 
		  begin
				coeff_reg  <= 32'h3F800000;   // 上电默认乘法器系数为浮点数 1.0
				idata_reg  <= 32'd0;
				offset_reg <= 32'd0;
		  end
		else 
		  begin
		
				if(coeff_valid_reg == 1'b1)   //对乘法器系数缓存
				  begin     
					  coeff_reg <= coeff;
				  end
				else 
				  begin
					  coeff_reg <= coeff_reg;
				  end
				
				if(idata_en == 1'b1) 
				  begin
					  idata_reg  <= {{16{idata[15]}},idata};
				  end
				else 
				  begin
					  idata_reg <= idata_reg;
				  end
				
				if(offset_valid_reg == 1'b1) // 对偏移数据进行缓存
				  begin      
					  offset_reg <= {{16{offset[15]}},offset[15:0]};   
				  end
				else 
				  begin
					  offset_reg <= offset_reg;
				  end
		  end
end

always @(posedge clk_100M) 
begin
  if(!rst_n)
    idata_i2f <= 0;
  else if(idata_en)
    idata_i2f <= idata_reg + offset_reg;
  else
    idata_i2f <= idata_i2f;
end


fix32int_float fix32int_float (
  .aclk                ( clk_100M             ),  // input wire aclk
  .s_axis_a_tvalid     ( idata_en             ),  // input wire s_axis_a_tvalid
  .s_axis_a_tready     ( idata_i2f_tready     ),  // output wire s_axis_a_tready
  .s_axis_a_tdata      ( idata_i2f            ),  // input wire [31 : 0] s_axis_a_tdata
  .m_axis_result_tvalid( idata_float_tvalid   ),  // output wire m_axis_result_tvalid
  .m_axis_result_tready( idata_en             ),  // input wire m_axis_result_tready
  .m_axis_result_tdata ( idata_float          )   // output wire [31 : 0] m_axis_result_tdata

);

float_mul float_mul (
  .aclk                ( clk_100M               ),  // input wire aclk 
  .aresetn             ( rst_n                  ),
  .s_axis_a_tvalid     ( idata_float_tvalid     ),  // input wire s_axis_a_tvalid
  .s_axis_a_tready     ( idata_float_tready     ),  // output wire s_axis_a_tready
  .s_axis_a_tdata      ( idata_float            ),  // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid     ( 1                      ),  // input wire s_axis_b_tvalid
  .s_axis_b_tready     ( coeff_reg_tready       ),  // output wire s_axis_b_tready
  .s_axis_b_tdata      ( coeff_reg              ),  // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid( idata_mul_fl_tvalid    ),  // output wire m_axis_result_tvalid
  .m_axis_result_tready( idata_float_tvalid     ),  // input wire m_axis_result_tready
  .m_axis_result_tdata ( idata_mul_fl           )   // output wire [31 : 0] m_axis_result_tdata

);


float_32intfix float_32intfix (
  .aclk                ( clk_100M             ),  // input wire aclk
  .s_axis_a_tvalid     ( idata_mul_fl_tvalid  ),  // input wire s_axis_a_tvalid
  .s_axis_a_tready     ( idata_mul_fl_tready  ),  // output wire s_axis_a_tready
  .s_axis_a_tdata      ( idata_mul_fl         ),  // input wire [31 : 0] s_axis_a_tdata
  .m_axis_result_tvalid( odata_fix_tvalid     ),  // output wire m_axis_result_tvalid
  .m_axis_result_tready( idata_en             ),  // input wire m_axis_result_tready
  .m_axis_result_tdata ( odata_fix            )   // output wire [31 : 0] m_axis_result_tdata

);


//reg [15:0] data_limted;
//reg data_limited_valid;

always @(posedge clk_100M or negedge rst_n)   //将乘法结果进行有符号形式的幅度限制，限制在 -32768 至 32767 之间。
begin
	if(~rst_n) begin
			data_limted <= 16'd0;
			data_limited_valid <= 16'd0;
	end
	else if (odata_fix[31] == 1'b0)
    begin
        if (odata_fix[30:15]>16'b0)  begin
            data_limted <= 16'd32767;
            data_limited_valid <= odata_fix_tvalid;
        end
        else begin
            data_limted <= odata_fix[15:0];
            data_limited_valid <= odata_fix_tvalid;
        end
    end
    else if (odata_fix[31]==1'b1)
    begin
        if(odata_fix[30:15]<16'hffff) begin
            data_limted<=16'h8000;
            data_limited_valid <= odata_fix_tvalid;
        end
        else begin
            data_limted <= odata_fix[15:0];
            data_limited_valid <= odata_fix_tvalid;
        end
    end
end

//wire [15:0]data_unsigned;

assign data_unsigned = data_limted - 16'h8000;   // 将限幅后的值转换为无符号







endmodule
