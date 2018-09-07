`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/08 20:43:15
// Design Name: 
// Module Name: uart_top
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


module uart_top(
						input clk_100M,
						//input clk_50M,
						input rst_n,
						input uart_rx,
						//input clk_bps1,
						output reg [47:0] data ,  //16位地址+32位数据   实际是低11位有效地址					 
						output reg valid
    );
    
    
    wire rev_dry;
    wire clk_bps1;
 (*KEEP="TRUE"*)   wire [7:0] rev_data;
    reg [47:0]  uart_data;
	reg rev_valid;
	reg valid_reg1,valid_reg2,valid_reg3,valid_reg4;
   
   //波特率产生模块 
    baud_rate #(100000000,115200)	
    	baud_rate_i(	
							.clk(clk_100M),	//波特率选择模块
							.rst(!rst_n),
							.bps_start(rev_dry),
							.clk_bps(clk_bps1)
						);
    
    
    
    //接收数据模块
	 uart_rx	
	 	uart_rx_i(
						.clk (clk_100M),
						.rst (!rst_n),
						.rs232_rx (uart_rx),
						.rx_data (rev_data),
						.rx_int (),
						.clk_bps (clk_bps1),
						.bps_start (rev_dry),
						.error_flg (rev_error)
				);
    

	reg rev_dry_d1,rev_dry_d2;
	reg [7:0] uart_head;
	
	reg  [20:0]	delay_count;
	reg			en_count;
	
	reg [4:0] status_uart;
	parameter 
			status_idle =  0 ,
			status_addr1 = 1 ,
			status_addr2 = 2 ,
			status_data1 = 3 ,
			status_data2 = 4 ,
			status_data3 = 5 ,
			status_data4 = 6 ,
			status_head1 = 7,
			status_head2 = 8;
		
	wire rev_dry_negedge ;
	assign rev_dry_negedge = (~rev_dry_d1) && (rev_dry_d2);		
	
	//wire uart_rx_2;
	//assign uart_rx_2 = uart_rx; 
	
	always @(posedge clk_100M or negedge rst_n)
	begin
			if(!rst_n) begin
					rev_dry_d1  <= 1'b0;
					rev_dry_d2  <= 1'b0;
					status_uart <= status_idle;
					uart_data    <= 8'd0;
					rev_valid   <= 1'b0;
					delay_count <= 'd0;
					en_count <= 'd0;
			end
			else begin
					rev_dry_d1 <= rev_dry;
					rev_dry_d2 <= rev_dry_d1;
	
					case (status_uart)
					
					status_idle:
					begin
					   rev_valid  <= 1'b0;
						if(en_count == 0)
						begin
							if(rev_dry_negedge == 1'b1) begin
							  uart_head <= rev_data;
							  status_uart<= status_head1;
							 end
						 end
						 else
						 begin
							delay_count <= delay_count + 1'b1;
							if(delay_count > 100000)
							begin
								en_count <= 1'b0;
							end
						 end
					end
					
					status_head1:
					begin
						uart_data <= 48'd0;
						if(rev_dry_negedge == 1'b1) begin
						  if((uart_head == 8'h55) && (rev_data == 8'h55)) begin
								status_uart <= status_addr1;
						  end						  
						  else begin
								en_count <= 1'b1;
								delay_count <= 'd0;
								status_uart <= status_idle;
						  end
					    end					
					end
					
					status_addr1:
					begin
							rev_valid <= 1'b0;
							if(rev_dry_negedge == 1'b1) begin							
								uart_data[47:40] <= rev_data;  //16位地址
								status_uart <= status_addr2;   //如果16位地址					
							end
					end
			
					status_addr2:
					begin
							rev_valid <= 1'b0;
							if(rev_dry_negedge == 1'b1) begin
								uart_data[39:32] <= rev_data;
								status_uart <= status_data1;
							end
					end
				
					
					status_data1:
					begin
							rev_valid <= 1'b0;
							if(rev_dry_negedge == 1'b1) begin
								uart_data[31:24] <= rev_data;
								status_uart <= status_data2; 
              end								
					end
					
					status_data2:
					begin
							rev_valid <= 1'b0;
							if(rev_dry_negedge == 1'b1) begin
								uart_data[23:16] <= rev_data;
								status_uart <= status_data3; 
							end	
					end
			
			    status_data3:
					begin
							rev_valid <= 1'b0;
							if(rev_dry_negedge == 1'b1) begin
								uart_data[15:8] <= rev_data;
								status_uart <= status_data4; 
							end
					end
					
					status_data4:
					begin
							if(rev_dry_negedge == 1'b1) begin
								rev_valid <= 1'b1;
								uart_data[7:0] <= rev_data;
								status_uart <= status_idle; 
							end	
					end
					
					endcase
			
			end
	end
	
	always @(posedge clk_100M )
	begin
		valid_reg1 <= rev_valid;
		valid_reg2 <= valid_reg1;
		valid_reg3 <= valid_reg2;
		valid_reg4 <= valid_reg3;
	end
	
	always @(posedge clk_100M )
	begin
		if({valid_reg1,valid_reg2}==2'b10)begin
			data <= uart_data;
		end
		else begin
			data <= data;
		end
	end
	
	always @(posedge clk_100M)
	begin
		if({valid_reg3,valid_reg4}==2'b10)begin
			valid <= 1'b1;
		end
		else begin
			valid <= 1'b0;
		end
	end
		

endmodule
