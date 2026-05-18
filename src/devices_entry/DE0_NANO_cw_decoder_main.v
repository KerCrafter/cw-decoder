module DE0_NANO_cw_decoder_main(
    input  wire reset,
    input  wire clk,
    input  wire cw_sig,
    output wire serial_line
);

    cw_decoder_main u_cw_decoder_main (
        .clk(clk),
        .reset(reset),
        .cw_sig(cw_sig),
        .serial_line(serial_line)
    );

endmodule

