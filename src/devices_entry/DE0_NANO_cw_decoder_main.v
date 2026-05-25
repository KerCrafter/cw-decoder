module DE0_NANO_cw_decoder_main(
    input  wire reset,
    input  wire clk,
    input  wire cw_sig,

    output wire pico_strobe,
    output wire [7:0] pico_data
);
    wire cw_clean;

    wire [7:0] data;
    wire       data_strobe;

    reg [7:0]  pico_data_r   = 8'h00;
    reg        pico_strobe_r = 1'b0;
    reg [15:0] strobe_cnt    = 0;

    assign pico_data   = pico_data_r;
    assign pico_strobe = pico_strobe_r;

    always @(posedge clk) begin

        // Gestion strobe — pulse de 1ms
        if (strobe_cnt > 0) begin
            strobe_cnt    <= strobe_cnt - 1;
            pico_strobe_r <= 1'b1;
        end else begin
            pico_strobe_r <= 1'b0;
        end

        // Quand le core produit un caractère → on l'envoie au Pico
        if (data_strobe) begin
            pico_data_r <= data;            // capture le caractère
            strobe_cnt  <= 16'd50_000;      // strobe 1ms à 50MHz
        end

    end

    button_debouncer #(
        .DEBOUNCE_CLK_CNT(65536)
    ) cw_debouncer (
        .clk(clk),
        .reset(~reset),
        .btn_in(cw_sig),
        .btn_debounced(cw_clean)
    );

    cw_decoder_main u_cw_decoder_main (
        .clk         (clk),
        .reset       (~reset),
        .cw_sig      (cw_clean),
        .data        (data),
        .data_strobe (data_strobe)
    );

endmodule
