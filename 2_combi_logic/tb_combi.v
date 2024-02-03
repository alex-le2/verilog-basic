`timescale 1ns / 1ps

module tb_combi;

	reg [7:0]	i_a;
	reg [7:0]	i_b;

	wire [8:0]	o_add_1;
	wire [7:0]	o_sub_1;
	wire [15:0]	o_mul_1;
	wire [7:0]	o_div_1;

	wire [8:0]	o_add_2;
	wire [7:0]	o_sub_2;
	wire [15:0]	o_mul_2;
	wire [7:0]	o_div_2;

//Instantiate the module
combi_1 DUT1(
	.i_a(i_a),
	.i_b(i_b),

	.o_add(o_add_1),
	.o_sub(o_sub_1),
	.o_mul(o_mul_1),
	.o_div(o_div_1)
);

combi_2 DUT2(
	.i_a(i_a),
	.i_b(i_b),

	.o_add(o_add_2),
	.o_sub(o_sub_2),
	.o_mul(o_mul_2),
	.o_div(o_div_2)
);

//NO clock USE in Combinational logic teset 
//make clock (100MHz)
//always #5 clk = ~clk;

//Verification logic
initial begin
	$display("initialize value [%d]", $time);
#10
	i_a = 8'd30;
	i_b = 8'd10;
#50
	$display("Add_1 : %d [%d]", o_add_1, $time);
	$display("Sub_1 : %d [%d]", o_sub_1, $time);
	$display("Mul_1 : %d [%d]", o_mul_1, $time);
	$display("Div_1 : %d [%d]", o_div_1, $time);

	$display("Add_2 : %d [%d]", o_add_2, $time);
	$display("Sub_2 : %d [%d]", o_sub_2, $time);
	$display("Mul_2 : %d [%d]", o_mul_2, $time);
	$display("Div_2 : %d [%d]", o_div_2, $time);

//checker
	if(o_add_1 == o_add_2) begin
		$display("Pass Add!");
	end
	else begin
		$display("Fail Add!");
	end

	if(o_sub_1 == o_sub_2) begin
		$display("Pass Sub!");
	end
	else begin
		$display("Fail Sub!");
	end

	if(o_mul_1 == o_mul_2) begin
		$display("Pass Mul!");
	end
	else begin
		$display("Fail Mul!");
	end

	if(o_div_1 == o_div_2) begin
		$display("Pass Div!");
	end
	else begin
		$display("Fail Div!");
	end

$finish;
end

endmodule
