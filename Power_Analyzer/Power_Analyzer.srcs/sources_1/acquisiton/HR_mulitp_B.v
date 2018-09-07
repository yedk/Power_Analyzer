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
       32'd5: //5us时基档位
       begin
         mulit_b <= 16'd13107;                
       end
       32'd10: //10us时基档位
       begin
         mulit_b <= 16'd13107;
       end
       32'd20: //20us时基档位
       begin
         mulit_b <= 16'd13107;
       end
       32'd50: //50us时基档位
       begin
         mulit_b <= 16'd10485;
       end
       32'd100: //100us时基档位
       begin
         mulit_b <= 16'd10485;
       end
       32'd200: //200us时基档位
       begin
         mulit_b <= 16'd10485;                 
       end                                  
       32'd500: //500us时基档位             
       begin                                
         mulit_b <= 16'd16777;                 
       end                                  
       32'd1000: //1ms时基档位               
       begin                                
         mulit_b <= 16'd16777;                 
       end                                  
       32'd2000: //2ms时基档位              
       begin                                
         mulit_b <= 16'd16777;                 
       end                                  
       32'd5000: //5ms时基档位
       begin
         mulit_b <= 16'd13421;
       end
       32'd10000: //10ms时基档位
       begin
         mulit_b <= 16'd13421;
       end
       32'd20000: //20ms时基档位
       begin
         mulit_b <= 16'd13421;
       end
       32'd50000: //50ms时基档位
       begin
         mulit_b <= 16'd10737;
       end
       32'd100000: //100ms时基档位
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
