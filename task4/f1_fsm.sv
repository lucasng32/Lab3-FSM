module f1_fsm #(
)(
    input logic rst,
    input logic en,
    input logic clk,
    input logic trigger,
    output logic [7:0] data_out,
    output logic cmd_seq,
    output logic cmd_delay

);
logic [7:0] sreg;

always_ff @ (posedge clk, posedge rst, posedge trigger) // x^7 + x^3 + 1
    if (rst)
        sreg <= 8'b0;
    else if (trigger) 
        cmd_seq <= 1'b1;
    else if (sreg == 8'b11111111 && !en) begin
        cmd_seq <= 1'b0;
        cmd_delay <= 1'b1;
    end
    else if (en) 
    begin
        if (sreg == 8'b11111111) begin
            sreg <= 8'b0;
            cmd_delay <= 1'b0;
        end
        else begin
            sreg <= (sreg << 1) + 8'b1;
        end
    end

assign data_out = sreg;
endmodule
