// pwm_duty_sweep_sequence.sv
// filepath: verification/pwm_duty_sweep_sequence.sv
`timescale 1ns/1ps
import uvm_pkg::*;
class pwm_duty_sweep_sequence extends uvm_sequence #(pwm_sequence_item);
  `uvm_object_utils(pwm_duty_sweep_sequence)

  pwm_sequence_item txn;

  function new(string name="pwm_duty_sweep_sequence");
    super.new(name);
  endfunction

  virtual task body();
    for (int i = 0; i <= 255; i++) begin
      txn = pwm_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.rst_n = 1; txn.enable = 1; txn.duty = i;
      finish_item(txn);
    end
  endtask
endclass