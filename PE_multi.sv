module PE_multi
#(
	//parameter cycle_count = 3,
	parameter in_width = 16
)
(


	input logic start_in,
	output logic start_out,
	input logic clk,
	input logic rst,
	
	input logic [in_width-1:0] in_north,
	input logic [in_width-1:0] in_west,
	input logic [in_width-1:0] out_south,
	input logic [in_width-1:0] out_east,
	output logic [2*in_width-1:0] Accum_Reg
);
	

	logic [2:0] state;
	logic [in_width-1:0] A_reg, B_reg;
	logic [2*in_width-1:0] mult_out;
	logic mult_rst;
	
	
	multiCycle_KM #(in_width) multiplier(A_reg, B_reg, clk, mult_rst, mult_out);
	
always_ff@(posedge clk) begin
	if(rst) begin
		state <= '0;
		A_reg <= '0;
		B_reg <= '0;
		Accum_Reg <= '0;
		mult_rst <= '1;
	end
	else if(start_in) begin
		case(state)
			0: begin	//Step 0, load register and reset the multiplier
					A_reg <= in_north;
					B_reg <= in_west;
					mult_rst <= '0;
					state = state+1;
				end
			1: begin
					mult_rst <= 0;
					state = state+1;
				end
			2: state = state+1;
			3: begin 
				state = state+1;
				A_reg <= in_north;
				B_reg <= in_west;
			   end
			4:	begin
					Accum_Reg = Accum_Reg+mult_out;
					state = 2;
				end
			5: begin
					
				end
		endcase
			

	end
end

always_ff@(posedge clk) begin
	start_out <= start_in;
end

endmodule

