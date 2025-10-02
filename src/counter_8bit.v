/*
 * Copyright (c) 2025 Ernest James Ramas
 * SPDX-License-Identifier: Apache-2.0
 */

 /*
 * 8-bit programmable binary counter with:
 *  - Asynchronous active-low reset
 *  - Synchronous load
 *  - Tri-state output
 */

`default_nettype none

module counter_8_bit (
    input  wire        clk,      // clock
    input  wire        rst_n,    // async reset, active low
    input  wire        en,       // count enable
    input  wire        load,     // synchronous load enable
    input  wire [7:0]  data_in,  // load value
    input  wire        out_en,   // output enable
    output wire [7:0]  data_out  // tri-state output
);

  reg [7:0] n;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      n <= 8'd0;
    end

    else if (load) begin
      n <= data_in;
    end

    else if (en) begin
      n <= n + 8'd1;
    end
  end

  assign data_out = (out_en) ? n : 8'bz;

endmodule
