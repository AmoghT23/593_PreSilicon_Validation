class mtx_mul_pkt_seq extends uvm_sequence #(mtx_mul_packet);

    `uvm_object_utils(mtx_mul_pkt_seq)



    function new(string name = "mtx_mul_pkt_seq");

        super.new(name);

    endfunction



    task body();

        mtx_mul_packet pkt;

        int unsigned iter = 0;



        repeat(1000) begin

            pkt = mtx_mul_packet::type_id::create($sformatf("pkt_%0d", iter));

            start_item(pkt);



            case (iter)

                0: begin // ALL ZEROS

                    if (!pkt.randomize() with {

                        foreach (A[i,j]) A[i][j] == 0;

                        foreach (B[i,j]) B[i][j] == 0;

                    }) `uvm_error("SEQ", "Randomization failed")

                end

                1: begin // IDENTITY MATRIX

                    if (!pkt.randomize() with {

                        foreach (A[i,j]) A[i][j] inside {[1:255]};

                        foreach (B[i,j]) {

                            if (i == j) B[i][j] == 1;

                            else        B[i][j] == 0;

                        }

                    }) `uvm_error("SEQ", "Randomization failed")

                end

                2: begin // MAX STRESS (255)

                    if (!pkt.randomize() with {

                        foreach (A[i,j]) A[i][j] == 255;

                        foreach (B[i,j]) B[i][j] == 255;

                    }) `uvm_error("SEQ", "Randomization failed")

                end

                default: begin // RANDOM

                    if (!pkt.randomize())

                        `uvm_error("SEQ", "Randomization failed")

                end

            endcase



            finish_item(pkt);

            iter++;

        end

        `uvm_info("SEQ", $sformatf("Sequence complete: %0d transactions sent", iter), UVM_LOW)

    endtask

endclass