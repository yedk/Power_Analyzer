`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:39:04 12/20/2017 
// Design Name: 
// Module Name:    gate_time_cnt 
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
module gate_time_cnt(

	input		            rst_n,
	input               clkin,
	input		    [31:0]	gate_vaule,    //N ㊣赤那?N*10ns
	output  reg         cnt_gate,    
	output	reg         gate_status
	);


reg [31:0]   data_cnt;  

always @(posedge clkin )
begin
	if(!rst_n)
	begin
		data_cnt <= 32'd0;
		cnt_gate <= 1'd0;
	end
  else if( data_cnt <= gate_vaule)
  begin
  	data_cnt <= data_cnt+32'd1;  
  	cnt_gate <= 1'd1;	
  end
  else
  begin
  	cnt_gate <= 1'd0;
  end
end


//??那y谷豕??那㊣??赤㏒?1??那y

always @(posedge clkin )
begin
	if(!rst_n)
	begin
		gate_status <= 1'd0;
	end
  else if(data_cnt > gate_vaule )
  begin
  	gate_status <= 1'd1;
  end
end

endmodule


