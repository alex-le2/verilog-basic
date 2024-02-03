`timescale 1ns / 1ps

module tb_exp_cal_8;

	reg 		clk;
	reg 		reset_n;
	reg 	[15:0]	in; 		//operand of power of 8
	reg 		i_valid;

	wire 	[127:0]	out;
	wire o_valid;

//instantiate DUT
exp_cal_8 DUT1 (
	.i_clk(clk),
	.i_reset_n(reset_n),
	.i_in(in),			//operand of 8 power
	.i_valid(i_valid),		//when the value is valid, this goes high value

	.o_out(out),		//power of 8
	.o_valid(o_valid)
);

	
//clock generation (100MHz)
	always #5	clk = ~clk;

integer i;
integer fd;


initial begin
//initialize values
$display("initialize value [%d]", $time);
	clk	<= 0;
	reset_n	<= 1;
	i_valid <= 0;
	in <= 0;
	fd <= $fopen("rtl_v.txt", "w");
	
#10
$display("Reset! [%d]", $time);
	reset_n	<= 0;

#10
	reset_n <= 1;
#10
@(posedge clk);
$display("Start! [%d]", $time);
	for(i = 0; i < 100; i = i + 1) begin
		@(negedge clk);
		i_valid <= 1;
		in <= i;
		@(posedge clk);
	end
	@(negedge clk);
	i_valid <= 0;
	in <= 0;
#100
$display("Finish! [%d]", $time);
$fclose(fd);
$finish;
end

	always @(posedge clk) begin
		if(o_valid) begin
			$fwrite(fd,"result = %0d\n", out);
		end
	end	

endmodule
