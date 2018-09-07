`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 19:49:00
// Design Name: 
// Module Name: fre_double_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fre_double_module(
      input         clk_200M,//系统时钟
      input         CARD1_VOL_FREQ, 
      input         CARD1_CUR_FREQ,
      input         CARD2_VOL_FREQ,
      input         CARD2_CUR_FREQ,
      input         CARD3_VOL_FREQ,
      input         CARD3_CUR_FREQ,
      
//      input         clk_in, //输入信号
      input         rst_n,
      input    [2:0]fre_choose,
                 
                 
      output        clk_out,
      output        clkout_change,
      output  [31:0]C,
      output        clkin_up
      
      
    );
    
    
wire [31:0]C;
reg        rst_n_r1;
reg        rst_n_r2;
reg        clk_in_r;
reg  [15:0]N_r;

reg  [15:0]N;
reg clk_in;

always@(posedge clk_200M)
begin
	if(!rst_n)
	  clk_in <= 0;
	else
	  case(fre_choose)
	  	3'd0: clk_in <= CARD1_VOL_FREQ;
	  	3'd1: clk_in <= CARD1_CUR_FREQ;
	  	3'd2: clk_in <= CARD2_VOL_FREQ;
	  	3'd3: clk_in <= CARD2_CUR_FREQ;
	  	3'd4: clk_in <= CARD3_VOL_FREQ;
	  	3'd5: clk_in <= CARD3_CUR_FREQ;
	  	default : clk_in <= CARD1_VOL_FREQ;
	  endcase
end


always@(posedge clk_200M or negedge rst_n)
begin
	 if(!rst_n)
	   begin
	   	rst_n_r1 <= 0;
	    rst_n_r2 <= 0;
	   end
	 else
	   begin
	   	rst_n_r1 <= 1;
	   	rst_n_r2 <= rst_n_r1;
	  end
	   
end

always@(posedge clk_200M)
begin
	if(!rst_n_r2)
	  begin
	  	clk_in_r <= 0;
	  	N_r <=0;
	  end
	else
	  begin
	  	clk_in_r <= clk_in;
	  	N_r <= N;
	  end
end    



always@(posedge clk_200M)
begin
	if(!rst_n_r2)
	  N <= 0;
	else if(C<=32'd400000000 && C > 32'd200000000)
	  N <= 16'd8192;
	else if(C<=32'd200000000 && C > 32'd40000000)
	  N <= 16'd4096;
	else if(C<=32'd40000000 && C > 32'd20000000)
	  N <= 16'd2048;
	else if(C<=32'd20000000 && C > 32'd312500)
	  N <= 16'd1024;
	else if(C<=32'd312500 && C > 32'd156250)
	  N <= 16'd512;
	else if(C<=32'd156250 && C > 32'd78125)
	  N <= 16'd256;
	else if(C<=32'd78125 && C > 32'd40000)
	  N <= 16'd128;
	else
	  N <= 0;
end





// 测频模块
fre_measure fre_measure(
.clk   (clk_200M   ),   
.clk_in(clk_in_r   ),
.rst_n (rst_n_r2   ),
.N     (N          ),                             
.C_out (C          ),
.clkin_up(clkin_up)      

);

// C/N分频器
C_N_frediv C_N_frediv(
.clk       ( clk_200M     ),        
.rst_n     ( rst_n_r2     ),    
.numerator ( C            ),// 输入信号频率
.N         ( N_r          ),// 放大倍数                       
.pulse     ( clk_out      ),
.change_out( clkout_change )       

);





endmodule
