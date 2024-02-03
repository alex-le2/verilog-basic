`timescale 1ns / 1ps

module fsm_test (
	input clk,
	input reset_n,
	input i_run,

	output reg o_done
);
	
//state values to use FSM
	reg [1:0]	c_state;	//current state
	reg [1:0]	n_state;	//next state

//reg_done is temporarily High
	wire is_done = 1'b1;
	
	localparam S_IDLE = 2'b00;
	localparam S_RUN  = 2'b01;
	localparam S_DONE = 2'b10;

//flow of state
	always @ (posedge clk or negedge reset_n) begin
		if(!reset_n) begin
			c_state <= S_IDLE;
		end
		else begin
			c_state <= n_state;
		end
	end

//compute n_state
	always @ (*) begin
		n_state = S_IDLE;	//to prevent latch
		case(c_state)
		S_IDLE: if(i_run)
				n_state = S_RUN;
		S_RUN: if(is_done)
				n_state = S_DONE;
		S_DONE: n_state = S_IDLE;
		endcase	
	end

//compute output
	always @ (*) begin
		o_done = 0;
		case(c_state)
		S_DONE: o_done = 1;
		endcase
	end
endmodule
