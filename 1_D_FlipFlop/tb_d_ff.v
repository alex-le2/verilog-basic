`timescale 1ms / 1ps

module tb_d_ff;

//input signals
	reg clk;
	reg clk_en;
	reg sync_reset;
	reg async_reset;
	reg async_reset_n;
	reg i_value;
//output siganals
	wire o_value_sync_reset;
	wire o_value_async_reset;
	wire o_value_async_reset_n;
	wire o_value_mixed_reset;
	wire o_value_no_reset;

	wire g_clk;			//define gated signal

	assign g_clk = clk && clk_en;	//make gated signal
//instantiate DUT
d_ff DUT1 
(	//intput signals
	.clk(g_clk),
	.sync_reset(sync_reset),
	.async_reset(async_reset),
	.async_reset_n(async_reset_n),
	.i_value(i_value),		//this is input value

//now, output signals
	.o_value_sync_reset(o_value_sync_reset),
	.o_value_async_reset(o_value_async_reset),
	.o_value_async_reset_n(o_value_async_reset_n),
	.o_value_mixed_reset(o_value_mixed_reset),
	.o_value_no_reset(o_value_no_reset)
);

//make clock (100MHz)
always #5 clk = ~clk;

initial begin
	$display("initialzize value [%d]", $time);
	$display("No input clock [%d]", $time);
	clk			<= 0;
	clk_en			<= 0;
	sync_reset		<= 0;
	async_reset		<= 0;
	async_reset_n		<= 1;
	
	i_value			<= 1;

#50
	$display("Async Reset [%d]", $time);
	sync_reset		<= 1;
	async_reset		<= 1;
	async_reset_n		<= 0;

#10
	sync_reset		<= 0;
	async_reset		<= 0;
	async_reset_n		<= 1;

#10
	$display("Input clock [%d]", $time);
	clk_en			<= 1;

#10
	$display("Sync Reset [%d]", $time);
	sync_reset		<= 1;
#10
	sync_reset		<= 0;
#50
	$display("Finish! [%d]", $time);
$finish;
end
endmodule
