`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:59:17 10/09/2016 
// Design Name: 
// Module Name:    peak_process 
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
module peak_process(
  input             adc_clk,
  input      [15:0] ch1_din,
  input      [15:0] ch2_din,
  input             rst_n,
  input      [31:0] time_base,//N�Ƚϳ���
  output reg [31:0] ch1_dout,
  output reg [31:0] ch2_dout
    );

reg [31:0] time_base0,time_cnt,time_cnt1;
reg [31:0] ch1_rise,ch1_fall,ch2_rise,ch2_fall;
reg [31:0] ch1_rise0,ch1_fall0,ch2_rise0,ch2_fall0;
reg ready;

reg [15:0] ch1_min0,ch1_min1,ch1_min2,ch1_max0,ch1_max1,ch1_max2;
reg [15:0] ch2_min0,ch2_min1,ch2_min2,ch2_max0,ch2_max1,ch2_max2;
reg [31:0] ch1_dout0,ch2_dout0;

//�����ȽϿ����ź�ready
always @(posedge adc_clk)
begin
	  if(!rst_n)
	  begin
	  	time_cnt <= 0;
	  	time_base0 <= 0;
	  	ready <= 0;
	  end
	 else
	 begin
	 	  time_base0 <= time_base-2'd1;
	 	 	time_cnt  <= time_cnt +1;
	 	 	ready <= 1;
	 	  if(time_cnt ==time_base0 )
	 	  begin
	 	  	 time_cnt <= 0;
	 	  	 ready <= 0;
	 	  end
	end
end


always @(posedge adc_clk)
begin
    if(!rst_n)
    begin
    	ch1_min0 <=16'd0;
    	ch1_min1 <=16'd0;
    	ch1_max0 <=16'd0;
    	ch1_max1 <=16'd0;
    	ch2_min0 <=16'd0;
    	ch2_min1 <=16'd0;
    	ch2_max0 <=16'd0;
    	ch2_max1 <=16'd0;    	
    end
	  else if(!ready)
	  begin
	  	ch1_min1 <= ch1_din;//��¼CH1Ĭ����Сֵ 
	  	ch1_max1 <= ch1_din;//��¼CH1Ĭ�����ֵ	 
	  	ch2_min1 <= ch2_din;//��¼CH2Ĭ����Сֵ 
	  	ch2_max1 <= ch2_din;//��¼CH2Ĭ�����ֵ
	  end
	 else if(ready)
	 begin
	 	 if(ch1_din >ch1_max1)//ɸѡch1  max
	 	 begin
	 	 	   ch1_max1 <= ch1_din;
	 	 end
	   else if(ch1_din < ch1_min1)//ɸѡch1  min
	   begin
	  	   ch1_min1 <= ch1_din;
	   end
	   if(ch2_din >ch2_max1)//ɸѡch2  max
	 	 begin
	 	 	   ch2_max1 <= ch2_din;
	 	 end
	   else if(ch2_din < ch2_min1)//ɸѡch2  min
	   begin
	  	  ch2_min1 <= ch2_din;
	   end
	 end
end

always @(posedge adc_clk)
begin
	 time_cnt1 <= time_cnt;
	 
	 if( time_cnt1 ==time_base0 &&time_cnt ==32'd0)
	 begin
	 	  //����ch1��һ�αȽϺ�����ֵ����Сֵ
	 	  ch1_dout <= {ch1_max1,ch1_min1};
	 	  ch2_dout <= {ch2_max1,ch2_min1};
	 end
	 else//���ݵ�����ɺ����
   begin
 	  ch1_dout <= ch1_dout;
 	  ch2_dout <= ch2_dout;
  end  
end


////2017-3-16 �����ϰ汾��ֵģʽ
/*
always @(posedge adc_clk)
begin
    if(!rst_n)
    begin
    	ch1_min0 <=16'd0;
    	ch1_min1 <=16'd0;
    	ch1_max0 <=16'd0;
    	ch1_max1 <=16'd0;
    	ch2_min0 <=16'd0;
    	ch2_min1 <=16'd0;
    	ch2_max0 <=16'd0;
    	ch2_max1 <=16'd0;
    	ch1_rise <=32'd0;
    	ch1_fall <=32'd0;
    	ch2_rise <=32'd0;
    	ch2_fall <=32'd0;
    	
    end
	  else if(!ready)
	  begin
	  	ch1_min1 <= ch1_din;//��¼CH1Ĭ����Сֵ 
	  	ch1_max1 <= ch1_din;//��¼CH1Ĭ�����ֵ	 
	  	ch2_min1 <= ch2_din;//��¼CH2Ĭ����Сֵ 
	  	ch2_max1 <= ch2_din;//��¼CH2Ĭ�����ֵ
	  	ch1_rise <=32'd0;
    	ch1_fall <=32'd0;
    	ch2_rise <=32'd0;
    	ch2_fall <=32'd0;
	  end
	 else if(ready)
	 begin
	 	 if(ch1_din >ch1_max1)//ɸѡch1  max
	 	 begin
	 	 	   ch1_max1 <= ch1_din;
	 	 	   ch1_rise <= ch1_rise+1'd1;
	 	 end
	   else if(ch1_din < ch1_min1)//ɸѡch1  min
	   begin
	  	   ch1_min1 <= ch1_din;
	  	   ch1_fall <= ch1_fall+1'd1;
	   end
	   if(ch2_din >ch2_max1)//ɸѡch2  max
	 	 begin
	 	 	   ch2_max1 <= ch2_din;
	 	 	   ch2_rise <= ch2_rise+1'd1;
	 	 end
	   else if(ch2_din < ch2_min1)//ɸѡch2  min
	   begin
	  	  ch2_min1 <= ch2_din;
	  	  ch2_fall <= ch2_fall+1'd1;
	   end
	 end
end

*/


/*
always @(posedge adc_clk)
begin
	 time_cnt1 <= time_cnt;
	 
	 if( time_cnt1 ==time_base0 &&time_cnt ==32'd0)
	 begin
	 	//����ch1�ȽϺ�����ֵ����Сֵ
	 	  ch1_max2 <= ch1_max1;
	 	  ch1_min2 <= ch1_min1;
	 	  //����ch1��һ�αȽϺ�����ֵ����Сֵ
	 	  ch1_dout0 <= {ch1_max2,ch1_min2};
	 	  ch2_max2 <= ch2_max1;
	 	  ch2_min2 <= ch2_min1;
	 	  ch2_dout0 <= {ch2_max2,ch2_min2};
	 	  ch1_rise0 <= ch1_rise;
    	ch1_fall0 <= ch1_fall;
    	ch2_rise0 <= ch2_rise;
    	ch2_fall0 <= ch2_fall; 
	 end  
	else if(time_cnt ==32'd1)
	begin
		//��ch1���ݴ�������״̬�£������һ�αȽ��е�max���ڵ�ǰ�ȽϽ����min����
		//������һ��max�뵱ǰ��min
		 if(ch1_rise0 >= ch1_fall0 && ch1_dout0[31:16] > ch1_min2)
		 begin
		 	  ch1_dout0 <= {ch1_min2,ch1_dout0[15:0]};
		 end
		 //��ch1���ݴ����½�״̬�£������һ�αȽ��е�minС�ڵ�ǰ�ȽϽ����max����
		//������һ��min�뵱ǰ��max
		 else if(ch1_rise0 < ch1_fall0 && ch1_dout0[15:0] < ch1_max2)
		 begin
		 	  ch1_dout0 <= {ch1_dout0[31:16],ch1_max2};
		 end
	  //�����������������
		else
		begin
			ch1_dout <= ch1_dout0;
		end
		
		//��ch2���ݴ�������״̬�£������һ�αȽ��е�max���ڵ�ǰ�ȽϽ����min����
		//������һ��max�뵱ǰ��min
		 if(ch2_rise0 >= ch2_fall0 && ch2_dout0[31:16] > ch2_min2)
		 begin
		 	  ch2_dout0 <= {ch2_min2,ch2_dout0[15:0]};
		 end
		 //��ch2���ݴ����½�״̬�£������һ�αȽ��е�minС�ڵ�ǰ�ȽϽ����max����
		//������һ��min�뵱ǰ��max
		 else if(ch2_rise0 < ch2_fall0 && ch2_dout0[15:0] < ch2_max2)
		 begin
		 	  ch2_dout0 <= {ch2_dout0[31:16],ch2_max2};
		 end
	  //�����������������
		else
		begin
			ch2_dout <= ch2_dout0;
		end
		
	end
  else//���ݵ�����ɺ����
  begin
 	  ch1_dout <= ch1_dout0;
 	  ch2_dout <= ch2_dout0;
  end
end

*/
endmodule
