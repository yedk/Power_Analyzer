`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:38:04 03/23/2017 
// Design Name: 
// Module Name:    auto_trig_level 
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
module auto_trig_level
#(parameter time_up =	100)
(

input					clk_1KHz,
input					clk,
input					rst_n,
input		[15:0]		data,
input					trigger,

output		[15:0]		auto_trig_level
    );

reg				clk_1KHz_reg;
reg 	[9:0]	cnt;
reg		[15:0]	data_max,data_min;
reg				clr_flag,clr_flag_reg;

reg     [16:0]	sum;

assign	auto_trig_level = sum[16:1];

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		sum <= 17'd0;
	else
		sum <= data_max + data_min;
end	

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		{clr_flag,clr_flag_reg}<= 2'b0;
	else
	begin
		if(cnt >= time_up)
			clr_flag <= 1'b1;
		else
			clr_flag <= 1'b0;
		
		clr_flag_reg <= clr_flag;	
	end			
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		clk_1KHz_reg<= 1'b0;
	else
		clk_1KHz_reg<=clk_1KHz;
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		cnt <= 10'd0;	
	end
	else if(trigger == 1'b1)
	begin
		cnt <= 10'd0;	
	end
	else if(cnt >= time_up)		 
	begin
		cnt <= 10'd0;
	end
	else if((~clk_1KHz_reg)&clk_1KHz)
	begin
		cnt <= cnt+1'b1;
	end
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		{data_max,data_min} <= {data,data};
	end
	else
	begin 
		if((~clr_flag_reg)&clr_flag)
		begin
			{data_max,data_min} <= {data,data};
		end
		else
		begin
			if(data > data_max)
				data_max <= data;
			else
				data_max <= data_max;
				
			if(data < data_min)	
				data_min <= data;
			else
				data_min <= data_min;
		end
	end
end




endmodule
