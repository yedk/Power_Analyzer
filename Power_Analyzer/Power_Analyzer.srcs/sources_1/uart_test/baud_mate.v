`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/08 20:41:55
// Design Name: 
// Module Name: baud_rate
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module baud_rate(
								clk,
								rst,
								bps_start,
								clk_bps
							);

input 				clk;			//81.84MHz��ʱ��
input 				rst;		   //��λ�ź�
input 				bps_start;	//���յ����ݺ󣬲�����ʱ�������ź���λ
output 				clk_bps;		//clk_bps�ĸߵ�ƽΪ���ջ��߷�������λ���м������ 

parameter
						FOSC  = 81840000,					
						BAUDR = 115200; 

//�����ʷ�Ƶ����ֵ
//`define		BPS_PARA			710	//������Ϊ115200ʱ�ķ�Ƶ����ֵ
//`define 		BPS_PARA_2		355	//������Ϊ115200ʱ�ķ�Ƶ����ֵ��һ�룬�������ݲ���

`define		BPS_PARA			FOSC / BAUDR		//������Ϊ115200ʱ�ķ�Ƶ����ֵ
`define 		BPS_PARA_2		FOSC / BAUDR / 2	//������Ϊ115200ʱ�ķ�Ƶ��?

reg	[12:0] 	cnt=13'd0;					//��Ƶ����
reg 				clk_bps_r;			//������ʱ�ӼĴ���

//----------------------------------------------------------

always @ (posedge clk or posedge rst)
	if(rst) cnt <= 13'd0;
	else if((cnt == `BPS_PARA) || !bps_start) cnt <= 13'd0;	//�����ʼ�������
	else cnt <= cnt + 1'b1;												//������ʱ�Ӽ�������

always @ (posedge clk or posedge rst)
	if(rst) clk_bps_r <= 1'b0;
	else if(cnt == `BPS_PARA_2) clk_bps_r <= 1'b1;	// clk_bps_r�ߵ�ƽΪ��������λ���м������,ͬʱҲ��Ϊ�������ݵ����ݸı��
	else clk_bps_r <= 1'b0;

assign clk_bps = clk_bps_r;

endmodule

