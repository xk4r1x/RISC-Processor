# RISC Processor in Verilog

A simple RISC (Reduced Instruction Set Computer) processor implemented in Verilog. This project demonstrates fundamental concepts of CPU architecture including instruction fetch, decode, execute, memory access, and write-back.

## 🚀 Overview

This processor supports a custom 16-bit instruction set architecture (ISA) with support for arithmetic operations, branching, memory access, and control instructions. Designed as a learning and demonstration tool for understanding RISC design principles and digital systems.

## 📁 Project Structure

```
risc-processor/
├── src/                 # Verilog source files
│   ├── alu.v            # Arithmetic Logic Unit
│   ├── control_unit.v   # Control logic
│   ├── datapath.v       # Core datapath logic
│   ├── instruction_memory.v
│   ├── register_file.v
│   ├── pipeline_registers.v
│   └── top.v            # Top-level module
├── testbench/           # Simulation testbenches
│   └── cpu_tb.v
└── README.md
```

## 🧠 Features

- 16-bit custom RISC ISA
- 8 general-purpose registers
- ALU with basic arithmetic and logic ops (ADD, SUB, AND, OR, XOR, etc.)
- Load/Store instructions
- Unconditional and conditional branches
- Single-cycle or multi-cycle implementation (specify which)
- Modular Verilog design for clarity and reuse

## 🧪 Testing

Testbenches written in Verilog to verify processor functionality:

```bash
# Example: Run simulation with Icarus Verilog
iverilog -o processor_tb testbench/processor_tb.v src/*.v
vvp processor_tb
```

Sample test programs are available in `instruction_memory.v`.

## 📚 Documentation

- Instruction Set Architecture (ISA)
- Block diagrams
- Control signal table
- Timing diagrams

Refer to the `docs/` directory for detailed design information.

## 🛠 Tools Used

- Verilog HDL
- Icarus Verilog (simulation)
- GTKWave (waveform viewer)
- (Optional) ModelSim / Vivado for advanced simulation and synthesis

## 📈 Future Work

- Add pipelining (IF/ID/EX/MEM/WB stages)
- Interrupt support
- Hazard detection and forwarding
- Integration with simple I/O peripherals
- Port to FPGA for real-time execution

## 🧑‍💻 Author

Makari Green

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
