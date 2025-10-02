`default_nettype none
`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test_counter_8bit.py.
*/
module tb_counter ();

  // Dump the signals to a VCD file. You can view it with gtkwave or surfer.
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb_counter);
    #1;
  end

  // Wire up the inputs and outputs:
  reg         clk;
  reg         rst_n;
  reg         en;
  reg         load;
  reg [7:0]   data_in;
  reg         out_en;
  wire [7:0]  data_out;
`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  counter_8bit user_project (

`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif
     
      .clk      (clk),
      .rst_n    (rst_n),
      .en       (en),
      .load     (load),
      .data_in  (data_in),
      .out_en   (out_en),
      .data_out (data_out)
  );

endmodule
