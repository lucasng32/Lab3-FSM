module lfsr #(
)(
    input logic clk,
    output logic [7:1] data_out
);
logic [7:1] sreg;

always_ff @ (posedge clk) 
    if (sreg == 7'b0)
        sreg <= 7'b1;
    else
        sreg <= {sreg[6:1], sreg[7] ^ sreg[3]};

assign data_out = sreg;
endmodule
