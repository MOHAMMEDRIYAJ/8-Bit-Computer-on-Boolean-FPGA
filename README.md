# 8-Bit-Computer-on-Boolean-Board

## 📌 Project Overview

This project implements a custom 8-Bit Computer designed entirely at the Register Transfer Level (RTL) using Verilog HDL. The architecture combines a modular datapath, micro-sequenced control unit, RAM, ALU, registers, and input/output interfaces to create a fully functional processor system on FPGA.

Unlike traditional SAP-style implementations, this version introduces a Layer-Based Program Architecture with multiple pre-programmed applications, manual programming capability, dual-speed execution clocks, and an enhanced input instruction mechanism. The design provides a practical platform for understanding processor operation, instruction execution, memory management, and hardware-software interaction at the RTL level.

This project is the Upgraded version of our old project . Check old version [github](https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Zedboard-FPGA) for clear understanding

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/Boolean%208-bit%20.png" width="80%" height="80%" >


---

## 📑 Table of Contents

1.  [Project Intent](#project-intent)
2.  [Project Architecture](#project-architecture)
3.  [Features](#features)
4.  [Design Hierarchy](#design-hierarchy)
5.  [Layer Operations](#layer-operations)
6.  [Instruction Set Architecture](#instruction-set-architecture-isa)
7.  [Control Signals](#control-signals--micro-operations-)
8.  [Instruction Execution](#instruction-execution)
9.  [Arithmetic Unit Operations](#arithmetic-unit-operations)
10. [Example Program T-cycles Demo](#example-program-t-cycles-demo)
11. [EDA Tool and FPGA](#eda-tool-and-fpga)
12. [File Structure](#file-structure)
13. [Verilog and Other Files](#files)
14. [Simulation](#simulation)
15. [Schematic](#schematic)
16. [Reports](#reports)
17. [FPGA Implementation and Demonstration](#fpga-implementation-and-demonstration)
18. [Collaborators](#collaborators)
19. [Reference](#reference)
20. [Conclusion](#conclusion)

---

## Project Intent

The goal of this project is to demonstrate how a complete computer system can be built from fundamental digital hardware components using RTL design principles. The project focuses on architectural clarity, modularity, and educational visualization rather than computational performance.

Key objectives include:

- Designing a complete 8-bit processor using Verilog HDL.
- Demonstrating the interaction between datapath and control logic.
- Implementing a layer-based execution system with multiple applications.
- Providing real-time user interaction through input instructions.
- Enabling easy observation of processor operation using slow clock modes.
- Creating a scalable foundation for future processor enhancements.

---

## Project Architecture 

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/8-bit%20Computer%20Final%20Version%20Architecture%20.png" width="80%" height="80%">

---

## Features

* **Custom 8-Bit RTL Computer Architecture**

* **7 Pre-Programmed Execution Layers**

  * Fibonacci Generator
  * Multiplication
  * Division
  * Maximum Number Finder
  * Password Checker
  * Sum of N Numbers
  * Traffic Light Controller

* **1 Manual Programming Layer** for user-defined programs

* **Dual Operating Clock Modes**

  * 6 Hz Execution Mode
  * 1 Hz Observation Mode

* **Enhanced INP Instruction**

  * Accepts external user input
  * Loads data into both the Accumulator and a specified RAM location

* **Multi-Cycle Instruction Execution** using T-state sequencing

* **16 × 8-bit Addressable RAM**

* **ALU Support for Arithmetic and Logical Operations**

  * ADD
  * SUB
  * ADI
  * SUI
  * XOR
  * AND

* **Carry and Zero Flag Support**

* **Conditional and Unconditional Branching**

  * JMP
  * JC
  * JZ

* **Input and Output Instruction Support**

* **Real-Time FPGA Visualization**

  * Output Display
  * Program Counter Display

* **Fully Synthesizable and FPGA Implementable RTL Design**

* **Modular and Extensible Architecture for Future Enhancements**

---

## Design Hierarchy 

<pre>CPU Top Module
    Clock Dividers
    RAM
    RAM Loader
    Binary to 7-Segment Decoder
    CPU Core
        Control Unit        
        Input Register        
        A Register        
        ALU        
        B Register        
        Output Register        
        Memory Address Register (MAR)        
        Instruction Register (IR)</pre>

---

## Layer Operations

<pre>000 : Fibonacci Loop
001 : Multiplication of two numbers
010 : Division of two numbers
011 : Maximum of two numbers
100 : Password Checker with maximum of 3 attempts
101 : Sum of N numbers
110 : Traffic Light with bit masking
111 : Manual Programming </pre>

---

## Instruction Set Architecture (ISA)

The processor implements a 16-instruction, 8-bit ISA inspired by SAP-style architectures, with support for memory access, immediate operations, arithmetic/logic operations, control flow, and basic input/output.  
Each instruction is executed using a multi-cycle control sequence.

---

### 🔹 Instruction Format

- Instruction width: **8 bits**
- Upper nibble `[7:4]` → **Opcode**
- Lower nibble `[3:0]` → **Operand / Address / Immediate**
- Byte `[7:0]`         → **8-bits Data value**

### 🔹 Instruction Set Summary

| Opcode (bin) | Mnemonic | T-Cycles | Type        | Description |
|-------------|----------|-------------|-------------|------------|
| `0000` | NOP | 3 | Control | Includes Delay in Program Execution |
| `0001` | LDA | 5 | Memory | Load accumulator from memory |
| `0010` | ADD | 6 | Memory | Add memory value to accumulator |
| `0011` | SUB | 6 | Memory | Subtract memory value from accumulator |
| `0100` | STA | 5 | Memory | Store accumulator to memory |
| `0101` | LDI | 4 | Immediate | Load immediate value into accumulator |
| `0110` | JMP | 4 | Control | Unconditional jump |
| `0111` | JC  | 4 (if CF=1 else 3) | Control | Jump if carry flag is set |
| `1000` | JZ  | 4 (if ZF=1 else 3) | Control | Jump if zero flag is set |
| `1001` | ADI | 5 | Immediate | Add immediate value to accumulator |
| `1010` | SUI | 5 | Immediate | Subtract immediate value from accumulator |
| `1011` | XRA | 6 | Memory | Bitwise XOR between accumulator and memory value|
| `1100` | ANA | 6 | Memory | Bitwise AND between accumulator and memory value|
| `1101` | INP | 7 | I/O | Load external input into accumulator |
| `1110` | OUT | 4 | I/O | Output accumulator to output register |
| `1111` | HLT | 4 | Control | Halt CPU execution |

> [!NOTE]
> Every instruction takes all 6 T-Cycles and INP instruction 7 T-cycles to complete and the table mentions only the operating T-cycles

### 🔹 Instruction Behavior Details

#### Memory Reference Instructions
- **LDA addr**: `A ← M[addr]`
- **STA addr**: `M[addr] ← A`
- **ADD addr**: `A ← A + M[addr]`
- **SUB addr**: `A ← A - M[addr]`
- **XRA addr**: `A ← A XOR M[addr]`
- **ANA addr**: `A ← A AND M[addr]`

#### Immediate Instructions
- **LDI imm**: `A ← imm`
- **ADI imm**: `A ← A + imm`
- **SUI imm**: `A ← A - imm`

#### Control Flow Instructions
- **JMP addr**: `PC ← addr`
- **JC addr** : `PC ← addr` if Carry = 1
- **JZ addr** : `PC ← addr` if Zero = 1

#### Input / Output Instructions
- **INP**: Reads external input into accumulator and RAM using handshake control
- **OUT**: Transfers accumulator content to output register for display

#### System Control
- **HLT**: Stops program execution by halting the control unit

### 🔹 Flags Affected

| Flag | Set By |
|----|-------|
| Carry (C) | ADD , SUB , ADI , SUI |
| Zero (Z) | ADD , SUB , ADI , SUI |

---

## Control Signals ( Micro-Operations )

| Signal No. | Signal | Description                                                |
| --------- | :------: | ---------------------------------------------------------- |
|  0 | CO     | Places the Program Counter value onto the internal BUS     |
|  1 | CL     | Loads the BUS value into the Program Counter               |
|  2 | CE     | Increments the Program Counter                             |
|  3 | OI     | Loads BUS data into the Output Register                    |
|  4 | BI     | Loads BUS data into the B Register                         |
|  5 | SUB    | Selects subtraction operation in the ALU                   |
|  6 | ALO    | Places the ALU output onto the BUS                         |
|  7 | AO     | Places the A Register value onto the BUS                   |
|  8 | AI     | Loads BUS data into the A Register                         |
|  9 | IO     | Places the instruction address field onto the BUS          |
|  10 | II     | Loads BUS data into the Instruction Register               |
|  11 | RO     | Places memory data onto the BUS                            |
|  12 | RI     | Loads BUS data into memory                                 |
|  13 | MI     | Loads the BUS value into the Memory Address Register (MAR) |
|  14 | HLT    | Halts program execution                                    |
|  15 | FE     | Updates the processor flag registers                       |
|  16 | XRA    | Selects bitwise XOR operation in the ALU                   |
|  17 | ANA    | Selects bitwise AND operation in the ALU                   |
|  18 | INP    | Places input register data onto the BUS                    |

---

## Instruction Execution 

**Fetch Cycle**     - T0 , T1 , T2 

**Execute Cycle**   - T3 , T4 , T5 , T6 (only for INP instruction)

### Fetch Cycle (Common for all instructions)

- T0  —  CO → MI
- T1  —  RO → II
- T2  —  CE

### Execute Cycle

| Mnemonic | T-Cycles | T3 | T4 | T5 | T6 |
|---------|---------|----|----|----|----|
| NOP | 3 | — | — | — |    | 
| LDA | 5 | IO → MI | RO → AI | — |    |
| ADD | 6 | IO → MI | RO → BI | ALO → AI , FE |     |
| SUB | 6 | IO → MI | RO → BI | SUB , ALO → AI, FE |    |
| STA | 5 | IO → MI | AO → RI | — |    |
| LDI | 5 | IO → AI | — | — |    |
| JMP | 5 | IO → CL | — | — |    |
| JC  | 3 or 4 | IO → CL (if C=1) | — | — |    |
| JZ  | 3 or 4 | IO → CL (if Z=1) | — | — |    |
| ADI | 5 | IO → BI | ALO → AI, FE | — |    |
| SUI | 5 | IO → BI | SUB , ALO → AI, FE | — |    |
| XRA | 6 | IO → MI | RO → BI | XRA , ALO → AI, FE |    |
| ANA | 6 | IO → MI | RO → BI | ANA , ALO → AI, FE |    |
| INP | 7 | (Request for input) | INP → AI | IO → MI | AO → RI |
| OUT | 4 | AO → OI | — | — |    |
| HLT | 4 | HLT | — | — |    |

> [!NOTE]
> Every instruction takes all 6 T-Cycles and INP instruction 7 T-cycles to complete and the table mentions only the operating T-cycles

---

## Arithmetic Unit Operations

The Arithmetic Unit performs arithmetic and logical operations based on the control signals SUB, XRA, and ANA.

| SUB | XRA | ANA | Operation |
|-----|-----|-----|-----------|
| 0   | 0   | 0   | A + B |
| 1   | 0   | 0   | A - B |
| 0   | 1   | 0   | Bitwise XOR operation between A and B |
| 0   | 0   | 1   | Bitwise AND operation between A and B |

### Notes
- Only one control signal should be active at a time
- SUB → Subtraction control
- XRA → XOR operation
- ANA → AND operation


---

## Example Program T-cycles Demo

### 2 Power Program

<pre>
Address: Opcode operand / Data
 
 0: LDI 1
 1: OUT
 2: STA 7
 3: ADD 7
 4: JC 6
 5: JMP 1
 6: HLT
</pre>

### 🔹 Address 0 : `LDI 1`

#### Fetch Cycle (common for all instructions)

| T-cycle | Operation            |
| ------- | -------------------- |
| T0      | MAR ← PC (0)         |
| T1      | IR ← RAM[0]          |
| T2      | PC ← 1               |

#### Execute Cycle (LDI)

| T-cycle | Operation            |
| ------- | -------------------- |
| T3      | A ← IR[3:0] (0001)   |

**Result:**

```
A = 1
PC = 1
```

---

### 🔹 Address 1 : `OUT` 

#### Fetch Cycle

| T-cycle | Operation    |
| ------- | ------------ |
| T0      | MAR ← PC (1) |
| T1      | IR ← RAM[1]  |
| T2      | PC ← 2       |

#### Execute Cycle

| T-cycle | Operation   |
| ------- | ----------- |
| T3      | OUT ← A     |

**Output:**

```
out_display = 00000001
7-segment shows: 1
```

---

### 🔹 Address 2 : `STA 7` 

#### Fetch Cycle

| T-cycle | Operation    |
| ------- | ------------ |
| T0      | MAR ← PC (2) |
| T1      | IR ← RAM[2]  |
| T2      | PC ← 3       |

#### Execute Cycle

| T-cycle | Operation             |
| ------- | --------------------- |
| T3      | MAR ← IR[3:0] (0111)  |
| T4      | RAM[7] ← A            |

---

### 🔹 Address 3 : `ADD 7` 

#### Fetch Cycle

| T-cycle | Operation    |
| ------- | ------------ |
| T0      | MAR ← PC (3) |
| T1      | IR ← RAM[3]  |
| T2      | PC ← 4       |

#### Execute Cycle

| T-cycle | Operation               |
| ------- | ----------------------- |
| T3      | MAR ← IR[3:0] (0111)    |
| T4      | B ← RAM[7]              |
| T5      | A ← A + B (from ALU) , FLAGS ← Carry / Zero |

**Result:**

```
A = 2
```

---

### 🔹 Address 4 : `JC 6` 

#### Fetch Cycle

| T-cycle | Operation    |
| ------- | ------------ |
| T0      | MAR ← PC (4) |
| T1      | IR ← RAM[4]  |
| T2      | PC ← 5       |

#### Execute Cycle

| T-cycle | Operation             |
| ------- | --------------------- |
| T3      | PC ← IR[3:0] (0110) (If Carry = 1) |

**Condition:**

```
Carry = 0 → No jump

```

---

### 🔹 Address 5 : `JMP 1` 

#### Fetch Cycle

| T-cycle | Operation    |
| ------- | ------------ |
| T0      | MAR ← PC (5) |
| T1      | IR ← RAM[5]  |
| T2      | PC ← 6       |

#### Execute Cycle

| T-cycle | Operation |
| ------- | --------- |
| T3      | PC ← IR[3:0] (0001)    |

 **Loop back to OUT instruction**

---

####  Loop Behavior Summary

Each loop doubles the accumulator value.

| Loop | A   | OUT       |
| ---- | --- | --------- |
| 1    | 1   | 1         |
| 2    | 2   | 2         |
| 3    | 4   | 4         |
| 4    | 8   | 8         |
| 5    | 16  | 16        |
| 6    | 32  | 32        |
| 7    | 64  | 64        |
| 8    | 128 | 128       |
| 9    | 256 | Carry = 1 |

---

### 🔹 Address 6 : `HLT` 

#### Fetch Cycle

| T-cycle | Operation   |
| ------- | ----------- |
| T0      | MAR ← 6     |
| T1      | IR ← RAM[6] |
| T2      | PC ← 7      |

#### Execute Cycle

| T-cycle | Operation |
| ------- | --------- |
| T3      | HALT = 1  (execution stops) |

---

####  Final CPU State

```
Accumulator (A) = 128
Carry Flag      = 1
Program Counter = 7
out_display     = 10000000
CPU State       = HALTED
```

---

## EDA Tool and FPGA

- **Software:**
-   AMD Vivado ML Edition (Standard) 2024.2, Cadence Incisive Simulator
- **Hardware:**
-   Board : Boolean Board (Spartan 7)
-   Part  : xc7s50csga324-1

---

## File Structure

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/File%20Structure.png" width="80%" height="80%">

---

## Files 

🔹 [Sources](https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/tree/main/Sources)

🔹 [Constraints](https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/tree/main/Constraints)

🔹 [Simulation](https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/tree/main/Simulation)

---

## Simulation

### 🔹 Testbench-1  Layer-000 (Preprogrammed) ([Fibonacci Loop](https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Simulation/layer_1_tb.v))

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/Layer_1_sim1.png">

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/Layer_1_sim2.png">

### 🔹 Testbench-2  Layer-001 (Preprogrammed) ([Multiplication of Two Numbers](https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Simulation/layer_2_tb.v))

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/Layer_2_sim1.png">

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/Layer_2_sim2.png">

### 🔹 Testbench-3  Layer-111 (Manual Programming) ([Multiples of 15 upto 255](https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Simulation/manual_layer.v))

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/Manual_layer_sim1.v.png">

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/Manual_layer_sim2.v.png">

> [!NOTE]
> `out_display` is present in simulation for verification and easier debugging.
> 
> `Clock Divider` is not used for Simulation.
>
> Some ports are not use for Simulation.

---

## Schematic

### 🔹 CPU Top View

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/Top%20view.png">

### 🔹 CPU Core View

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/Core%20View.png">

### 🔹 Technology View

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/Technology%20view.png">

---

## Reports

### 🔹 Design Time Summary

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/Timing%20Report.png">

### 🔹 Utilization [Post Synthesis]

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/Post%20Synthesis%20Report%20.png">

### 🔹 Utilization [Post Implementation]

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/Post%20Implementation%20Report.png">

---

## FPGA Implementation and Demonstration

<img src="https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Boolean-FPGA/blob/main/Images/Boolean%208-bit%20.png">

### 🔹 [Demonstration Video Link](https://drive.google.com/file/d/1aTcI65OitU7tla8BNdzaIk9-2c580Hyk/view?usp=drive_link)

---


## Collaborators

- Mohammed Riyaj J  [[Linkedin]](https://www.linkedin.com/in/mohammedriyaj786/)

- Navneet Prasad  [[Linkedin]](https://www.linkedin.com/in/navneetprasad1311/)

- Akash P  [[Linkedin]](https://www.linkedin.com/in/akash-p-092423309/)

- Vikash R  [[Linkedin]](https://www.linkedin.com/in/vikashr1409/)
 
Under the guidance of [Dr. Elango Sekar](https://www.linkedin.com/in/elango-sekar-8973b958/) Associate Professor , Department of ECE , Bannari Amman Institute of Technology 

---

## Reference 

- Our Older Version [[Github]](https://github.com/MOHAMMEDRIYAJ/8-Bit-Computer-on-Zedboard-FPGA)

- Austin Morlan [[Website]](https://austinmorlan.com/posts/8bit_breadboard_fpga/)

- Ben Eater [[YouTube]](https://www.youtube.com/playlist?list=PLowKtXNTBypGqImE405J2565dvjafglHU)

- Digital Computer Electronics / Albert Paul Malvino, Jerald A. Brown 

---
