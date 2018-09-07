`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:32:59 04/08/2018 
// Design Name: 
// Module Name:    C_N_frediv 
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
module C_N_frediv(
      input        clk,
      input        rst_n,
      input [31:0] numerator,//分子
      input [15:0] N,//分母
      
      output reg   pulse,
      output reg   change_out
    );
wire [31:0]quotient;  //商
wire [31:0]remainder; //余数
reg [31:0]counter;
reg [31:0]divnum;
reg [31:0]sum;
reg flag;
reg [31:0]counter_pulseh;
reg [31:0]hightime;
wire [31:0]quotient_ip;
wire [31:0]fractional;
wire [31:0]denominator;
wire [63:0]m_axis_dout_tdata;
reg [31:0]quotient_r;
reg [31:0]quotient_diff;
reg [31:0]quotient_right;
reg [31:0]remain_right  ;
reg [31:0]denominator_right;
reg change;


assign denominator = {{16'h0},N};
//除法器	
divide divide (
  .aclk(clk),                                      // input wire aclk
  .s_axis_divisor_tvalid(rst_n),                        // input wire s_axis_divisor_tvalid
  .s_axis_divisor_tdata(denominator),      // input wire [31 : 0] s_axis_divisor_tdata
  .s_axis_dividend_tvalid(rst_n),                    // input wire s_axis_dividend_tvalid
  .s_axis_dividend_tdata(numerator),             // input wire [31 : 0] s_axis_dividend_tdata
  .m_axis_dout_tvalid(m_axis_dout_tvalid),          // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(m_axis_dout_tdata)            // output wire [63 : 0] m_axis_dout_tdata
);

assign quotient_ip = m_axis_dout_tdata[63:32];
assign fractional = m_axis_dout_tdata[31:0];

assign quotient  = (denominator) ? quotient_ip : 16'h0;
assign remainder = (denominator) ? fractional  : 16'h0;


//检测除法结果变化
always@(posedge clk)
begin
	if(counter >= divnum)
	   quotient_r <= quotient;
	else
	   quotient_r <= quotient_r;
end

always@(posedge clk)
begin
	if(!rst_n)	 
	  quotient_diff <=0;
	else if(quotient_r >= quotient)
	  quotient_diff <= quotient_r - quotient;
	else
	  quotient_diff <= quotient - quotient_r;

end

always@(posedge clk)
begin
	if(!rst_n)
	  begin
	    change <= 0;
	    change_out <= 0;
	  end
	else if(quotient_diff >= 1'd1)
	  begin
	  	change <= 1;
	  	change_out <= 1;
	  end
	else if(counter >= divnum)	 
	  begin
	  	change <= 0;
	  	change_out <= 0;
	  end
	else
	  begin
	  	change <= change;
	  	change_out <= 0;
	  end
end

always@(posedge clk)
begin
	if(!rst_n)
	  begin
	  	quotient_right    <= 0;
      remain_right      <= 0;
      denominator_right <= 0;
      hightime          <= 0;
    end
  else if(counter >= divnum)
    begin
    	quotient_right    <= quotient;
      remain_right      <= remainder;
      denominator_right <= denominator;
      hightime          <= {1'b0, quotient[31:1]};
    end
  else
    begin
    	quotient_right    <= quotient_right;
      remain_right      <= remain_right;
      denominator_right <= denominator_right;
      hightime          <= hightime;
    end
end 


//计数器b
always@(posedge clk)
begin
	if(!rst_n)
	  counter <= 0;
	else if (counter >= divnum )
	  counter <= 0;
	else
	  counter <= counter + 1'b1;	
end


always@(posedge clk)
begin
	if(!rst_n)
	  begin
	  	sum <= 0;
	  	flag <= 0;
	  end
	else if(counter >= divnum)
	  begin
	  	if(change)
	  	  begin
	  	    sum  <= 0;
	  	    flag <= 0;
	  	  end
	  	else if((sum + remain_right) >= denominator_right)
	  	  begin
	  	  	sum <= sum + remain_right - denominator_right;
	  	  	flag <=1;
	  	  end
	  	else
	  	  begin
	  	  	sum <= sum + remain_right;
	  	  	flag <= 0;
	  	  end
	  end
	else
	  begin
	  	sum <= sum;
	  	flag <= flag;
	  end	
end

//构建2种计数阈值
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
	  divnum <= 0;
	else if(flag)
	  divnum <= quotient;
	else
	  divnum <= quotient -1;		
end


//产生时钟
always@(posedge clk)
begin
	if(!rst_n)
	  counter_pulseh <= 0;
	else if(counter >= divnum) 
	  counter_pulseh <= 0;
	else
	  counter_pulseh <= counter_pulseh + 1'b1;
			
end

always@(posedge clk)
begin
	if(!rst_n)
	  pulse <= 0;
	else if(counter_pulseh > hightime -1)
	  pulse <= 1;
	else
	  pulse <= 0;
		
end



endmodule
