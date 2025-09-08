module fetch (
	input	CLK,
   	input	RST_N,
	input	[15:0] PC,		// Program Counter out
	input	[15:0] OUT_MEMORY,	// memory output
	output	[15:0] MAR,		// Memory Adderess Register
	output	[15:0] MBR,		// Memory Buffer Register
	output	START
);

reg [15:0] i_pc;	// Inner PC
reg [15:0] mar;
reg [15:0] mbr;
reg start;

assign MAR = mar;
assign MBR = mbr;
assign START = start;

always @(posedge CLK, negedge RST_N) begin
   	 if (!RST_N) begin		// 레지스터 초기화
        	i_pc  <= 0;	
        	mar  <= 0;
        	mbr  <= 0;
		start  <= 0;
    	end

	else begin
		if (start) begin
			mar <= i_pc;			// 메모리 주소 레지스터에 프로그램 카운터의 값 저장
        		mbr <= OUT_MEMORY;	// 메모리 버터 레지스터에 메모리에 저장된 명령어를 저장
        		i_pc <= i_pc + 1;			// 다음 주소를 불러오기 위해 1줄 뒤에 값을 저장
		end
    	end
end

always @(*) begin
	i_pc <= PC;	// PC값이 바뀔 때 (입력 값이 바뀔 때) i_pc값에 새로 적용
	start <= 1;
end

endmodule
