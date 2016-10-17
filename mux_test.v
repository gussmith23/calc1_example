`include "mux_out.v"

module mux_test;
   

   wire [0:31] req_data;
   wire [0:1]  req_resp;
   reg [0:31]  req_data1, req_data2;
   reg [0:1]   req_resp1, req_resp2;

   mux_out(req_data, req_resp, req_data1, req_data2, req_resp1, req_resp2);
   
initial
  begin
   
  
     req_resp1 = 2'b01;
     req_resp2 = 2'b00;
     req_data1 = 4096;
     req_data2 = 1234;
     
     
     #100

       req_resp1 = 2'b00;

     #100
     req_resp2 = 2'b01;

     #100

       req_resp2 = 2'b00;

     #100

       req_data1 = 2'b01;

     #100
     req_data2 = 2'b00;

     #100

       req_data1 = 2'b00;

     #100
     req_data2 = 2'b01;

     #100

       req_data2 = 2'b00;

     #100 $stop;
     

  end // initial begin
   
  always @ (req_data1 or req_data2 or req_resp1 or req_resp2) begin     

     $display ("time: %t, data: %d, resp: %b", $time, req_data, req_resp);
     

  end
   
endmodule // mux_test