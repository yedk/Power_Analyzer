`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:25:50 09/27/2016 
// Design Name: 
// Module Name:    data_gen 
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
module data_gen(
input clk,
input rst_L,
input [15:0] delay_dat,
input [31:0] add_dat,
input [15:0] ch00_inst,
input [15:0] ch01_inst,

output reg [31:0] adc_dat
    );

reg [15:0]ch0,ch1;

reg [31:0] adc_dat_reg;

reg [15:0] count_reg;	
reg count_enable; 

always @(posedge clk)
begin
	 if(!rst_L)
	 begin
	 	count_reg <= 16'd0;
	 	count_enable <= 0;
    end
	 else if(count_reg == delay_dat) begin
	 	count_reg <= 16'd0;
	 	count_enable <= 1;
	 end
	 else begin
	 	count_reg <= count_reg+1;
		count_enable <= 0;	 		  
	 end
end

always @(posedge clk)
begin
	 if(!rst_L)
	 begin
	    ch0 <= ch00_inst;
	    ch1 <= ch01_inst;
	 end
	 else if(count_enable)
	 begin
		   ch0 <=  ch0 + add_dat[15:0];
       ch1 <=  ch1 + add_dat[31:16];//触发相关不能动         
	 end
	 else
	 begin
		   ch0 <=  ch0;
       ch1 <=  ch1;//触发相关不能动            
	 end           
	 adc_dat_reg <= {ch1,ch0}; 
   adc_dat <= adc_dat_reg;         
                                                               
end
endmodule
                              