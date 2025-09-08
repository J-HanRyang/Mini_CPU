module comparator (
	input [7:0] a,
	input [7:0] b,
	output GREATER,
	output EQUAL,
	output LESS
);

reg greater;
reg equal;
reg less;

assign GREATER = greater;
assign EQUAL = equal;
assign LESS = less;

always @(*) begin
	if (a > b) begin
		greater = 1;
		equal = 0;
		less = 0;
	end

	else if (a == b) begin
		greater = 0;
		equal = 1;
		less = 0;
	end

	else begin
		greater = 0;
		equal = 0;
		less = 1;
	end
end

endmodule
