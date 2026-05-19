`default_nettype none

module cw_decoder_main (
    input  wire clk,
    input  wire reset,
    input  wire cw_sig,
    input wire kb_dp_in,
    input wire kb_dm_in,
    output wire kb_dp_out,
    output wire kb_dm_out,
    output wire kb_dp_oe,
    output wire kb_dm_oe,
    output wire tp_usb_init,
    output wire tp_sync_detected
);

    wire serial_line;
    wire clk_48;
    wire clk_48_locked;

    cw_decoder_core cw_decoder_core_inst (
        .clk(clk),
        .reset(reset),
        .cw_sig(cw_sig),
        .serial_line(serial_line)
    );

    usb_hid_keyboard u_usb_hid_keyboard (
        .clk(clk_48),
        .clk_locked(clk_48_locked),
        .reset(reset),
        .kb_dp_oe(kb_dp_oe),
        .kb_dp_out(kb_dp_out),
        .kb_dp_in(kb_dp_in),
        .kb_dm_oe(kb_dm_oe),
        .kb_dm_out(kb_dm_out),
        .kb_dm_in(kb_dm_in),
        .tp_usb_init(tp_usb_init),
        .tp_sync_detected(tp_sync_detected)
    );

    altpll #(
        .intended_device_family ("Cyclone IV E"),
        .inclk0_input_frequency (20000),   // période en ps : 1/50MHz = 20000ps
        .clk0_multiply_by       (24),
        .clk0_divide_by         (25),      // 50 × 24/25 = 48 MHz
        .operation_mode         ("NORMAL"),
        .compensate_clock       ("CLK0")
    ) altpll_inst (
        .inclk  ({1'b0, clk}),
        .clk    (clk_48),
        .locked (clk_48_locked)
    );

endmodule
