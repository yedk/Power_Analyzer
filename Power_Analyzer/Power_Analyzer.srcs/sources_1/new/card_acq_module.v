`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/05 10:19:00
// Design Name: 
// Module Name: card_acq_module
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


module card_acq_module(
          input              clk_100M            ,
          input              clk_50M             ,
          input              clk_10M             ,
          input              rst_n               ,
          
//          input    [15:0]    ht595_ControlData   , // 595 输入数据     
//          input              ht595_en            ,
          
          input              sample_clk          , //采样时钟，直接给出到adc的cnv端口

          input              S1_1_adc_busy,
          input              S1_1_adc_sdo ,
          input              S1_2_adc_busy,
          input              S1_2_adc_sdo ,
          input              S2_1_adc_busy,
          input              S2_1_adc_sdo ,
          input              S2_2_adc_busy,
          input              S2_2_adc_sdo ,
          input              S3_1_adc_busy,
          input              S3_1_adc_sdo ,
          input              S3_2_adc_busy,
          input              S3_2_adc_sdo ,
                                           
          output             S1_1_adc_sck ,
          output             S1_1_adc_cnv ,                    
          output             S1_2_adc_sck ,
          output             S1_2_adc_cnv ,                    
          output             S2_1_adc_sck ,
          output             S2_1_adc_cnv ,                  
          output             S2_2_adc_sck ,
          output             S2_2_adc_cnv ,                    
          output             S3_1_adc_sck ,
          output             S3_1_adc_cnv ,                    
          output             S3_2_adc_sck ,
          output             S3_2_adc_cnv ,
          
          input    [31:0]    S1_1_coeff       ,
          input    [15:0]    S1_1_offset      ,
          input              S1_1_coeff_valid ,
          input              S1_1_offset_valid,
          input    [31:0]    S1_2_coeff       ,
          input    [15:0]    S1_2_offset      ,
          input              S1_2_coeff_valid ,
          input              S1_2_offset_valid,
          input    [31:0]    S2_1_coeff       ,
          input    [15:0]    S2_1_offset      ,
          input              S2_1_coeff_valid ,
          input              S2_1_offset_valid,
          input    [31:0]    S2_2_coeff       ,
          input    [15:0]    S2_2_offset      ,
          input              S2_2_coeff_valid ,
          input              S2_2_offset_valid,
          input    [31:0]    S3_1_coeff       ,
          input    [15:0]    S3_1_offset      ,
          input              S3_1_coeff_valid ,
          input              S3_1_offset_valid,
          input    [31:0]    S3_2_coeff       ,
          input    [15:0]    S3_2_offset      ,
          input              S3_2_coeff_valid ,
          input              S3_2_offset_valid,
                                                                        
//          output             oe_595              , 
//          output             ser_595             , 
//          output             srclk_595           , 
//          output             rclk_595            ,
 
          output       [15:0]S1_1_odata_signed   ,  
          output       [15:0]S1_2_odata_signed   , 
          output       [15:0]S2_1_odata_signed   ,  
          output       [15:0]S2_2_odata_signed   , 
          output       [15:0]S3_1_odata_signed   , 
          output       [15:0]S3_2_odata_signed   ,  
          
          output       [15:0]S1_1_odata_unsigned ,
          output       [15:0]S1_2_odata_unsigned ,
          output       [15:0]S2_1_odata_unsigned ,
          output       [15:0]S2_2_odata_unsigned ,
          output       [15:0]S3_1_odata_unsigned ,
          output       [15:0]S3_2_odata_unsigned , 
          
          output             S1_1_odata_valid    ,          
          output             S1_2_odata_valid    , 
          output             S2_1_odata_valid    ,
          output             S2_2_odata_valid    ,
          output             S3_1_odata_valid    ,  
          output             S3_2_odata_valid   
                         
                             
    );


reg [3:0]cnt;
reg      clk_1M;

wire [15:0]odata           ;
wire       odata_valid     ;
wire       S1_1_adc_en     ;
wire [15:0]S1_1_adc_data   ;
wire [15:0]S1_1_odata_signed      ;
wire       S1_1_odata_valid;
wire       S1_2_adc_en     ;
wire [15:0]S1_2_adc_data   ;
wire [15:0]S1_2_odata_signed      ;
wire       S1_2_odata_valid;
wire       S2_1_adc_en     ;
wire [15:0]S2_1_adc_data   ;
wire [15:0]S2_1_odata_signed      ;
wire       S2_1_odata_valid;
wire       S2_2_adc_en     ;
wire [15:0]S2_2_adc_data   ;
wire [15:0]S2_2_odata_signed      ;
wire       S2_2_odata_valid;
wire       S3_1_adc_en     ;
wire [15:0]S3_1_adc_data   ;
wire [15:0]S3_1_odata_signed      ;
wire       S3_1_odata_valid;
wire       S3_2_adc_en     ;
wire [15:0]S3_2_adc_data   ;
wire [15:0]S3_2_odata_signed      ;
wire       S3_2_odata_valid;


/*
ILA_PCIE_TOP 
		ILA_CARD (
	.clk(clk_10M), // input wire clk


	.probe0({
			sample_clk   ,             
      S1_1_adc_busy,
      S1_1_adc_sdo ,
      S1_2_adc_busy,
      S1_2_adc_sdo ,
      S2_1_adc_busy,
      S2_1_adc_sdo ,
      S2_2_adc_busy,
      S2_2_adc_sdo ,            
      S1_1_adc_sck ,
      S1_1_adc_cnv ,
      S1_2_adc_sck ,
      S1_2_adc_cnv ,
      S2_1_adc_sck ,
      S2_1_adc_cnv ,
      S2_2_adc_sck ,
      S2_2_adc_cnv ,
      S1_1_odata_unsigned[15:0],		
	    S1_1_adc_data[15:0],
	    S1_1_odata_unsigned[15:0],
	    S2_1_offset  [15:0] 					
	         
	
	}), // input wire [127:0]  probe0  
	.probe1({
					S1_1_coeff   [31:0],
          S1_1_offset  [15:0],
          S1_2_coeff   [31:0],
          S1_2_offset  [15:0],
          S2_1_coeff   [31:0]       
              
					       
					 
							   				  
	}) // input wire [127:0]  probe1
);
*/
/*

HT595 HT595(
  .clk     ( clk_50M           ),               
  .rstn    ( rst_n             ),                
  .set_en  ( ht595_en          ),           
  .set_data( ht595_ControlData ),
  .set_over(                   ),                 
  .oe      (    oe_595         ),      
  .ser     (   ser_595         ),      
  .srclk   ( srclk_595         ),      
  .rclk    (  rclk_595         )       

);
*/

always@(posedge clk_10M)
begin
	if(!rst_n)
	  begin
	  	cnt <= 0;
	  	clk_1M <= 0;
	  end
	else if( cnt >= 4'd4 )
	  begin
	  	cnt <= 0;
	  	clk_1M <= ~clk_1M;
	  end
	else
	  begin
	  	cnt <= cnt + 1;
	  	clk_1M <= clk_1M;
	  end	
	
end


wire clk_ila_1M;

BUFG BUFG_inst (
      .O(clk_ila_1M), // 1-bit output: Clock output
      .I(clk_1M)  // 1-bit input: Clock input
   );



ADC_LTC2830 U2_ltc2830_S1_1 (

   .clk_100M   ( clk_100M        ), 
   .clk_50M    ( clk_50M         ), 
   .rst_n      ( rst_n           ), 
   .sample_clk ( sample_clk      ), 
   .adc_busy   ( S1_1_adc_busy   ), 
   .adc_sdo    ( S1_1_adc_sdo    ), 
   
   .adc_sck    ( S1_1_adc_sck    ), 
   .adc_cnv    ( S1_1_adc_cnv    ), 
   .adc_data_en( S1_1_adc_en     ), 
   .adc_data   ( S1_1_adc_data   )
   
);      
    
Base_line_ad Base_line_ad_S1_1(
  
  .clk_100M          ( clk_100M            ),    
  .rst_n             ( rst_n               ),       
  .idata             ( S1_1_adc_data       ),    
  .idata_valid       ( S1_1_adc_en         ), 
  .coeff             ( S1_1_coeff          ),  
  .coeff_valid       ( S1_1_coeff_valid    ), 
  .offset            ( S1_1_offset         ),  
  .offset_valid      ( S1_1_offset_valid   ),
                
  .data_limted       ( S1_1_odata_signed   ),
  .data_unsigned     ( S1_1_odata_unsigned ), 
  .data_limited_valid( S1_1_odata_valid    )  

);


ADC_LTC2830 U2_ltc2830_S1_2 (

   .clk_100M   ( clk_100M        ), 
   .clk_50M    ( clk_50M         ), 
   .rst_n      ( rst_n           ), 
   .sample_clk ( sample_clk      ), 
   .adc_busy   ( S1_2_adc_busy   ), 
   .adc_sdo    ( S1_2_adc_sdo    ), 
   
   .adc_sck    ( S1_2_adc_sck    ), 
   .adc_cnv    ( S1_2_adc_cnv    ), 
   .adc_data_en( S1_2_adc_en     ), 
   .adc_data   ( S1_2_adc_data   )
   
);      
    
Base_line_ad Base_line_ad_S1_2(
  
  .clk_100M          ( clk_100M            ),    
  .rst_n             ( rst_n               ),       
  .idata             ( S1_2_adc_data       ),    
  .idata_valid       ( S1_2_adc_en         ), 
  .coeff             ( S1_2_coeff          ),  
  .coeff_valid       ( S1_2_coeff_valid    ), 
  .offset            ( S1_2_offset         ),  
  .offset_valid      ( S1_2_offset_valid   ),
                
  .data_limted       ( S1_2_odata_signed   ),
  .data_unsigned     ( S1_2_odata_unsigned ), 
  .data_limited_valid( S1_2_odata_valid    )  

);

ADC_LTC2830 U2_ltc2830_S2_1 (

   .clk_100M   ( clk_100M        ), 
   .clk_50M    ( clk_50M         ), 
   .rst_n      ( rst_n           ), 
   .sample_clk ( sample_clk      ), 
   .adc_busy   ( S2_1_adc_busy   ), 
   .adc_sdo    ( S2_1_adc_sdo    ), 
   
   .adc_sck    ( S2_1_adc_sck    ), 
   .adc_cnv    ( S2_1_adc_cnv    ), 
   .adc_data_en( S2_1_adc_en     ), 
   .adc_data   ( S2_1_adc_data   )
   
);      
    
Base_line_ad Base_line_ad_S2_1(
  
  .clk_100M          ( clk_100M            ),    
  .rst_n             ( rst_n               ),       
  .idata             ( S2_1_adc_data       ),    
  .idata_valid       ( S2_1_adc_en         ), 
  .coeff             ( S2_1_coeff          ),  
  .coeff_valid       ( S2_1_coeff_valid    ), 
  .offset            ( S2_1_offset         ),  
  .offset_valid      ( S2_1_offset_valid   ),
                
  .data_limted       ( S2_1_odata_signed   ),
  .data_unsigned     ( S2_1_odata_unsigned ), 
  .data_limited_valid( S2_1_odata_valid    )  

);

ADC_LTC2830 U2_ltc2830_S2_2 (

   .clk_100M   ( clk_100M        ), 
   .clk_50M    ( clk_50M         ), 
   .rst_n      ( rst_n           ), 
   .sample_clk ( sample_clk      ), 
   .adc_busy   ( S2_2_adc_busy   ), 
   .adc_sdo    ( S2_2_adc_sdo    ), 
   
   .adc_sck    ( S2_2_adc_sck    ), 
   .adc_cnv    ( S2_2_adc_cnv    ), 
   .adc_data_en( S2_2_adc_en     ), 
   .adc_data   ( S2_2_adc_data   )
   
);      
    
Base_line_ad Base_line_ad_S2_2(
  
  .clk_100M          ( clk_100M            ),    
  .rst_n             ( rst_n               ),       
  .idata             ( S2_2_adc_data       ),    
  .idata_valid       ( S2_2_adc_en         ), 
  .coeff             ( S2_2_coeff          ),  
  .coeff_valid       ( S2_2_coeff_valid    ), 
  .offset            ( S2_2_offset         ),  
  .offset_valid      ( S2_2_offset_valid   ),
                
  .data_limted       ( S2_2_odata_signed   ),
  .data_unsigned     ( S2_2_odata_unsigned ), 
  .data_limited_valid( S2_2_odata_valid    )  

);


ADC_LTC2830 U2_ltc2830_S3_1 (

   .clk_100M   ( clk_100M        ), 
   .clk_50M    ( clk_50M         ), 
   .rst_n      ( rst_n           ), 
   .sample_clk ( sample_clk      ), 
   .adc_busy   ( S3_1_adc_busy   ), 
   .adc_sdo    ( S3_1_adc_sdo    ), 
   
   .adc_sck    ( S3_1_adc_sck    ), 
   .adc_cnv    ( S3_1_adc_cnv    ), 
   .adc_data_en( S3_1_adc_en     ), 
   .adc_data   ( S3_1_adc_data   )
   
);      
    
Base_line_ad Base_line_ad_S3_1(
  
  .clk_100M          ( clk_100M            ),    
  .rst_n             ( rst_n               ),       
  .idata             ( S3_1_adc_data       ),    
  .idata_valid       ( S3_1_adc_en         ), 
  .coeff             ( S3_1_coeff          ),  
  .coeff_valid       ( S3_1_coeff_valid    ), 
  .offset            ( S3_1_offset         ),  
  .offset_valid      ( S3_1_offset_valid   ),
                
  .data_limted       ( S3_1_odata_signed   ),
  .data_unsigned     ( S3_1_odata_unsigned ), 
  .data_limited_valid( S3_1_odata_valid    )  

);

ADC_LTC2830 U2_ltc2830_S3_2 (

   .clk_100M   ( clk_100M        ), 
   .clk_50M    ( clk_50M         ), 
   .rst_n      ( rst_n           ), 
   .sample_clk ( sample_clk      ), 
   .adc_busy   ( S3_2_adc_busy   ), 
   .adc_sdo    ( S3_2_adc_sdo    ), 
   
   .adc_sck    ( S3_2_adc_sck    ), 
   .adc_cnv    ( S3_2_adc_cnv    ), 
   .adc_data_en( S3_2_adc_en     ), 
   .adc_data   ( S3_2_adc_data   )
   
);      
    
Base_line_ad Base_line_ad_S3_2(
  
  .clk_100M          ( clk_100M            ),    
  .rst_n             ( rst_n               ),       
  .idata             ( S3_2_adc_data       ),    
  .idata_valid       ( S3_2_adc_en         ), 
  .coeff             ( S3_2_coeff          ),  
  .coeff_valid       ( S3_2_coeff_valid    ), 
  .offset            ( S3_2_offset         ),  
  .offset_valid      ( S3_2_offset_valid   ),
                                           
  .data_limted       ( S3_2_odata_signed   ),
  .data_unsigned     ( S3_2_odata_unsigned ), 
  .data_limited_valid( S3_2_odata_valid    )  

);







endmodule
