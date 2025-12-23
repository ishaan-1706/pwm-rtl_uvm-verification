// pwm_interface.sv
// filepath: verification/pwm_interface.sv
interface pwm_intf #(parameter int WIDTH = 8) (input bit clk);
  logic rst_n;
  logic enable;
  logic [WIDTH-1:0] duty;
  logic pwm_out;

  modport dut_mp (input clk, rst_n, enable, duty, output pwm_out);
  modport tb_mp (output rst_n, enable, duty, input pwm_out, clk);
endinterface