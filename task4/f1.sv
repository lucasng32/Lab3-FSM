module f1 #()(
    input logic trigger,
    input logic clk,
    input logic rst,
    output logic [7:0] data_out
);

logic cmd_seq;
logic cmd_delay;
logic time_out;
logic tick;
logic [6:0] random;
logic muxout;

clktick #(.WIDTH(5))myclktick (
    .en(cmd_seq),
    .rst(rst),
    .clk(clk),
    .N(5'd24),
    .tick(tick)
);

delay #(.WIDTH(7))mydelay (
    .trigger(cmd_delay),
    .rst(rst),
    .clk(clk),
    .n(random),
    .time_out(time_out)
);

lfsr mylfsr (
    .clk(clk),
    .data_out(random)
);

assign muxout = cmd_seq ? tick : time_out;

f1_fsm myf1_fsm (
    .rst(rst),
    .en(muxout),
    .trigger(trigger),
    .clk (clk),
    .data_out(data_out),
    .cmd_delay(cmd_delay),
    .cmd_seq(cmd_seq)
);

endmodule
