`timescale 1ns/1ns
module tb_PE_multi();

	logic [7:0] north, west, south, east;
	logic [15:0] out, expected;
	logic start_in, start_out, clk, rst;
	
	PE_multi #(8) dut(start_in, start_out, clk, rst, north, west, south, east, out);


	localparam PERIOD = 20;


initial begin
	clk = '0;
	forever begin
		#(PERIOD/2);
		clk = !clk;
	end
end

initial begin;
	#(PERIOD/2);
	rst = '0;
	north = '0;
	west = '0;
	start_in = '0;
	#PERIOD;
	rst = '1;
	#(PERIOD*2);
	start_in = '1;
	#PERIOD;
	rst = '0;
	north = 'h1F;
	west = 'h66;
	expected = north*west;
	#(PERIOD*3);
	north = 'h2c;
	west = 'h23;
	expected = north*west+expected;
	#(PERIOD*3);
	north = 'h45;
	west = 'h86;
	expected = north*west+expected;
	for(int i = 0; i < 6; i = i+1) begin
		#PERIOD;
	end
	$stop;
end
endmodule
