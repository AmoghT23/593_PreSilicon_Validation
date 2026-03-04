class mtx_mul_drv extends uvm_driver #(mtx_mul_packet);
    `uvm_component_utils(mtx_mul_drv)
    virtual mtx_mul_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual mtx_mul_if)::get(this, "", "vif", vif))
            `uvm_fatal("DRV", "Virtual interface not found")
    endfunction

    task run_phase(uvm_phase phase);
        // Reset Logic
        vif.rst <= 1; 
        vif.start <= 0;
        repeat(5) @(posedge vif.clk);
        vif.rst <= 0;

        forever begin
            seq_item_port.get_next_item(req);
            drive_item(req);
            seq_item_port.item_done();
        end
    endtask

    task drive_item(mtx_mul_packet req);
    @(posedge vif.clk);
    vif.A     <= req.A;
    vif.B     <= req.B;
    vif.start <= 1;
    @(posedge vif.clk);
    vif.start <= 0;
    
    wait(vif.done == 1);
    // Wait for the pipeline to finish so the next 'start' doesn't 
    // kill the current calculation's final steps
    repeat(6) @(posedge vif.clk); 
endtask
endclass