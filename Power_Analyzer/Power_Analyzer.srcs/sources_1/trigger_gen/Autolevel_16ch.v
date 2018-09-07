`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:35:51 11/22/2017 
// Design Name: 
// Module Name:    Autolevel_16ch 
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
module Autolevel_16ch(

input					clk_1KHz,
input					clk,
input					rst_n,
input		[31:0]		data,
input					trigger,

output		[15:0]		auto_trig_level_1,
output		[15:0]		auto_trig_level_2
//output		[15:0]		auto_trig_level_3,
//output		[15:0]		auto_trig_level_4,
//output		[15:0]		auto_trig_level_5,
//output		[15:0]		auto_trig_level_6,
//output		[15:0]		auto_trig_level_7,
//output		[15:0]		auto_trig_level_8,
//output		[15:0]		auto_trig_level_9,
//output		[15:0]		auto_trig_level_10,
//output		[15:0]		auto_trig_level_11,
//output		[15:0]		auto_trig_level_12,
//output		[15:0]		auto_trig_level_13,
//output		[15:0]		auto_trig_level_14,
//output		[15:0]		auto_trig_level_15,
//output		[15:0]		auto_trig_level_16
    );


auto_trig_level auto_trig_level_inst1
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[15:0]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_1)
    );

auto_trig_level auto_trig_level_inst2
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[31:16]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_2)
    );

/*    
auto_trig_level auto_trig_level_inst3
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[47:32]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_3)
    );    

auto_trig_level auto_trig_level_inst4
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[63:48]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_4)
    );

auto_trig_level auto_trig_level_inst5
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[79:64]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_5)
    );

auto_trig_level auto_trig_level_inst6
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[95:80]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_6)
    );
    
auto_trig_level auto_trig_level_inst7
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[111:96]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_7)
    );
    
auto_trig_level auto_trig_level_inst8
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[127:112]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_8)
    );
    
auto_trig_level auto_trig_level_inst9
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[143:128]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_9)
    );
    
auto_trig_level auto_trig_level_inst10
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[159:144]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_10)
    );
    
auto_trig_level auto_trig_level_inst11
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[175:160]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_11)
    );
    
auto_trig_level auto_trig_level_inst12
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[191:176]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_12)
    );
    
auto_trig_level auto_trig_level_inst13
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[207:192]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_13)
    );
    
auto_trig_level auto_trig_level_inst14
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[223:208]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_14)
    );
    
auto_trig_level auto_trig_level_inst15
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[239:224]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_15)
    );
    
auto_trig_level auto_trig_level_inst16
(

	.clk_1KHz(clk_1KHz),
	.clk(trig_clk),
	.rst_n(trig_rst_n),
	.data(data[255:240]),
	.trigger(trig_out),
	
	.auto_trig_level(auto_trig_level_16)
    );            
*/            
                        
endmodule
