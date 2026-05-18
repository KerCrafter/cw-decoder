project_new -family "Cyclone IV E" -overwrite cw-decoder 
set_global_assignment -name DEVICE EP4CE22F17C6

set_global_assignment -name TOP_LEVEL_ENTITY DE0_NANO_cw_decoder_main

set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files

set_global_assignment -name VERILOG_FILE src/devices_entry/DE0_NANO_cw_decoder_main.v
set_global_assignment -name VERILOG_FILE src/cw_decoder_main.v 
set_global_assignment -name VERILOG_FILE src/cw_decoder_core.v

set_location_assignment PIN_R8 -to clk
set_location_assignment PIN_R14 -to cw_sig 

set_location_assignment PIN_T14 -to serial_line

project_close
