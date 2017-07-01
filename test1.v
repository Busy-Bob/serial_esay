// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.0.0 Build 156 04/24/2013 SJ Full Version"
// CREATED		"Sun Jul 02 00:20:23 2017"

module test1(
	clk250,
	key,
	reset,
	clk9600,
	value,
	ser,
	off_number,
	show_value
);


input wire	clk250;
input wire	key;
input wire	reset;
input wire	clk9600;
input wire	[3:0] value;
output wire	ser;
output wire	[2:0] off_number;
output wire	[15:0] show_value;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	[4:0] SYNTHESIZED_WIRE_2;
wire	[63:0] SYNTHESIZED_WIRE_3;





key_out	b2v_inst(
	.IN_clk(clk250),
	.IN_key(key),
	.IN_reset(reset),
	.IN_shank_hand(SYNTHESIZED_WIRE_0),
	.IN_value(value),
	.OUT_finish(SYNTHESIZED_WIRE_1),
	.OUT_number(SYNTHESIZED_WIRE_2),
	.OUT_off_number(off_number),
	.OUT_show_value(show_value),
	.OUT_value(SYNTHESIZED_WIRE_3));


serial_output	b2v_inst2(
	.IN_clk(clk9600),
	.IN_finish(SYNTHESIZED_WIRE_1),
	.IN_number(SYNTHESIZED_WIRE_2),
	.IN_value(SYNTHESIZED_WIRE_3),
	.OUT_ser(ser),
	.OUT_shanke_hand(SYNTHESIZED_WIRE_0));


endmodule
