#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f f1.vcd

# run verilator translation
verilator -Wall --cc --trace f1.sv lfsr.sv clktick.sv delay.sv f1_fsm.sv --exe f1_tb.cpp

# build verilator translation
make -j -C obj_dir/ -f Vf1.mk Vf1

# run executable
obj_dir/Vf1