//for auto trig mode

module auto_trig_cnt(
		cnt_en, 
		clk,
		clk_ref,
		sys_trig_sig,//有效触发信号

		cout
		);

input		cnt_en;
input		clk,
		clk_ref;
input		sys_trig_sig;

output		cout;

parameter	CNT_WIDTH = 12,
		GAP_NUM = 260;


reg		cout;
reg		cout_pre;
reg	[CNT_WIDTH-1:0]	tmp_data;

reg	clk_ref_latch_a,
	clk_ref_latch_b;

reg	[CNT_WIDTH-1:0]	cnt_reg;
reg		cnt_en_dly;
reg		auto_sig;
reg		sys_trig_sig_dly1,
		sys_trig_sig_dly2;

reg	auto_sig_dly1,
	auto_sig_dly2;
reg	which_edge;
//*********************************
always @ (posedge clk)
begin
	if(auto_sig_dly2 == 1'b0 && auto_sig_dly1 == 1'b1)
	begin
		which_edge <= ~which_edge;
	end
end

always @ (posedge clk)
begin
	if(which_edge)
	begin
		clk_ref_latch_a <= clk_ref;
	end
	else
	begin
		clk_ref_latch_a <= ~clk_ref;
	end

	clk_ref_latch_b <= clk_ref_latch_a;
	cnt_en_dly <= cnt_en;
end

always @(posedge clk )
begin
	//自动触发使能无效
	if(cnt_en_dly == 1'b0 )
	begin
		cout_pre<=0;
		if(auto_sig == 1'b0)
		begin			
			tmp_data <= 0;
		end
		else
		begin			
			tmp_data <= GAP_NUM-2;
		end
	end
	//自动触发使能开启
	else
	begin
		if(tmp_data < GAP_NUM )	//about triged in 4Hz
		begin
			if((clk_ref_latch_a == 1'b1) && (clk_ref_latch_b == 1'b0))
			begin
				tmp_data<=tmp_data+1;
				cout_pre<=0;
			end
		end
		else
			cout_pre<=1;	
	end
end

//自动触发信号输出
always @ (posedge clk)
begin
	cout <= cout_pre;
end

//*******************

reg		trg_clr;
reg		sys_trig_sig_reg;

always @ (posedge sys_trig_sig or negedge trg_clr)
begin
	if(!trg_clr)
	begin
		sys_trig_sig_reg <= 1'b0;		
	end
	else
	begin
		sys_trig_sig_reg <= 1'b1;		
	end
end

always @ (posedge clk)
begin
	sys_trig_sig_dly1 <= sys_trig_sig_reg;
	sys_trig_sig_dly2 <= sys_trig_sig_dly1;
end

always @ (posedge clk )
begin	
	if(sys_trig_sig_dly2 == 1'b0 && sys_trig_sig_dly1 == 1'b1)	
	begin
		cnt_reg <= 0;
		auto_sig<= 0;
		trg_clr <= 1'b0;
	end	
	else 
	begin
		trg_clr <= 1'b1;
		if(cnt_reg < GAP_NUM )
		begin
			if((clk_ref_latch_a == 1'b1) && (clk_ref_latch_b == 1'b0))
			begin
				cnt_reg <= cnt_reg+1;
				auto_sig <= 0;
			end
		end	
		else
			auto_sig <= 1;
	end
end


always @ (posedge clk )// for difference  N and  N+1  in Auto modle
begin
	auto_sig_dly1 <= cout_pre;//auto_sig;
	auto_sig_dly2 <= auto_sig_dly1;
end
//********************

endmodule
