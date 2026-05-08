`timescale 1ns/1ns
module tb_multiCycle_KM();
	
	logic clk, rst;
	logic [7:0] A, B;
	logic [15:0] C, Cex;
	
	assign Cex = A*B;
	
	multiCycle_KM #(8) dut(A, B, clk, rst, C);
	
initial begin
	clk = 0;
	forever begin
		#10;
		clk = !clk;
	end
end

initial begin
	A = 'h12345678;
	B = 'h91602f23;
	rst = 0;
	#5;
	rst = 1;
	#10;
	rst = 0;

	#80;
	$stop;
end




endmodule