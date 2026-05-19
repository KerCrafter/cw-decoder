project_new -family "Cyclone IV E" -overwrite cw-decoder 
set_global_assignment -name DEVICE EP4CE22F17C6

set_global_assignment -name TOP_LEVEL_ENTITY DE0_NANO_cw_decoder_main

set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files

set_global_assignment -name VERILOG_FILE src/devices_entry/DE0_NANO_cw_decoder_main.v
set_global_assignment -name VERILOG_FILE src/cw_decoder_main.v 
set_global_assignment -name VERILOG_FILE src/cw_decoder_core.v
set_global_assignment -name VERILOG_FILE src/usb-hid-keyboard/src/usb_hid_keyboard.v

set_location_assignment PIN_R8 -to clk

set_location_assignment PIN_R14 -to cw_sig 

set_location_assignment PIN_T14 -to kb_dp
set_location_assignment PIN_R13 -to kb_dm

set_location_assignment PIN_A15 -to tp_usb_init
set_location_assignment PIN_A13 -to tp_sync_detected


project_close
