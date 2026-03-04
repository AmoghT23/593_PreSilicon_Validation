class mtx_mul_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(mtx_mul_scoreboard)
    uvm_analysis_imp #(mtx_mul_packet, mtx_mul_scoreboard) item_export;

    int total, passed;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        item_export = new("item_export", this);
    endfunction

    function void write(mtx_mul_packet pkt);
    logic [2*WIDTH-1:0] exp_C [N-1:0][N-1:0];
    bit fail = 0;
    total++;

    // Golden Model
    for(int i=0; i<N; i++) begin
        for(int j=0; j<N; j++) begin
            exp_C[i][j] = 0;
            for(int k=0; k<N; k++) begin
                exp_C[i][j] = exp_C[i][j] + (32'(pkt.A[i][k]) * 32'(pkt.B[k][j]));
            end
            if(exp_C[i][j] !== pkt.C[i][j]) fail = 1;
        end
    end

    if(!fail) passed++;
    
    // Comprehensive Log
    `uvm_info("SCB", $sformatf("\n--- Trans %0d [%s] ---\nA: %p\nB: %p\nDUT C: %p\nEXP C: %p", 
              total, fail ? "FAIL" : "PASS", pkt.A, pkt.B, pkt.C, exp_C), UVM_LOW)
endfunction

// Make sure you have the report_phase to see the final %
function void report_phase(uvm_phase phase);
    real p_pct;
    if (total > 0) p_pct = (real'(passed)/total)*100.0;
    `uvm_info("FINAL", $sformatf("\nTotal: %0d\nPassed: %0d (%.2f%%)\nFailed: %0d", 
              total, passed, p_pct, (total-passed)), UVM_NONE)
endfunction
endclass