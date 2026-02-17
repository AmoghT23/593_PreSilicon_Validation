interface intf #(parameter WIDTH = 16,
                 parameter N = 3);
    logic clk;
    logic rst;
    logic start;
    logic [WIDTH-1:0] A [N-1:0][N-1:0];
    logic [WIDTH-1:0] B [N-1:0][N-1:0];
    wire [2*WIDTH-1:0] C [N-1:0][N-1:0];
    logic done;

modport TB(input clk, input rst);

modport DUT(input clk, rst, start, A, B, C, done)
    
endinterface: intf
