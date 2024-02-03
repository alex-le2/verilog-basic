`timescale 1ns / 1ps

module tb_counter_2024;
	reg clk;
	reg reset_n;

	wire [10:0]	w_cnt;

//instantiate DUT
counter_2024 DUT1(	
	.i_clk(clk),
	.i_reset_n(reset_n),
	
	.o_cnt(w_cnt)
);


//clock generate (100MHz)
always #5 clk = ~clk;

integer count_1_cycle = 0;		//detect the first 2023th count

initial begin
//initialize values
$display("initialize values [%d]", $time);
	reset_n <= 1;
	clk	<= 0;

#100
$display("Reset! [%d]", $time);	
	reset_n <= 0;

#10
	reset_n <= 1;

#5
$display("Start! [%d]", $time);

//#20220
//$display("Count 2023! [%d]", $time);

repeat (2023) begin
	@(posedge clk);
	count_1_cycle = count_1_cycle + 1;
end
$display("Count 2023! [%d]", $time);

#500
$display("Finish! [%d]", $time);
$finish;
end
endmodule
