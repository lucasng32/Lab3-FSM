module top #(
    parameter WIDTH = 16,
    parameter OUT_WIDTH = 7
)(
    input logic [WIDTH-1:0] N,
    input logic en,
    input logic rst,
    input logic clk,
    output logic [OUT_WIDTH:0] data_out
);

logic tick;

clktick myclktick(
    .clk(clk),
    .rst(rst),
    .en(en),
    .N(N),
    .tick(tick)
);

f1_fsm my_f1_fsm(
    .rst(rst),
    .clk(clk),
    .en(tick),
    .data_out(data_out)
);

endmodule

