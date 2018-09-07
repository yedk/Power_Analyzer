`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:10:08 11/03/2016 
// Design Name: 
// Module Name:    Edge_trigger 
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
module Edge_trigger(

	input		[7:0]		rise_edge_data,
	input		[7:0]		fall_edge_data,
	input		[7:0]		rise_or_fall_edge_data,
	input		[3:0]		trig_mode,
	input		[7:0]		A_ch_valid,
	input		[1:0]		A_state,
	input					edge_clk,
	input					rst_n,
	
	output					edge_pulse
    );

	reg			[7:0]		rise_edge_data_reg;
	reg			[7:0]		fall_edge_data_reg;
	reg			[7:0]		rise_or_fall_edge_data_reg;
	reg						edge_pulse_reg;
	
always @(posedge edge_clk or negedge rst_n)
begin
	if(!rst_n)
		rise_edge_data_reg <=8'd0;
	else
		rise_edge_data_reg <= (rise_edge_data & A_ch_valid);
end

always @(posedge edge_clk or negedge rst_n)
begin
	if(!rst_n)
		fall_edge_data_reg <= 8'd0;
	else
		fall_edge_data_reg <= (fall_edge_data & A_ch_valid);
end

always @(posedge edge_clk or negedge rst_n)
begin
	if(!rst_n)
		rise_or_fall_edge_data_reg <= 8'd0;
	else
		rise_or_fall_edge_data_reg <= (rise_or_fall_edge_data & A_ch_valid);
end

always @(posedge edge_clk or negedge rst_n)
begin
	if(!rst_n)
		edge_pulse_reg <= 1'd0;
	else if(trig_mode[3:0] == 4'd0)
	    case(A_state)
	    	2'b10:
	    		edge_pulse_reg <= |rise_or_fall_edge_data_reg;
			2'b01:
				edge_pulse_reg <= |rise_edge_data_reg;
			2'b00:	
				edge_pulse_reg <= |fall_edge_data_reg;
			default:edge_pulse_reg <= 1'd0;
		endcase
	else
		edge_pulse_reg <= 1'd0;
end		

assign edge_pulse = edge_pulse_reg;
		

endmodule
