
module multiCycle_KM
#(
	parameter in_width = 16
)
(
	input logic [in_width-1:0] A,
	input logic [in_width-1:0] B,
	input logic clk,
	input logic rst,
	output logic [2*in_width-1:0] C
);

	logic [2:0] state;
	wire [in_width/2-1:0] A1, B1, A0, B0, As, Bs;
	assign A1 = A[in_width-1:in_width/2];
	assign B1 = B[in_width-1:in_width/2];
	
	assign A0 = A[in_width/2-1:0];
	assign B0 = B[in_width/2-1:0];
	
	assign As = A1+A0;
	assign Bs = B1+B0;

	wire [in_width-1:0] C1, C0;
	assign C1 = C[2*in_width-1:in_width];
	assign C0 = C[in_width-1:0];

	always_ff@(posedge clk) begin
		if(rst)
			state <= 2'b00;
		else begin
			case (state)
				2'b00: 	begin
								state <= 2'b01;	
								C <= A1*B1<<in_width;
					end
				2'b01:	begin
								state <= 2'b10;	
								C <= C + A0*B0;
							end
				2'b10: 	begin
								state <= 2'b00;
								C <= C + ((As*Bs - C[2*in_width-1:in_width] - C[in_width-1:0])<<(in_width/2));
							end
				2'b11: 	begin
								state <= state;
								C <= '0;
							end
				default: C = 'x;
			endcase
		end
	
	end
endmodule
	
	


