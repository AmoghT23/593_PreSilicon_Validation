class mtx_mul_agnt extends uvm_agent;
    `uvm_component_utils(mtx_mul_agnt)

    mtx_mul_drv drv;
    mtx_mul_seqr seqr;
    mtx_mul_monitor mon;

    function new(string name="agnt", uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv  = mtx_mul_drv::type_id::create("drv", this);
        seqr = mtx_mul_seqr::type_id::create("seqr", this);
        mon  = mtx_mul_monitor::type_id::create("mon", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction
endclass