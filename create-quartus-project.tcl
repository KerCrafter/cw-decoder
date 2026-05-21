project_new -family "Cyclone IV E" -overwrite cw-decoder 
set_global_assignment -name DEVICE EP4CE22F17C6

set_global_assignment -name TOP_LEVEL_ENTITY DE0_NANO_cw_decoder_main

set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files

set_global_assignment -name VERILOG_FILE src/devices_entry/DE0_NANO_cw_decoder_main.v
set_global_assignment -name VERILOG_FILE src/cw_decoder_main.v 
set_global_assignment -name VERILOG_FILE src/cw_decoder_core.v

set_location_assignment PIN_R8 -to clk
set_location_assignment PIN_L15 -to reset

set_location_assignment PIN_R14 -to cw_sig 

set_location_assignment PIN_T14 -to pico_data[0]
set_location_assignment PIN_R13 -to pico_data[1]
set_location_assignment PIN_R12 -to pico_data[2]
set_location_assignment PIN_T10 -to pico_data[3]
set_location_assignment PIN_P11 -to pico_data[4]
set_location_assignment PIN_N12 -to pico_data[5]
set_location_assignment PIN_N9 -to pico_data[6]
set_location_assignment PIN_L16 -to pico_data[7]

set_location_assignment PIN_R16 -to pico_strobe


project_close
