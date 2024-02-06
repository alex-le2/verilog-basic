`timescale 1ns / 1ps

module true_dpbram #(
	parameter DWIDTH = 16,
	parameter AWIDTH = 12,
	parameter MEM_SIZE = 3840
)

(
	input clk,

	input [AWIDTH-1:0] addr0,
	input ce0,
	input we0,
	output reg[DWIDTH-1:0] q0,
	input [DWIDTH-1:0] d0,

	input [AWIDTH-1:0] addr1,
	input ce1,
	input we1,
	output reg[DWIDTH-1:0] q1,
	input [DWIDTH-1:0] d1
);

	//define the memory style
	(* ram_style = "block" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

	always @(posedge clk) begin
		if(ce0) begin
			if(we0)
				ram[addr0] <= d0;	//if write mode, write.
			else
				q0 <= ram[addr0];	//else if read mode, read.
		end
	end

	always @(posedge clk) begin
		if(ce1) begin
			if(we1)
				ram[addr1] <= d1;	//if write mode, write.
			else
				q1 <= ram[addr1];	//else if read mode, read.
		end
	end

endmodule
