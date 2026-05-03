`timescale 1ns/1ns
module tb_KM();

	
	logic [15:0] C, C_ex;
	logic [7:0] A, B;
	
	assign C_ex = A*B;
	
	single_cycle_KM #(.in_width(8)) dut(.A(A), .B(B), .C(C));
	
	
	
	
	initial begin
	
		A = 0; B = 0; C = 0;
		
		
		
		#10; 
		
		A = 145;
		B = 15;
		
		
	end
	
endmodule