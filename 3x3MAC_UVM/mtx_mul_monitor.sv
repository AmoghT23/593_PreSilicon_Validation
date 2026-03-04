class mtx_mul_monitor extends uvm_monitor;
    `uvm_component_utils(mtx_mul_monitor)
    virtual mtx_mul_if vif;
    uvm_analysis_port #(mtx_mul_packet) mon_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        mon_port = new("mon_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual mtx_mul_if)::get(this, "", "vif", vif))
            `uvm_fatal("MON", "Virtual interface not found")
    endfunction

    task run_phase(uvm_phase phase);
    forever begin
        mtx_mul_packet pkt = mtx_mul_packet::type_id::create("pkt");
        
        // Use fork-join_any to ensure we don't hang if a signal is missed
        fork
            begin
                @(posedge vif.start);
                pkt.A = vif.A;
                pkt.B = vif.B;
                @(posedge vif.done);
                repeat(3) @(posedge vif.clk); // Pipeline delay
                pkt.C = vif.C;
                mon_port.write(pkt);
            end
            begin
                // Timeout safety: if 1000 cycles pass with no activity, move on
                repeat(1000) @(posedge vif.clk);
            end
        join_any
        disable fork;
    end
endtask
endclass