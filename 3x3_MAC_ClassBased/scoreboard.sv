class scoreboard;

    mailbox mon_inToscb;
    mailbox mon_outToscb;

    function new(mailbox mon_inToscb, mailbox mon_outToscb); 
    this.mon_inToscb = mon_inToscb;
    this.mon_outToscb = mon_outToscb;
    endfunction //new()

    task main();
        fork
            get_input();
            get_output();
        join
    endtask 

    task get_input();
        
    endtask 

    task get_output();
        
    endtask 
endclass //scoreboard
