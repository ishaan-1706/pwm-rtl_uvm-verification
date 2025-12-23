# **PWM RTL + UVM Verification Environment**

This repository contains a clean, parameterized RTL implementation of a simple edge‑aligned PWM (Pulse Width Modulation) generator, along with a complete UVM‑based verification environment.  
The project is intentionally minimal, modular, and easy to extend — designed to serve as a foundation for learning, experimentation, and future feature expansion.

---

## **📁 Repository Structure**

```
.
├── README.md
├── LICENSE
├── .gitignore
├── future_expansions.md
│
├── rtl/
│   ├── pwm_core.sv
│   └── top.sv
│
└── verification/
    ├── pwm_interface.sv
    ├── pwm_pkg.sv
    ├── pwm_sequence_item.sv
    ├── pwm_sequencer.sv
    ├── pwm_driver.sv
    ├── pwm_monitor.sv
    ├── pwm_agent.sv
    ├── pwm_env.sv
    ├── pwm_scoreboard.sv
    ├── pwm_coverage.sv
    ├── pwm_sequence.sv
    ├── pwm_reset_sequence.sv
    ├── pwm_duty_sweep_sequence.sv
    ├── pwm_zero_duty_sequence.sv
    ├── pwm_full_duty_sequence.sv
    ├── pwm_enable_toggle_sequence.sv
    └── testbench.sv
```

---

## **🔧 RTL Overview**

### **`pwm_core.sv`**
A synthesizable, parameterized PWM generator featuring:

- Edge‑aligned PWM  
- Free‑running counter  
- Duty‑cycle comparator  
- Clean enable/reset behavior  
- Parameterized resolution (`WIDTH`)  

This module is intentionally minimal to keep the hardware mapping clear and extensible.

### **`top.sv`**
A thin wrapper around `pwm_core`, providing a stable integration boundary for:

- Testbench instantiation  
- Future register interfaces  
- System‑level integration  

---

## **🧪 UVM Verification Environment**

The verification environment is a complete block‑level UVM setup, including:

### **✔ Agent**
- **Driver**: Drives `rst_n`, `enable`, and `duty`  
- **Sequencer**: Supplies sequence items  
- **Monitor**: Samples DUT signals and publishes transactions  

### **✔ Scoreboard**
Implements a cycle‑accurate reference model of the PWM counter and compares expected vs. actual `pwm_out`.

### **✔ Coverage**
Functional coverage includes:

- Duty bins (zero, low, mid, high, max)  
- Enable and reset behavior  
- PWM output  
- Cross coverage (duty × enable)  

### **✔ Sequences**
Multiple scenarios are included:

- Randomized stimulus  
- Reset sequence  
- Duty sweep (0 → 255)  
- Zero‑duty test  
- Full‑duty test  
- Enable toggle test  

### **✔ Testbench**
Instantiates:

- DUT (`top.sv`)  
- Interface (`pwm_intf`)  
- UVM environment  
- Clock generator  

Runs all sequences sequentially to achieve broad functional coverage.

---

## **▶️ Running the Simulation**

This project is designed to run cleanly on:

- **EDA Playground** (Aldec Riviera‑Pro)  
- **Local Riviera‑Pro installations**  
- Any simulator with UVM IEEE 1800.2‑2017 support  

To run on EDA Playground:

1. Select **SystemVerilog / UVM IEEE 1800.2‑2017**  
2. Add all RTL and verification files in the correct order  
3. Use Riviera‑Pro as the simulator  
4. Run `testbench.sv` as the top module  

OR 

Use this URL for easy implementation

```
https://www.edaplayground.com/x/LSrV
```
---

## **🌱 Future Expansions**

A dedicated document, **future_expansions.md**, outlines how this project can evolve — from simple RTL enhancements to full verification‑architecture changes.

Examples include:

- Prescaler  
- Double‑buffered duty registers  
- Multi‑channel PWM  
- Dead‑time insertion  
- Register interface (APB/AXI‑Lite)  
- Fault handling  

Each feature is categorized by its impact on RTL and verification.

---

## **📜 License**

This project is released under the **MIT License**.  
See the `LICENSE` file for details.

---

## **🙌 Acknowledgements**

This project was built with a focus on:

- Clean RTL design  
- Modular UVM architecture  
- Scalability and clarity  
- Educational value  

It serves as a solid foundation for anyone learning UVM, RTL design, or block‑level verification.