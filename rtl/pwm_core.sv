// rtl/pwm_core.sv
// Simple edge-aligned PWM core with parameterized resolution.

module pwm_core #(
  parameter int WIDTH = 8  // resolution: counter and duty width
) (
  input  logic                 clk,
  input  logic                 rst_n,    // active-low async reset
  input  logic                 enable,   // enables PWM operation
  input  logic [WIDTH-1:0]     duty,     // duty setting: 0 .. 2^WIDTH-1
  output logic                 pwm_out   // PWM output
);

  // Free-running counter
  logic [WIDTH-1:0] counter;

  // Counter: increments when enabled, resets on rst_n or when disabled
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= '0;
    end else if (!enable) begin
      // When disabled, hold a known state
      counter <= '0;
    end else begin
      counter <= counter + 1'b1;  // naturally wraps at max value
    end
  end

  // PWM generation: high when counter < duty (for enabled state)
  always_comb begin
    if (!enable) begin
      pwm_out = 1'b0;
    end else begin
      pwm_out = (counter < duty);
    end
  end

endmodule