`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:56:29 03/27/2017 
// Design Name: 
// Module Name:    select_4ch 
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
module select_4ch(
input              adc_tx_clk,
input      [31:0] data_from_serdes_s1,
input      [31:0] data_from_serdes_s2,
input      [31:0] data_from_serdes_s3,
input      [31:0] data_from_serdes_s4,
//input      [31:0] data_from_serdes_s5,
//input      [31:0] data_from_serdes_s6,
//input      [31:0] data_from_serdes_s7,
//input      [31:0] data_from_serdes_s8, 
input      [31:0]  set_channel_id0,

output reg [63:0] data_16ch
    );


reg [63:0] data_16channel,data_16channel_reg;

always @(  adc_tx_clk  )
begin
   data_16channel_reg <= data_16channel;
   data_16ch <=data_16channel_reg;

end


//��0���洢ͨ������ѡ��
always @(  adc_tx_clk  )
begin
	  case(set_channel_id0[7:0])
	    8'd0:  
      begin                   
      	  data_16channel[15:0] <= data_from_serdes_s1[15:0];   
      end                                                           
      8'd1:                                                     
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s1[31:16];  
      end                                                           
      8'd2:                                                     
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[15:0];  
      end                                                           
      8'd3:                                                     
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[31:16];  
      end                                                           
      8'd4:                                                     
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[15:0];  
      end                                                           
      8'd5:                                                     
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[31:16];  
      end                                                           
      8'd6:                                                     
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[15:0]; 
      end                                                           
      8'd7:                                                     
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[31:16];
      end  
      /*                                                         
      8'd8:                                                     
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s1[143:128];
      end                                                           
      8'd9:                                                     
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s1[159:144];
      end                                                           
      8'd10:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s1[175:160];
      end                                                           
      8'd11:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s1[191:176];
      end                                                           
      8'd12:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s1[207:192];
      end                                                           
      8'd13:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s1[223:208];
      end                                                           
      8'd14:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s1[239:224];
      end                                                           
      8'd15:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s1[255:240];
      end                          
      8'd16: 
      begin                   
      	  data_16channel[15:0] <= data_from_serdes_s2[15:0];   
      end                                                           
      8'd17:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[31:16];  
      end                                                           
      8'd18:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[47:32];  
      end                                                           
      8'd19:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[63:48];  
      end                                                           
      8'd20:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[79:64];  
      end                                                           
      8'd21:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[95:80];  
      end                                                           
      8'd22:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[111:96]; 
      end                                                           
      8'd23:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[127:112];
      end                                                           
      8'd24:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[143:128];
      end                                                           
      8'd25:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[159:144];
      end                                                           
      8'd26:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[175:160];
      end                                                           
      8'd27:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[191:176];
      end                                                           
      8'd28:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[207:192];
      end                                                           
      8'd29:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[223:208];
      end                                                           
      8'd30:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[239:224];
      end                                                           
      8'd31:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s2[255:240];
      end                          
      8'd32: 
      begin                   
      	  data_16channel[15:0] <= data_from_serdes_s3[15:0];   
      end                                                           
      8'd33:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[31:16];  
      end                                                           
      8'd34:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[47:32];  
      end                                                           
      8'd35:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[63:48];  
      end                                                           
      8'd36:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[79:64];  
      end                                                           
      8'd37:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[95:80];  
      end                                                           
      8'd38:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[111:96]; 
      end                                                           
      8'd39:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[127:112];
      end                                                           
      8'd40:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[143:128];
      end                                                           
      8'd41:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[159:144];
      end                                                           
      8'd42:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[175:160];
      end                                                           
      8'd43:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[191:176];
      end                                                           
      8'd44:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[207:192];
      end                                                           
      8'd45:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[223:208];
      end                                                           
      8'd46:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[239:224];
      end                                                           
      8'd47:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s3[255:240];
      end                          
      8'd48: 
      begin                   
      	  data_16channel[15:0] <= data_from_serdes_s4[15:0];   
      end                                                           
      8'd49:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[31:16];  
      end                                                           
      8'd50:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[47:32];  
      end                                                           
      8'd51:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[63:48];  
      end                                                           
      8'd52:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[79:64];  
      end                                                           
      8'd53:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[95:80];  
      end                                                           
      8'd54:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[111:96]; 
      end                                                           
      8'd55:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[127:112];
      end                                                           
      8'd56:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[143:128];
      end                                                           
      8'd57:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[159:144];
      end                                                           
      8'd58:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[175:160];
      end                                                           
      8'd59:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[191:176];
      end                                                           
      8'd60:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[207:192];
      end                                                           
      8'd61:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[223:208];
      end                                                           
      8'd62:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[239:224];
      end                                                           
      8'd63:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s4[255:240];
      end                          
      8'd64: 
      begin                   
      	  data_16channel[15:0] <= data_from_serdes_s5[15:0];   
      end                                                           
      8'd65:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[31:16];  
      end                                                           
      8'd66:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[47:32];  
      end                                                           
      8'd67:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[63:48];  
      end                                                           
      8'd68:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[79:64];  
      end                                                           
      8'd69:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[95:80];  
      end                                                           
      8'd70:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[111:96]; 
      end                                                           
      8'd71:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[127:112];
      end                                                           
      8'd72:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[143:128];
      end                                                           
      8'd73:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[159:144];
      end                                                           
      8'd74:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[175:160];
      end                                                           
      8'd75:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[191:176];
      end                                                           
      8'd76:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[207:192];
      end                                                           
      8'd77:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[223:208];
      end                                                           
      8'd78:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[239:224];
      end                                                           
      8'd79:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s5[255:240];
      end                          
      8'd80: 
      begin                   
      	  data_16channel[15:0] <= data_from_serdes_s6[15:0];   
      end                                                           
      8'd81:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[31:16];  
      end                                                           
      8'd82:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[47:32];  
      end                                                           
      8'd83:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[63:48];  
      end                                                           
      8'd84:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[79:64];  
      end                                                           
      8'd85:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[95:80];  
      end                                                           
      8'd86:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[111:96]; 
      end                                                           
      8'd87:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[127:112];
      end                                                           
      8'd88:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[143:128];
      end                                                           
      8'd89:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[159:144];
      end                                                           
      8'd90:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[175:160];
      end                                                           
      8'd91:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[191:176];
      end                                                           
      8'd92:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[207:192];
      end                                                           
      8'd93:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[223:208];
      end                                                           
      8'd94:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[239:224];
      end                                                           
      8'd95:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s6[255:240];
      end                          
      8'd96: 
      begin                   
      	  data_16channel[15:0] <= data_from_serdes_s7[15:0];   
      end                                                           
      8'd97:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[31:16];  
      end                                                           
      8'd98:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[47:32];  
      end                                                           
      8'd99:                                                    
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[63:48];  
      end                                                           
      8'd100:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[79:64];  
      end                                                           
      8'd101:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[95:80];  
      end                                                           
      8'd102:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[111:96]; 
      end                                                           
      8'd103:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[127:112];
      end                                                           
      8'd104:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[143:128];
      end                                                           
      8'd105:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[159:144];
      end                                                           
      8'd106:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[175:160];
      end                                                           
      8'd107:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[191:176];
      end                                                           
      8'd108:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[207:192];
      end                                                           
      8'd109:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[223:208];
      end                                                           
      8'd110:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[239:224];
      end                                                           
      8'd111:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s7[255:240];
      end                          
      8'd112:
      begin                   
      	  data_16channel[15:0] <= data_from_serdes_s8[15:0];   
      end                                                           
      8'd113:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[31:16];  
      end                                                           
      8'd114:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[47:32];  
      end                                                           
      8'd115:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[63:48];  
      end                                                           
      8'd116:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[79:64];  
      end                                                           
      8'd117:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[95:80];  
      end                                                           
      8'd118:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[111:96]; 
      end                                                           
      8'd119:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[127:112];
      end                                                           
      8'd120:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[143:128];
      end                                                           
      8'd121:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[159:144];
      end                                                           
      8'd122:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[175:160];
      end                                                           
      8'd123:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[191:176];
      end                                                           
      8'd124:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[207:192];
      end                                                           
      8'd125:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[223:208];
      end                                                           
      8'd126:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[239:224];
      end                                                           
      8'd127:                                                   
      begin                                                    
      	  data_16channel[15:0] <= data_from_serdes_s8[255:240];
      end
      
    */                          
      default:
      begin
      	 data_16channel[15:0] <= 16'h0;
      end      
      	  	 
    endcase	
end 
    
//��1���洢ͨ������ѡ��
always @(  adc_tx_clk  )
begin
	  case(set_channel_id0[15:8])
	    8'd0:  
      begin                   
      	  data_16channel[31:16] <= data_from_serdes_s1[15:0];  
      end                                                          
      8'd1:                                                    
      begin                                                   
      	  data_16channel[31:16] <= data_from_serdes_s1[31:16]; 
      end                                                          
      8'd2:                                                    
      begin                                                   
      	  data_16channel[31:16] <= data_from_serdes_s2[15:0];  
      end                                                          
      8'd3:                                                    
      begin                                                   
      	  data_16channel[31:16] <= data_from_serdes_s2[31:16]; 
      end                                                          
      8'd4:                                                    
      begin                                                   
      	  data_16channel[31:16] <= data_from_serdes_s3[15:0];  
      end                                                          
      8'd5:                                                    
      begin                                                   
      	  data_16channel[31:16] <= data_from_serdes_s3[31:16]; 
      end                                                          
      8'd6:                                                    
      begin                                                   
      	  data_16channel[31:16] <= data_from_serdes_s4[15:0];  
      end                                                                                      
      8'd7:                                                                                
      begin                                                                               
      	  data_16channel[31:16] <= data_from_serdes_s4[31:16];
      end 
      /*                                                          
      8'd8:                                                     
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s1[143:128];
      end                                                           
      8'd9:                                                     
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s1[159:144];
      end                                                           
      8'd10:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s1[175:160];
      end                                                           
      8'd11:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s1[191:176];
      end                                                           
      8'd12:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s1[207:192];
      end                                                           
      8'd13:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s1[223:208];
      end                                                           
      8'd14:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s1[239:224];
      end                                                           
      8'd15:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s1[255:240];
      end                          
      8'd16: 
      begin                   
      	  data_16channel[31:16] <= data_from_serdes_s2[15:0];   
      end                                                           
      8'd17:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[31:16];  
      end                                                           
      8'd18:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[47:32];  
      end                                                           
      8'd19:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[63:48];  
      end                                                           
      8'd20:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[79:64];  
      end                                                           
      8'd21:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[95:80];  
      end                                                           
      8'd22:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[111:96]; 
      end                                                           
      8'd23:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[127:112];
      end                                                           
      8'd24:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[143:128];
      end                                                           
      8'd25:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[159:144];
      end                                                           
      8'd26:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[175:160];
      end                                                           
      8'd27:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[191:176];
      end                                                           
      8'd28:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[207:192];
      end                                                           
      8'd29:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[223:208];
      end                                                           
      8'd30:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[239:224];
      end                                                           
      8'd31:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s2[255:240];
      end                          
      8'd32: 
      begin                   
      	  data_16channel[31:16] <= data_from_serdes_s3[15:0];   
      end                                                           
      8'd33:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[31:16];  
      end                                                           
      8'd34:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[47:32];  
      end                                                           
      8'd35:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[63:48];  
      end                                                           
      8'd36:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[79:64];  
      end                                                           
      8'd37:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[95:80];  
      end                                                           
      8'd38:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[111:96]; 
      end                                                           
      8'd39:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[127:112];
      end                                                           
      8'd40:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[143:128];
      end                                                           
      8'd41:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[159:144];
      end                                                           
      8'd42:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[175:160];
      end                                                           
      8'd43:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[191:176];
      end                                                           
      8'd44:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[207:192];
      end                                                           
      8'd45:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[223:208];
      end                                                           
      8'd46:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[239:224];
      end                                                           
      8'd47:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s3[255:240];
      end                          
      8'd48: 
      begin                   
      	  data_16channel[31:16] <= data_from_serdes_s4[15:0];   
      end                                                           
      8'd49:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[31:16];  
      end                                                           
      8'd50:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[47:32];  
      end                                                           
      8'd51:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[63:48];  
      end                                                           
      8'd52:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[79:64];  
      end                                                           
      8'd53:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[95:80];  
      end                                                           
      8'd54:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[111:96]; 
      end                                                           
      8'd55:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[127:112];
      end                                                           
      8'd56:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[143:128];
      end                                                           
      8'd57:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[159:144];
      end                                                           
      8'd58:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[175:160];
      end                                                           
      8'd59:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[191:176];
      end                                                           
      8'd60:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[207:192];
      end                                                           
      8'd61:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[223:208];
      end                                                           
      8'd62:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[239:224];
      end                                                           
      8'd63:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s4[255:240];
      end                          
      8'd64: 
      begin                   
      	  data_16channel[31:16] <= data_from_serdes_s5[15:0];   
      end                                                           
      8'd65:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[31:16];  
      end                                                           
      8'd66:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[47:32];  
      end                                                           
      8'd67:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[63:48];  
      end                                                           
      8'd68:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[79:64];  
      end                                                           
      8'd69:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[95:80];  
      end                                                           
      8'd70:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[111:96]; 
      end                                                           
      8'd71:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[127:112];
      end                                                           
      8'd72:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[143:128];
      end                                                           
      8'd73:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[159:144];
      end                                                           
      8'd74:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[175:160];
      end                                                           
      8'd75:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[191:176];
      end                                                           
      8'd76:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[207:192];
      end                                                           
      8'd77:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[223:208];
      end                                                           
      8'd78:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[239:224];
      end                                                           
      8'd79:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s5[255:240];
      end                          
      8'd80: 
      begin                   
      	  data_16channel[31:16] <= data_from_serdes_s6[15:0];   
      end                                                           
      8'd81:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[31:16];  
      end                                                           
      8'd82:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[47:32];  
      end                                                           
      8'd83:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[63:48];  
      end                                                           
      8'd84:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[79:64];  
      end                                                           
      8'd85:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[95:80];  
      end                                                           
      8'd86:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[111:96]; 
      end                                                           
      8'd87:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[127:112];
      end                                                           
      8'd88:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[143:128];
      end                                                           
      8'd89:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[159:144];
      end                                                           
      8'd90:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[175:160];
      end                                                           
      8'd91:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[191:176];
      end                                                           
      8'd92:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[207:192];
      end                                                           
      8'd93:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[223:208];
      end                                                           
      8'd94:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[239:224];
      end                                                           
      8'd95:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s6[255:240];
      end                          
      8'd96: 
      begin                   
      	  data_16channel[31:16] <= data_from_serdes_s7[15:0];   
      end                                                           
      8'd97:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[31:16];  
      end                                                           
      8'd98:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[47:32];  
      end                                                           
      8'd99:                                                    
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[63:48];  
      end                                                           
      8'd100:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[79:64];  
      end                                                           
      8'd101:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[95:80];  
      end                                                           
      8'd102:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[111:96]; 
      end                                                           
      8'd103:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[127:112];
      end                                                           
      8'd104:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[143:128];
      end                                                           
      8'd105:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[159:144];
      end                                                           
      8'd106:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[175:160];
      end                                                           
      8'd107:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[191:176];
      end                                                           
      8'd108:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[207:192];
      end                                                           
      8'd109:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[223:208];
      end                                                           
      8'd110:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[239:224];
      end                                                           
      8'd111:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s7[255:240];
      end                          
      8'd112:
      begin                   
      	  data_16channel[31:16] <= data_from_serdes_s8[15:0];   
      end                                                           
      8'd113:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[31:16];  
      end                                                           
      8'd114:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[47:32];  
      end                                                           
      8'd115:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[63:48];  
      end                                                           
      8'd116:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[79:64];  
      end                                                           
      8'd117:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[95:80];  
      end                                                           
      8'd118:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[111:96]; 
      end                                                           
      8'd119:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[127:112];
      end                                                           
      8'd120:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[143:128];
      end                                                           
      8'd121:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[159:144];
      end                                                           
      8'd122:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[175:160];
      end                                                           
      8'd123:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[191:176];
      end                                                           
      8'd124:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[207:192];
      end                                                           
      8'd125:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[223:208];
      end                                                           
      8'd126:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[239:224];
      end                                                           
      8'd127:                                                   
      begin                                                    
      	  data_16channel[31:16] <= data_from_serdes_s8[255:240];
      end  
      */                        
      default:
      begin
      	 data_16channel[31:16] <= 16'h11;
      end      
      	  	 
    endcase	
end 
//��2���洢ͨ������ѡ��
always @(  adc_tx_clk  )
begin
	  case(set_channel_id0[23:16])
	    8'd0:  
      begin                   
      	  data_16channel[47:32] <= data_from_serdes_s1[15:0]; 
      end                                                         
      8'd1:                                                   
      begin                                                   
      	  data_16channel[47:32] <= data_from_serdes_s1[31:16];
      end                                                         
      8'd2:                                                   
      begin                                                   
      	  data_16channel[47:32] <= data_from_serdes_s2[15:0]; 
      end                                                         
      8'd3:                                                   
      begin                                                   
      	  data_16channel[47:32] <= data_from_serdes_s2[31:16];
      end                                                         
      8'd4:                                                   
      begin                                                   
      	  data_16channel[47:32] <= data_from_serdes_s3[15:0]; 
      end                                                         
      8'd5:                                                   
      begin                                                   
      	  data_16channel[47:32] <= data_from_serdes_s3[31:16];
      end                                                         
      8'd6:                                                   
      begin                                                   
      	  data_16channel[47:32] <= data_from_serdes_s4[15:0]; 
      end                                                         
      8'd7:                                                   
      begin                                                   
      	  data_16channel[47:32] <= data_from_serdes_s4[31:16];
      end 
      /*                                                          
      8'd8:                                                     
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s1[143:128];
      end                                                           
      8'd9:                                                     
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s1[159:144];
      end                                                           
      8'd10:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s1[175:160];
      end                                                           
      8'd11:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s1[191:176];
      end                                                           
      8'd12:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s1[207:192];
      end                                                           
      8'd13:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s1[223:208];
      end                                                           
      8'd14:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s1[239:224];
      end                                                           
      8'd15:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s1[255:240];
      end                          
      8'd16: 
      begin                   
      	  data_16channel[47:32] <= data_from_serdes_s2[15:0];   
      end                                                           
      8'd17:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[31:16];  
      end                                                           
      8'd18:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[47:32];  
      end                                                           
      8'd19:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[63:48];  
      end                                                           
      8'd20:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[79:64];  
      end                                                           
      8'd21:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[95:80];  
      end                                                           
      8'd22:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[111:96]; 
      end                                                           
      8'd23:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[127:112];
      end                                                           
      8'd24:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[143:128];
      end                                                           
      8'd25:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[159:144];
      end                                                           
      8'd26:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[175:160];
      end                                                           
      8'd27:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[191:176];
      end                                                           
      8'd28:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[207:192];
      end                                                           
      8'd29:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[223:208];
      end                                                           
      8'd30:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[239:224];
      end                                                           
      8'd31:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s2[255:240];
      end                          
      8'd32: 
      begin                   
      	  data_16channel[47:32] <= data_from_serdes_s3[15:0];   
      end                                                           
      8'd33:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[31:16];  
      end                                                           
      8'd34:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[47:32];  
      end                                                           
      8'd35:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[63:48];  
      end                                                           
      8'd36:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[79:64];  
      end                                                           
      8'd37:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[95:80];  
      end                                                           
      8'd38:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[111:96]; 
      end                                                           
      8'd39:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[127:112];
      end                                                           
      8'd40:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[143:128];
      end                                                           
      8'd41:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[159:144];
      end                                                           
      8'd42:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[175:160];
      end                                                           
      8'd43:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[191:176];
      end                                                           
      8'd44:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[207:192];
      end                                                           
      8'd45:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[223:208];
      end                                                           
      8'd46:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[239:224];
      end                                                           
      8'd47:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s3[255:240];
      end                          
      8'd48: 
      begin                   
      	  data_16channel[47:32] <= data_from_serdes_s4[15:0];   
      end                                                           
      8'd49:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[31:16];  
      end                                                           
      8'd50:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[47:32];  
      end                                                           
      8'd51:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[63:48];  
      end                                                           
      8'd52:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[79:64];  
      end                                                           
      8'd53:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[95:80];  
      end                                                           
      8'd54:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[111:96]; 
      end                                                           
      8'd55:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[127:112];
      end                                                           
      8'd56:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[143:128];
      end                                                           
      8'd57:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[159:144];
      end                                                           
      8'd58:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[175:160];
      end                                                           
      8'd59:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[191:176];
      end                                                           
      8'd60:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[207:192];
      end                                                           
      8'd61:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[223:208];
      end                                                           
      8'd62:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[239:224];
      end                                                           
      8'd63:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s4[255:240];
      end                          
      8'd64: 
      begin                   
      	  data_16channel[47:32] <= data_from_serdes_s5[15:0];   
      end                                                           
      8'd65:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[31:16];  
      end                                                           
      8'd66:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[47:32];  
      end                                                           
      8'd67:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[63:48];  
      end                                                           
      8'd68:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[79:64];  
      end                                                           
      8'd69:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[95:80];  
      end                                                           
      8'd70:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[111:96]; 
      end                                                           
      8'd71:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[127:112];
      end                                                           
      8'd72:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[143:128];
      end                                                           
      8'd73:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[159:144];
      end                                                           
      8'd74:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[175:160];
      end                                                           
      8'd75:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[191:176];
      end                                                           
      8'd76:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[207:192];
      end                                                           
      8'd77:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[223:208];
      end                                                           
      8'd78:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[239:224];
      end                                                           
      8'd79:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s5[255:240];
      end                          
      8'd80: 
      begin                   
      	  data_16channel[47:32] <= data_from_serdes_s6[15:0];   
      end                                                           
      8'd81:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[31:16];  
      end                                                           
      8'd82:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[47:32];  
      end                                                           
      8'd83:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[63:48];  
      end                                                           
      8'd84:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[79:64];  
      end                                                           
      8'd85:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[95:80];  
      end                                                           
      8'd86:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[111:96]; 
      end                                                           
      8'd87:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[127:112];
      end                                                           
      8'd88:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[143:128];
      end                                                           
      8'd89:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[159:144];
      end                                                           
      8'd90:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[175:160];
      end                                                           
      8'd91:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[191:176];
      end                                                           
      8'd92:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[207:192];
      end                                                           
      8'd93:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[223:208];
      end                                                           
      8'd94:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[239:224];
      end                                                           
      8'd95:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s6[255:240];
      end                          
      8'd96: 
      begin                   
      	  data_16channel[47:32] <= data_from_serdes_s7[15:0];   
      end                                                           
      8'd97:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[31:16];  
      end                                                           
      8'd98:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[47:32];  
      end                                                           
      8'd99:                                                    
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[63:48];  
      end                                                           
      8'd100:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[79:64];  
      end                                                           
      8'd101:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[95:80];  
      end                                                           
      8'd102:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[111:96]; 
      end                                                           
      8'd103:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[127:112];
      end                                                           
      8'd104:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[143:128];
      end                                                           
      8'd105:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[159:144];
      end                                                           
      8'd106:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[175:160];
      end                                                           
      8'd107:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[191:176];
      end                                                           
      8'd108:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[207:192];
      end                                                           
      8'd109:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[223:208];
      end                                                           
      8'd110:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[239:224];
      end                                                           
      8'd111:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s7[255:240];
      end                          
      8'd112:
      begin                   
      	  data_16channel[47:32] <= data_from_serdes_s8[15:0];   
      end                                                           
      8'd113:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[31:16];  
      end                                                           
      8'd114:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[47:32];  
      end                                                           
      8'd115:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[63:48];  
      end                                                           
      8'd116:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[79:64];  
      end                                                           
      8'd117:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[95:80];  
      end                                                           
      8'd118:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[111:96]; 
      end                                                           
      8'd119:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[127:112];
      end                                                           
      8'd120:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[143:128];
      end                                                           
      8'd121:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[159:144];
      end                                                           
      8'd122:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[175:160];
      end                                                           
      8'd123:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[191:176];
      end                                                           
      8'd124:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[207:192];
      end                                                           
      8'd125:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[223:208];
      end                                                           
      8'd126:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[239:224];
      end                                                           
      8'd127:                                                   
      begin                                                    
      	  data_16channel[47:32] <= data_from_serdes_s8[255:240];
      end
      */                          
      default:
      begin
      	 data_16channel[47:32] <= 16'h22;
      end      
      	  	 
    endcase	
end

//��3���洢ͨ������ѡ��
always @(  adc_tx_clk  )
begin
	  case(set_channel_id0[31:24])
	    8'd0:  
      begin                   
      	  data_16channel[63:48] <= data_from_serdes_s1[15:0]; 
      end                                                         
      8'd1:                                                   
      begin                                                   
      	  data_16channel[63:48] <= data_from_serdes_s1[31:16];
      end                                                         
      8'd2:                                                   
      begin                                                   
      	  data_16channel[63:48] <= data_from_serdes_s2[15:0]; 
      end                                                         
      8'd3:                                                   
      begin                                                   
      	  data_16channel[63:48] <= data_from_serdes_s2[31:16];
      end                                                         
      8'd4:                                                   
      begin                                                   
      	  data_16channel[63:48] <= data_from_serdes_s3[15:0]; 
      end                                                         
      8'd5:                                                   
      begin                                                   
      	  data_16channel[63:48] <= data_from_serdes_s3[31:16];
      end                                                         
      8'd6:                                                   
      begin                                                   
      	  data_16channel[63:48] <= data_from_serdes_s4[15:0]; 
      end                                                         
      8'd7:                                                   
      begin                                                   
      	  data_16channel[63:48] <= data_from_serdes_s4[31:16];
      end  
      /*                                                         
      8'd8:                                                     
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s1[143:128];
      end                                                           
      8'd9:                                                     
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s1[159:144];
      end                                                           
      8'd10:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s1[175:160];
      end                                                           
      8'd11:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s1[191:176];
      end                                                           
      8'd12:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s1[207:192];
      end                                                           
      8'd13:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s1[223:208];
      end                                                           
      8'd14:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s1[239:224];
      end                                                           
      8'd15:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s1[255:240];
      end                          
      8'd16: 
      begin                   
      	  data_16channel[63:48] <= data_from_serdes_s2[15:0];   
      end                                                           
      8'd17:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[31:16];  
      end                                                           
      8'd18:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[47:32];  
      end                                                           
      8'd19:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[63:48];  
      end                                                           
      8'd20:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[79:64];  
      end                                                           
      8'd21:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[95:80];  
      end                                                           
      8'd22:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[111:96]; 
      end                                                           
      8'd23:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[127:112];
      end                                                           
      8'd24:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[143:128];
      end                                                           
      8'd25:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[159:144];
      end                                                           
      8'd26:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[175:160];
      end                                                           
      8'd27:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[191:176];
      end                                                           
      8'd28:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[207:192];
      end                                                           
      8'd29:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[223:208];
      end                                                           
      8'd30:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[239:224];
      end                                                           
      8'd31:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s2[255:240];
      end                          
      8'd32: 
      begin                   
      	  data_16channel[63:48] <= data_from_serdes_s3[15:0];   
      end                                                           
      8'd33:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[31:16];  
      end                                                           
      8'd34:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[47:32];  
      end                                                           
      8'd35:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[63:48];  
      end                                                           
      8'd36:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[79:64];  
      end                                                           
      8'd37:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[95:80];  
      end                                                           
      8'd38:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[111:96]; 
      end                                                           
      8'd39:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[127:112];
      end                                                           
      8'd40:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[143:128];
      end                                                           
      8'd41:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[159:144];
      end                                                           
      8'd42:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[175:160];
      end                                                           
      8'd43:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[191:176];
      end                                                           
      8'd44:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[207:192];
      end                                                           
      8'd45:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[223:208];
      end                                                           
      8'd46:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[239:224];
      end                                                           
      8'd47:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s3[255:240];
      end                          
      8'd48: 
      begin                   
      	  data_16channel[63:48] <= data_from_serdes_s4[15:0];   
      end                                                           
      8'd49:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[31:16];  
      end                                                           
      8'd50:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[47:32];  
      end                                                           
      8'd51:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[63:48];  
      end                                                           
      8'd52:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[79:64];  
      end                                                           
      8'd53:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[95:80];  
      end                                                           
      8'd54:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[111:96]; 
      end                                                           
      8'd55:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[127:112];
      end                                                           
      8'd56:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[143:128];
      end                                                           
      8'd57:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[159:144];
      end                                                           
      8'd58:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[175:160];
      end                                                           
      8'd59:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[191:176];
      end                                                           
      8'd60:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[207:192];
      end                                                           
      8'd61:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[223:208];
      end                                                           
      8'd62:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[239:224];
      end                                                           
      8'd63:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s4[255:240];
      end                          
      8'd64: 
      begin                   
      	  data_16channel[63:48] <= data_from_serdes_s5[15:0];   
      end                                                           
      8'd65:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[31:16];  
      end                                                           
      8'd66:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[47:32];  
      end                                                           
      8'd67:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[63:48];  
      end                                                           
      8'd68:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[79:64];  
      end                                                           
      8'd69:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[95:80];  
      end                                                           
      8'd70:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[111:96]; 
      end                                                           
      8'd71:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[127:112];
      end                                                           
      8'd72:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[143:128];
      end                                                           
      8'd73:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[159:144];
      end                                                           
      8'd74:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[175:160];
      end                                                           
      8'd75:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[191:176];
      end                                                           
      8'd76:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[207:192];
      end                                                           
      8'd77:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[223:208];
      end                                                           
      8'd78:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[239:224];
      end                                                           
      8'd79:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s5[255:240];
      end                          
      8'd80: 
      begin                   
      	  data_16channel[63:48] <= data_from_serdes_s6[15:0];   
      end                                                           
      8'd81:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[31:16];  
      end                                                           
      8'd82:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[47:32];  
      end                                                           
      8'd83:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[63:48];  
      end                                                           
      8'd84:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[79:64];  
      end                                                           
      8'd85:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[95:80];  
      end                                                           
      8'd86:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[111:96]; 
      end                                                           
      8'd87:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[127:112];
      end                                                           
      8'd88:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[143:128];
      end                                                           
      8'd89:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[159:144];
      end                                                           
      8'd90:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[175:160];
      end                                                           
      8'd91:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[191:176];
      end                                                           
      8'd92:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[207:192];
      end                                                           
      8'd93:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[223:208];
      end                                                           
      8'd94:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[239:224];
      end                                                           
      8'd95:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s6[255:240];
      end                          
      8'd96: 
      begin                   
      	  data_16channel[63:48] <= data_from_serdes_s7[15:0];   
      end                                                           
      8'd97:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[31:16];  
      end                                                           
      8'd98:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[47:32];  
      end                                                           
      8'd99:                                                    
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[63:48];  
      end                                                           
      8'd100:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[79:64];  
      end                                                           
      8'd101:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[95:80];  
      end                                                           
      8'd102:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[111:96]; 
      end                                                           
      8'd103:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[127:112];
      end                                                           
      8'd104:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[143:128];
      end                                                           
      8'd105:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[159:144];
      end                                                           
      8'd106:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[175:160];
      end                                                           
      8'd107:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[191:176];
      end                                                           
      8'd108:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[207:192];
      end                                                           
      8'd109:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[223:208];
      end                                                           
      8'd110:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[239:224];
      end                                                           
      8'd111:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s7[255:240];
      end                          
      8'd112:
      begin                   
      	  data_16channel[63:48] <= data_from_serdes_s8[15:0];   
      end                                                           
      8'd113:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[31:16];  
      end                                                           
      8'd114:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[47:32];  
      end                                                           
      8'd115:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[63:48];  
      end                                                           
      8'd116:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[79:64];  
      end                                                           
      8'd117:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[95:80];  
      end                                                           
      8'd118:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[111:96]; 
      end                                                           
      8'd119:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[127:112];
      end                                                           
      8'd120:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[143:128];
      end                                                           
      8'd121:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[159:144];
      end                                                           
      8'd122:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[175:160];
      end                                                           
      8'd123:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[191:176];
      end                                                           
      8'd124:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[207:192];
      end                                                           
      8'd125:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[223:208];
      end                                                           
      8'd126:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[239:224];
      end                                                           
      8'd127:                                                   
      begin                                                    
      	  data_16channel[63:48] <= data_from_serdes_s8[255:240];
      end
      */                          
      default:
      begin
      	 data_16channel[63:48] <= 16'h33;
      end      
      	  	 
    endcase	
end
endmodule