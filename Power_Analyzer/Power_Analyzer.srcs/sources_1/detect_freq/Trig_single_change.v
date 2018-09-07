`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:04:37 10/28/2016 
// Design Name: 
// Module Name:    Trig_single_change 
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
module Trig_single_change(

input		[15:0]		data,
input		[15:0]		trig_level_l,
input		[15:0]		trig_level_h,
input					    trig_clk,
input					    rst_n,

output					  in_data_out,           //in?¡ê¨º?
output					  out_data_out,          //out?¡ê¨º?
output					nomal_data_out				 //?y3¡ê?¡ê¨º?
    );

reg                     nomal_data_out_reg;
wire					nomal_data_out;

reg                     in_data_out_reg;
wire					in_data_out;

wire					out_data_out;



always@(posedge trig_clk or negedge rst_n )
begin
	if(!rst_n)
	begin
		nomal_data_out_reg <= 1'b0;
	end
	else if(data > trig_level_h)
	begin
		nomal_data_out_reg <= 1'b1;
	end
	else if(data < trig_level_l)
	 begin
    	 nomal_data_out_reg <= 1'b0;
	end
	else
   begin	
		nomal_data_out_reg <= nomal_data_out_reg;
	end
end

always@(posedge trig_clk or negedge rst_n )
begin
	if(!rst_n)
	begin
		in_data_out_reg <= 1'b0;
	end
	else if((data > trig_level_l) && (data < trig_level_h))
	begin
   	in_data_out_reg <= 1'b1;
	end
	else 
	begin
   	in_data_out_reg <= 1'b0;
	end
end

//reg nomal_data_out_reg1;

//always@(posedge trig_clk  )
//begin
//	 nomal_data_out_reg1 <= in_data_out_reg;
//	 nomal_data_out <= nomal_data_out_reg1;	
//end
  
  
assign nomal_data_out = nomal_data_out_reg;
assign in_data_out = in_data_out_reg;
assign out_data_out = ~in_data_out_reg;
endmodule
