`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:28:43 11/02/2016 
// Design Name: 
// Module Name:    rise_edge_detect 
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
module rise_edge_detect(
	input 		[1:0]		data_in,
	input					rst_n,
	input					rise_edge_clk,
	
	output		[1:0]		edge_pulse
    );
    
    reg 		[1:0]		data_in_dly;
    reg 		[1:0]		edge_pulse_reg;

always@(posedge rise_edge_clk or negedge rst_n)
begin
	if(!rst_n)
	data_in_dly <= 2'd0;
	else
	data_in_dly <= data_in;
end

always@(posedge rise_edge_clk or negedge rst_n)
begin
	if(!rst_n)
	edge_pulse_reg <= 2'd0;
	else
	edge_pulse_reg <= ((~data_in_dly) & (data_in));
end

assign	edge_pulse = edge_pulse_reg;
endmodule
