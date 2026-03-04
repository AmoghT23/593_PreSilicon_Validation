package mtx_mul_package;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Parameters for 3x3 8-bit multiplication (16-bit accumulator)
    parameter int WIDTH = 8;
    parameter int N     = 3;

    // Order matters! Include packet before the components that use it.
    `include "mtx_mul_packet.sv"
    `include "mtx_mul_pkt_seq.sv"
    `include "mtx_mul_seqr.sv"
    `include "mtx_mul_drv.sv"
    `include "mtx_mul_monitor.sv"
    `include "mtx_mul_agnt.sv"
    `include "mtx_mul_scb.sv"
    `include "mtx_mul_env.sv"
    `include "mtx_mul_test.sv"
endpackage