// pwm_sequence.sv
// filepath: verification/pwm_sequence.sv
`timescale 1ns/1ps
import uvm_pkg::*;
//import pwm_pkg::*;
class pwm_sequence extends uvm_sequence #(pwm_sequence_item);
  `uvm_object_utils(pwm_sequence)

  pwm_sequence_item txn;
  longint loop_count = 20;

  function new(string name="pwm_sequence");
    super.new(name);
  endfunction

  virtual task body();
    repeat (loop_count) begin
      txn = pwm_sequence_item::type_id::create("txn");
      start_item(txn);
      assert(txn.randomize());
      txn.rst_n = 1;  // Keep reset deasserted for basic test
      finish_item(txn);
    end
  endtask
endclass
