`default_nettype none

module cw_decoder_core (
    input  wire clk,
    input  wire reset,
    input  wire cw_sig,
    output reg [7:0] serial_line
);

  reg [2:0] sig_len;
  reg sig_end;

  reg [2:0] sig2_len;

  always @(posedge clk) begin
    if(reset) begin
      sig_len <= 0;
      sig_end <= 0;

      sig2_len <= 0;
      serial_line <= 0;

    end else begin
      if(cw_sig) begin
        if(sig_end == 0) begin
          sig_len = sig_len + 1;
        end

        if(sig_end == 1) begin
          sig2_len = sig2_len + 1;
        end
      end else begin
        if(sig_len > 0) begin
          sig_end <= 1;
        end
      end

      if(sig_len == 1 && sig2_len == 0) begin
        serial_line <= 69;
      end else if(sig_len > 1 && sig2_len == 0) begin
        serial_line <= 84;
      end else if(sig2_len == 1) begin
        serial_line <= 73;
      end else begin
        serial_line <= 77;
      end
    end
  end

endmodule
