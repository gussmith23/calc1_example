`define CLK_PERIOD 10

interface calc_ifc(input bit clk);
  
  logic [0:31] out_data1, out_data2, out_data3, out_data4;
  logic [0:1] out_resp1, out_resp2, out_resp3, out_resp4;

  logic scan_out;

  logic [0:3] error_found;
  
  logic [0:3] req1_cmd_in, req2_cmd_in, req3_cmd_in, req4_cmd_in;
  logic [0:31] req1_data_in, req2_data_in, req3_data_in, req4_data_in;

  logic [1:7] reset;
  logic scan_in;

  modport TEST_PROGRAM(
    // Note: "input" and "output" keywords are sticky! We only need to use them
    // once each.
    input out_data1, out_data2, out_data3, out_data4,
    out_resp1, out_resp2, out_resp3, out_resp4, 
    scan_out, 

    output error_found, 
    req1_cmd_in, req1_data_in, 
    req2_cmd_in, req2_data_in, 
    req3_cmd_in, req3_data_in,
    req4_cmd_in, req4_data_in, 
    reset, 
    scan_in);
    
endinterface

// This program resets the device, enters the command add(1,2), and checks for a
// correct result.
program test(calc_ifc.TEST_PROGRAM calc_ifc1);

  initial begin 

    // The calculator is expecting this initial reset and will not work without it.
    calc_ifc1.reset <= 7'b1111111;
    #(7*`CLK_PERIOD) calc_ifc1.reset <= 0;// TODO: how can we do this better?
                                          // what can we add in the interface so that
                                          // we don't have to know anything about the
                                          // clock period inside the test program?

    // Input command. Command: addition. Arguments: 1 and 2.
    calc_ifc1.req1_cmd_in <= 1;
    calc_ifc1.req1_data_in <= 1;
    #`CLK_PERIOD calc_ifc1.req1_cmd_in <= 0;
    calc_ifc1.req1_data_in <= 2;

    // Wait for the signal that the data line has data on it.
    @ (calc_ifc1.out_resp1);

    // Check that the calculator didn't return an error code.
    assert(calc_ifc1.out_resp1 == 1) begin 
      $display("Response code is 1 - operation returned without error! Checking correctness...");
      // Check that the calculator calculated the addition correctly.
      assert(calc_ifc1.out_data1 == 3) $display("Addition succeeded! Got 1 + 2 == 3.");
      else $error("Addition failed! Got 1 + 2 == %d", calc_ifc1.out_data1);
    end
    else $error("Response code is %b - calculator error!", calc_ifc1.out_resp1);

    $finish;

  end

endprogram

module testbench();
  
  bit clk;

  initial clk = 0;
  always #(`CLK_PERIOD/2) clk = !clk;

  calc_ifc calc_ifc1(clk);

  calc1_top calc(
    calc_ifc1.out_data1, calc_ifc1.out_data2, calc_ifc1.out_data3, calc_ifc1.out_data4,
    calc_ifc1.out_resp1, calc_ifc1.out_resp2, calc_ifc1.out_resp3, calc_ifc1.out_resp4,
    calc_ifc1.scan_out,
    // Note: the design has three clocks, but we'll just connect them all to one clock
    // for now.
    clk, clk, clk,
    calc_ifc1.error_found, 
    calc_ifc1.req1_cmd_in, calc_ifc1.req1_data_in, 
    calc_ifc1.req2_cmd_in, calc_ifc1.req2_data_in, 
    calc_ifc1.req3_cmd_in, calc_ifc1.req3_data_in, 
    calc_ifc1.req4_cmd_in, calc_ifc1.req4_data_in, 
    calc_ifc1.reset, 
    calc_ifc1.scan_in);

  test test_program(calc_ifc1);

endmodule
