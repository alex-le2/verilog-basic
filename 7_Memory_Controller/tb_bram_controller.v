`timescale 1ns / 1ps

`define ADDR_WIDTH 7
`define DATA_WIDTH 16
`define MEM_DEPTH 128

module tb_bram_controller;
	reg clk;
	reg reset_n;
	reg i_run;
	reg [`ADDR_WIDTH-1:0] i_num_cnt;
	wire o_idle;
	wire o_write;
	wire o_read;
	wire o_done;

	//Memory I/F
	wire [`ADDR_WIDTH-1:0] 	addr0;
	wire  					ce0;
	wire  					we0;
	wire [`DATA_WIDTH-1:0]  q0;
	wire [`DATA_WIDTH-1:0] 	d0;

	wire  					o_valid;
	wire [`DATA_WIDTH-1:0] 	o_mem_data;

	//clk gen (100MHz)
	always #5 clk = ~clk;

	initial begin
		//initialize value
		$display("initialize value [%0d]", $time);
			reset_n <= 1;
			clk	<= 0;
			i_run	<= 0;
			i_num_cnt <= 0;

		//reset!
		#100
		$display("Reset! [%0d]", $time);
			reset_n <= 0;
		#10
			reset_n <= 1;
		#10
		@(posedge clk);

		$display("Check IDLE [%0d]", $time);
		wait(o_idle);

		$display("Start! [%0d]", $time);
			i_num_cnt <= 7'd100;
			i_run <= 1;
		@ (posedge clk);
			i_run <= 0;

		$display("Wait Done [%0d]", $time);
		wait(o_done);

		#100
		$display("Success! [%0d]", $time);
		$finish;
	end

	//instantiate DUT
	bram_controller #(
		.DWIDTH (`DATA_WIDTH),		//width
		.AWIDTH (`ADDR_WIDTH),		//address bit #
		.MEM_SIZE (`MEM_DEPTH)		//length
)
	DUT1(
		.clk(clk),
		.reset_n(reset_n),

		.i_run(i_run),
		.i_num_cnt(i_num_cnt),

		.o_idle(o_idle),
		.o_write(o_write),
		.o_read(o_read),
		.o_done(o_done),

		//Memory I/F
		.addr0(addr0),
		.ce0(ce0),
		.we0(we0),
		.q0(q0),
		.d0(d0),

		//output read value from BRAM
		.o_valid(o_valid),
		.o_mem_data(o_mem_data)
);


	
	true_dpbram  #(
		.DWIDTH (`DATA_WIDTH),		//width
		.AWIDTH (`ADDR_WIDTH),		//address bit #
		.MEM_SIZE (`MEM_DEPTH)		//length
)
	DUT2(
		.clk(clk),

		.addr0(addr0),
		.ce0(ce0),
		.we0(we0),
		.q0(q0),
		.d0(d0),

		.addr1(),
		.ce1(),
		.we1(),
		.q1(),
		.d1()
);




endmodule
