#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f f1_fsm.vcd

# run verilator translation
verilator -Wall --cc --trace f1_fsm.sv --exe f1_fsm_tb.cpp

# build verilator translation
make -j -C obj_dir/ -f Vf1_fsm.mk Vf1_fsm

# run executable
obj_dir/Vf1_fsm