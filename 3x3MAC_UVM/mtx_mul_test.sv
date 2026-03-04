class mtx_mul_test extends uvm_test;

    `uvm_component_utils(mtx_mul_test)

    mtx_mul_env     env;
    mtx_mul_pkt_seq test_seq;

    function new(string name = "mtx_mul_test", uvm_component parent);
        super.new(name, parent);
        `uvm_info("TST", "Inside Constructor", UVM_HIGH)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("TST", "Build Phase", UVM_HIGH)
        env = mtx_mul_env::type_id::create("env", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("TST", "Connect Phase", UVM_HIGH)
    endfunction

    // -------------------------------------------------------------------------
    // start_of_simulation_phase
    // Print UVM topology and ASCII art of the testbench architecture
    // -------------------------------------------------------------------------
    function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TST", "\n================================================================\n  UVM TOPOLOGY - 3x3 Matrix Multiplication Unit\n  ECE-593, Portland State University\n================================================================\n  mtx_mul_test\n  └── mtx_mul_env\n      ├── mtx_mul_agnt\n      │   ├── mtx_mul_seqr\n      │   ├── mtx_mul_drv\n      │   └── mtx_mul_monitor --(analysis port)-->\n      └── mtx_mul_scb\n================================================================\n  PIPELINE TIMING:\n  T0: start pulse  -> MACs reset\n  T1: A[i][0]*B[0][j] -> Stage1\n  T2: done asserts\n  T3: pipeline draining\n  T4: pipeline draining\n  T5: *** C VALID *** sample here\n================================================================", UVM_LOW)
    uvm_top.print_topology();
endfunction

    function void print_uvm_topology();
        `uvm_info("TST", {"\n",
        "================================================================\n",
        "   UVM TESTBENCH TOPOLOGY - 3x3 Matrix Multiplication Unit\n",
        "   ECE-593, Portland State University\n",
        "================================================================\n",
        "\n",
        "  +----------------------------------------------------------+\n",
        "  |                    mtx_mul_test                          |\n",
        "  |  +----------------------------------------------------+  |\n",
        "  |  |                  mtx_mul_env                       |  |\n",
        "  |  |  +-------------------------------+  +-----------+  |  |\n",
        "  |  |  |       mtx_mul_agnt            |  | mtx_mul_  |  |  |\n",
        "  |  |  |  +-----------+  +----------+  |  |   scb     |  |  |\n",
        "  |  |  |  | mtx_mul_  |  | mtx_mul_ |  |  |           |  |  |\n",
        "  |  |  |  |   seqr    |  |   drv    |  |  | golden    |  |  |\n",
        "  |  |  |  |           |  |          |  |  | model +   |  |  |\n",
        "  |  |  |  +-----------+  +----------+  |  | compare   |  |  |\n",
        "  |  |  |       |              |         |  |           |  |  |\n",
        "  |  |  |  +----------+        |         |  | coverage  |  |  |\n",
        "  |  |  |  | mtx_mul_ |        |         |  |           |  |  |\n",
        "  |  |  |  |  monitor |<-------+---------|->+-----------+  |  |\n",
        "  |  |  |  +----------+ (analysis port)  |                 |  |\n",
        "  |  |  +-------------------------------+                  |  |\n",
        "  |  +----------------------------------------------------+  |\n",
        "  +----------------------------------------------------------+\n",
        "           |               |                    ^\n",
        "           | seq_item      | drive signals      | C, done\n",
        "           v               v                    |\n",
        "  +----------------------------------------------------------+\n",
        "  |                  mtx_mul_if (Virtual Interface)         |\n",
        "  |   drv_cb (output: start, A, B)  mon_cb (input: all)    |\n",
        "  +----------------------------------------------------------+\n",
        "                          |\n",
        "                          v\n",
        "  +----------------------------------------------------------+\n",
        "  |              DUT: mtx_mul_unit (WIDTH=16, N=3)          |\n",
        "  |                                                          |\n",
        "  |   mac[0][0]  mac[0][1]  mac[0][2]                      |\n",
        "  |   mac[1][0]  mac[1][1]  mac[1][2]   (9x mac_unit)      |\n",
        "  |   mac[2][0]  mac[2][1]  mac[2][2]                      |\n",
        "  |                                                          |\n",
        "  |   Each mac_unit: Stage1(input regs) -> Stage2(product)  |\n",
        "  |                  -> Stage3(accumulator) = 3 cycles      |\n",
        "  +----------------------------------------------------------+\n",
        "\n",
        "  PIPELINE TIMING (N=3):\n",
        "  T0: start pulse  -> accumulators reset\n",
        "  T1: A[i][0]*B[0][j] -> Stage 1 (input regs)\n",
        "  T2: done asserts (count==2); A[i][1]*B[1][j] -> Stage 1\n",
        "  T3: A[i][2]*B[2][j] -> Stage 1; P0 -> Stage 3 (acc)\n",
        "  T4: P1 -> Stage 3; P0+P1 accumulating\n",
        "  T5: *** C VALID *** P0+P1+P2 in accumulator -- SAMPLE HERE\n",
        "================================================================\n"
        }, UVM_LOW)
    endfunction

    // -------------------------------------------------------------------------
    // end_of_elaboration_phase -- print UVM topology
    // -------------------------------------------------------------------------
    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction

    // -------------------------------------------------------------------------
    // run_phase
    // -------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        test_seq = mtx_mul_pkt_seq::type_id::create("test_seq");

        phase.raise_objection(this);
        `uvm_info("TST", "Run Phase: Starting sequence", UVM_LOW)

        // Run the sequence -- blocking, waits for all 1000 transactions
        test_seq.start(env.agnt.seqr);

        // Drain time: allow monitor to send the last transaction to scoreboard
        // 3 cycles post-done + margin
        #200;

        `uvm_info("TST", "Run Phase: Sequence complete", UVM_LOW)
        phase.drop_objection(this);
    endtask

endclass
