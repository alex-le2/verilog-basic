`timescale 1ns / 1ps

module fsm_counter(

	input clk,
	input reset_n,
	input i_run,
	input [6:0]	i_num_cnt,

	output o_idle,
	output o_run,
	output o_done
);
	
	wire is_done;		//HIGH when finish running

	reg [1:0]	c_state;
	reg [1:0]	n_state;

	localparam S_IDLE = 2'b00;
	localparam S_RUN  = 2'b01;
	localparam S_DONE = 2'b10;

	//1. flow of state
	always @ (posedge clk or negedge reset_n) begin
		if(!reset_n) begin
			c_state <= S_IDLE;
		end
		else begin
			c_state <= n_state;
		end
	end

	//2. compute n_state
	always @ (*) begin
//		n_state = S_IDLE	//prevent latch -> this code replace with default case
		case(c_state)
		S_IDLE: if(i_run)
				n_state = S_RUN;
		S_RUN: if(is_done)
				n_state = S_DONE;
		S_DONE: n_state = S_IDLE;
		default: n_state = S_IDLE;
		endcase	
	end

	//3. implement count logic
	reg	[6:0]	r_cnt;		//be able to count 2^7 = 128

	always @(posedge clk or negedge reset_n) begin
		if(!reset_n) begin
			r_cnt <= 7'd0;
		end
		else if(r_cnt == i_num_cnt - 1) begin
			r_cnt <= 7'd0;
		end
		else if (o_run) begin
			r_cnt <= r_cnt + 1'b1;;
		end
		else begin
			r_cnt <= 7'd0;
		end
	end
	
	//3.5 make HIGH is_done value when finish counting
	assign is_done = o_run && (r_cnt == i_num_cnt - 1);

	//4. compute output (assign idle, run, done signal)
	assign o_idle = c_state == S_IDLE;
	assign o_run  = c_state == S_RUN;
	assign o_done = c_state == S_DONE;

endmodule
