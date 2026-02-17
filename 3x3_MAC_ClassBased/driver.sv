class driver;

    int tx_count1 = 0;
    int tx_count2 = 0;

    virtual intf intf_vi;
    mailbox genTodriv;

    function new(virtual intf intf_vi, mailbox genTodriv);
        this.intf_vi = intf_vi;
        this.genTodriv = genTodriv;
    endfunction //new()

    task reset;
        wait(intf_vi.rst);
        $display("[DRIV]: Reset Started");
    endtask 

    task  main(arguments);
        forever begin
            genTodriv.get(trans);
            intf_vi.cb.A <= trans.A;
            #10;
        end
    endtask //
endclass //driver
