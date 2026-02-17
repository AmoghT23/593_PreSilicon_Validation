class transaction #(parameter WIDTH = 16,
                    parameter N = 3);

    rand logic [WIDTH-1:0] A [N-1:0][N-1:0];
    rand logic [WIDTH-1:0] B [N-1:0][N-1:0];
    rand bit start;
    
    
    wire [2*WIDTH-1:0] C [N-1:0][N-1:0];
    bit done;
    function new();
        $display("Transaction started");
        
    endfunction 
endclass 
