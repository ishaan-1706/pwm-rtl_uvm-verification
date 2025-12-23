// pwm_agent.sv
// filepath: verification/pwm_agent.sv
`timescale 1ns/1ps
import uvm_pkg::*;
//import pwm_pkg::*;
class pwm_agent extends uvm_agent;
  `uvm_component_utils(pwm_agent)

  function new(string name="", uvm_component parent);
    super.new(name, parent);
  endfunction

  pwm_sequencer sequencer_h;
  pwm_driver driver_h;
  pwm_monitor monitor_h;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver_h = pwm_driver::type_id::create("driver_h", this);
    sequencer_h = pwm_sequencer::type_id::create("sequencer_h", this);
    monitor_h = pwm_monitor::type_id::create("monitor_h", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
  endfunction
endclass