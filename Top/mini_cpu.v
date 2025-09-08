module mini_cpu (
	input  CLK,
	input  RST_N,
	input	 [15:0] PC,
	input	 [15:0] OUT_ADDRESS_MEMORY,
	input	 [15:0] OUT_MEMORY,
	output [7:0] ADDRESS, 
	output [15:0] MAR,
	output [15:0] IN_ADDRESS_MEMORY,
	output [15:0] RESULT
);

wire [15:0] 	MBR;
wire [1:0]   	IDEN;
wire [3:0]   	OPCODE;
wire 		START;

// Instance fetch
fetch U_FETCH (
	.CLK(CLK),
	.RST_N(RST_N),
	.PC(PC),
	.OUT_MEMORY(OUT_MEMORY),
	.MAR(MAR),
	.MBR(MBR),
	.START(START)
);

// Instance decode
decode U_DECODE (
	.MBR(MBR),
	.IDEN(IDEN),
	.OPCODE(OPCODE),
	.ADDRESS(ADDRESS)
);

// Instatnce execute
execute U_EXECUTE (
	.CLK(CLK),
	.RST_N(RST_N),
	.IDEN(IDEN),
	.OPCODE(OPCODE),
	.OUT_ADDRESS_MEMORY(OUT_ADDRESS_MEMORY),
	.IN_ADDRESS_MEMORY(IN_ADDRESS_MEMORY),
	.RESULT(RESULT),
	.START(START)
);

endmodule
