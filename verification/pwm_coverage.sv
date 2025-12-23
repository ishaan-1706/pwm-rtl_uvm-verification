// pwm_coverage.sv
// filepath: verification/pwm_coverage.sv
`timescale 1ns/1ps
import uvm_pkg::*;
//import pwm_pkg::*;
class pwm_coverage extends uvm_subscriber #(pwm_sequence_item);
  `uvm_component_utils(pwm_coverage)

  function new(string name="", uvm_component parent);
    super.new(name, parent);
    dut_cov = new();
  endfunction

  pwm_sequence_item txn;
  real cov;

  covergroup dut_cov;
    option.per_instance = 1;
    DUTY: coverpoint txn.duty { 
      bins zero = {0}; 
      bins low = {[1:127]}; 
      bins mid = {[128:191]}; 
      bins high = {[192:254]}; 
      bins max = {255}; 
    }
    ENABLE: coverpoint txn.enable;
    RST_N: coverpoint txn.rst_n;
    PWM_OUT: coverpoint txn.pwm_out;
    CROSS_DE: cross DUTY, ENABLE;  // Duty vs Enable interactions
  endgroup
  
  function void write(pwm_sequence_item t);
    txn = t;
    dut_cov.sample();
  endfunction

  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov = dut_cov.get_coverage();
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("Coverage is %f", cov), UVM_MEDIUM)
  endfunction
endclass