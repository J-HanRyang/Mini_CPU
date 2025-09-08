`timescale 1ns/100ps

module mini_cpu_tb;
reg  CLK;
reg  RST_N;
reg  [15:0] PC;

wire [7:0]  ADDRESS;
wire [15:0] MAR;
wire [15:0] RESULT;
wire [15:0] OUT_MEMORY;
wire [15:0] OUT_ADDRESS_MEMORY;
wire [15:0] IN_ADDRESS_MEMORY;

mini_cpu U_CPU (
	.CLK(CLK),
	.RST_N(RST_N),
	.PC(PC),
	.RESULT(RESULT),
	.OUT_MEMORY(OUT_MEMORY),
	.MAR(MAR),
	.ADDRESS(ADDRESS),
	.IN_ADDRESS_MEMORY(IN_ADDRESS_MEMORY),
	.OUT_ADDRESS_MEMORY(OUT_ADDRESS_MEMORY)
);


cpu_memory U_MEMORY (
	.ADDRESS(ADDRESS),
	.MAR(MAR),
	.IN_ADDRESS_MEMORY(IN_ADDRESS_MEMORY),
	.OUT_ADDRESS_MEMORY(OUT_ADDRESS_MEMORY),
	.OUT_MEMORY(OUT_MEMORY)
);


initial begin
	CLK = 0;
	RST_N = 0;

	#10 RST_N = 1;

	#30 PC = 16'd100;
	
	#160 $finish;
end

always #5 CLK = ~CLK;

endmodule

