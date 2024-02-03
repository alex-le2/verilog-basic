`timescale 1ns / 1ps

module combi_2(
	input	[7:0]	i_a,
	input	[7:0]	i_b,

	output reg 	[8:0]	o_add,
	output reg	[7:0]	o_sub,
	output reg	[15:0]	o_mul,
	output reg	[7:0]	o_div
);

	always @(*) begin
		o_add = i_a + i_b;
		o_sub = i_a - i_b;
		o_mul = i_a * i_b;
		o_div = i_a / i_b;
	end
endmodule

