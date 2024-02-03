`timescale 1ns / 1ps

module tb_fsm_test;

	reg clk;
	reg reset_n;
	reg i_run;

	wire o_done;
//clk gen (100MHz)
	always #5 clk = ~clk;

initial begin
//initialize values
	$display("initialize values [%d]", $time);
		clk <= 0;
		reset_n <= 1;
		i_run <= 0;

	#10
	$display("Reset! [%d]", $time);
		reset_n <= 0;

	#10
		reset_n <= 1;

	@(posedge clk)
	$display("Start [%d]", $time);
		i_run <= 1;
	@(posedge clk)
	 	i_run <= 0;
	#100
	$display("Finish! [%d]", $time);
	$finish;
end
	
//instantiate DUT
fsm_test DUT1(
	.clk(clk),
	.reset_n(reset_n),
	.i_run(i_run),

	.o_done(o_done)
);

endmodule
