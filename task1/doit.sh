#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f lfsr.vcd

# run verilator translation
verilator -Wall --cc --trace lfsr.sv --exe lfsr_tb.cpp

# build verilator translation
make -j -C obj_dir/ -f Vlfsr.mk Vlfsr

# run executable
obj_dir/Vlfsr