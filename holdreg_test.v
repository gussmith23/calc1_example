`include "holdreg.v"

module holdreg_test;
   
   reg a_clk, b_clk, c_clk, scan_in;
   
   
   reg [0:3] req_cmd_in;
   
   reg [1:7] reset;
   
   reg [0:31] req_data_in;
   
   
   wire scan_out;
   wire [0:3] hold_prio_req;
   wire [0:31] hold_data1, hold_data2;

   holdreg H1(hold_data1, hold_data2, hold_prio_req, scan_out, a_clk, b_clk, c_clk, req_cmd_in, req_data_in, reset, scan_in);

   initial c_clk = 1'b0;
   always #100 c_clk = ~c_clk;
	
   initial
     begin

	req_cmd_in = 0;
	req_data_in = 0;
	reset[1] = 0;
	
	#600 req_cmd_in = 1;
	req_data_in = 10;
	#200 req_data_in=12;
	#200 req_cmd_in = 2;
	req_data_in = 15;

     end // initial begin
   
   always
     @ (reset or c_clk or  req_cmd_in or req_data_in) begin
	
	$display("at time %t, res=%d, reqcmd=%b, reqdata=%d, hold1=%d, hold2=%d, hold_req=%b", $time, reset[1], req_cmd_in, req_data_in, hold_data1, hold_data2, hold_prio_req);
	
	
     end
   
	
endmodule // holdreg_test
