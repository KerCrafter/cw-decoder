`default_nettype none

module cw_decoder_core (
    input  wire clk,
    input  wire reset,
    input  wire cw_sig,
    output reg [7:0] serial_line
);

  reg [2:0] pulse_rx [0:1];
  reg [2:0] cur_pulse;

  reg [2:0] sig2_len;

  always @(posedge clk) begin
    if(reset) begin
      pulse_rx[0] <= 0;
      pulse_rx[1] <= 0;
      cur_pulse <= 0;

      serial_line <= 0;

    end else begin
      if(cw_sig) begin
        pulse_rx[cur_pulse] = pulse_rx[cur_pulse] + 1;
      end else begin
        if(pulse_rx[cur_pulse] > 0) begin
          cur_pulse = cur_pulse + 1;
        end
      end

      if(pulse_rx[0] == 1 && pulse_rx[1] == 0) begin
        serial_line <= 69;
      end else if(pulse_rx[0] > 1 && pulse_rx[1] == 0) begin
        serial_line <= 84;
      end else if(pulse_rx[1] == 1) begin
        serial_line <= 73;
      end else begin
        serial_line <= 77;
      end
    end
  end

endmodule
