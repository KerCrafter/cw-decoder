`default_nettype none

module cw_decoder_core (
    input  wire clk,
    input  wire reset,
    input  wire cw_sig,
    output reg [7:0] data,
    output reg data_strobe
);

  reg [31:0] cur_pulse;
  reg [31:0] cur_pulse_len;
  reg [31:0] cur_unpulse_len;
  reg [0:3] char_wave;
  reg [31:0] speed_val;
  reg [31:0] dit_len;
  reg [31:0] cur_dit_len;

  always @(posedge clk) begin
    if(reset) begin
      char_wave <= 0;
      cur_pulse <= 0;
      cur_pulse_len <= 0;
      cur_unpulse_len <= 0;
      data <= 0;
      data_strobe <= 0;
      speed_val <= 2;

      cur_dit_len <= 0;
      dit_len <= 0;

    end else begin
      if(cw_sig) begin
        cur_pulse_len <= cur_pulse_len + 1;
        cur_unpulse_len <= 0;
      end else begin

        if(cur_pulse_len > 0) begin
          //speed_val = (cur_pulse_len + 1 + speed_val) / 2;

          //char_wave[cur_pulse] <= cur_pulse_len >= speed_val;
          cur_pulse <= cur_pulse + 1;
          cur_pulse_len <= 0;

          char_wave[cur_pulse] <= cur_pulse_len >= (cur_dit_len + (cur_dit_len/2));

          if(cur_pulse == 0) begin
            dit_len <= cur_pulse_len;
          end else begin
            if(cur_pulse_len < dit_len) begin
              dit_len <= cur_pulse_len;
            end
          end
        end

        if(cur_unpulse_len <= cur_dit_len * 4) begin
          cur_unpulse_len <= cur_unpulse_len + 1;
        end

        if(cur_unpulse_len == (cur_dit_len * 4)) begin

          if(cur_pulse == 1) begin
            case (char_wave[0])
              1'b0: data <= 69; //E
              1'b1: data <= 84; //T
            endcase
          end else if(cur_pulse == 2) begin
            case (char_wave[0:1])
              2'b00: data <= 73; //I
              2'b01: data <= 65; //A
              2'b10: data <= 78; //N
              2'b11: data <= 77; //M
            endcase
          end else if(cur_pulse == 3) begin
            case (char_wave[0:2])
              3'b000: data <= 83; //S
              3'b001: data <= 85; //U
              3'b010: data <= 82; //R
              3'b011: data <= 87; //W
              3'b100: data <= 68; //D
              3'b101: data <= 75; //K
              3'b110: data <= 71; //G
              3'b111: data <= 79; //O
            endcase

          end else if(cur_pulse == 4) begin
            case (char_wave[0:3])
              4'b0000: data <= 72; //H
              4'b0001: data <= 86; //V
              4'b0010: data <= 70; //F

              4'b0100: data <= 76; //L

              4'b0110: data <= 80; //P
              4'b0111: data <= 74; //J
              4'b1000: data <= 66; //B
              4'b1001: data <= 88; //X
              4'b1010: data <= 67; //C
              4'b1011: data <= 89; //Y
              4'b1100: data <= 90; //Z
              4'b1101: data <= 81; //Q
            endcase
          end

          data_strobe <= 1;
        end

        if(cur_unpulse_len == (cur_dit_len * 4) + 1) begin
          data_strobe <= 0;
          data <= 0;
          cur_pulse <= 0; 
          char_wave <= 0;


          cur_dit_len <= 6000000;
          //if(
          //  (cur_pulse == 1 && char_wave[0] == 1'b1) ||
          //  (cur_pulse == 2 && char_wave[0:1] == 2'b11) ||
          //  (cur_pulse == 3 && char_wave[0:2] == 3'b111) ||
          //  (cur_pulse == 4 && char_wave[0:3] == 4'b1111)) begin
          //end else begin
          //  cur_dit_len <= dit_len;
          //end
        end

      end


    end
  end

endmodule
