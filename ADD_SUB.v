module ADD_SUB#(
	parameter N = 8
)(
	input c_in,
	input [N-1:0] x, y,
	output [N-1:0] sum
);

wire     [N-1:0] t;

assign t = y ^ {N{c_in}};
assign sum = x + t + c_in;

endmodule
