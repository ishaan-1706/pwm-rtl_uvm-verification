
// pwm_reset_sequence.sv
// filepath: verification/pwm_reset_sequence.sv
`timescale 1ns/1ps
import uvm_pkg::*;
//import pwm_pkg::*;
class pwm_reset_sequence extends uvm_sequence #(pwm_sequence_item);
  `uvm_object_utils(pwm_reset_sequence)

  pwm_sequence_item txn;

  function new(string name="pwm_reset_sequence");
    super.new(name);
  endfunction

  virtual task body();
    txn = pwm_sequence_item::type_id::create("txn");
    start_item(txn);
    txn.rst_n = 0; txn.enable = 0; txn.duty = 0;
    finish_item(txn);
    #10;  // Wait for reset
    txn = pwm_sequence_item::type_id::create("txn");
    start_item(txn);
    txn.rst_n = 1; txn.enable = 1; txn.duty = 128;  // Enable with mid duty
    finish_item(txn);
  endtask
endclass