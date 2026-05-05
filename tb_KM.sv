`timescale 1ns/1ns
module tb_KM();

	wire [15:0] C;
	logic [15:0] C_ex, diff;
	logic [7:0] A, B;

	assign diff = C_ex-C;
	
	assign C_ex = A*B;
	
	single_cycle_KM #(.in_width(8)) dut(.A(A), .B(B), .C(C));
	
	
	
	
	initial begin
	
		A = 0; B = 0; #10; 
		A = 145; B = 15; #10;
		A = 0; B = 15; #10;
		A = 145; B = 0; #10;
		A = '1; B = '1; #10;
		A = 0; B = 0; #10;
		A = '1; B = 135; #10;
		$stop;
	end
	
endmodule