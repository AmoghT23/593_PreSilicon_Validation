module accumulator16(
    input logic clk, rst,
    input logic [15:0] data_in,
    output logic [15:0] acc
);
    logic [15:0] sum;
    logic cout;

    adder16 adder(
        .a(acc),
        .b(data_in),
        .cin(1'b0),
        .sum(sum),
        .cout(cout)
    );

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            acc <= 16'd0;
        else
            acc <= sum; // update accumulator
    end
endmodule
