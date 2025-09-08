module Barrel_Shifter (
	input 	[15:0] number,
	input 	[3:0] n,
	output 	[15:0] result_l,
	output	[15:0] result_r
);

assign result_l = number << n;
assign result_r = number >> n;

endmodule
