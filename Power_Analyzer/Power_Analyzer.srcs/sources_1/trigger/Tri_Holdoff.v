module	Tri_Holdoff(//input	
			Tri_Holdoff,		//Holdoff Time
			Clkin,			//			
			Trigger,		//input trigger signal

		 //output
			Sys_Tri			//output trigger signal
		 );
/////////////input////////////////
input	[31:0]	Tri_Holdoff;
input		Clkin;
input		Trigger;
reg		tri_tmp1;
reg		tri_tmp2;
reg		tri_tmp3;
wire		tri_tmp;

/////////////output//////////////
output		Sys_Tri;
wire		Sys_Tri;
reg		Clr;
reg		Clr_n;
reg		carry_en1;
reg		carry_en2;
reg		Clk_En;
reg	[31:0]	Holdoff;
reg	[31:0]	Tri_Holdoff_reg1;
reg	[31:0]	Tri_Holdoff_reg;

reg		cmp_result1,
		cmp_result2;

always @ (posedge Clkin)	//buffer the clr signal
begin
	Tri_Holdoff_reg1 <= Tri_Holdoff;
	Tri_Holdoff_reg <= Tri_Holdoff_reg1;
end

reg     pptest;

always @ (posedge Clkin)	//buffer the clr signal
begin
	if(Tri_Holdoff == Tri_Holdoff_reg)
		pptest<= 1;
	else
		pptest<= 0;		
end

always @ (posedge Clkin)	//buffer the clr signal
begin
	Clr_n <= Clr & pptest;
end

always @(posedge Trigger or negedge Clr_n )
begin
	if(!Clr_n)
	begin
		Clk_En<=1'b0;
	end
	else  	//rise Trigger
	begin
		Clk_En<=1'b1;
	end
end

/////////////Holdoff////////////////////
always @(posedge Clkin)
begin
	if(!Clk_En)
	begin
		Holdoff[7:0]<=8'b0;
		carry_en1<=1'b0;
	end
	else
	begin
		Holdoff[7:0]<=Holdoff[7:0]+1'b1;
		if(Holdoff[7:0]==8'hfe)
		begin
			carry_en1<=1'b1;
		end
		else
		begin
			carry_en1<=1'b0;
		end
	end
end
always @(posedge Clkin)
begin
	if(!Clk_En)
	begin
		Holdoff[31:8]<=24'b0;
	end
	else if(carry_en1)
	begin
		Holdoff[31:8]<=Holdoff[31:8]+24'b1;
	end
end

////CMP LOW 8 bit
always @(posedge Clkin)
begin
	if(Holdoff[7:0] == Tri_Holdoff_reg[7:0])
	begin
		cmp_result1 <= 1'b0;
	end
	else
	begin
		cmp_result1 <= 1'b1;
	end
end

//CMP HIGH 24 bit
always @(posedge Clkin)
begin
	if(Holdoff[31:8] == Tri_Holdoff_reg[31:8])
	begin
		cmp_result2 <= 1'b0;
	end
	else
	begin
		cmp_result2 <= 1'b1;
	end
end


always @(posedge Clkin)
begin	
	//if(Holdoff[31:0] == Tri_Holdoff_reg[31:0])	//>
	if(cmp_result2 == 1'b0 && cmp_result1 == 1'b0)
	begin
		Clr<=1'b0;
	end
	else 
	begin
		Clr<=1'b1;
	end	
end
////////////////释抑后触发信号输出///////////////////
always @(posedge Clkin)//2007-9-24 negedge 
begin
	tri_tmp1<=Clk_En;
end
always @(posedge Clkin)
begin
	tri_tmp2 <= tri_tmp1;
end

reg		tri_temp;

assign	tri_tmp = ~tri_tmp2 & Clk_En;

reg	tri_temp_reg;
reg	fifo_wr_gap_dly1,
	fifo_wr_gap_dly2;

always @ (posedge Clkin)
begin
	tri_temp <= ~tri_tmp2 & Clk_En;	
end
//****************** trigger hold off end


wire	sys_tri_pre/* synthesis syn_keep = 1 */;
assign	sys_tri_pre = tri_temp;//Trigger; random_trig_come

  BUFG BUFG_sys_tri(			
		.O(Sys_Tri),
		.I(sys_tri_pre)
		);
endmodule