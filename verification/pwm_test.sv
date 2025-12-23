// pwm_test.sv
// filepath: verification/pwm_test.sv
`timescale 1ns/1ps
import uvm_pkg::*;
import pwm_pkg::*;
class pwm_test extends uvm_test;
  `uvm_component_utils(pwm_test)

  function new(string name="", uvm_component parent);
    super.new(name, parent);
  endfunction

  pwm_env env_h;
  pwm_sequence seq;
  pwm_reset_sequence rst_seq;
  pwm_duty_sweep_sequence duty_sweep_seq;
  pwm_zero_duty_sequence zero_duty_seq;
  pwm_full_duty_sequence full_duty_seq;
  pwm_enable_toggle_sequence enable_toggle_seq;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_h = pwm_env::type_id::create("env_h", this);
    seq = pwm_sequence::type_id::create("seq");
    rst_seq = pwm_reset_sequence::type_id::create("rst_seq");
    duty_sweep_seq = pwm_duty_sweep_sequence::type_id::create("duty_sweep_seq");
    zero_duty_seq = pwm_zero_duty_sequence::type_id::create("zero_duty_seq");
    full_duty_seq = pwm_full_duty_sequence::type_id::create("full_duty_seq");
    enable_toggle_seq = pwm_enable_toggle_sequence::type_id::create("enable_toggle_seq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    rst_seq.start(env_h.agent_h.sequencer_h);  // Reset first
    seq.start(env_h.agent_h.sequencer_h);      // Random (basic)
    // Add new sequences for comprehensive testing
    duty_sweep_seq.start(env_h.agent_h.sequencer_h);
    zero_duty_seq.start(env_h.agent_h.sequencer_h);
    full_duty_seq.start(env_h.agent_h.sequencer_h);
    enable_toggle_seq.start(env_h.agent_h.sequencer_h);
    #1000;  // Longer run to stabilize coverage
    phase.drop_objection(this);
  endtask
endclass