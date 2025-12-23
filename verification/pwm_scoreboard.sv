// pwm_scoreboard.sv
// filepath: verification/pwm_scoreboard.sv
`timescale 1ns/1ps
import uvm_pkg::*;
//import pwm_pkg::*;
`uvm_analysis_imp_decl(_drv)
`uvm_analysis_imp_decl(_mon)
class pwm_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(pwm_scoreboard)

  uvm_analysis_imp_drv #(pwm_sequence_item, pwm_scoreboard) aport_drv;
  uvm_analysis_imp_mon #(pwm_sequence_item, pwm_scoreboard) aport_mon;

  // Remove fifos, compare directly in write_mon
  // uvm_tlm_fifo #(pwm_sequence_item) expfifo;
  // uvm_tlm_fifo #(pwm_sequence_item) outfifo;

  int VECT_CNT, PASS_CNT, ERROR_CNT;
  logic [7:0] ref_counter = 0;  // Reference counter

  function new(string name="pwm_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    aport_drv = new("aport_drv", this);
    aport_mon = new("aport_mon", this);
    // Remove fifo creation
    // expfifo = new("expfifo", this);
    // outfifo = new("outfifo", this);
  endfunction

  // Simplify write_drv: just log stimulus, no model update
  function void write_drv(pwm_sequence_item tr);
    `uvm_info("write_drv STIM", tr.input2string(), UVM_MEDIUM)
    // No counter update or fifo put
  endfunction

  // Update write_mon: maintain model and compare here
  function void write_mon(pwm_sequence_item tr);
    logic expected_pwm_out;
    `uvm_info("write_mon OUT", tr.convert2string(), UVM_MEDIUM)
    // Update reference model based on sampled inputs
    if (!tr.rst_n || !tr.enable) begin
      ref_counter = 0;
      expected_pwm_out = 0;
    end else begin
      ref_counter = ref_counter + 1;
      expected_pwm_out = (ref_counter < tr.duty) ? 1 : 0;
    end
    // Compare actual vs expected
    if (tr.pwm_out == expected_pwm_out) begin
      PASS();
      `uvm_info("PASS", tr.convert2string(), UVM_MEDIUM)
    end else begin
      ERROR();
      `uvm_info("ERROR [ACTUAL]", tr.convert2string(), UVM_MEDIUM)
      `uvm_info("ERROR [EXPECTED]", $sformatf("pwm_out=%0b", expected_pwm_out), UVM_MEDIUM)
    end
  endfunction

  // Remove run_phase, as comparison is now in write_mon
  // task run_phase(uvm_phase phase);
  //   // Removed
  // endtask

  function void PASS();
    VECT_CNT++; PASS_CNT++;
  endfunction

  function void ERROR();
    VECT_CNT++; ERROR_CNT++;
  endfunction
endclass