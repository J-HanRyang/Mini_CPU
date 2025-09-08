module booth_substep#(
	parameter N = 8
)(
	input signed [N-1:0] acc,
	input signed [N-1:0] Q,
	input signed q0,
	input signed [N-1:0] multiplicand,
	output reg signed [N-1:0] next_acc,
	output reg signed [N-1:0] next_Q,
	output reg q0_next
);
    
wire [N-1:0] addsub_temp;
	
ADD_SUB U_ADD_SUB(Q[0], acc, multiplicand, addsub_temp);
	
always @(*) begin	
	if(Q[0] == q0) begin
        	q0_next = Q[0];
        	next_Q = Q>>1;
        	next_Q[N-1] = acc[0];
        	next_acc = acc>>1;

		if (acc[N-1] == 1)
                	next_acc[N-1] = 1;
		end

		else begin
           		q0_next = Q[0];
			next_Q = Q>>1;
            		next_Q[N-1] = addsub_temp[0];
			next_acc = addsub_temp>>1;
			if (addsub_temp[N-1] == 1) begin
                		next_acc[N-1] = 1;
			end
		end			
	end	
endmodule 
