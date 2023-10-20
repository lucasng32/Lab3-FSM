module f1_fsm #(
)(
    input logic rst,
    input logic en,
    input logic clk,
    output logic [7:0] data_out
);
logic [7:0] sreg;

always_ff @ (posedge clk, posedge rst) // x^7 + x^3 + 1
    if (rst)
        sreg <= 8'b0;
    else if (en) 
    begin
        if (sreg == 8'b11111111)
            sreg <= 8'b0;
        else
            sreg <= (sreg << 1) + 8'b1;
    end

assign data_out = sreg;
endmodule
