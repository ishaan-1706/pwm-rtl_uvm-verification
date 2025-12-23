// pwm_enable_toggle_sequence.sv
// filepath: verification/pwm_enable_toggle_sequence.sv
`timescale 1ns/1ps
import uvm_pkg::*;
class pwm_enable_toggle_sequence extends uvm_sequence #(pwm_sequence_item);
  `uvm_object_utils(pwm_enable_toggle_sequence)

  pwm_sequence_item txn;

  function new(string name="pwm_enable_toggle_sequence");
    super.new(name);
  endfunction

  virtual task body();
    repeat (20) begin
      txn = pwm_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.rst_n = 1; txn.enable = 1; txn.duty = 128;  // Enable
      finish_item(txn);
      txn = pwm_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.rst_n = 1; txn.enable = 0; txn.duty = 128;  // Disable
      finish_item(txn);
    end
  endtask
endclass