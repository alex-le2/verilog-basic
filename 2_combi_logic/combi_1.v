`timescale 1ns / 1ps

module combi_1(
	input	[7:0]	i_a,
	input	[7:0]	i_b,

	output 	[8:0]	o_add,
	output	[7:0]	o_sub,
	output 	[15:0]	o_mul,
	output	[7:0]	o_div
);

	assign o_add = i_a + i_b;
	assign o_sub = i_a - i_b;
	assign o_mul = i_a * i_b;
	assign o_div = i_a / i_b;		//it's hard to synthesize

endmodule
