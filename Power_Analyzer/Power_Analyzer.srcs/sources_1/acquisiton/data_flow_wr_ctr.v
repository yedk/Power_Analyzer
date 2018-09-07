`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module data_flow_wr_ctr(	
	rst,//active low
	fifo_wclk,
	time_base,	
	data_flow_mode,
	fifo_all_wendiv	,	//divide the fifo write enable signal so that it fit the actual sample rate.
	a_dffs_en,
	b_dffs_en
	);

input		rst;
input		fifo_wclk;
input	[31:0]	time_base;
input   data_flow_mode;

output		fifo_all_wendiv;
output		a_dffs_en, b_dffs_en;

reg		cmp_resault_r1,cmp_resault_r2;
reg		cmp_resault_div2_r1,cmp_resault_div2_r2;
reg		dffs_en1_reg,dffs_en2_reg;
reg		pre_div2;
(*KEEP = "true" *)wire		rst_test;
assign rst_test= rst;

wire [31:0] time_gap_num ;
assign time_gap_num = time_base-2'd1;

//实现了2抽
always @ (posedge fifo_wclk )
begin
	if(rst == 1'b0)
		pre_div2 <= 1'b1;
	else
		pre_div2 <= ~ pre_div2;
end

counter_hs_cmp counter_hs_cmp_inst (
    .rst(rst), //"0" is active
    .clk_in(fifo_wclk), 
    .set_num_in(time_gap_num), //PC发送的硬件抽点系数
    .cmp_resault(cmp_resault),//计数到抽点系数时，输出高
    .cmp_resault_div2(cmp_resault_div2)//计数到抽点系数/2时，输出高
    );
 
    
always @ (posedge fifo_wclk )
begin
     cmp_resault_r1<=cmp_resault;
     cmp_resault_r2<=cmp_resault_r1;
     cmp_resault_div2_r1<=cmp_resault_div2;
     cmp_resault_div2_r2<=cmp_resault_div2_r1;
end

always @ (posedge fifo_wclk)//posedge fifo_all_wendiv
begin
	if(rst == 1'b0)
	begin		
		dffs_en1_reg <= 1'b0;
	end
	else if (cmp_resault_r1 == 1'b0 && cmp_resault_r2 == 1'b1)//下降沿
	begin
		dffs_en1_reg <= 1'b1;
	end
	else
	begin
		dffs_en1_reg <= 1'b0;
	end
end
always @ (posedge fifo_wclk)//posedge fifo_all_wendiv
begin
	if(rst == 1'b0)
	begin		
		dffs_en2_reg <= 1'b0;
	end
	else if (cmp_resault_div2_r1 == 1'b0 && cmp_resault_div2_r2 == 1'b1)
	begin
		dffs_en2_reg <= 1'b1;
	end
	else
	begin
		dffs_en2_reg <= 1'b0;
	end
end

assign a_dffs_en = (time_gap_num[9:2] == 8'h00)? 1'b1 : dffs_en1_reg;//cmp_resault
assign b_dffs_en = (time_gap_num[9:2] == 8'h00)? 1'b1 : dffs_en2_reg;//cmp_resault_div2
assign fifo_all_wendiv = data_flow_mode ? ((time_gap_num[31:0] == 32'd0)? pre_div2 : cmp_resault_r2):1;

endmodule 
