module execute (
	input	CLK,
	input	RST_N,
	input	START,
	input	[1:0]	IDEN,
	input	[3:0]  	OPCODE,
	input	[15:0] OUT_ADDRESS_MEMORY,	// input mem[ADDRESS]
	output	[15:0] IN_ADDRESS_MEMORY,	// output mem[ADDRESS]
	output	[15:0] RESULT
);

reg [15:0] ia_mem;
reg [15:0] ar;	// Arithmetic Register : 누산기
reg greater, equal, less;

wire [7:0] 	result_add;
wire [7:0] 	result_sub;
wire [15:0]	result_mul;
wire [15:0]	result_left;
wire [15:0]	result_right;
wire GREATER;
wire EQUAL;
wire LESS;

assign IN_ADDRESS_MEMORY = ia_mem;
assign RESULT = ar;

ADD_SUB U_ADD (
	.c_in(1'b0),
	.x(ar),
	.y(OUT_ADDRESS_MEMORY),
	.sum(result_add)
);

ADD_SUB U_SUB (
	.c_in(1'b1),
	.x(ar),
	.y(OUT_ADDRESS_MEMORY),
	.sum(result_sub)
);

booth_multiplier U_MUL(
	.multiplier(ar),
	.multiplicand(OUT_ADDRESS_MEMORY),
	.product(result_mul)
);

Barrel_Shifter U_Shift (
	.number(ar),
	.n(OUT_ADDRESS_MEMORY),
	.result_l(result_left),
	.result_r(result_right)
);

comparator U_COM (
	.a(ar),
	.b(OUT_ADDRESS_MEMORY),
	.GREATER(GREATER),
	.EQUAL(EQUAL),
	.LESS(LESS)
);

always @(posedge CLK, negedge RST_N) begin
	if (!RST_N) begin
		ia_mem <= 16'b0;
		ar 	<= 0;
	end

	else begin
		if (START) begin
			if (IDEN == 2'b01) begin
				case (OPCODE)
					4'b0000 : ar <= OUT_ADDRESS_MEMORY;
					4'b0001 : ar <= result_add;
					4'b0010 : ar <= result_sub;
					4'b0011 : ar <= result_mul;
					4'b0100 : ar <= result_left;
					4'b0101 : ar <= result_right;
					4'b0110 : ar <= ar + 1;
					4'b0111 : ar <= ar - 1;
					4'b1000 : begin 
						greater <= GREATER;
						equal <= EQUAL;
						less <= LESS;
					end
					4'b1111 : ia_mem <= ar;
					default   : ar <= 0;
				endcase
			end

			else begin
				ar <= OUT_ADDRESS_MEMORY;
			end
		end
	end
end

endmodule
