`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:55:58 04/09/2018 
// Design Name: 
// Module Name:    fre_measure 
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
module fre_measure(
      input            clk,
      input            clk_in,
      input            rst_n,
      input      [15:0]N,
                                  
      output reg [31:0]C_out,
      output reg       clkin_up
           
    );

reg [31:0]cnt_mea;
reg [3:0]cnt_clkin;
reg clkin_a;
reg clkin_b;
//reg clkin_up;
reg flag_cnt;
wire [31:0]q;
reg counter_en;
reg [31:0]C;
reg [31:0]C_r;
reg [31:0]C_diff;


//保存clkin当前和以前的状态
always@(posedge clk)
begin
	if(!rst_n)
	  begin
	   	clkin_a <= 0;
	   	clkin_b <= 0;
	  end	
  else
    begin
    	clkin_a <= clk_in;
    	clkin_b <= clkin_a;
    end
	
end

//检查clkin的上升沿
always@(posedge clk)
begin
	if(!rst_n)
	  clkin_up <= 0;
	else if(!clkin_b & clkin_a)
	  clkin_up <= 1'b1;
	else
	  clkin_up <= 0;		
end

always@(posedge clk)
begin
	if(!rst_n)
	  begin
	    cnt_clkin <=0;
	    flag_cnt <=0;
	  end
	else if((cnt_clkin > 4'd3) & clkin_up)
	  begin
	    cnt_clkin <=1;
	    flag_cnt <=1;
	  end
	else if(clkin_up)
	  begin
	  	cnt_clkin <= cnt_clkin + 1'b1;
	  	flag_cnt <=0;
	  end
	else
	  begin
	  	cnt_clkin <= cnt_clkin;
	  	flag_cnt <=0;
	  end
		
end

always@(posedge clk)
begin
	if(!rst_n)
	  counter_en <=0;
	else if(clkin_up)
	  counter_en <=1;
	else
	  counter_en <= counter_en;
end



//累加计数
fre_acc fre_acc (
  .CLK(clk),    // input wire CLK
  .CE(counter_en),      // input wire CE
  .SCLR(flag_cnt || !rst_n),  // input wire SCLR
  .Q(q)        // output wire [31 : 0] Q
);

always@(posedge clk)
begin
	if(!rst_n)
	  cnt_mea <= 0;
	else if(flag_cnt)
	  cnt_mea <= q + 1'b1;
	else
	  cnt_mea <= cnt_mea;		
end

//将测量4个周期取平均值
always@(posedge clk)
begin
	if(!rst_n)
	  C <=0;
	else if(flag_cnt)
	  C <= {{2'b00},cnt_mea[31:2]};	
	else
	  C <= C;	
end

 

always@(posedge clk)
begin
	if(!rst_n)
	  begin
	    C_diff <= 0;
	    C_r <= 0;
	  end
	else if(flag_cnt)
	  begin
	  	C_r <= C;
	  	if(C_r >= C)
	  	  C_diff <= C_r -C;
	  	else
	  	  C_diff <= C -C_r;
	  end
	else
	  begin
	  	C_diff <= C_diff;
	  	C_r <= C_r;
	  end
	
end

always@(posedge clk)
begin
	if(!rst_n)
	  C_out <=0;
	else if(C_diff > N)
	  C_out <= C;
	else
	  C_out <= C_r;
end

endmodule
