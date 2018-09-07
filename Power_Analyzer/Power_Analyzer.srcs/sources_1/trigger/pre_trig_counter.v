`timescale 1ns / 1ps//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:15:18 04/26/2007
// Design Name: 
// Module Name:    counter_n 
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
module pre_trig_counter(
		clr,//active low
		count_en, //active high
		pre_trg_clkin,	//250 MHz
		data, 
		cout
		);
input		clr;
input		count_en;

//input		cnt_clk;
input		pre_trg_clkin;
input	[31:0]	data;
output reg		cout;

reg [31:0] counter;
reg cmp_data,cmp_flag;




always @(posedge pre_trg_clkin)
begin
	if(!clr)
	begin
	 	    counter <= 0;
	end
	else if(count_en&cmp_flag )
	begin
		   counter <= counter+1;
	end
  else
  begin
  	  counter <= counter;
  end
end


always @(posedge pre_trg_clkin)
begin
	if(!clr)
	begin
	 	    cmp_data <= 0;
	 	    cmp_flag <= 1;
	end
  else if(counter > data)
  begin
  	   cmp_data <= 1;
  	   cmp_flag <= 0;
  end
  else 
  begin
  	   cmp_data <= 0;
  	   cmp_flag <= 1;
  end
end

always @(posedge pre_trg_clkin)
begin
	if(!clr)
	begin
	 	    cout <= 0;
	end
 else if(data==32'd0)
 begin
     cout <= 1;
 end
 else
 begin
 	   cout <= cmp_data;
 end
end

/*wire		cout;
wire		pre_depth_over;

reg		 cout_reg;
(*KEEP="TRUE"*)reg	[31:0]	tmp_data;
reg		carry_en_1,
		carry_en_2;

(*KEEP="TRUE"*)reg		cmp_resault_l,
		cmp_resault_m,
		cmp_resault_h;

reg		cout_const;
reg		cout_sel;
reg		pre_depth_over_reg1,
		pre_depth_over_reg2;

assign	cout = (cout_sel == 1'b1) ? cout_const : cout_reg;
assign	pre_depth_over = cmp_resault_l & cmp_resault_m & cmp_resault_h ;



always @ (posedge pre_trg_clkin)
begin
	if(data == 31'h00000000)
		cout_sel <= 1'b1;
	else 
		cout_sel <= 1'b0;
end

always @ (posedge pre_trg_clkin)
begin
	if(clr == 1'b0)
		cout_const <= 1'b0;	
	else 
		cout_const <= 1'b1;
end

always @ (posedge pre_trg_clkin )
begin
	pre_depth_over_reg1 <= pre_depth_over;
	pre_depth_over_reg2 <= pre_depth_over_reg1;
end

always @ (posedge pre_trg_clkin )
begin
	if(clr == 1'b0)
	begin
		cout_reg <= 1'b0;	
	end
	else if(pre_depth_over_reg1 == 1'b1 && pre_depth_over_reg2 == 1'b0)
	begin
		cout_reg <= 1'b1;
	end
end


always @(posedge pre_trg_clkin )//or negedge count_en)
begin
	if(clr == 1'b0 )	//as clr
	begin
		tmp_data[7:0] <= 8'h00;
		carry_en_1 <= 1'b0;
	end
	else if (count_en == 1'b1)
	begin
		tmp_data[7:0] <= tmp_data[7:0] + 1;
		if(tmp_data[7:0] ==  8'hfe)
		begin			
			carry_en_1 <= 1'b1;
		end
		else
		begin
			carry_en_1 <= 1'b0;			
		end			
	end
	else 
	begin
		carry_en_1 <= 1'b0;
	end
end
				
always @(posedge pre_trg_clkin )
begin
	if(clr == 1'b0 )	//as clr
	begin
		tmp_data[15:8] <= 8'h00;
	end
	else //if (count_en == 1'b1)
	begin		
		if(carry_en_1 == 1'b1)
			tmp_data[15:8] <= tmp_data[15:8] + 1;				
	end
end

always @ (posedge pre_trg_clkin )
begin
	if(tmp_data[15:8] ==  8'hff)
	begin			
		carry_en_2 <= 1'b1;
	end
	else
	begin
		carry_en_2<= 1'b0;			
	end	
end

always @(posedge pre_trg_clkin )
begin
	if(clr == 1'b0)	//as clr
		begin
			tmp_data[31:16] <= 4'h0;
		end
	else //if (count_en == 1'b1)
		begin		
			if(carry_en_1 == 1'b1 && carry_en_2 == 1'b1)
				tmp_data[31:16] <= tmp_data[31:16] + 1;				
		end
end


//////////////////////////////////////////////////////////
always @ (posedge pre_trg_clkin )
begin
	if(clr == 1'b0 )	
	begin
		cmp_resault_l <= 1'b0;
	end
	else if(tmp_data[7:0] == data[7:0])
		cmp_resault_l <= 1'b1;	
	else 
		cmp_resault_l <= 1'b0;
end
/////////////////////////////////////////////////////////////
always @ (posedge pre_trg_clkin )
begin
	if(clr == 1'b0)	
	begin
		cmp_resault_m <= 1'b0;
	end
	else if(tmp_data[15:8] == data[15:8])
		cmp_resault_m <= 1'b1;
	else 
		cmp_resault_m <= 1'b0;
end
/////////////////////////////////////////////////////////////
always @ (posedge pre_trg_clkin)
begin
	if(clr == 1'b0 )	
	begin
		cmp_resault_h <= 1'b0;
	end
	else if(tmp_data[31:16] == data[31:16])
		cmp_resault_h <= 1'b1;	
	else 
		cmp_resault_h <= 1'b0;
end
	*/
endmodule
