`default_nettype none

module cw_decoder_main (
    input  wire clk,
    input  wire reset,
    input  wire cw_sig,
    output wire serial_line
);

    cw_decoder_core cw_decoder_core_inst (
        .clk(clk),
        .reset(reset),
        .cw_sig(cw_sig),
        .serial_line(serial_line)
    );

endmodule
