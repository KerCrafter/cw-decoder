#!/bin/bash

export PROJECT_SOURCES=`
  grep "set_global_assignment -name VERILOG_FILE" create-quartus-project.tcl |
  awk '{print $4}' |
  xargs
` 

./tests/cocotb-runner/run_tests.sh
