//最多储存16位数字
// clk  250Hz

module key_out(input IN_clk, input [3:0] IN_value, input IN_key, input IN_reset, input IN_shank_hand,
				output reg [63:0] OUT_value, output reg [4:0] OUT_number, output reg OUT_finish, output [2:0] OUT_off_number, output [15:0] OUT_show_value);
	
	initial
	begin
		OUT_number = 0;
		OUT_value = 0;
		OUT_finish = 0;
	end
			
	assign OUT_off_number = (OUT_number >= 5'd4)? 0 : 4 - OUT_number;
	assign OUT_show_value = OUT_value[15:0];
	always @(posedge IN_clk or negedge IN_reset)
		begin
			if(!IN_reset)
				begin
					OUT_value <= 0;
					OUT_number <= 0;
					OUT_finish <= 0;
				end
			else if(IN_key)
				begin
					if(IN_value <= 9 && OUT_number <= 16)
						begin
							OUT_value <= {OUT_value, IN_value};
							OUT_number <= OUT_number + 1;
						end
					else if(IN_value == 4'hE)//C
						begin
							OUT_number <= OUT_number - 1;
							OUT_value <= OUT_value >> 4;
						end
					else if(IN_value == 4'hF)// =
						begin
							OUT_finish <= 1;
						end
					else
						begin
							OUT_value <= OUT_value;
						end
				end
			else
				begin
					OUT_value <= OUT_value;
					if(IN_shank_hand)
						OUT_finish <= 0;
					else
						OUT_finish <= OUT_finish;
				end
				
		end

endmodule 