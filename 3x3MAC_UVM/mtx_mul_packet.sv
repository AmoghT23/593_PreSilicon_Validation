class mtx_mul_packet extends uvm_sequence_item;
    `uvm_object_utils(mtx_mul_packet)

    rand logic [WIDTH-1:0] A [N-1:0][N-1:0];
    rand logic [WIDTH-1:0] B [N-1:0][N-1:0];
    logic [2*WIDTH-1:0] C [N-1:0][N-1:0];

    constraint stress_dist { 
        foreach(A[i, j]) A[i][j] dist {0:=1, 1:=1, 255:=3, [2:254]:/5};
        foreach(B[i, j]) B[i][j] dist {0:=1, 1:=1, 255:=3, [2:254]:/5};
    }

    function new(string name = "mtx_mul_packet");
        super.new(name);
    endfunction
endclass