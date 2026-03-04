class mtx_mul_env extends uvm_env;
    `uvm_component_utils(mtx_mul_env)

    mtx_mul_agnt agnt;
    mtx_mul_scoreboard scb;

    function new(string name="env", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agnt = mtx_mul_agnt::type_id::create("agnt", this);
        scb  = mtx_mul_scoreboard::type_id::create("scb", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // Connect Monitor's Analysis Port to Scoreboard's Export
        agnt.mon.mon_port.connect(scb.item_export);
    endfunction
endclass