
module multiCycle_KM
#(
	param in_width = 16
)
(
	input logic [in_width:0] A,
	input logic [in_width:0] B,
	input logic clk,
	input logic rst,
	output logic [2*in_width:0] C
)

	logic [2:0] state;
	wire [in_width/2-1:0] A1, B1, A0, B0, As, Bs;
	assign A1 = A[in_width-1:in_width];
	assign B1 = B[in_width-1:in_width];

	always_ff@(posedge clk, negedge rst) begin
		if(!rst)
			state <= 2'b00;
		else begin
			if (state = 2'b10)
				state <= 2'b00;
			else
				state <= state + 1;
	end
	
	always_ff@(posedge clk, negedge rst) begin
		case (state) begin
			2'b00: 	begin
							state <= 2'b01;	
							C <= A1*B1<<in_width;
						end
			2'b01:	begin
							state <= 2'b10;	
							C = C + A0*B0;
						end
			2'b10: 	begin
							state <= 2'b00;
							C = C + ((A1+A0)*(B1+B0) - A1*B1 - A0*B0)<<(in_width/2);
						end
			default: begin
							state = '0;
							C = '0;
						end
		
		endcase

	
	end
	
	


