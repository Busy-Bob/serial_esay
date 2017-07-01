// clk 9600

// finish 要持续整个时间
// temp_value
// 可以不用固定IN_
module serial_output(input IN_clk, input IN_finish, input [63:0] IN_value, input [4:0] IN_number,
					output reg OUT_ser, output reg OUT_shanke_hand);

	reg [3:0] temp_number = 0;
	reg [9:0] temp_result = 0;
	reg [3:0] k = 0;
	reg [159:0] ser = 160'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
	reg [63:0] value = 0;
	
	reg flag = 0;
	reg [7:0] n = 0;
//	reg [5:0] max_n = 0;  可以直接固定输出数目
	
	always @(IN_number)
	begin 
		ser = 160'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
		k = 0;
//		max_n = 4'd10 * IN_number;
		value = IN_value;
		repeat(16)
		begin
			if(IN_number > k)
				begin
					temp_number = value >> 4*k;
					temp_result = change_ascii(temp_number);
					{ser,temp_result} = {ser,temp_result} << 10;
					k = k + 1;
				end
			else
				begin
					ser = ser;
					temp_number = 0;
					temp_result = 0;
				end
			
		end
	end
	
//	always @(posedge IN_finish)
//	begin
//		flag = 1;
//	end
	
	always @(posedge IN_clk, posedge IN_finish)
	begin
		if(IN_finish)
			begin
				if(n == 0)
					begin 
						flag <= 1;
					end
				else
					flag <= flag;
				if(flag)
					begin
						if(OUT_shanke_hand)//此次已经输出完，保持
							begin
								n = 0;
								OUT_ser = 1;
							end
						else //还未输出
							begin
								OUT_ser = ser[n];
								n = n + 1;
								if(n >= 8'd160)
									begin
										OUT_shanke_hand = 1;
										n = 0;
									end
								else
									OUT_shanke_hand = 0;
							end
					end
				else
					begin
						OUT_ser = 1;
					end
			end
		else
			begin
				flag = 0;
				OUT_shanke_hand = 0;
				n = 0;
				OUT_ser = 1;
			end
	end
//	
/* 	always @(posedge IN_begin_out)
	begin
		if()
	end */
	
	function [9:0] change_ascii;
	input [3:0] a;
	begin
		change_ascii = {1'b1, {4'h0,a}+8'd48, 1'b0};
	end
	endfunction
	
//	function [7:0] reverse;
//	input [7:0] x;
//	begin
//		reverse = (x & 8'h0F) << 4 + (x & 8'hF0) >> 4;
//		reverse = (reverse & 8'h33) << 2 + (reverse & 8'hCC) >> 2;
//		reverse = (reverse & 8'h55) << 1 + (reverse & 8'hAA) >> 1;
//	end
//	endfunction
	
endmodule 