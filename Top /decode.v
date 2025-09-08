module decode(
 	input	[15:0]	MBR,	// 16bit Memory
	output	[1:0]	IDEN,	// [13:12] 2bit 명령어 / 메모리 식별
  	output	[3:0]	OPCODE,	// [11:8] 4bit opcode
  	output	[7:0]	ADDRESS	// 마지막 8bit address
);

reg [1:0] iden;
reg [3:0] opcode;
reg [7:0] address;

assign IDEN = iden;
assign OPCODE = opcode;
assign ADDRESS = address;

always @(*) begin
	iden	<= MBR[13:12];
	opcode 	<= MBR[11:8];
	address <= MBR[7:0];
end

endmodule
