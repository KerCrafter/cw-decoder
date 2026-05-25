`default_nettype none

module cw_decoder_main (
    input  wire clk,
    input  wire reset,
    input  wire cw_sig,
    output wire [7:0] data,
    output wire data_strobe
);

    cw_decoder_core cw_decoder_core_inst (
        .clk(clk),
        .reset(reset),
        .cw_sig(cw_sig),
        .data(data),
        .data_strobe(data_strobe)
    );

endmodule
