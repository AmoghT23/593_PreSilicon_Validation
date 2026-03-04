module top;
    import uvm_pkg::*;
    import mtx_mul_package::*;

    logic clk;
    initial begin clk = 0; forever #5 clk = ~clk; end

    mtx_mul_if vif(clk);

    mtx_mul_unit #(.WIDTH(WIDTH), .N(N)) dut (
        .clk(vif.clk), .rst(vif.rst), .start(vif.start),
        .A(vif.A), .B(vif.B), .C(vif.C), .done(vif.done)
    );

    initial begin
        $dumpfile("mtx_waves.vcd");
        $dumpvars(0, top);
        uvm_config_db#(virtual mtx_mul_if)::set(null, "*", "vif", vif);
        run_test("mtx_mul_test");
    end
endmodule