//  Library:  calc1
//  Module:  Testbenches
//  Author:  Naseer Siddique

`include "calc1_top.v"

module bigtest;

   wire [0:31] out_data1, out_data2, out_data3, out_data4;
   wire [0:1]  out_resp1, out_resp2, out_resp3, out_resp4;
   wire 	 scan_out;
   
   
   reg 	 a_clk;
   reg 	 b_clk;
   reg 	 c_clk;
   reg [0:3] 	 error_found, req1_cmd_in, req2_cmd_in, req3_cmd_in, req4_cmd_in;
   reg [0:31]  req1_data_in, req2_data_in, req3_data_in, req4_data_in;
   reg [1:7] 	 reset;
   reg	 scan_in;

   calc1_top D1(out_data1, out_data2, out_data3, out_data4, out_resp1, out_resp2, out_resp3, out_resp4, scan_out, a_clk, b_clk, c_clk, error_found, req1_cmd_in, req1_data_in, req2_cmd_in, req2_data_in, req3_cmd_in, req3_data_in, req4_cmd_in, req4_data_in, reset, scan_in);


   
   initial 
     begin
	c_clk = 0;
	a_clk = 0;
	b_clk = 0;
	scan_in = 0;
	error_found = 4'b0000;
	req1_cmd_in = 0;
	req1_data_in = 0;
	req2_cmd_in = 0;
	req2_data_in = 0;
	req3_cmd_in = 0;
	req3_data_in = 0;
	req4_data_in = 0;
     end
   
	
   always #100 c_clk = ~c_clk;
   
   initial
     begin

	reset[1] = 1;
	#800 

	  reset[1] = 0;

	#400 

	  // test 1
	  
	  req1_cmd_in = 1;
	req1_data_in = 'h0000001A;
	req2_cmd_in = 0;
	req2_data_in = 0;
	req3_cmd_in = 0;
	req3_data_in = 0;
	req4_cmd_in = 0;
	req4_data_in = 0;

	#200
	
	req1_cmd_in = 0;
	req1_data_in = 'h00000005;
		
	#1000

	  // test 2
	  
	  req1_cmd_in = 1;
	req1_data_in = 'h4a0f58d4;

	#200

	  req1_cmd_in = 0;
	req1_data_in = 'h0000f03e;

	#1000

	  // test 3
	  
	req1_cmd_in = 1;
	req1_data_in = 'h874fc0fd;
	
	#200

	  req1_cmd_in = 0;
	req1_data_in = 'h3f00f03e;

	#1000

	  // test 4
	  	  
	req1_cmd_in = 1;
	req1_data_in = 'hf74fc0fd;

	#200

	  req1_cmd_in = 0;
	req1_data_in = 'hff00f03e;

	#1000

	  // test 5
	  
	  req1_cmd_in = 1;
	req1_data_in = 'hc403c462;

	#200

	  req1_cmd_in = 0;
	req1_data_in = 'hd2aca01f;

	#1000
	  
	  // test 6
	  
	  req1_cmd_in = 2;
	req1_data_in = 'hd2aca01f;

	#200

	  req1_cmd_in = 0;
	req1_data_in = 'hc403c462;

	#1000

	  // test 7
	  
	req1_cmd_in = 2;
	req1_data_in = 'h874fc0fd;

	#200

	  req1_cmd_in = 0;
	req1_data_in = 'h3f00f03e;

	#1000

	  // test 8
	  
	req1_cmd_in = 2;
	req1_data_in = 'hc403c462;

	#200

	  req1_cmd_in = 0;
	req1_data_in = 'hd2aca01f;

	#1000

	  // test 9
	  
	req1_cmd_in = 5;
	req1_data_in = 'hcde1056e;

	#200

	  req1_cmd_in = 0;
	req1_data_in = 'h00000101;

	#1000

	  // test 10
	  
	  req1_cmd_in = 5;
	req1_data_in = 'hcde1056e;

	#200

	  req1_cmd_in = 0;
	req1_data_in = 'h00000000;

	#1000

	  // test 11
	  
	  req1_cmd_in = 6;
	req1_data_in = 'hcde1056e;
	
	#200

	  req1_cmd_in = 0;
	req1_data_in = 'h00000101;

	#1000

	  // test 12
	  	  
	req1_cmd_in = 6;
	req1_data_in = 'hcde1056e;
		
	#200

	  req1_cmd_in = 0;
	req1_data_in = 'h00000000;

	#1000

	  // begin request 2 testing

	  // test 13
	  
	  req2_cmd_in = 1;
	req2_data_in = 'hc403c462;

	#200

	  req2_cmd_in = 0;
	req2_data_in = 'hd2aca01f;

	#1000

	  // test 14
	  
	  req2_cmd_in = 2;
	req2_data_in = 'hd2aca01f;

	#200

	  req2_cmd_in = 0;
	req2_data_in = 'hc403c462;

	#1000

	  // test 15

	req2_cmd_in = 2;
	req2_data_in = 'hc403c462;

	#200

	  req2_cmd_in = 0;
	req2_data_in = 'hd2aca01f;

	#1000

	  // test 16
	  
	req2_cmd_in = 5;
	req2_data_in = 'hcde1056e;

	#200

	  req2_cmd_in = 0;
	req2_data_in = 'h00000101;

	#1000

	  // test 17
	  
	  req2_cmd_in = 5;
	req2_data_in = 'hcde1056e;

	#200

	  req2_cmd_in = 0;
	req2_data_in = 'h00000000;

	#1000

	  // test 18
	  
	  req2_cmd_in = 6;
	req2_data_in = 'hcde1056e;
	
	#200

	  req2_cmd_in = 0;
	req2_data_in = 'h00000101;

	#1000

	  // test 19
	  	  
	req2_cmd_in = 6;
	req2_data_in = 'hcde1056e;
		
	#200

	  req2_cmd_in = 0;
	req2_data_in = 'h00000000;

	#1000	  

	  // begin request 3 testing

	  // test 20
	  
	  req3_cmd_in = 1;
	req3_data_in = 'hc403c462;

	#200

	  req3_cmd_in = 0;
	req3_data_in = 'hd2aca01f;

	#1000

	  // test 21
	  
	  req3_cmd_in = 2;
	req3_data_in = 'hd2aca01f;

	#200

	  req3_cmd_in = 0;
	req3_data_in = 'hc403c462;

	#1000

	  // test 22

	  req3_cmd_in = 2;
	req3_data_in = 'hc403c462;
	
	#200

	  req3_cmd_in = 0;
	req3_data_in = 'hd2aca01f;

	#1000

	  // test 23
	  
	req3_cmd_in = 5;
	req3_data_in = 'hcde1056e;

	#200

	  req3_cmd_in = 0;
	req3_data_in = 'h00000101;

	#1000

	  // test 24
	  
	  req3_cmd_in = 5;
	req3_data_in = 'hcde1056e;

	#200

	  req3_cmd_in = 0;
	req3_data_in = 'h00000000;

	#1000

	  // test 25
	  
	  req3_cmd_in = 6;
	req3_data_in = 'hcde1056e;
	
	#200

	  req3_cmd_in = 0;
	req3_data_in = 'h00000101;

	#1000

	  // test 26
	  	  
	req3_cmd_in = 6;
	req3_data_in = 'hcde1056e;
		
	#200

	  req3_cmd_in = 0;
	req3_data_in = 'h00000000;

	#1000	  

	  // begin request 4 testing

	  // test 27
	  
	  req4_cmd_in = 1;
	req4_data_in = 'hc403c462;

	#200

	  req4_cmd_in = 0;
	req4_data_in = 'hd2aca01f;

	#1000

	  // test 28
	  
	  req4_cmd_in = 2;
	req4_data_in = 'hd2aca01f;

	#200

	  req4_cmd_in = 0;
	req4_data_in = 'hc403c462;

	#1000

	  // test 29

	  req4_cmd_in = 2;
	req4_data_in = 'hc403c462;
	
	#200

	  req4_cmd_in = 0;
	req4_data_in = 'hd2aca01f;

	#1000

	  // test 30
	  
	req4_cmd_in = 5;
	req4_data_in = 'hcde1056e;

	#200

	  req4_cmd_in = 0;
	req4_data_in = 'h00000101;

	#1000

	  // test 31
	  
	  req4_cmd_in = 5;
	req4_data_in = 'hcde1056e;

	#200

	  req4_cmd_in = 0;
	req4_data_in = 'h00000000;

	#1000

	  // test 32
	  
	  req4_cmd_in = 6;
	req4_data_in = 'hcde1056e;
	
	#200

	  req4_cmd_in = 0;
	req4_data_in = 'h00000101;

	#1000

	  // test 33
	  	  
	req4_cmd_in = 6;
	req4_data_in = 'hcde1056e;
		
	#200

	  req4_cmd_in = 0;
	req4_data_in = 'h00000000;

	#1000	  
	  
	  // testing for invalid operand

	  // test 34
	  
	  req1_cmd_in = 7;
	req1_data_in = 'h2309abef;

	#200

	  req1_cmd_in = 0;
	req1_data_in = 'h332200ff;

	// testing the priority queue

	
		
	#2000 $stop;

     end // initial begin

   always
     @ (reset or c_clk or req1_cmd_in or req1_data_in or req2_cmd_in or req2_data_in or req3_cmd_in or req3_data_in or req4_cmd_in or req4_data_in) begin
	
	$display ("%t: r:%b \n 1c:%d,1d:%d \n 2c:%d,2d:%d \n 3c:%d,3d:%d \n 4c:%d,4d:%d \n 1r:%d,1d:%d \n 2r:%d,2d:%d \n 3r:%d,3d:%d \n 4r:%d,4d:%d \n\n", $time, reset[1], req1_cmd_in, req1_data_in, req2_cmd_in, req2_data_in, req3_cmd_in, req3_data_in, req4_cmd_in, req4_data_in, out_resp1, out_data1, out_resp2, out_data2, out_resp3, out_data3, out_resp4, out_data4);
	
     end

endmodule // bigtest


// this test breaks due to 4 adds at the same time
module test1;

  
   wire [0:31] out_data1, out_data2, out_data3, out_data4;
   wire [0:1]  out_resp1, out_resp2, out_resp3, out_resp4;
   wire 	 scan_out;
   
   
   reg 	 a_clk;
   reg 	 b_clk;
   reg 	 c_clk;
   reg [0:3] 	 error_found, req1_cmd_in, req2_cmd_in, req3_cmd_in, req4_cmd_in;
   reg [0:31]  req1_data_in, req2_data_in, req3_data_in, req4_data_in;
   reg [1:7] 	 reset;
   reg	 scan_in;

   calc1_top D1(out_data1, out_data2, out_data3, out_data4, out_resp1, out_resp2, out_resp3, out_resp4, scan_out, a_clk, b_clk, c_clk, error_found, req1_cmd_in, req1_data_in, req2_cmd_in, req2_data_in, req3_cmd_in, req3_data_in, req4_cmd_in, req4_data_in, reset, scan_in);


   
   initial 
     begin
	c_clk = 0;
	a_clk = 0;
	b_clk = 0;
	scan_in = 0;
	error_found = 4'b1111;
	
     end
   
	
   always #100 c_clk = ~c_clk;
   
   initial
     begin

	reset[1] = 1;
	#200 

	  reset[1] = 0;

	#400 

	req1_cmd_in = 1;
	req1_data_in = 10;
	req2_cmd_in = 1;
	req2_data_in = 1000000;
	req3_cmd_in = 1;
	req3_data_in = {{30{1'b1}}, 1'b0};
	req4_cmd_in = 1;
	req4_data_in = {{20{1'b1}}, 1'b0};


	#200 
	  req1_cmd_in = 0;
	req1_data_in = 25;
	req2_cmd_in = 0;
	req2_data_in = 2000000;
	req3_cmd_in = 0;
	req3_data_in = 2;
	req4_cmd_in = 0;
	req4_data_in = 5;
	
	
	#200

	  req1_cmd_in = 2;
	req1_data_in = 5;
	req2_cmd_in = 2;
	req2_data_in = 10;
	req3_cmd_in = 2;
	req3_data_in = 50000;
	req4_cmd_in = 2;
	req4_data_in = {31{1'b1}};
	
	#200

	  req1_cmd_in = 0;
	req1_data_in = 5;
	req2_cmd_in = 0;
	req2_data_in = 9;
	req3_cmd_in = 0;
	req3_data_in = 1999;
	req4_cmd_in = 0;
	req4_data_in = {31{1'b1}};

	#200
	
	#2000 $stop;

     end // initial begin

   always
     @ (reset or c_clk or req1_cmd_in or req1_data_in or req2_cmd_in or req2_data_in or req3_cmd_in or req3_data_in or req4_cmd_in or req4_data_in) begin
	
	$display ("%t: r:%b \n 1c:%d,1d:%d \n 2c:%d,2d:%d \n 3c:%d,3d:%d \n 4c:%d,4d:%d \n 1r:%d,1d:%d \n 2r:%d,2d:%d \n 3r:%d,3d:%d \n 4r:%d,4d:%d \n\n", $time, reset[1], req1_cmd_in, req1_data_in, req2_cmd_in, req2_data_in, req3_cmd_in, req3_data_in, req4_cmd_in, req4_data_in, out_resp1, out_data1, out_resp2, out_data2, out_resp3, out_data3, out_resp4, out_data4);
	
     end

endmodule // test1

module test2;

  
   wire [0:31] out_data1, out_data2, out_data3, out_data4;
   wire [0:1]  out_resp1, out_resp2, out_resp3, out_resp4;
   wire 	 scan_out;
   
   
   reg 	 a_clk;
   reg 	 b_clk;
   reg 	 c_clk;
   reg [0:3] 	 error_found, req1_cmd_in, req2_cmd_in, req3_cmd_in, req4_cmd_in;
   reg [0:31]  req1_data_in, req2_data_in, req3_data_in, req4_data_in;
   reg [1:7] 	 reset;
   reg	 scan_in;

   calc1_top D1(out_data1, out_data2, out_data3, out_data4, out_resp1, out_resp2, out_resp3, out_resp4, scan_out, a_clk, b_clk, c_clk, error_found, req1_cmd_in, req1_data_in, req2_cmd_in, req2_data_in, req3_cmd_in, req3_data_in, req4_cmd_in, req4_data_in, reset, scan_in);


   
	
   always #100 c_clk = ~c_clk;
   
   initial
     begin

	c_clk = 0;
	a_clk = 0;
	b_clk = 0;
	scan_in = 0;
	error_found = 4'b1111;               // this turns off the bugs
	reset = 1111111;
	#200 

	  reset = 0;

	#400 

	req1_cmd_in = 1;
	req1_data_in = 10;

	#200

	  req1_cmd_in = 0;
	req1_data_in = 25;
	req2_cmd_in = 1;
	req2_data_in = 1000000;

	#200
	  
	req2_cmd_in = 0;
	req2_data_in = 2000000;	

	#200
	
	req3_cmd_in = 1;
	req3_data_in = {{29{1'b1}}, 1'b0};

	#200

	req3_cmd_in = 0;
	req3_data_in = 2;


	#200
	
	req4_cmd_in = 1;
	req4_data_in = {{20{1'b1}}, 1'b0};

	#200
	
	req4_cmd_in = 0;
	req4_data_in = 5;
	req1_cmd_in = 2;
	req1_data_in = 5;
	
	#200

	  req1_cmd_in = 0;
	req1_data_in = 5;
	req2_cmd_in = 2;
	req2_data_in = 10;

	#200

	req2_cmd_in = 0;
	req2_data_in = 9;
	req3_cmd_in = 2;
	req3_data_in = 50000;

	#200

	req3_cmd_in = 0;
	req3_data_in = 1999;
	req4_cmd_in = 2;
	req4_data_in = {31{1'b1}};
	
	#200

	req4_cmd_in = 0;
	req4_data_in = {31{1'b1}};

	#200

	  reset = 1111111;
	
	#200 

	  reset = 0;
	error_found = 4'b0000;               // turns on the bugs
		

	#400 

	req1_cmd_in = 1;
	req1_data_in = 10;

	#200

	  req1_cmd_in = 0;
	req1_data_in = 25;
	req2_cmd_in = 1;
	req2_data_in = 1000000;

	#200
	  
	req2_cmd_in = 0;
	req2_data_in = 2000000;	

	#200
	
	req3_cmd_in = 1;
	req3_data_in = {{29{1'b1}}, 1'b0};

	#200

	req3_cmd_in = 0;
	req3_data_in = 2;


	#200
	
	req4_cmd_in = 1;
	req4_data_in = {{20{1'b1}}, 1'b0};

	#200
	
	req4_cmd_in = 0;
	req4_data_in = 5;
	req1_cmd_in = 2;
	req1_data_in = 5;
	
	#200

	  req1_cmd_in = 0;
	req1_data_in = 5;
	req2_cmd_in = 2;
	req2_data_in = 10;

	#200

	req2_cmd_in = 0;
	req2_data_in = 9;
	req3_cmd_in = 2;
	req3_data_in = 50000;

	#200

	req3_cmd_in = 0;
	req3_data_in = 1999;
	req4_cmd_in = 2;
	req4_data_in = {31{1'b1}};
	
	#200

	req4_cmd_in = 0;
	req4_data_in = {31{1'b1}};

	#200
	
	#2000 $stop;

     end // initial begin

   always
     @ (reset or c_clk or req1_cmd_in or req1_data_in or req2_cmd_in or req2_data_in or req3_cmd_in or req3_data_in or req4_cmd_in or req4_data_in) begin
	
	$display ("%t: r:%b \n 1c:%d,1d:%d \n 2c:%d,2d:%d \n 3c:%d,3d:%d \n 4c:%d,4d:%d \n 1r:%d,1d:%d \n 2r:%d,2d:%d \n 3r:%d,3d:%d \n 4r:%d,4d:%d \n\n", $time, reset[1], req1_cmd_in, req1_data_in, req2_cmd_in, req2_data_in, req3_cmd_in, req3_data_in, req4_cmd_in, req4_data_in, out_resp1, out_data1, out_resp2, out_data2, out_resp3, out_data3, out_resp4, out_data4);
	
     end

endmodule // test2

   
module test3;

  
   wire [0:31] out_data1, out_data2, out_data3, out_data4;
   wire [0:1]  out_resp1, out_resp2, out_resp3, out_resp4;
   wire 	 scan_out;
   
   
   reg 	 a_clk;
   reg 	 b_clk;
   reg 	 c_clk;
   reg [0:3] 	 error_found, req1_cmd_in, req2_cmd_in, req3_cmd_in, req4_cmd_in;
   reg [0:31]  req1_data_in, req2_data_in, req3_data_in, req4_data_in;
   reg [1:7] 	 reset;
   reg	 scan_in;

   calc1_top D1(out_data1, out_data2, out_data3, out_data4, out_resp1, out_resp2, out_resp3, out_resp4, scan_out, a_clk, b_clk, c_clk, error_found, req1_cmd_in, req1_data_in, req2_cmd_in, req2_data_in, req3_cmd_in, req3_data_in, req4_cmd_in, req4_data_in, 
reset, scan_in);


   
   initial 
     begin
	c_clk = 0;
	a_clk = 0;
	b_clk = 0;
	scan_in = 0;
	error_found = 4'b1111;
	
     end
   
	
   always #100 c_clk = ~c_clk;
   
   initial
     begin

	reset[1] = 1;
	#600 reset[1] = 0;

	req1_cmd_in = 1;
	req1_data_in = 10;
	req2_cmd_in = 0;
	req2_data_in = 0;
	req3_cmd_in = 5;
	req3_data_in = 3;
	req4_cmd_in = 0;
	req4_data_in = 0;

	#200 
	  req1_cmd_in = 0;
	req1_data_in = 3;
	req2_cmd_in = 2;
	req2_data_in = 3;
	req3_cmd_in = 0;
	req3_data_in = 3;
	
	
	#200

	  req2_cmd_in = 0;
	req2_data_in = 2;
	req4_cmd_in = 6;
	req4_data_in = 12;
	
	#200

	  req3_cmd_in = 1;
	req3_data_in = 1999;
	
	  req4_cmd_in = 0;
	req4_data_in = 2;

	#200

	  req3_cmd_in = 0;
	req3_data_in= 1000;

	req4_cmd_in = 2;
	req4_data_in = 2000;

	#200

	  req4_cmd_in = 0;
	req4_data_in = 1000;
	
	
	
	#2000 $stop;

     end // initial begin

   always
     @ (reset or c_clk or req1_cmd_in or req1_data_in or req2_cmd_in or req2_data_in or req3_cmd_in or req3_data_in or req4_cmd_in or req4_data_in) begin
	
	$display ("%t: r:%b \n 1c:%d,1d:%d \n 2c:%d,2d:%d \n 3c:%d,3d:%d \n 4c:%d,4d:%d \n 1r:%d,1d:%d \n 2r:%d,2d:%d \n 3r:%d,3d:%d \n 4r:%d,4d:%d \n\n", $time, reset[1], req1_cmd_in, req1_data_in, req2_cmd_in, req2_data_in, req3_cmd_in, req3_data_in, req4_cmd_in, req4_data_in, out_resp1, out_data1, out_resp2, out_data2, out_resp3, out_data3, out_resp4, out_data4);
	
     end

endmodule // test3

   
