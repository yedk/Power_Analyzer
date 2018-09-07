`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:35 12/20/2017 
// Design Name: 
// Module Name:    freq_detect 
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
module freq_detect(

	input		            clkinx,
	input			          rst_n,
	input			          clkin,
	input			  [31:0]	gate_vaule,//N ¡À¨ª¨º?N*10ns
	output	reg [31:0]  mea_cnt_fx,
	output  reg [31:0]  mea_cnt_fs,
	output	            mea_flag
		);


reg		real_gate=0;
wire		gate_ctl;
	
//generate gate: gate_ctl
//generate measure finish flag: mea_flag
	gate_time_cnt  
		gate_time_cnt_i( 
        .rst_n(rst_n),
				.clkin(clkin),
				.gate_vaule(gate_vaule),//N ¡À¨ª¨º?N*10ns
				.cnt_gate(gate_ctl),
				.gate_status(mea_flag)
				);


//generate real gate: real_gate
always @ (posedge clkinx)
begin
	if (!rst_n)
	begin			
		real_gate <= 1'b0;
	end
	else if(gate_ctl == 1'b1)
	begin
		real_gate <= 1'b1;
	end
	else if(gate_ctl == 1'b0)
	begin	
		real_gate <= 1'b0;
	end
		
end

//count clkinx: mea_cnt_fx
always @(posedge clkinx or negedge rst_n)
begin
	if(!rst_n)
	begin
		mea_cnt_fx <= 32'd0;
	end
  else if(real_gate)
  begin
  	mea_cnt_fx <= mea_cnt_fx +32'd1;
  end
end

//count clkin: mea_cnt_fs
always @(posedge clkin or negedge rst_n)
begin
	if(!rst_n)
	begin
		mea_cnt_fs <= 32'd0;
	end
  else if(real_gate)
  begin
  	mea_cnt_fs <= mea_cnt_fs +32'd1;
  end
end




/*
//count clkinx: mea_cnt_fx
counter32  counter2(	
      .rst_n(rst_n),
			.clkin(clkinx),
			.cnt_ena(real_gate),

			.data_cnt(mea_cnt_fx)
			);

//count clkin: mea_cnt_fs
counter32  counter_fs( 
      .rst_n(rst_n),
			.clkin(clkin),	
			.cnt_ena(real_gate),

			.data_cnt(mea_cnt_fs)
			);
*/
endmodule
