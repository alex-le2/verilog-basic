`timescale 1ns / 1ps

module counter_2024(
	input i_clk,
	input i_reset_n,
	
	output reg [10:0]	o_cnt		//2048 = 2^11
);

	always @ (posedge i_clk or negedge i_reset_n) begin
		if(!i_reset_n) begin
			o_cnt <= 11'd0;
		end
		else if (o_cnt == 2024-1)begin	//count until 0~2023
			o_cnt <= 11'd0;
		end
		else begin
			o_cnt <= o_cnt + 1;
		end
	end
endmodule
