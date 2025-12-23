// pwm_monitor.sv
// filepath: verification/pwm_monitor.sv
`timescale 1ns/1ps
import uvm_pkg::*;
//import pwm_pkg::*;
class pwm_monitor extends uvm_monitor;
  `uvm_component_utils(pwm_monitor)

  function new(string name="", uvm_component parent);
    super.new(name, parent);
  endfunction

  pwm_sequence_item txn;
  virtual pwm_intf vif;
  uvm_analysis_port #(pwm_sequence_item) ap_mon;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!(uvm_config_db#(virtual pwm_intf)::get(this, "", "vif", vif)))
      `uvm_fatal("monitor", "unable to get interface");
    ap_mon = new("ap_mon", this);
    txn = pwm_sequence_item::type_id::create("txn", this);
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      @(negedge vif.clk);
      txn.rst_n = vif.rst_n;
      txn.enable = vif.enable;
      txn.duty = vif.duty;
      txn.pwm_out = vif.pwm_out;
      ap_mon.write(txn);
    end
  endtask
endclass