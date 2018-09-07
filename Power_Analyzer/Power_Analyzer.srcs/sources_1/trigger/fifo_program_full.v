
//////////////////////////////////////////////////////////////////////////////////
module fifo_program_full(
	input             clk,                 
	input             reset,               
	input             wen,                 
	input             adc_Rxdat_valid,     
	input             ren,                 
	input             ready_dsp,           
	input             trigged_dsp,         
	input             auto_dsp,  
	input             tri_auto,          
	input      [15:0] num_program, 
	input			  auto_rclk_en,        
	output reg        program_full         
			    );


(*KEEP="TRUE"*)reg	[15:0] cnt_data;
reg [15:0] num_program_r;
reg wen_r;
reg ren_r;
reg adc_Rxdat_valid1,adc_Rxdat_valid2,adc_Rxdat_valid3;

always @ (posedge clk)
begin
	num_program_r<=num_program;
	adc_Rxdat_valid1 <= adc_Rxdat_valid;
	adc_Rxdat_valid2 <= adc_Rxdat_valid1;
	adc_Rxdat_valid3 <= adc_Rxdat_valid2;
end

always @ (posedge clk)
begin
	if(!reset)
	begin
		cnt_data <= 16'h0000;
	end
	else if(cnt_data<num_program)
	begin
	  if( {ready_dsp,trigged_dsp,auto_dsp,tri_auto} == 4'b1001)//自动触发情况下，没有触发信号，边读边写情况计数器不自加
	  begin
	     cnt_data <= cnt_data;      	
	  end	
	  else if( {ready_dsp,trigged_dsp,auto_dsp,tri_auto} == 4'b1000)//正常触发情况下和自动触发有触发信号，边读边写情况计数器不自加
	  begin
	     cnt_data <= cnt_data;      	
	  end
	  else if(auto_rclk_en)
	     cnt_data <= cnt_data;  
	  else if(adc_Rxdat_valid)
	  begin
	  	cnt_data <= cnt_data + 1'b1;
	  end
	end	
end


always @ (posedge clk)
begin
	if(!reset)
	begin
		program_full <= 1'b0;
	end
    else if(cnt_data >= num_program)
    begin
      program_full <= 1'b1;
    end
    else
    begin
      program_full <= 1'b0;
    end
end

endmodule
