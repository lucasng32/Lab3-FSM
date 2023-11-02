#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f f1_fsm.vcd

# run verilator translation
verilator -Wall --cc --trace f1_fsm_2.sv --exe f1_fsm_tb.cpp

# build verilator translation
make -j -C obj_dir/ -f Vf1_fsm_2.mk Vf1_fsm_2

# run executable
obj_dir/Vf1_fsm_2