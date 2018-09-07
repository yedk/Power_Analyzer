`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:53:33 11/08/2016 
// Design Name: 
// Module Name:    Period_trigger 
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
module Period_trigger(

input		[31:0]		trig_mode,
input					A_level_state_data,
input		[143:0]		B_ch_valid,             //T1 OR TIME
input		[143:0]		B_state,				//T2
input					Period_clk,
input					rst_n,

output					Period_pulse

    );
    
parameter		IDLE = 2'b01;
parameter		WAIT = 2'b10;

reg			[1:0]		state;
reg			[143:0]		cnt;
reg			[143:0]		cnt_dly;
reg						Period_pulse_reg;
reg						A_level_state_data_dly;
reg						A_level_state_data_rise;

always  @(posedge Period_clk or negedge rst_n)
begin
	if(!rst_n)
		cnt_dly <= 'd0;
	else 
		cnt_dly <= cnt;	
end

always  @(posedge Period_clk or negedge rst_n)
begin
	if(!rst_n)
		A_level_state_data_dly <= 1'd0;
	else 
		A_level_state_data_dly <= A_level_state_data;	
end

always  @(posedge Period_clk or negedge rst_n)
begin
	if(!rst_n)
		A_level_state_data_rise <= 1'd0;
	else 
		A_level_state_data_rise <= (A_level_state_data)&&(!A_level_state_data_dly);	
end



///////FSM////////
always  @(posedge Period_clk or negedge rst_n)
begin
	if(!rst_n)
		state <= IDLE;
	else begin
	   case(state)
			IDLE: if(A_level_state_data == 1'd1)
					state <= WAIT;
			WAIT: 	state <= WAIT;
			default: state <= IDLE;
		endcase	
	end
end

always  @(posedge Period_clk or negedge rst_n)
begin
	if(!rst_n)
		cnt <= 144'd0;
	else if((state == WAIT)&&(A_level_state_data == 1'd1))
		cnt <= 144'd0;
	else if(state == WAIT)
		cnt <= cnt + 1'b1;		
end


//用cnt_dly信号是因为检查上升沿会延迟一个脉冲，cnt必须延迟一个脉冲才可以对齐
always  @(posedge Period_clk or negedge rst_n)
begin
	if(!rst_n)
		Period_pulse_reg <= 1'd0;
	else if((trig_mode[3:0] == 4'd6)&&(state == WAIT)&&(A_level_state_data_rise == 1'd1))
	begin 
		case(trig_mode[8:7])
			2'b00: if(cnt_dly < B_ch_valid)
						Period_pulse_reg <= 1'd1;
				   else
						Period_pulse_reg <= 1'd0;
			2'b01: if(cnt_dly > B_ch_valid)
						Period_pulse_reg <= 1'd1;
				   else
						Period_pulse_reg <= 1'd0;
			2'b10: if((cnt_dly > B_ch_valid)&&(cnt_dly < B_state))
						Period_pulse_reg <= 1'd1;
				   else
						Period_pulse_reg <= 1'd0;
			2'b11: if((cnt_dly < B_ch_valid)||(cnt_dly > B_state))
						Period_pulse_reg <= 1'd1;
				   else
						Period_pulse_reg <= 1'd0;
			default: Period_pulse_reg <= 1'd0; 
		endcase
	end
	else
		Period_pulse_reg <= 1'd0;
end

assign Period_pulse = Period_pulse_reg;

endmodule
