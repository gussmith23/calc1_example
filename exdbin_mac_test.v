`include "exdbin_mac.v"

module exdbin_mac_test;

   wire [0:63] bin_sum;
   wire        bin_ovfl;
   reg [0:63]  fxu_areg_q, fxu_breg_q;
   reg [0:3]   alu_cmd;
   reg 	       local_error_found;

   exdbin_mac(bin_ovfl, bin_sum, alu_cmd, fxu_areg_q, local_error_found, fxu_breg_q);

   initial
     begin
	$display ("time: %t,alu_cmd: %d,reg1: %d, reg2: %d\nresult: %d, ovfl: %b", $time, alu_cmd, fxu_areg_q, fxu_breg_q, bin_sum, bin_ovfl);
	 fxu_areg_q = 25;
	fxu_breg_q = 22;
	alu_cmd = 1;
	local_error_found = 1;

	#5
	$display ("time: %t,alu_cmd: %d,reg1: %d, reg2: %d\nresult: %d, ovfl: %b", $time, alu_cmd, fxu_areg_q, fxu_breg_q, bin_sum, bin_ovfl);
	  alu_cmd = 2;
	

	#5
	  $display ("time: %t,alu_cmd: %d,reg1: %d, reg2: %d\nresult: %d, ovfl: %b", $time, alu_cmd, fxu_areg_q, fxu_breg_q, bin_sum, bin_ovfl);
	  fxu_areg_q = 10;
	fxu_breg_q = 10;

	#5
	  $display ("time: %t,alu_cmd: %d,reg1: %d, reg2: %d\nresult: %d, ovfl: %b", $time, alu_cmd, fxu_areg_q, fxu_breg_q, bin_sum, bin_ovfl);
	  alu_cmd = 1;

	#5
	  $display ("time: %t,alu_cmd: %d,reg1: %d, reg2: %d\nresult: %d, ovfl: %b", $time, alu_cmd, fxu_areg_q, fxu_breg_q, bin_sum, bin_ovfl);
	  fxu_areg_q = 3'b100;
	fxu_breg_q = 2'b10;


	#5 
	  $display ("time: %t,alu_cmd: %d,reg1: %d, reg2: %d\nresult: %d, ovfl: %b", $time, alu_cmd, fxu_areg_q, fxu_breg_q, bin_sum, bin_ovfl);
	  alu_cmd = 2;

	#5
	  $display ("time: %t,alu_cmd: %d,reg1: %d, reg2: %d\nresult: %d, ovfl: %b", $time, alu_cmd, fxu_areg_q, fxu_breg_q, bin_sum, bin_ovfl);
	  fxu_areg_q = 0;
	fxu_breg_q =0;

	#5
	  $display ("time: %t,alu_cmd: %d,reg1: %d, reg2: %d\nresult: %d, ovfl: %b", $time, alu_cmd, fxu_areg_q, fxu_breg_q, bin_sum, bin_ovfl);
	fxu_areg_q=2;
	fxu_breg_q=4;
	#5
	  $display ("time: %t,alu_cmd: %d,reg1: %d, reg2: %d\nresult: %d, ovfl: %b", $time, alu_cmd, fxu_areg_q, fxu_breg_q, bin_sum, bin_ovfl);

	alu_cmd = 1;
	fxu_areg_q = 'hffff0000;
	fxu_breg_q = 'h000ffff;

	#5

	  fxu_areg_q = 'hffffffe;
	fxu_breg_q = 2;

	#5

	  fxu_areg_q = 'hf0f0f0;
	fxu_breg_q = 'h101010;
			       
	#5

	  fxu_areg_q = 'hffffffff;
	fxu_breg_q = 1;
	
	#5
	  
	  alu_cmd = 2;
	fxu_areg_q = 'hffffffff;
	fxu_breg_q = 'hfffffffe;

	#5

	  fxu_areg_q = 'h10000000;
	fxu_breg_q = 1;

	
	
	#100	
	$stop;

     end // initial begin

endmodule