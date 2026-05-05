module single_cycle_KM
#(
	parameter in_width = 32
)
(
	input wire [in_width-1:0] A,
	input wire [in_width-1:0] B,
	output wire [2*in_width-1:0] C
);
	
	wire [in_width/2-1:0] A1, A0, B1, B0;
	
	assign A1 = A[in_width-1:in_width/2];
	assign B1 = B[in_width-1:in_width/2];
	assign A0 = A[in_width/2-1:0];
	assign B0 = B[in_width/2-1:0];
	
	wire [in_width*2-1:0] C2,C1,C0;

	assign C2 = A1*B1;
	assign C0 = A0*B0;
	assign C1 = (A1+A0)*(B1+B0) - C2 - C0;
	
	assign C = C2 + C1 + C0;
	
	
	endmodule