// rtl/top.sv
// Thin wrapper around pwm_core for clean top-level integration.

module top #(
  parameter int WIDTH = 8
) (
  input  logic                 clk,
  input  logic                 rst_n,
  input  logic                 enable,
  input  logic [WIDTH-1:0]     duty,
  output logic                 pwm_out
);

  // Instantiate the core PWM
  pwm_core #(
    .WIDTH (WIDTH)
  ) u_pwm_core (
    .clk    (clk),
    .rst_n  (rst_n),
    .enable (enable),
    .duty   (duty),
    .pwm_out(pwm_out)
  );

endmodule