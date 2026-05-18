`default_nettype none

module cw_decoder_core (
    input  wire clk,
    input  wire reset,
    input  wire cw_sig,
    output reg [7:0] serial_line
);

  reg [2:0] pulse_rx [0:3];
  reg [2:0] cur_pulse;

  reg [2:0] sig2_len;

  always @(posedge clk) begin
    if(reset) begin
      pulse_rx[0] <= 0;
      pulse_rx[1] <= 0;
      pulse_rx[2] <= 0;
      pulse_rx[3] <= 0;
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

      if(cur_pulse == 0) begin

        if(pulse_rx[0] == 1) begin
          serial_line <= 69; //E
        end else if(pulse_rx[0] > 1) begin
          serial_line <= 84; //T
        end

      end else if(cur_pulse == 1) begin

        if(pulse_rx[0] == 1 && pulse_rx[1] == 1) begin
          serial_line <= 73; //I 
        end else if(pulse_rx[0] > 1 && pulse_rx[1] > 1) begin
          serial_line <= 77; //M
        end else if(pulse_rx[0] == 1 && pulse_rx[1] > 1) begin
          serial_line <= 65; //A
        end else if(pulse_rx[0] > 1 && pulse_rx[1] == 1) begin
          serial_line <= 78; //N
        end

      end else if(cur_pulse == 2) begin

        if(pulse_rx[0] == 1 && pulse_rx[1] == 1 && pulse_rx[2] == 1) begin
          serial_line <= 83; //S
        end else if(pulse_rx[0] > 1 && pulse_rx[1] > 1 && pulse_rx[2] > 1) begin
          serial_line <= 79; //O
        end else if(pulse_rx[0] == 1 && pulse_rx[1] > 1 && pulse_rx[2] > 1) begin
          serial_line <= 87; //W
        end else if(pulse_rx[0] == 1 && pulse_rx[1] == 1 && pulse_rx[2] > 1) begin
          serial_line <= 85; //U
        end else if(pulse_rx[0] == 1 && pulse_rx[1] > 1 && pulse_rx[2] == 1) begin
          serial_line <= 82; //R
        end else if(pulse_rx[0] > 1 && pulse_rx[1] == 1 && pulse_rx[2] > 1) begin
          serial_line <= 75; //K
        end else if(pulse_rx[0] > 1 && pulse_rx[1] > 1 && pulse_rx[2] == 1) begin
          serial_line <= 71; //G
        end else if(pulse_rx[0] > 1 && pulse_rx[1] == 1 && pulse_rx[2] == 1) begin
          serial_line <= 68; //D
        end

      end else if(cur_pulse == 3) begin

        if(pulse_rx[0] > 1 && pulse_rx[1] == 1 && pulse_rx[2] == 1 && pulse_rx[3] == 1) begin
          serial_line <= 66; //B
        end

      end

    end
  end

endmodule
