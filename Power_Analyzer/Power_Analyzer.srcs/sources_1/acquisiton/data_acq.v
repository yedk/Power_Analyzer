
module data_acq(
	input             rst_L,
	input             adc_tx_clk,
	input      [15:0] adc1_data,  //ADC1采集的数据
	input      [15:0] adc2_data,  //ADC2采集的数据
    input      [31:0] time_gap_num, //抽点系数
	input      [2:0]  acq_mode, //采集模式控制,000:正常，001：峰值，010：平均
    input             fifo_all_wen,
    input      [15:0] mulit_b,  //HR乘法器系数
    output reg [15:0] adc1_rx_data,
    output reg [15:0] adc2_rx_data
		);
		
		
reg	[15:0]	adc1_data_reg1,adc1_data_reg2,adc1_data_reg3;
reg	[15:0]	adc2_data_reg1,adc2_data_reg2,adc2_data_reg3;

reg   [31:0]  adc1_data_tmp,adc2_data_tmp;
reg [15:0] adc1_data_div,adc2_data_div;
wire [15:0] ch1_hr_dat,ch2_hr_dat;
wire [31:0] ch1_peak_dat ,ch2_peak_dat;


always @(posedge adc_tx_clk)
begin
	adc1_data_reg1 <= adc1_data;
	adc1_data_reg2 <= adc1_data_reg1;  
	adc1_data_reg3 <= adc1_data_reg2;
	
	adc2_data_reg1 <= adc2_data;
	adc2_data_reg2 <= adc2_data_reg1;
	adc2_data_reg3 <= adc2_data_reg2;
 end                 

                     
////////////////////////////////////////////////////////////////////////////


//////////////////普通采集
always @ (posedge adc_tx_clk)
begin
	if(fifo_all_wen)
	begin
		adc1_data_div  <= adc1_data_reg1;
		adc2_data_div  <= adc2_data_reg1;
	end
end

//峰值模式采集
peak_process peak_process_ch12(
				.adc_clk(adc_tx_clk), 
				.ch1_din(adc1_data_reg1),//adc2_data_reg3
				.ch2_din(adc2_data_reg1),//adc2_data_reg3
				.rst_n(rst_L), 
				.time_base(time_gap_num ),
				.ch1_dout(ch1_peak_dat),//max,min
				.ch2_dout(ch2_peak_dat) //max,min	
				);



//HR模式采集	
HR	 HR_ch12(
 		.cha_data_in(adc1_data_reg1 ),//adc2_data_reg3
		.chb_data_in(adc2_data_reg1 ),//adc2_data_reg3
		.s_clk(adc_tx_clk ),
		.time_base(time_gap_num),
		.mulit_b(mulit_b),//乘累加器系数
		.rst_n(rst_L ),			
		.cha_data_out(ch1_hr_dat ),
		.chb_data_out(ch2_hr_dat )  
	);		




always @ (posedge adc_tx_clk)
begin
	case(acq_mode)
		3'd1://peak mode
		begin
		  adc1_rx_data <= ch1_peak_dat;   
		  adc2_rx_data <= ch2_peak_dat;
		end
		3'd2://hr mode
		begin
		  adc1_rx_data <= {ch1_hr_dat,ch1_hr_dat};   
		  adc2_rx_data <= {ch2_hr_dat,ch2_hr_dat};  
		end
		default://正常采集
		begin
			//adc1_rx_data <= {adc1_data_div,adc1_data_div};     
		  //adc2_rx_data <= {adc2_data_div,adc2_data_div};  
		  adc1_rx_data <= adc1_data_div;
		  adc2_rx_data <= adc2_data_div; 
		end	
	endcase	
end





endmodule