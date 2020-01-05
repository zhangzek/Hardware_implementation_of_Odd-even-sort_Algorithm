module sort_N_tb;
	reg 		CLK;
	reg 		RSTn;
    wire [7:0] 	max;
    wire [7:0] 	min;

initial
begin
	CLK = 0;
	forever #10 CLK = ~CLK;
end

initial 
begin
	RSTn = 0;
	#10 
	RSTn = 1;
end
sort_N sort_inst (	.CLK	(CLK	),
	         		.RSTn	(RSTn	),
	         		.max	(max	),
	         		.min	(min	));

endmodule