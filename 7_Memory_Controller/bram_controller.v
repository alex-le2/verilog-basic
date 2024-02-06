`timescale 1ns / 1ps

module bram_controller #(
	parameter DWIDTH = 16,		//width
	parameter AWIDTH = 12,		//address bit #
	parameter MEM_SIZE = 3840	//length
)

(

	input	clk,
	input	reset_n,

	input	i_run,
	input	[AWIDTH-1:0]	i_num_cnt,

	output	o_idle,
	output	o_write,
	output	o_read,
	output	o_done,


	//Memory I/F
	output	[AWIDTH-1:0]	addr0,
	output			ce0,
	output			we0,
	input	[DWIDTH-1:0]	q0,
	output	[DWIDTH-1:0]	d0,

	//output read value from BRAM
	output	reg		o_valid,
	output [DWIDTH-1:0]	o_mem_data
);


	reg [1:0] c_state;		//current state
	reg [1:0] n_state;		//next state

	wire	w_done_w;		//wire write done flag
	wire	w_done_r;		//wire read done flag

	reg [AWIDTH-1:0] addr_cnt;	//This means address number, incrementing until 2^AWIDTH (Default = 2^16 = 65,536)

	//localparam for FSM
	localparam S_IDLE  = 2'b00;
	localparam S_WRITE = 2'b01;
	localparam S_READ  = 2'b10;
	localparam S_DONE  = 2'b11;

	//1. FLOW OF STATE
	always @ (posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			c_state <= S_IDLE;
		end
		else begin
			c_state <= n_state;
		end
	end

	//2. compute n_state
	always @ (*) begin
		n_state = c_state;
		case (c_state)
			S_IDLE:		if (i_run)
						n_state = S_WRITE;
			S_WRITE:	if (w_done_w)
						n_state = S_READ;
			S_READ:		if(w_done_r)
						n_state = S_DONE;
			S_DONE:		n_state = S_IDLE;
		endcase
	end

	//3. compute output
	assign o_idle  = c_state == S_IDLE;
	assign o_write = c_state == S_WRITE;
	assign o_read  = c_state == S_READ;
	assign o_done  = c_state == S_DONE;


	//count core part
	always @ (posedge clk or negedge reset_n) begin
		if(!reset_n) begin
			addr_cnt <= 0;
		end
		else if(w_done_w || w_done_r) begin
			addr_cnt <= 0;		
		end
		else if (o_write || o_read) begin
			addr_cnt <= addr_cnt + 1;
		end
	end

	assign w_done_w = o_write && (addr_cnt ==i_num_cnt - 1);
	assign w_done_r = o_read && (addr_cnt ==i_num_cnt - 1);

	//Memory I/F assignment
	assign addr0	= addr_cnt;		//address = address which increments by counter.
	assign ce0	= o_write || o_read;	//chip enable is set to HIGH value when memory is read from or written to.
	assign we0	= o_write;		
	assign d0	= addr_cnt;		//We're going to write data the same as address value.


	//vaild signal
	always @(posedge clk or negedge reset_n) begin
		if(!reset_n) begin
			o_valid <= 0;
		end
		else begin
			o_valid <= o_read;
		end
	end
	
	assign o_mem_data = q0;

endmodule
