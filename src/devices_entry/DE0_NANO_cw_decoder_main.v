module DE0_NANO_cw_decoder_main(
    input  wire reset,
    input  wire clk,
    input  wire cw_sig,
    inout wire kb_dp,
    inout wire kb_dm,
    output wire tp_usb_init
);

    cw_decoder_main u_cw_decoder_main (
        .clk(clk),
        .reset(reset),
        .cw_sig(cw_sig),
        .kb_dp(kb_dp),
        .kb_dm(kb_dm),
        .tp_usb_init(tp_usb_init)
    );

endmodule

