class monitor_in;
    virtual intf vif;
    mailbox mon_inToscb;

    function new(virtual intf vif, mailbox mon_inToscb); 
        this.vif = vif;
        this.mon_inToscb = mon_inToscb;
    endfunction //new()

    task main();
        $display("Monitor to scoreboard started");
        #10;
        $display("Monitor Ended");
    endtask
endclass //monitor_in
