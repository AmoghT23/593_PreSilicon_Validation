class mtx_mul_seqr extends uvm_sequencer #(mtx_mul_packet);
    `uvm_component_utils(mtx_mul_seqr)

    function new(string name="mtx_mul_seqr", uvm_component parent);
        super.new(name, parent);
    endfunction
endclass