`default_nettype none
`timescale 1ns / 1ps

module tb ();

  // Dump the signals to a FST file. You can view it with gtkwave or surfer.
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
    #1;
  end

  wire clk;
  wire reset;
  wire cw_sig;
  wire [7:0] serial_line;

  cw_decoder_core u_cw_decoder_core (
      .clk  (clk),
      .reset  (reset),
      .cw_sig (cw_sig),
      .serial_line(serial_line)
  );

endmodule
