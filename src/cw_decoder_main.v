`default_nettype none

module cw_decoder_main (
    input  wire clk,
    input  wire reset,
    input  wire cw_sig,
    inout wire kb_dp,
    inout wire kb_dm,
    output wire tp_usb_init
);

    wire serial_line;

    cw_decoder_core cw_decoder_core_inst (
        .clk(clk),
        .reset(reset),
        .cw_sig(cw_sig),
        .serial_line(serial_line)
    );

    usb_hid_keyboard u_usb_hid_keyboard (
        .clk(clk),
        .reset(reset),
        .kb_dp(kb_dp),
        .kb_dm(kb_dm),
        .tp_usb_init(tp_usb_init)
    );

endmodule
