`include "transaction.sv"

class generator;
    transaction trans;
    mailbox genTodriv;
    int tx_count;

    function new(mailbox genTodriv);
        this.genTodriv = genTodriv;
    endfunction 

    task main();
        $display("Generator Started");
        repeat(tx_count) begin 
            trans.new();

            if(!trans.randomize()) $fatal("[GEN]: Randomization Failed")
            genTodriv.put(trans);
            $display("[GEN]: Matrix %0d sent to Driver", tx_count);
        end
        $display("[GEN]: Generator Ended");
    endtask 

endclass 
