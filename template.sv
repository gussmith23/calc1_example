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

  clocking cb @(posedge clk);
    input out_data1, out_data2, out_data3, out_data4,
    out_resp1, out_resp2, out_resp3, out_resp4, 
    scan_out; 

    output error_found, 
    req1_cmd_in, req1_data_in, 
    req2_cmd_in, req2_data_in, 
    req3_cmd_in, req3_data_in,
    req4_cmd_in, req4_data_in, 
    scan_in;
  endclocking

  modport TEST_PROGRAM(clocking cb, output reset); 
    
endinterface

// Represents a single request into the calculator.
// See below for the randomizable version!
class Request;
  logic [0:3] cmd;
  bit [0:31] operand1, operand2;

  function new(input logic [0:3] cmd, logic [0:31] operand1, operand2);
    this.cmd = cmd;
    this.operand1 = operand1;
    this.operand2 = operand2;
  endfunction
endclass

// Randomizable request.
// Note: In this example, this randomizable request class is heavily constrained
// because we know exactly which bugs we're looking for.
// In a real-world scenario, you would not constrain your class so heavily.
class RequestRand;
  rand bit [0:3] cmd;
  rand bit [0:31] operand1, operand2;

  constraint c {
    
    // Constrain to add (1), subtract (2), invalid command (3),
    // and shift left (5)
		cmd inside {1,2,3,5};
    
    // Each of the three parts of the constraint below ensures that this request
    // will trigger a bug. 
    
    // BUG 1: Subtract doesn't work with this specific operand! (And possibly
    // other operands - can you find any others?)
		(operand1==32'b0000_1000_0000_1000_0000_0000_0000_0000 && cmd==2) 
    // BUG 2: Shift left with operand 0 leads to error!
    ||(operand2==0 && cmd==5) 
    // BUG 3: Invalid commands (cmd=3, in this case) are not detected!
    || cmd==3;
  }
endclass

// This program generates a queue of Requests and puts them into the calculator
// one-by-one, computing the expected output for each and checking it against
// the actual output.
// Note: In a real-world example of a random test, you would likely run a lot 
// more than 10 tests. As I stated above, this example random test is heavily
// constrained so that we're guaranteed to find one of three bugs. Thus, we 
// don't need to run that many tests to see all three bugs!
program automatic test(calc_ifc.TEST_PROGRAM calc_ifc1);
  RequestRand request_queue[$];
  RequestRand req;
  logic [0:31] expected_output;
  logic valid_cmd;
  int number_of_tests=10;

  initial begin 

    // TODO: Create a Generator class to handle command generation.
    // Set up our task queue
    for (int i=1;i<=number_of_tests;i++) begin
    	req = new();
    	if(!req.randomize()) $finish;
    	request_queue.push_back(req);
    end

    // Reset device
    calc_ifc1.reset <= 7'b1111111;
    repeat (7) @calc_ifc1.cb;
    calc_ifc1.reset <= 0;

    while (request_queue.size() != 0) begin
      RequestRand req;
      req = request_queue.pop_front();
      
      // Put the request on the wire.
      @calc_ifc1.cb;
      calc_ifc1.cb.req1_cmd_in <= req.cmd;
      calc_ifc1.cb.req1_data_in <= req.operand1;
      @calc_ifc1.cb;
      calc_ifc1.cb.req1_cmd_in <= 0;
      calc_ifc1.cb.req1_data_in <= req.operand2;
      @calc_ifc1.cb;
      calc_ifc1.cb.req1_data_in <= 0;

      // Wait for the signal that the data line has data on it.
      @ (calc_ifc1.cb.out_resp1);
      $display("Response code is %0b - calculator responded! ", calc_ifc1.cb.out_resp1);
       
      // Calculate the expected output value.
      // Note: Shift Right not implemented yet!
      case(req.cmd)
        1: begin valid_cmd=1; expected_output = req.operand1 + req.operand2; end
        2: begin valid_cmd=1; expected_output = req.operand1 - req.operand2; end
        3: begin valid_cmd=0; end
        5: begin valid_cmd=1; expected_output = req.operand1 << req.operand2; end
      endcase

      // Check that invalid commands were detected.
      if(valid_cmd==0)
        assert(calc_ifc1.cb.out_resp1==2) 
        else begin
          $error("INVALID command NOT detected! Output: %0d. (Operands: %0d, %0d; command: %0b)",
                  calc_ifc1.cb.out_data1, req.operand1, req.operand2, req.cmd);
          continue;
        end

      assert(calc_ifc1.cb.out_data1 == expected_output) 
        $display("Operation succeeded! Operands: %0d, %0d; output: %0d; command: %0b.", 
                    req.operand1, req.operand2, calc_ifc1.cb.out_data1, req.cmd);
      else $error("Operation failed! Output: %0d. Expected %0d. (Operands: %0d, %0d; command: %0b)",
                    calc_ifc1.cb.out_data1, expected_output, req.operand1, req.operand2, req.cmd);
    end
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
