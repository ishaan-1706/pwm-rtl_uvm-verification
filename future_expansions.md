# Future Expansions for the PWM RTL + UVM Environment

This document outlines potential enhancements to the PWM design and its verification environment.  
Each feature is categorized based on how much it affects the RTL architecture and the UVM testbench.

The goal is to give future contributors (or your future self) a clear roadmap for extending the project without breaking existing structure.

---

## 🟦 Category 1 — RTL Changes With *No* Verification Architecture Impact

These modifications change internal RTL behavior but do not alter the DUT interface or require new UVM components.

### 1. Center-Aligned PWM (Up/Down Counter)
- Replace the up-counter with an up/down counter.
- Produces symmetric PWM waveforms.
- No new ports or protocols.

### 2. Multi-Channel PWM (Shared Counter)
- One counter drives multiple comparators.
- Useful for RGB LEDs, motor phases, etc.
- Verification scales linearly but architecture stays the same.

### 3. Phase Shifting
- Add a per-channel phase offset.
- Only affects waveform timing.
- No new interface signals.

### 4. Programmable Resolution
- Allow dynamic selection of effective counter width.
- Same interface, different internal max count.

---

## 🟩 Category 2 — Small RTL Extensions (Minimal Verification Impact)

These add small logic blocks but do not change the DUT interface.

### 1. Prescaler
- Insert a clock divider before the counter.
- Verification only sees a slower PWM frequency.

### 2. Double-Buffered Duty Register
- Add `duty_shadow` and `duty_active`.
- Ensures glitch-free duty updates.
- Verification only needs to observe update timing.

### 3. Synchronous Start/Stop
- Add gating logic to align PWM start across modules.
- No new ports unless explicitly exposed.

---

## 🟥 Category 3 — Features That *Do* Impact Verification Architecture

These introduce new ports, protocols, or safety behavior.  
They require new sequences, coverage, scoreboard logic, and possibly a register model.

### 1. Dead-Time Generator
- Generates complementary outputs (`pwm_high`, `pwm_low`).
- Adds timing constraints and safety checks.
- Verification must check dead-time correctness.

### 2. Register Interface (APB or AXI-Lite)
- Adds a full bus protocol.
- Requires:
  - Register model (UVM RAL)
  - Bus agent
  - Register sequences
  - Register coverage

### 3. Fault Handling
- Add `fault_in`, fault latch, and override logic.
- Verification must test:
  - Fault injection
  - Recovery
  - Priority rules

---

## 🧭 Summary Table

| Feature | Category | Impact |
|--------|----------|--------|
| Prescaler | 🟩 | Internal timing only |
| Double-buffered duty | 🟩 | Internal sequencing only |
| Center-aligned PWM | 🟦 | Same interface, different waveform |
| Multi-channel PWM | 🟦 | Scales outputs, no new protocols |
| Phase shifting | 🟦 | Adds offset logic only |
| Synchronous start/stop | 🟩 | Gating logic only |
| Dead-time generator | 🟥 | New outputs + safety timing |
| Register interface | 🟥 | New protocol + register model |
| Fault handling | 🟥 | New states + safety behavior |
| Programmable resolution | 🟦 | Same interface, different max count |

---

## 🧠 Why This Document Exists

This project is intentionally minimal and clean.  
Future expansions should preserve that clarity.

This roadmap helps ensure that:

- RTL remains modular and synthesizable  
- Verification remains scalable and maintainable  
- Contributors understand the architectural impact of each feature  

Feel free to extend this document as the project evolves.