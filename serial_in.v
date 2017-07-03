//s0检测是否有0；
//s1 检测到0之后进行数据的处理
//s2 信号消失，给出握手信号
// 可以检测没有停止位的情况
// 9600*16Hz
// out_number 表示输出的数字的数量
module serial_in(input IN_clk, input IN_ser,
						output reg [63:0] OUT_data, output reg OUT_shanke_hand, output reg [4:0] OUT_number, output [2:0] OUT_off_number);

	reg [1:0] state = 0;
	reg [3:0] flag = 0;
	reg [3:0] number_bit = 0;
	reg [7:0] temp_ascii = 0;
//	reg delay; //跳过结束段，等待信号起始端
	parameter s0 = 0, s1 = 1, s2 = 2;
	
	assign OUT_off_number = (OUT_number >= 5'd4)? 0 : 4 - OUT_number;
	
	always @(posedge IN_clk)
	begin
		case(state)
			s0:
				begin
					if(!IN_ser)//起始信号
						begin
							if(flag == 4'b1000)
								begin 
									state = s1;
									number_bit = 0;
									flag = 0;
									OUT_data = 0;
									OUT_shanke_hand = 0;
									OUT_number = 0;
								end
							else
								begin
									state = s0;
									flag = flag + 1;
									OUT_shanke_hand = 0;
								end
						end
					else
						begin
							flag = 0;
							state = s0;
							number_bit = 0;
							OUT_data = OUT_data;
							OUT_shanke_hand = 0;
							OUT_number = OUT_number;
						end
				end
			s1:
				begin
					if(flag == 4'hF)
						begin
							temp_ascii = {temp_ascii,IN_ser};
							number_bit = number_bit + 1;
							flag = 0;
						end
					else
						begin
//							temp_ascii = 0;
//							number_bit = number_bit + 1;
							flag = flag + 1;
						end
					
					// 下面可以加一些条件 == 9 判断结束位是否有效
					if(number_bit == 4'd8)
						begin
							state = s1;
							
							if(flag == 0)
								begin
									OUT_number = OUT_number + 1; //当第一次到的时候
									OUT_data = {OUT_data,change_number(temp_ascii)};
								end
						end
					else if(number_bit == 4'd10)
						begin
			
							if(temp_ascii[0])// 不是开头
								begin
									state = s2;
									number_bit = 0;
									// 待加
								end
							else
								begin
									state = s1;
									number_bit = 0;
								end
						end
					else
						begin
							state = s1;
							
						end
				end
			s2:
				begin
					OUT_shanke_hand = 1;
					state = s0;
				end
			default:
				begin
					state = 0;
				end
		endcase
	end
						
	//增加if条件可以增加字母的识别					
	function [3:0] change_number;
	input [7:0] a;
	begin
		change_number = reverse(a) - 8'd48;
	end
	endfunction					
	
	// verilog中加减运算符优先级高于逻辑运算符和移位运算符！！！！！！！！！！！！,C也是这样的
	function [7:0] reverse;
	input [7:0] x;
	begin
		reverse = ((x & 8'h0F) << 4) + ((x & 8'hF0) >> 4);
		reverse = ((reverse & 8'h33) << 2) + ((reverse & 8'hCC) >> 2);
		reverse = ((reverse & 8'h55) << 1) + ((reverse & 8'hAA) >> 1);
	end
	endfunction						
endmodule 