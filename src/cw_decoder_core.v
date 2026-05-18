`default_nettype none

module cw_decoder_core (
    input  wire clk,
    input  wire reset,
    input  wire cw_sig,
    output reg [7:0] serial_line
);

  reg [2:0] cur_pulse;
  reg [2:0] cur_pulse_len;
  reg [0:3] char_wave;

  always @(posedge clk) begin
    if(reset) begin
      char_wave <= 0;
      cur_pulse <= 0;
      cur_pulse_len <= 0;
      serial_line <= 0;

    end else begin
      if(cw_sig) begin
        cur_pulse_len <= cur_pulse_len + 1;
      end else begin
        cur_pulse_len <= 0;

        if(cur_pulse_len > 0) begin
          char_wave[cur_pulse] <= cur_pulse_len > 1;
          cur_pulse <= cur_pulse + 1;
        end
      end

      if(cur_pulse == 1) begin
        case (char_wave[0])
          1'b0: serial_line <= 69; //E
          1'b1: serial_line <= 84; //T
        endcase
      end else if(cur_pulse == 2) begin
        case (char_wave[0:1])
          2'b00: serial_line <= 73; //I
          2'b01: serial_line <= 65; //A
          2'b10: serial_line <= 78; //N
          2'b11: serial_line <= 77; //M
        endcase
      end else if(cur_pulse == 3) begin
        case (char_wave[0:2])
          3'b000: serial_line <= 83; //S
          3'b001: serial_line <= 85; //U
          3'b010: serial_line <= 82; //R
          3'b011: serial_line <= 87; //W
          3'b100: serial_line <= 68; //D
          3'b101: serial_line <= 75; //K
          3'b110: serial_line <= 71; //G
          3'b111: serial_line <= 79; //O
        endcase

      end else if(cur_pulse == 4) begin
        case (char_wave[0:3])
          4'b1000: serial_line <= 66; //B
          4'b1010: serial_line <= 67; //C
          4'b0010: serial_line <= 70; //F
          4'b0000: serial_line <= 72; //H
          4'b0111: serial_line <= 74; //J
          4'b0100: serial_line <= 76; //L
          4'b0110: serial_line <= 80; //P
          4'b1101: serial_line <= 81; //Q
          4'b0001: serial_line <= 86; //V
          4'b1100: serial_line <= 90; //Z
        endcase
      end

    end
  end

endmodule
