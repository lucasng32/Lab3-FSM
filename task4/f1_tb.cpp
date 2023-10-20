#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vf1.h"

#include "vbuddy.cpp"     // include vbuddy code
#define MAX_SIM_CYC 100000

int main(int argc, char **argv, char **env) {
  int simcyc;     // simulation clock count
  int tick;       // each clk cycle has two ticks for two edges
  int lights = 0; // state to toggle LED lights
  enum state {IDLE, COUNT, WAIT};
  state curr_state = IDLE;
  int react_time = 0;

  Verilated::commandArgs(argc, argv);
  // init top verilog instance
  Vf1 * top = new Vf1;
  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("f1.vcd");
 
  // init Vbuddy
  if (vbdOpen()!=1) return(-1);
  vbdHeader("F1");
  vbdSetMode(1);        // Flag mode set to one-shot

  // initialize simulation inputs
  top->clk = 1;
  top->rst = 1;
  top->trigger = 0;
  
  // run simulation for MAX_SIM_CYC clock cycles
  for (simcyc=0; simcyc<MAX_SIM_CYC; simcyc++) {
    // dump variables into VCD file and toggle clock
    for (tick=0; tick<2; tick++) {
      tfp->dump (2*simcyc+tick);
      top->clk = !top->clk;
      top->eval ();
    }

    top->rst = (simcyc < 2); 
    if (curr_state == IDLE){
      top->trigger = vbdFlag();
      vbdHex(4, (react_time >> 16) & 0xF);
      vbdHex(3, (react_time >> 8) & 0xF);
      vbdHex(2, (react_time >> 4) & 0xF);
      vbdHex(1, react_time & 0xF);
      if (top->data_out == 1){
        curr_state = COUNT;
      }
    }
    if (curr_state == WAIT){
      if (vbdFlag()){
        curr_state = IDLE;
        react_time = vbdElapsed();
      }
    }
    if (curr_state == COUNT){
      if (top->data_out == 0){
        vbdInitWatch();
        curr_state = WAIT;
      }
    }

    vbdBar(top->data_out & 0xFF);
    vbdCycle(simcyc);
    

    if (Verilated::gotFinish())  exit(0);
  }

  vbdClose();     // ++++
  tfp->close(); 
  exit(0);
}
