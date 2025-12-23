// pwm_sequence_item.sv
// filepath: verification/pwm_sequence_item.sv
`timescale 1ns/1ps
import uvm_pkg::*;
//import pwm_pkg::*;
class pwm_sequence_item extends uvm_sequence_item;
  parameter int WIDTH = 8;
  rand logic rst_n;
  rand logic enable;
  rand logic [WIDTH-1:0] duty;
  logic pwm_out;

  `uvm_object_utils_begin(pwm_sequence_item)
    `uvm_field_int(rst_n, UVM_ALL_ON)
    `uvm_field_int(enable, UVM_ALL_ON)
    `uvm_field_int(duty, UVM_ALL_ON)
    `uvm_field_int(pwm_out, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="pwm_sequence_item");
    super.new(name);
  endfunction

  function string input2string();
    return $sformatf("rst_n=%0b enable=%0b duty=%0d", rst_n, enable, duty);
  endfunction

  function string output2string();
    return $sformatf("pwm_out=%0b", pwm_out);
  endfunction

  function string convert2string();
    return {input2string(), " ", output2string()};
  endfunction
endclass