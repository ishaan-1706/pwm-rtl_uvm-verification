// pwm_driver.sv
// filepath: verification/pwm_driver.sv
`timescale 1ns/1ps
import uvm_pkg::*;
//import pwm_pkg::*;
class pwm_driver extends uvm_driver #(pwm_sequence_item);
  `uvm_component_utils(pwm_driver)
  uvm_analysis_port #(pwm_sequence_item) drv2sb;

  function new(string name="", uvm_component parent);
    super.new(name, parent);
    drv2sb = new("drv2sb", this);
  endfunction

  virtual pwm_intf vif;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!(uvm_config_db#(virtual pwm_intf)::get(this, "", "vif", vif)))
      `uvm_fatal(get_type_name(), "unable to get interface");
  endfunction

  task run_phase(uvm_phase phase);
    pwm_sequence_item txn;
    forever begin
      seq_item_port.get_next_item(txn);
      @(posedge vif.clk);
      vif.rst_n <= txn.rst_n;
      vif.enable <= txn.enable;
      vif.duty <= txn.duty;
      drv2sb.write(txn);
      seq_item_port.item_done();
    end
  endtask
endclass