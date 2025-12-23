// pwm_env.sv
// filepath: verification/pwm_env.sv
`timescale 1ns/1ps
import uvm_pkg::*;
//import pwm_pkg::*;
class pwm_env extends uvm_env;
  `uvm_component_utils(pwm_env)

  function new(string name="", uvm_component parent);
    super.new(name, parent);
  endfunction

  pwm_agent agent_h;
  pwm_coverage coverage_h;
  pwm_scoreboard scoreboard_h;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent_h = pwm_agent::type_id::create("agent_h", this);
    coverage_h = pwm_coverage::type_id::create("coverage_h", this);
    scoreboard_h = pwm_scoreboard::type_id::create("scoreboard_h", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent_h.monitor_h.ap_mon.connect(coverage_h.analysis_export);
    agent_h.monitor_h.ap_mon.connect(scoreboard_h.aport_mon);
    agent_h.driver_h.drv2sb.connect(scoreboard_h.aport_drv);
  endfunction
endclass
