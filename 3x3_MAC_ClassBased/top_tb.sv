`include "interface.sv"

module tb_top;

bit clk;
bit rst;

always #5 clk = ~clk;

initial begin
    rst = 1;
    #10 rst = 0;
end

intf intf_top();

assign intf_top.clk = clk;
assign intf_top.rst = rst;

test t1(intf_top);

mtx_mul_unit DUT(
    .clk(intf_top.clk),
    .rst(intf_top.rst),
    .start(intf_top.start),
    .A(intf_top.A),
    .B(intf_top.B),
    .C(intf_top.C),
    .done(intf_top.done)
);

endmodule
