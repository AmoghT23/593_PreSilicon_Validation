class monitor_out;

    int tx_count = 0;
    virtual intf vif;
    mailbox mon_outToscb;

    function new(virtual intf_vi vif, mailbox mon_outToscb);
    this.vif = vif;
    this.mon_outToscb = mon_outToscb;    
    endfunction //new()

    task main();
        $display("Monitor Out started");
        #10;
        $display("Monitor Out Ended");
    endtask 
endclass //monitor_out
