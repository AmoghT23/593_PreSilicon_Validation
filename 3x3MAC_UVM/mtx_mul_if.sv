interface mtx_mul_if(input logic clk);
    import mtx_mul_package::*;

    logic rst;
    logic start;
    logic [WIDTH-1:0] A [N-1:0][N-1:0];
    logic [WIDTH-1:0] B [N-1:0][N-1:0];
    logic [2*WIDTH-1:0] C [N-1:0][N-1:0];
    logic done;
endinterface