// pwm_sequencer.sv
// filepath: verification/pwm_sequencer.sv
`timescale 1ns/1ps
import uvm_pkg::*;
//import pwm_pkg::*;
class pwm_sequencer extends uvm_sequencer #(pwm_sequence_item);
  `uvm_component_utils(pwm_sequencer)

  function new(string name="", uvm_component parent);
    super.new(name, parent);
  endfunction
endclass