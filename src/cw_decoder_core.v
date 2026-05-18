`default_nettype none

module cw_decoder_core (
    input  wire clk,
    input  wire reset,
    input  wire cw_sig,
    output reg [7:0] serial_line
);

  reg [2:0] sig_len;

  always @(posedge clk) begin
    if(reset) begin
      sig_len <= 0;
      serial_line <= 0;

    end else begin
      if(cw_sig) begin
        sig_len = sig_len + 1;
      end

      if(sig_len == 1) begin
        serial_line <= 69;
      end else begin
        serial_line <= 84;
      end
    end
  end

endmodule
