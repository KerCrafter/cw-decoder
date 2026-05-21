module DE0_NANO_cw_decoder_main(
    input  wire reset,
    input  wire clk,
    input  wire cw_sig,

    output wire pico_strobe,
    output wire [7:0] pico_data
);

    reg [7:0]  pico_data_r   = 8'h00;
    reg        pico_strobe_r = 1'b0;
    reg [25:0] timer         = 0;
    reg [15:0] strobe_cnt    = 0;

    assign pico_data   = pico_data_r;
    assign pico_strobe = pico_strobe_r;

    always @(posedge clk) begin
        timer <= timer + 1;

        // Gestion strobe — pulse de 1ms
        if (strobe_cnt > 0) begin
            strobe_cnt    <= strobe_cnt - 1;
            pico_strobe_r <= 1'b1;
        end else begin
            pico_strobe_r <= 1'b0;
        end

        // 1 seconde après démarrage → envoie 'a'
        if (timer == 26'd50_000_000) begin
            pico_data_r <= 8'h62;       // ASCII 'a'
            strobe_cnt  <= 16'd50_000;  // strobe 1ms
        end
    end

    cw_decoder_main u_cw_decoder_main (
        .clk(clk),
        .reset(1'b0),
        .cw_sig(cw_sig)
    );

endmodule

