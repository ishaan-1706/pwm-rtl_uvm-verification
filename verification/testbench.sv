// testbench.sv
// filepath: verification/testbench.sv
`include "pwm_interface.sv"
`include "pwm_pkg.sv"
module testbench;
  import uvm_pkg::*;
  import pwm_pkg::*;
  bit clk;
  always #5 clk = ~clk;  // 100 MHz

  pwm_intf #(.WIDTH(8)) vif (clk);
  top #(.WIDTH(8)) dut (.clk(vif.clk), .rst_n(vif.rst_n), .enable(vif.enable), .duty(vif.duty), .pwm_out(vif.pwm_out));

  initial begin
    uvm_config_db#(virtual pwm_intf)::set(null, "*", "vif", vif);
    run_test("pwm_test");
  end
endmodule