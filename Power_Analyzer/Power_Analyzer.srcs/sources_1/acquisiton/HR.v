`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:13:20 09/30/2015 
// Design Name: 
// Module Name:    HR 
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
module HR(
 		input	   [15:0]	cha_data_in,
		input	   [15:0]	chb_data_in,
		input	            s_clk,
		input      [31:0]   time_base,
		input      [15:0]   mulit_b,
		input	            rst_n,
					
		output reg [15:0] cha_data_out,
		output reg [15:0] chb_data_out  
	);			  
reg [31:0] data_r;
wire[31:0] reg_set_num;
reg ready;


reg [15:0] cha_data0,chb_data0;
// reg [15:0] mulit_b;
reg [16:0] chaData_to_mulit,chbData_to_mulit;
reg [24:0] chaData_to_add,chbData_to_add;
wire [45:14] chaData_from_Muliacc0,chbData_from_Muliacc0; 
reg [45:14]  chaData_from_Muliacc, chbData_from_Muliacc; 
reg acc_rst_n;

//时基    硬件抽点     乘法器系数    乘累加后的无效位宽   
//5us	         5         13107             16       
//10us	      10         13107             17       
//20us	      20         13107             18       
//50us	      50         10485             19       
//100us      	100        10485             20       
//200us      	100        10485             20       
//500us      	250        16777             22       
//1ms	        500        16777             23       
//2ms	        1000       16777             24       
//5ms	        2500       13421             25       
//10ms	      5000       13421             26       
//20ms	      10000      13421             27       
//50ms	      25000      10737             28       
//100ms      	50000      10737             29       


/*
//根据不同的时基档位，设置乘法器系数b。
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
       32'd100: //200us时基档位
       begin
         mulit_b <= 16'd10485;                 
       end                                  
       32'd250: //500us时基档位             
       begin                                
         mulit_b <= 16'd16777;                 
       end                                  
       32'd500: //1ms时基档位               
       begin                                
         mulit_b <= 16'd16777;                 
       end                                  
       32'd1000: //2ms时基档位              
       begin                                
         mulit_b <= 16'd16777;                 
       end                                  
       32'd2500: //5ms时基档位
       begin
         mulit_b <= 16'd13421;
       end
       32'd5000: //10ms时基档位
       begin
         mulit_b <= 16'd13421;
       end
       32'd10000: //20ms时基档位
       begin
         mulit_b <= 16'd13421;
       end
       32'd25000: //50ms时基档位
       begin
         mulit_b <= 16'd10737;
       end
       32'd50000: //100ms时基档位
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
*/

assign	reg_set_num = time_base-2'd1;


reg [15:0] mulit_b_ch1,mulit_b_ch2;
 
always @(posedge s_clk)//
begin 
   mulit_b_ch1 <= mulit_b;
   mulit_b_ch2 <= mulit_b;
end 
 
always @(posedge s_clk)//
begin 	
	if(!rst_n)
		begin
			data_r <= 0;
			ready <= 1'b0;
		end				
	else 
		begin
			 if(data_r == reg_set_num)
			 begin
			 	   data_r <= 0;
			 	   ready <= 1'b0;
			 end
			 else
				begin 
					data_r <= data_r+1;
			 	  ready <= 1'b1;
				end		
		end
end

//在ready==0时（加法器复位时），记录当前的采集值
/*
always @(posedge s_clk)
begin
	if(data_r == 32'd0)
	begin
		 cha_data0 <= cha_data_in;
		 chb_data0 <= chb_data_in; 
		  chaData_to_mulit <= 17'd0;
		  chbData_to_mulit <= 17'd0;
	end
	else if( data_r == 32'd1)
	begin
		 chaData_to_mulit <= cha_data0 +cha_data_in;
		 chbData_to_mulit <= chb_data0 +chb_data_in;
	end 
  else
	begin
		 chaData_to_mulit <= cha_data_in;
		 chbData_to_mulit <= chb_data_in;
	end
end
*/


always @(posedge s_clk)
begin
	case(data_r)
		32'd0:
		begin
		  cha_data0 <= cha_data_in;
		  chb_data0 <= chb_data_in; 
		  chaData_to_mulit <= 17'd0;
		  chbData_to_mulit <= 17'd0;
		end	
		32'd1:
		begin
		 chaData_to_mulit <= cha_data0 +cha_data_in;
		 chbData_to_mulit <= chb_data0 +chb_data_in;
		end	
		default:
		begin
		  chaData_to_mulit <= cha_data_in;
		  chbData_to_mulit <= chb_data_in;
		end
	endcase	
end








always @(posedge s_clk)
begin
     acc_rst_n <= ~ready;
end
/*
//数据进行乘累加
mulitplier_acc mulitplier_acc_CH1 (
  .clk(s_clk), // input clk
  .ce(1), // input ce
  .sclr(acc_rst_n), // input sclr active high
  .bypass(0), // input bypass
  .a(mulit_b_ch1), // input [15 : 0] a
  .b(chaData_to_mulit), // input [16 : 0] b
  .s(chaData_from_Muliacc0) // output [45 : 0] s
);

//数据进行乘累加
mulitplier_acc mulitplier_acc_CH2 (
  .clk(s_clk), // input clk
  .ce(1), // input ce
  .sclr(acc_rst_n), // input sclr active high
  .bypass(0), // input bypass
  .a(mulit_b_ch2), // input [15 : 0] a
  .b(chbData_to_mulit), // input [16 : 0] b
  .s(chbData_from_Muliacc0) // output [45 : 0] s
);
*/
always @ (posedge s_clk)  
begin   
	if(data_r == 32'd1)
	begin
	  chaData_from_Muliacc <= chaData_from_Muliacc0;  
	  chbData_from_Muliacc <= chbData_from_Muliacc0;  
	end
  else
  begin
  	chaData_from_Muliacc <= chaData_from_Muliacc;  
  	chbData_from_Muliacc <= chbData_from_Muliacc;  
  end
end
  
  

//根据不同的时基档位，将乘累加后的数据输出。
always @ ( * )
begin
   if(!rst_n)
   begin
   	  cha_data_out <= 16'd0;
      chb_data_out <= 16'd0;
   end
   else if(data_r == 32'd2)
   begin
     case(time_base)
       32'd5: //5us时基档位
       begin
         cha_data_out <= chaData_from_Muliacc[31:16];
         chb_data_out <= chbData_from_Muliacc[31:16];           
       end
       32'd10: //10us时基档位
       begin
         cha_data_out <= chaData_from_Muliacc[32:17];
         chb_data_out <= chbData_from_Muliacc[32:17]; 
       end
       32'd20: //20us时基档位
       begin
         cha_data_out <= chaData_from_Muliacc[33:18];
         chb_data_out <= chbData_from_Muliacc[33:18]; 
       end
       32'd50: //50us时基档位
       begin                                      
         cha_data_out <= chaData_from_Muliacc[34:19];
         chb_data_out <= chbData_from_Muliacc[34:19]; 
       end
       32'd100: //100us时基档位
       begin
         cha_data_out <= chaData_from_Muliacc[35:20]; 
         chb_data_out <= chbData_from_Muliacc[35:20]; 

       end
       32'd200: //200us时基档位
       begin
         cha_data_out <= chaData_from_Muliacc[36:21]; 
         chb_data_out <= chbData_from_Muliacc[36:21];                  
       end                                  
       32'd500: //500us时基档位             
       begin                                
         cha_data_out <= chaData_from_Muliacc[38:23];
         chb_data_out <= chbData_from_Muliacc[38:23];                 
       end                                  
       32'd1000: //1ms时基档位               
       begin                                
         cha_data_out <= chaData_from_Muliacc[39:24];
         chb_data_out <= chbData_from_Muliacc[39:24];                 
       end                                  
       32'd2000: //2ms时基档位              
       begin                                
         cha_data_out <= chaData_from_Muliacc[40:25]; 
         chb_data_out <= chbData_from_Muliacc[40:25];                 
       end                                  
       32'd5000: //5ms时基档位
       begin
         cha_data_out <= chaData_from_Muliacc[41:26];
         chb_data_out <= chbData_from_Muliacc[41:26];
       end
       32'd10000: //10ms时基档位
       begin
         cha_data_out <= chaData_from_Muliacc[42:27];
         chb_data_out <= chbData_from_Muliacc[42:27];
       end
       32'd20000: //20ms时基档位
       begin
         cha_data_out <= chaData_from_Muliacc[43:28];
         chb_data_out <= chbData_from_Muliacc[43:28];
       end
       32'd50000: //50ms时基档位
       begin
         cha_data_out <= chaData_from_Muliacc[44:29];
         chb_data_out <= chbData_from_Muliacc[44:29];
       end
       32'd100000: //100ms时基档位
       begin
         cha_data_out <= chaData_from_Muliacc[45:30];
         chb_data_out <= chbData_from_Muliacc[45:30];
       end
     default:
     begin
     	 cha_data_out <= chaData_from_Muliacc[29:14];
         chb_data_out <= chbData_from_Muliacc[29:14];
     end	
     endcase	
   end 
end



endmodule
