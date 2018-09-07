`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:26:11 11/04/2016 
// Design Name: 
// Module Name:    Edge_detect_128ch 
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
module Edge_detect_143ch(    

	input		[7:0]		nomal_mode_data,           
	input					trig_rst_n,                
	input					edge_clk,             
	                                              
	output		[7:0]		rise_edge,            
	output		[7:0]		fall_edge,            
	output		[7:0]		rise_or_fall_edge     


    );

Edge_detect Edge_detect_inst1(
	.nomal_data(nomal_mode_data[1:0]),
	.rst_n(trig_rst_n),
	.edge_clk(edge_clk),
	
	.rise_edge(rise_edge[1:0]),
	.fall_edge(fall_edge[1:0]),
	.rise_or_fall_edge(rise_or_fall_edge[1:0])
    );
    
Edge_detect Edge_detect_inst2(
	.nomal_data(nomal_mode_data[3:2]),
	.rst_n(trig_rst_n),
	.edge_clk(edge_clk),
	
	.rise_edge(rise_edge[3:2]),
	.fall_edge(fall_edge[3:2]),
	.rise_or_fall_edge(rise_or_fall_edge[3:2])
    );
    
Edge_detect Edge_detect_inst3(
	.nomal_data(nomal_mode_data[5:4]),
	.rst_n(trig_rst_n),
	.edge_clk(edge_clk),
	
	.rise_edge(rise_edge[5:4]),
	.fall_edge(fall_edge[5:4]),
	.rise_or_fall_edge(rise_or_fall_edge[5:4])
    );
 
Edge_detect Edge_detect_inst4(
	.nomal_data(nomal_mode_data[7:6]),
	.rst_n(trig_rst_n),
	.edge_clk(edge_clk),
	
	.rise_edge(rise_edge[7:6]),
	.fall_edge(fall_edge[7:6]),
	.rise_or_fall_edge(rise_or_fall_edge[7:6])
    );
/*    
Edge_detect Edge_detect_inst5(
	.nomal_data(nomal_mode_data[79:64]),
	.rst_n(trig_rst_n),
	.edge_clk(edge_clk),
	
	.rise_edge(rise_edge[79:64]),
	.fall_edge(fall_edge[79:64]),
	.rise_or_fall_edge(rise_or_fall_edge[79:64])
    );
    
Edge_detect Edge_detect_inst6(
	.nomal_data(nomal_mode_data[95:80]),
	.rst_n(trig_rst_n),
	.edge_clk(edge_clk),
	
	.rise_edge(rise_edge[95:80]),
	.fall_edge(fall_edge[95:80]),
	.rise_or_fall_edge(rise_or_fall_edge[95:80])
    );
    
Edge_detect Edge_detect_inst7(
	.nomal_data(nomal_mode_data[111:96]),
	.rst_n(trig_rst_n),
	.edge_clk(edge_clk),
	
	.rise_edge(rise_edge[111:96]),
	.fall_edge(fall_edge[111:96]),
	.rise_or_fall_edge(rise_or_fall_edge[111:96])
    );
    
Edge_detect Edge_detect_inst8(
	.nomal_data(nomal_mode_data[127:112]),
	.rst_n(trig_rst_n),
	.edge_clk(edge_clk),
	
	.rise_edge(rise_edge[127:112]),
	.fall_edge(fall_edge[127:112]),
	.rise_or_fall_edge(rise_or_fall_edge[127:112])
    );
    
Edge_detect Edge_detect_inst9(
	.nomal_data(nomal_mode_data[143:128]),
	.rst_n(trig_rst_n),
	.edge_clk(edge_clk),
	
	.rise_edge(rise_edge[143:128]),
	.fall_edge(fall_edge[143:128]),
	.rise_or_fall_edge(rise_or_fall_edge[143:128])
    );
*/    
endmodule