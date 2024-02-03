`timescale 1ns / 1ps

module exp_cal_8(
	input		i_clk,
	input		i_reset_n,
	input	[15:0]	i_in,		//operand of power of 8
	input		i_valid,

	output	[127:0]	o_out,		//output of power of 8
	output		o_valid		
);

	reg	[31:0]	r_pwr_of_2;
	reg	[63:0]	r_pwr_of_4;
	reg	[127:0]	r_pwr_of_8;

	reg	[2:0]	r_valid;

//Flow of power operation
	always @ (posedge i_clk or negedge i_reset_n) begin
		if(!i_reset_n) begin
			r_pwr_of_2 <= 32'd0;
			r_pwr_of_4 <= 64'd0;
			r_pwr_of_8 <= 128'd0;
		end
		else begin
			r_pwr_of_2 <= i_in * i_in;
			r_pwr_of_4 <= r_pwr_of_2 * r_pwr_of_2;
			r_pwr_of_8 <= r_pwr_of_4 * r_pwr_of_4;
		end
	end

//Flow of valid signal
	always @ (posedge i_clk or negedge i_reset_n) begin
		if(!i_reset_n) begin
			r_valid <= 3'd0;
		end
		else begin
			r_valid <= {r_valid[1:0], i_valid};
		end
	end

	assign o_out = r_pwr_of_8;
	assign o_valid = r_valid[2];
endmodule
