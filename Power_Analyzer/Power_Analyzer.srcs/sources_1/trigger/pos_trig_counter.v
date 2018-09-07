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
module pos_trig_counter(
		clr,		 
		inclk, 
		data, 
		cout
		);
//parameter	HSB = 31;
input	clr;
input		inclk;
input	[36:0]	data;

output		cout;

wire	pos_depth_over;
reg		 cout_reg;
reg	[36:0]	tmp_data;
reg		carry_en_1,
		carry_en_2,
		carry_en_3,
		carry_en_4;
reg		cout_reg_en;

reg		cmp_resault_l,
		cmp_resault_m,
		cmp_resault_h,
		cmp_resault_sh;
reg		pos_depth_over_reg1,
		pos_depth_over_reg2;
		//wire		cmp_resault_sha;
reg		cmp_resault_sha1,
		cmp_resault_sha2;



assign	cout = (data == 37'h0000) ? 1'b1 : cout_reg;	//advanced the stability
assign	pos_depth_over = cmp_resault_l & cmp_resault_m & cmp_resault_h & cmp_resault_sh;

 
always @ (posedge inclk)
begin
	pos_depth_over_reg1 <= pos_depth_over;
	pos_depth_over_reg2 <= pos_depth_over_reg1;
end	


always @ (posedge inclk )
begin
	if(clr == 1'b0)
	begin
		cout_reg <= 1'b0;
		//cout_reg_en <= 1'b0;
	end
	else if(pos_depth_over_reg1 == 1'b1 && pos_depth_over_reg2 == 1'b0)
	begin
		cout_reg <= 1'b1;
		//cout_reg_en <= 1'b1;
	end
end


always @(posedge inclk or negedge clr )//or negedge count_en)
begin
	if(!clr )	//as clr
	begin
		tmp_data[7:0] <= 8'h00;
		carry_en_1 <= 1'b0;
	end
	else //if (count_en == 1'b1) //2007-10-11
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
end
//////////////////////////////////////
/*
always @(posedge inclk or negedge clr )//or negedge count_en)
begin
	if(!clr )	//as clr
	begin
		tmp_data[7:4] <= 4'h0;
	end
	else if(carry_en_1 == 1'b1)
	begin		
		tmp_data[7:4] <= tmp_data[7:4] + 1;
	end
end


always @(posedge inclk)
begin
	if(tmp_data[7:4] ==  4'hf)
	begin			
		carry_en_2 <= 1'b1;
	end
	else
	begin
		carry_en_2 <= 1'b0;			
	end		
end
*/
///////////////////////////////////////////////////////////////
always @(posedge inclk or negedge clr)
begin
	if(!clr )	//as clr
	begin
		tmp_data[15:8] <= 8'h00;
	end
	else if(carry_en_1 == 1'b1)
	begin
		tmp_data[15:8] <= tmp_data[15:8] + 1;				
	end
end

always @(posedge inclk)
begin
	if(tmp_data[15:8] ==  8'hff)
	begin			
		carry_en_2 <= 1'b1;
	end
	else
	begin
		carry_en_2 <= 1'b0;			
	end		
end

////////////////////////////////////////////////////////////////
always @(posedge inclk or negedge clr)
begin
	if(!clr )	//as clr
	begin
		tmp_data[23:16] <= 8'h00;
	end
	else if(carry_en_1 == 1'b1 && carry_en_2 == 1'b1)	//carry_en_2 == 1'b1 && 
	begin
		tmp_data[23:16] <= tmp_data[23:16] + 1;				
	end
end

always @(posedge inclk)
begin
	if(tmp_data[23:16] ==  8'hff)
	begin			
		carry_en_3 <= 1'b1;
	end
	else
	begin
		carry_en_3 <= 1'b0;			
	end		
end

//////////////////////////////////////////////////////////////

always @(posedge inclk or negedge clr)
begin
	if(!clr )	//as clr
	begin
		tmp_data[31:24] <= 8'h00;
	end
	else if(carry_en_1 == 1'b1 && carry_en_2 == 1'b1 && carry_en_3 == 1'b1)
	begin
		tmp_data[31:24] <= tmp_data[31:24] + 1;				
	end
end

///////////////////////////////////////////////////////////////

always @(posedge inclk)
begin
	if(tmp_data[31:24] ==  8'hff)
	begin			
		carry_en_4 <= 1'b1;
	end
	else
	begin
		carry_en_4 <= 1'b0;			
	end		
end


always @(posedge inclk or negedge clr)
begin
	if(!clr )	//as clr
	begin
		tmp_data[36:32] <= 5'h00;
	end
	else if(carry_en_1 == 1'b1 && carry_en_2 == 1'b1 && carry_en_3 == 1'b1 && carry_en_4 == 1'b1)
	begin
		tmp_data[36:32] <= tmp_data[36:32] + 1;				
	end
end

//////////////////////////////////////////////////////////
always @ (posedge inclk or negedge clr)
begin
	if(!clr )	
	begin
		cmp_resault_l <= 1'b0;
	end
	else if(tmp_data[7:0] == data[7:0])
		cmp_resault_l <= 1'b1;	
	else 
		cmp_resault_l <= 1'b0;
end
/////////////////////////////////////////////////////////////
always @ (posedge inclk or negedge clr)
begin
	if(!clr )	
	begin
		cmp_resault_m <= 1'b0;
	end
	else if(tmp_data[15:8] == data[15:8])
		cmp_resault_m <= 1'b1;
	else 
		cmp_resault_m <= 1'b0;
end
/////////////////////////////////////////////////////////////
always @ (posedge inclk or negedge clr)
begin
	if(!clr )	
	begin
		cmp_resault_h <= 1'b0;
	end
	else if(tmp_data[23:16] == data[23:16])
		cmp_resault_h <= 1'b1;	
	else 
		cmp_resault_h <= 1'b0;
end

////////////////////////////////////////////
always @ (posedge inclk or negedge clr)
begin
	if(!clr )	
	begin
		cmp_resault_sh <= 1'b0;
	end
	else if(tmp_data[36:24] == data[36:24])
		cmp_resault_sh <= 1'b1;
	else
		cmp_resault_sh <= 1'b0;
end
////////////////////////////////////////////
	
endmodule