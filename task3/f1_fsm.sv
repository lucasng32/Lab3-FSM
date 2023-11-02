module f1_fsm #(
)(
    input logic rst,
    input logic en,
    input logic clk,
    output logic [7:0] data_out
);

//define state
typedef enum { S0, S1, S2, S3, S4, S5, S6, S7, S8 } states;
states current, next;

//state transition
always_ff @ (posedge clk)
    if (rst) current <= S0;
    else if (en) current <= next;

//next state logic
always_comb
    case (current)
        S0: next = S1;
        S1: next = S2;
        S2: next = S3;
        S3: next = S4;
        S4: next = S5;
        S5: next = S6;
        S6: next = S7;
        S7: next = S8;
        S8: next = S0;
    endcase

//output logic
always_comb
    case(current)
        S0: data_out = 8'b0;
        S1: data_out = 8'b1;
        S2: data_out = 8'b11;
        S3: data_out = 8'b111;
        S4: data_out = 8'b1111;
        S5: data_out = 8'b11111;
        S6: data_out = 8'b111111;
        S7: data_out = 8'b1111111;
        S8: data_out = 8'b11111111;
    endcase

endmodule
