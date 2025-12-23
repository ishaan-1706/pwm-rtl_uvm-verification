// pwm_full_duty_sequence.sv
// filepath: verification/pwm_full_duty_sequence.sv
`timescale 1ns/1ps
import uvm_pkg::*;
class pwm_full_duty_sequence extends uvm_sequence #(pwm_sequence_item);
  `uvm_object_utils(pwm_full_duty_sequence)

  pwm_sequence_item txn;

  function new(string name="pwm_full_duty_sequence");
    super.new(name);
  endfunction

  virtual task body();
    repeat (50) begin  // Multiple cycles
      txn = pwm_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.rst_n = 1; txn.enable = 1; txn.duty = 255;
      finish_item(txn);
    end
  endtask
endclass