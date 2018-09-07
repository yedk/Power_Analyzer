//////////////////////////////////////////////////////////////////////////////////
module counter_hs_cmp(
input	            rst,		//"0" is active
input	            clk_in,
input     [31:0]	set_num_in,
output reg	        cmp_resault,
output reg	        cmp_resault_div2
	);


reg [31:0] conuter;

always @(posedge clk_in)
begin
  if(!rst)
  begin
    conuter <=32'd0;
    cmp_resault <= 0;	
  end
  else
  begin
  	if(conuter == set_num_in)
  	begin
  	   conuter <=32'd0;	
  	   cmp_resault <= 1;
  	end	
    else
    begin
      conuter <= conuter +1;
      cmp_resault <= 0;		
    end
  end	
end


always @(posedge clk_in)
begin
  if(!rst)
  begin
    cmp_resault_div2 <= 0;	
  end
  else if(conuter == set_num_in[31:1])
  begin
  	cmp_resault_div2 <= 1;
  end	
  else
  begin
    cmp_resault_div2 <= 0;		
  end	
end
endmodule
/*
module counter_hs_cmp(
	rst,		//"0" is active
	clk_in,
	set_num_in,
	cmp_resault,
	cmp_resault_div2
	);

parameter	HSB = 31;
parameter	HSB_H = 15;

input		rst;
input		clk_in;

input	[HSB:0]	set_num_in;

output		cmp_resault;
output		cmp_resault_div2;

reg	[HSB:0]	cnt_reg;
reg		carrey_en_1, carrey_en_2,carrey_en_3,carrey_en_4;
reg  cmp_resault_h, cmp_resault_m, cmp_resault_l;
reg		temp_cmp_resault_h, temp_cmp_resault_m, temp_cmp_resault_l;

wire	[HSB:0]	setnum;

wire		clr;	//"0" is active.

wire	[31:0]	temp_num;	
////////////////////////////////////////////////////////
assign setnum=set_num_in;


assign cmp_resault = cmp_resault_h & cmp_resault_m & cmp_resault_l;

assign clr = (~cmp_resault) & rst;
////////////////////////////////////////////////////////


//////////////////////32位计数器//////////////////////////////////
always @ (posedge clk_in) 
begin
	if(clr == 1'b0)
	begin
		cnt_reg[7:0] <= 8'h00;
	end
	else
	begin
		cnt_reg[7:0] <= cnt_reg[7:0] + 1'h01;
	end
	if(cnt_reg[7:0] == 8'hfe)
	begin
		carrey_en_1 <= 1'b1;
	end
	else
	begin
		carrey_en_1 <= 1'b0;
	end
end


always @ (posedge clk_in)
begin
	if(clr == 1'b0)
	begin
			cnt_reg[15:8] <= 8'h00;
	end
	else if(carrey_en_1 == 1'b1)
	begin
		cnt_reg[15:8] <= cnt_reg[15:8] + 1'b1;
	end
	if(cnt_reg[15:8] == 8'hfe)
	begin
		carrey_en_2 <= 1'b1;
	end
	else
	begin
		carrey_en_2 <= 1'b0;
	end
end

always @ (posedge clk_in)
begin
	if(clr == 1'b0)
	begin
			cnt_reg[23:16] <= 8'h00;
	end
	else if(carrey_en_2 == 1'b1)
	begin
		cnt_reg[23:16] <= cnt_reg[23:16] + 1'b1;
	end
	if(cnt_reg[23:16] == 8'hfe)
	begin
		carrey_en_3 <= 1'b1;
	end
	else
	begin
		carrey_en_3 <= 1'b0;
	end
end

always @ (posedge clk_in)
begin
	if(clr == 1'b0)
	begin
			cnt_reg[31:24] <= 8'h00;
	end
	else if(carrey_en_3 == 1'b1)
	begin
		cnt_reg[31:24] <= cnt_reg[31:24] + 1'b1;
	end
	if(cnt_reg[31:24] == 8'hfe)
	begin
		carrey_en_4 <= 1'b1;
	end
	else
	begin
		carrey_en_4 <= 1'b0;
	end
end
////////////////////////////////////////////////////////


/////////////////////计数结果比较///////////////////////////////////
always @ (posedge clk_in) 
begin
	if(cnt_reg[7:0] == setnum[7:0])
		cmp_resault_l <= 1'b1;
	else
		cmp_resault_l <= 1'b0;
end

always @ (posedge clk_in) 
begin
	if(cnt_reg[15:8] == setnum[15:8])
		cmp_resault_m <= 1'b1;
	else
		cmp_resault_m <= 1'b0;
end

always @ (posedge clk_in) 
begin
	if(cnt_reg[HSB:16] == setnum[HSB:16])
		cmp_resault_h <= 1'b1;
	else
		cmp_resault_h <= 1'b0;
end

////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
assign temp_num[30:0] =set_num_in[31:1];

assign cmp_resault_div2 = temp_cmp_resault_h & temp_cmp_resault_m & temp_cmp_resault_l;
////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
always @ (posedge clk_in) 
begin
	if(cnt_reg[7:0] == temp_num[7:0])
		temp_cmp_resault_l <= 1'b1;
	else
		temp_cmp_resault_l <= 1'b0;
end

always @ (posedge clk_in) 
begin
	if(cnt_reg[15:8] == temp_num[15:8])
		temp_cmp_resault_m <= 1'b1;
	else
		temp_cmp_resault_m <= 1'b0;
end

always @ (posedge clk_in) 
begin
	if(cnt_reg[30:16] == temp_num[30:16])
		temp_cmp_resault_h <= 1'b1;
	else
		temp_cmp_resault_h <= 1'b0;
end

////////////////////////////////////////////////////////
endmodule
*/
