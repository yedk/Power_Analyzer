`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:12:57 03/04/2017 
// Design Name: 
// Module Name:    HR_mulitp_B 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module HR_mulitp_B(
    input             s_clk,
    input             rst_n,
 		input      [31:0] time_base, 
 		output reg [15:0] mulit_b 
    );

always @ (posedge s_clk)
begin
   if(!rst_n)
   begin
   	  mulit_b <= 16'd13107;
   end
   else
   begin
     case(time_base)
       32'd5: //5usʱ����λ
       begin
         mulit_b <= 16'd13107;                
       end
       32'd10: //10usʱ����λ
       begin
         mulit_b <= 16'd13107;
       end
       32'd20: //20usʱ����λ
       begin
         mulit_b <= 16'd13107;
       end
       32'd50: //50usʱ����λ
       begin
         mulit_b <= 16'd10485;
       end
       32'd100: //100usʱ����λ
       begin
         mulit_b <= 16'd10485;
       end
       32'd200: //200usʱ����λ
       begin
         mulit_b <= 16'd10485;                 
       end                                  
       32'd500: //500usʱ����λ             
       begin                                
         mulit_b <= 16'd16777;                 
       end                                  
       32'd1000: //1msʱ����λ               
       begin                                
         mulit_b <= 16'd16777;                 
       end                                  
       32'd2000: //2msʱ����λ              
       begin                                
         mulit_b <= 16'd16777;                 
       end                                  
       32'd5000: //5msʱ����λ
       begin
         mulit_b <= 16'd13421;
       end
       32'd10000: //10msʱ����λ
       begin
         mulit_b <= 16'd13421;
       end
       32'd20000: //20msʱ����λ
       begin
         mulit_b <= 16'd13421;
       end
       32'd50000: //50msʱ����λ
       begin
         mulit_b <= 16'd10737;
       end
       32'd100000: //100msʱ����λ
       begin
         mulit_b <= 16'd10737;
       end
     default:
     begin
     	 mulit_b <= 16'd13107;
     end	
     endcase	
   end 
end




endmodule
