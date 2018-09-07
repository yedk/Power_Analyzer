`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/27 10:13:24
// Design Name: 
// Module Name: data_source_choose
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


module data_source_choose( 

	input         clk_100M,
	input  [31:0] data_from_serdes_s1, 
	input  [31:0] data_from_serdes_s2, 
	input  [31:0] data_from_serdes_s3, 
	input  [31:0] data_from_serdes_s4,                              
	input  [31:0] data_from_card_s1,   
	input  [31:0] data_from_card_s2,   
	input  [31:0] data_from_card_s3,   
  input  [31:0] data_from_card_s4,  
  input  [1:0]  oserdes_data_sel,
  output [31:0]	data_real_source1,
  output [31:0]	data_real_source2,
  output [31:0]	data_real_source3,
  output [31:0]	data_real_source4
 
    );
    
  reg [31:0]	data_real_source1;  
  reg [31:0]	data_real_source2;  
  reg [31:0]	data_real_source3;  
  reg [31:0]	data_real_source4;  
    
  always @(posedge clk_100M)
	begin
	  case(oserdes_data_sel[1:0])
	  	2'b00:
	  	 begin
         data_real_source1 <= data_from_serdes_s1;
         data_real_source2 <= data_from_serdes_s2;
         data_real_source3 <= data_from_serdes_s3;
         data_real_source4 <= data_from_serdes_s4;
       end
      2'b01:
	  	 begin
         data_real_source1 <= data_from_card_s1;
         data_real_source2 <= data_from_card_s2;
         data_real_source3 <= data_from_card_s3;
         data_real_source4 <= data_from_card_s4;                      
       end
     	default:
     		begin
     			data_real_source1 <= data_from_card_s1;
     			data_real_source2 <= data_from_card_s2;
     			data_real_source3 <= data_from_card_s3;
     			data_real_source4 <= data_from_card_s4;     			
     		end             
	  endcase
	end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
