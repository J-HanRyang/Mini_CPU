module cpu_memory(
	input	[7:0]	ADDRESS,
	input	[15:0] 	MAR,
	input	[15:0] 	IN_ADDRESS_MEMORY,
	output	[15:0]	OUT_ADDRESS_MEMORY,
	output	[15:0] 	OUT_MEMORY
);

reg [15:0] mem [0:255];	//2^8-1
reg [15:0] o_mem;
reg [15:0] oa_mem;

assign OUT_MEMORY = o_mem;
assign OUT_ADDRESS_MEMORY = oa_mem;

always @(MAR) begin
	o_mem <= mem[MAR];
end

always @(ADDRESS) begin
	oa_mem <= mem[ADDRESS];
end

always @(IN_ADDRESS_MEMORY) begin
	mem[ADDRESS] <= IN_ADDRESS_MEMORY;
end

initial begin
	// number
	mem[0] = 16'b0000_0000_0000_0000;	// start memory
	mem[1] = 16'b0000_0000_0001_0000;	// 16
	mem[2] = 16'b0000_0000_0000_0100; 	// 4
	mem[3] = 16'b0000_0000_0000_1000;	// 8
	mem[4] = 16'b0000_0000_0000_0111;	// 7
	mem[5] = 16'b0000_0000_0000_0100;	// 4
	mem[6] = 16'b0000_0000_0000_0011;	// 3
	mem[7] = 16'b0000_0001_0010_1100;	// 300
	mem[8] = 16'b0000_0001_0011_0010;	// 306
	mem[9] = 16'b0000_0001_1001_0000;	// 400

	// result
	mem[10] = 16'b0000_0000_0000_0000;	// 306

	// instruction
	mem[100] = 16'b0001_0000_0000_0001;	// ar = 16
	mem[101] = 16'b0001_0001_0000_0010;	// ar = 16 + 4 = 20
	mem[102] = 16'b0001_0011_0000_0011;	// ar = 20 * 8 = 160
	mem[103] = 16'b0001_0010_0000_0100;	// ar = 160 - 7 = 153
	mem[104] = 16'b0001_0100_0000_0101;	// ar = 153 << 4 = 153 * 16 = 2448
	mem[105] = 16'b0001_0101_0000_0110; 	// ar = 153 >> 3 = 153 / 8 = 306
	mem[106] = 16'b0001_0110_0000_0000; 	// ar = 306 + 1 = 307
	mem[107] = 16'b0001_0111_0000_0000; 	// ar = 307 - 1 = 306
	mem[108] = 16'b0001_1000_0000_0111; 	// great = 1
	mem[109] = 16'b0001_1000_0000_1000; 	// equal = 1
	mem[110] = 16'b0001_1000_0000_1001; 	// less = 1
	mem[111] = 16'b0001_1111_0000_1010; 	// mem[10] = 306
end

endmodule
