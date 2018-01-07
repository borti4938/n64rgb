// megafunction wizard: %RAM: 2-PORT%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altsyncram 

// ============================================================
// File Name: ram2port_1.v
// Megafunction Name(s):
// 			altsyncram
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 17.1.1 Internal Build 593 12/11/2017 SJ Lite Edition
// ************************************************************


//Copyright (C) 2017  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module ram2port_1 (
	data,
	rd_aclr,
	rdaddress,
	rdclock,
	rden,
	wraddress,
	wrclock,
	wren,
	q);

	input	[10:0]  data;
	input	  rd_aclr;
	input	[9:0]  rdaddress;
	input	  rdclock;
	input	  rden;
	input	[9:0]  wraddress;
	input	  wrclock;
	input	  wren;
	output	[10:0]  q;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0	  rd_aclr;
	tri1	  rden;
	tri1	  wrclock;
	tri0	  wren;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [10:0] sub_wire0;
	wire [10:0] q = sub_wire0[10:0];

	altsyncram	altsyncram_component (
				.aclr1 (rd_aclr),
				.address_a (wraddress),
				.address_b (rdaddress),
				.clock0 (wrclock),
				.clock1 (rdclock),
				.data_a (data),
				.rden_b (rden),
				.wren_a (wren),
				.q_b (sub_wire0),
				.aclr0 (1'b0),
				.addressstall_a (1'b0),
				.addressstall_b (1'b0),
				.byteena_a (1'b1),
				.byteena_b (1'b1),
				.clocken0 (1'b1),
				.clocken1 (1'b1),
				.clocken2 (1'b1),
				.clocken3 (1'b1),
				.data_b ({11{1'b1}}),
				.eccstatus (),
				.q_a (),
				.rden_a (1'b1),
				.wren_b (1'b0));
	defparam
		altsyncram_component.address_aclr_b = "CLEAR1",
		altsyncram_component.address_reg_b = "CLOCK1",
		altsyncram_component.clock_enable_input_a = "BYPASS",
		altsyncram_component.clock_enable_input_b = "BYPASS",
		altsyncram_component.clock_enable_output_b = "BYPASS",
		altsyncram_component.intended_device_family = "Cyclone 10 LP",
		altsyncram_component.lpm_type = "altsyncram",
		altsyncram_component.numwords_a = 768,
		altsyncram_component.numwords_b = 768,
		altsyncram_component.operation_mode = "DUAL_PORT",
		altsyncram_component.outdata_aclr_b = "CLEAR1",
		altsyncram_component.outdata_reg_b = "CLOCK1",
		altsyncram_component.power_up_uninitialized = "FALSE",
		altsyncram_component.ram_block_type = "M9K",
		altsyncram_component.rdcontrol_reg_b = "CLOCK1",
		altsyncram_component.widthad_a = 10,
		altsyncram_component.widthad_b = 10,
		altsyncram_component.width_a = 11,
		altsyncram_component.width_b = 11,
		altsyncram_component.width_byteena_a = 1;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ADDRESSSTALL_A NUMERIC "0"
// Retrieval info: PRIVATE: ADDRESSSTALL_B NUMERIC "0"
// Retrieval info: PRIVATE: BYTEENA_ACLR_A NUMERIC "0"
// Retrieval info: PRIVATE: BYTEENA_ACLR_B NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_ENABLE_A NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_ENABLE_B NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "8"
// Retrieval info: PRIVATE: BlankMemory NUMERIC "1"
// Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_A NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_B NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_A NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_B NUMERIC "0"
// Retrieval info: PRIVATE: CLRdata NUMERIC "0"
// Retrieval info: PRIVATE: CLRq NUMERIC "1"
// Retrieval info: PRIVATE: CLRrdaddress NUMERIC "1"
// Retrieval info: PRIVATE: CLRrren NUMERIC "0"
// Retrieval info: PRIVATE: CLRwraddress NUMERIC "0"
// Retrieval info: PRIVATE: CLRwren NUMERIC "0"
// Retrieval info: PRIVATE: Clock NUMERIC "1"
// Retrieval info: PRIVATE: Clock_A NUMERIC "0"
// Retrieval info: PRIVATE: Clock_B NUMERIC "0"
// Retrieval info: PRIVATE: IMPLEMENT_IN_LES NUMERIC "0"
// Retrieval info: PRIVATE: INDATA_ACLR_B NUMERIC "0"
// Retrieval info: PRIVATE: INDATA_REG_B NUMERIC "0"
// Retrieval info: PRIVATE: INIT_FILE_LAYOUT STRING "PORT_B"
// Retrieval info: PRIVATE: INIT_TO_SIM_X NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone 10 LP"
// Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "0"
// Retrieval info: PRIVATE: JTAG_ID STRING "NONE"
// Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "0"
// Retrieval info: PRIVATE: MEMSIZE NUMERIC "8448"
// Retrieval info: PRIVATE: MEM_IN_BITS NUMERIC "0"
// Retrieval info: PRIVATE: MIFfilename STRING ""
// Retrieval info: PRIVATE: OPERATION_MODE NUMERIC "2"
// Retrieval info: PRIVATE: OUTDATA_ACLR_B NUMERIC "1"
// Retrieval info: PRIVATE: OUTDATA_REG_B NUMERIC "1"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "2"
// Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_MIXED_PORTS NUMERIC "2"
// Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_PORT_A NUMERIC "3"
// Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_PORT_B NUMERIC "3"
// Retrieval info: PRIVATE: REGdata NUMERIC "1"
// Retrieval info: PRIVATE: REGq NUMERIC "0"
// Retrieval info: PRIVATE: REGrdaddress NUMERIC "1"
// Retrieval info: PRIVATE: REGrren NUMERIC "1"
// Retrieval info: PRIVATE: REGwraddress NUMERIC "1"
// Retrieval info: PRIVATE: REGwren NUMERIC "1"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: USE_DIFF_CLKEN NUMERIC "0"
// Retrieval info: PRIVATE: UseDPRAM NUMERIC "1"
// Retrieval info: PRIVATE: VarWidth NUMERIC "0"
// Retrieval info: PRIVATE: WIDTH_READ_A NUMERIC "11"
// Retrieval info: PRIVATE: WIDTH_READ_B NUMERIC "11"
// Retrieval info: PRIVATE: WIDTH_WRITE_A NUMERIC "11"
// Retrieval info: PRIVATE: WIDTH_WRITE_B NUMERIC "11"
// Retrieval info: PRIVATE: WRADDR_ACLR_B NUMERIC "0"
// Retrieval info: PRIVATE: WRADDR_REG_B NUMERIC "0"
// Retrieval info: PRIVATE: WRCTRL_ACLR_B NUMERIC "0"
// Retrieval info: PRIVATE: enable NUMERIC "0"
// Retrieval info: PRIVATE: rden NUMERIC "1"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: ADDRESS_ACLR_B STRING "CLEAR1"
// Retrieval info: CONSTANT: ADDRESS_REG_B STRING "CLOCK1"
// Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_A STRING "BYPASS"
// Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_B STRING "BYPASS"
// Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_B STRING "BYPASS"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone 10 LP"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
// Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "768"
// Retrieval info: CONSTANT: NUMWORDS_B NUMERIC "768"
// Retrieval info: CONSTANT: OPERATION_MODE STRING "DUAL_PORT"
// Retrieval info: CONSTANT: OUTDATA_ACLR_B STRING "CLEAR1"
// Retrieval info: CONSTANT: OUTDATA_REG_B STRING "CLOCK1"
// Retrieval info: CONSTANT: POWER_UP_UNINITIALIZED STRING "FALSE"
// Retrieval info: CONSTANT: RAM_BLOCK_TYPE STRING "M9K"
// Retrieval info: CONSTANT: RDCONTROL_REG_B STRING "CLOCK1"
// Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "10"
// Retrieval info: CONSTANT: WIDTHAD_B NUMERIC "10"
// Retrieval info: CONSTANT: WIDTH_A NUMERIC "11"
// Retrieval info: CONSTANT: WIDTH_B NUMERIC "11"
// Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "1"
// Retrieval info: USED_PORT: data 0 0 11 0 INPUT NODEFVAL "data[10..0]"
// Retrieval info: USED_PORT: q 0 0 11 0 OUTPUT NODEFVAL "q[10..0]"
// Retrieval info: USED_PORT: rd_aclr 0 0 0 0 INPUT GND "rd_aclr"
// Retrieval info: USED_PORT: rdaddress 0 0 10 0 INPUT NODEFVAL "rdaddress[9..0]"
// Retrieval info: USED_PORT: rdclock 0 0 0 0 INPUT NODEFVAL "rdclock"
// Retrieval info: USED_PORT: rden 0 0 0 0 INPUT VCC "rden"
// Retrieval info: USED_PORT: wraddress 0 0 10 0 INPUT NODEFVAL "wraddress[9..0]"
// Retrieval info: USED_PORT: wrclock 0 0 0 0 INPUT VCC "wrclock"
// Retrieval info: USED_PORT: wren 0 0 0 0 INPUT GND "wren"
// Retrieval info: CONNECT: @aclr1 0 0 0 0 rd_aclr 0 0 0 0
// Retrieval info: CONNECT: @address_a 0 0 10 0 wraddress 0 0 10 0
// Retrieval info: CONNECT: @address_b 0 0 10 0 rdaddress 0 0 10 0
// Retrieval info: CONNECT: @clock0 0 0 0 0 wrclock 0 0 0 0
// Retrieval info: CONNECT: @clock1 0 0 0 0 rdclock 0 0 0 0
// Retrieval info: CONNECT: @data_a 0 0 11 0 data 0 0 11 0
// Retrieval info: CONNECT: @rden_b 0 0 0 0 rden 0 0 0 0
// Retrieval info: CONNECT: @wren_a 0 0 0 0 wren 0 0 0 0
// Retrieval info: CONNECT: q 0 0 11 0 @q_b 0 0 11 0
// Retrieval info: GEN_FILE: TYPE_NORMAL ram2port_1.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram2port_1.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram2port_1.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram2port_1.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram2port_1_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram2port_1_bb.v FALSE
// Retrieval info: LIB_FILE: altera_mf
