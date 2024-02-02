`timescale 1ns / 1ps

module d_ff (

//define input signals
	input clk,
	input sync_reset,
	input async_reset,
	input async_reset_n,
	input i_value,		//this is input value

//now, define output signals
	output reg o_value_sync_reset,
	output reg o_value_async_reset,
	output reg o_value_async_reset_n,
	output reg o_value_mixed_reset,
	output reg o_value_no_reset
);


//1. sync_reset D FlipFlop
	always @ (posedge clk) begin
		if(sync_reset) begin
			o_value_sync_reset <= 1'b0;
		end
		else begin
			o_value_sync_reset <= i_value;
		end
	end

//2. async_reset D FF
	always @ (posedge clk or posedge async_reset) begin
		if(async_reset) begin
			o_value_async_reset <= 1'b0;
		end
		else begin
			o_value_async_reset <= i_value;
		end
	end

//3. async_reset_n D FF
	always @ (posedge clk or negedge async_reset_n) begin
		if(!async_reset_n) begin
			o_value_async_reset_n <= 1'b0;
		end
		else begin
			o_value_async_reset_n <= i_value;
		end
	end		

//4. mixed_reset D FF
	always @ (posedge clk or posedge async_reset) begin
		if(async_reset) begin
			o_value_mixed_reset <= 1'b0;
		end
		if(sync_reset) begin
			o_value_mixed_reset <= 1'b0;
		end
		else begin
			o_value_mixed_reset <= i_value;			
		end
	end	

//5. no reset value
	always @ (posedge clk) begin
		o_value_no_reset <= i_value;
	end
endmodule


