`timescale 1ns / 1ps

module tb_fsm_counter;

	reg clk;
	reg reset_n;

	reg 		i_run;
	reg [6:0]	i_num_cnt;

	wire o_idle;
	wire o_run;
	wire o_done;

	//clock gen (100MHz)
	always #5 clk = ~clk;

	initial begin
	//initialize values
	$display("Initialize values [%d]", $time);
		clk <= 0;
		reset_n <= 1;
		i_run <= 0;
		i_num_cnt <= 7'd0;

	#10
	$display("Reset! [%d]", $time);
		reset_n <= 0;

	#10
		reset_n <= 1;
	#10
	@ (posedge clk);

	$display("Check IDLE! wait o_idle [%d]", $time);
	wait(o_idle);

	$display("Start! [%d]", $time);
		i_run <= 1;
		i_num_cnt <= 7'd100;

	@ (posedge clk)
		i_run <= 0;

	wait(o_done);
	$display("Finish counting! [%d]", $time);
	#100

	$finish;
	end
	
	//instantiate DUT
	fsm_counter DUT1(
			.clk(clk),
			.reset_n(reset_n),
			.i_run(i_run),
			.i_num_cnt(i_num_cnt),

			.o_idle(o_idle),
			.o_run(o_run),
			.o_done(o_done)
	);


endmodule
