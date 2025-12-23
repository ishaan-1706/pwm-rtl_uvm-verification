// pwm_pkg.sv
// filepath: verification/pwm_pkg.sv
`ifndef PWM_PKG
`define PWM_PKG
`include "uvm_macros.svh"
package pwm_pkg;
  import uvm_pkg::*;
  `include "pwm_sequence_item.sv"
  `include "pwm_sequencer.sv"
  `include "pwm_driver.sv"
  `include "pwm_monitor.sv"
  `include "pwm_scoreboard.sv"
  `include "pwm_coverage.sv"
  `include "pwm_agent.sv"
  `include "pwm_env.sv"
  `include "pwm_sequence.sv"
  `include "pwm_reset_sequence.sv"
  `include "pwm_duty_sweep_sequence.sv"
  `include "pwm_zero_duty_sequence.sv"
  `include "pwm_full_duty_sequence.sv"
  `include "pwm_enable_toggle_sequence.sv"
  `include "pwm_test.sv"
endpackage
`endif