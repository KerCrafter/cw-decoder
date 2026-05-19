module DE0_NANO_cw_decoder_main(
    input  wire reset,
    input  wire clk,
    input  wire cw_sig,
    inout wire kb_dp,
    inout wire kb_dm,
    output wire tp_usb_init,
    output wire tp_sync_detected
);

    wire kb_dp_oe;
    wire kb_dp_out;
    wire kb_dp_in;

    wire kb_dm_oe;
    wire kb_dm_out;
    wire kb_dm_in;

    assign kb_dp = kb_dp_oe ? kb_dp_out : 1'bZ;
    assign kb_dm = kb_dm_oe ? kb_dm_out : 1'bZ;

    cw_decoder_main u_cw_decoder_main (
        .clk(clk),
        .reset(1'b0),
        .cw_sig(cw_sig),
        .kb_dp_oe(kb_dp_oe),
        .kb_dp_out(kb_dp_out),
        .kb_dp_in(kb_dp),
        .kb_dm_oe(kb_dm_oe),
        .kb_dm_out(kb_dm_out),
        .kb_dm_in(kb_dm),
        .tp_usb_init(tp_usb_init),
        .tp_sync_detected(tp_sync_detected)
    );

endmodule

