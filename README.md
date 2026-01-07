# 32-bit ALU UVM Verification

**Professional Verification Environment using UVM, IMC, SimVision & Verisim Debug**

---

<div align="center">
  <img src="https://img.shields.io/badge/Build-Passing-brightgreen" alt="Build Status">
  <img src="https://img.shields.io/badge/Coverage-95%25-blue" alt="Coverage">
  <img src="https://img.shields.io/github/stars/username/repo?style=social" alt="GitHub Stars">
</div>

---

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Tools Used](#tools-used)
- [Directory Structure](#directory-structure)
- [Getting Started](#getting-started)
- [Contribution Guidelines](#contribution-guidelines)
- [Authors](#authors)
- [License](#license)

---

## Overview
This project provides a complete **UVM (Universal Verification Methodology)** environment for a **32-bit ALU**.  
It ensures functional correctness, performance, and reliability using constrained-random stimulus, coverage analysis, and assertions.

---

## Features
- **UVM Components:** Driver, Monitor, Sequencer, Scoreboard, Functional coverage, Assertions  
- **ALU Operations:** Add, Subtract, AND, OR, XOR, Shifts, Rotates, Overflow detection  
- **Verification Methodology:** Constrained-random tests, Transaction-based sequences, Reference model comparison

---

## Tools Used
- <span style="background-color:#BB8D3F; color:white; padding:2px 6px; border-radius:3px;">IMC</span> – Metrics & Coverage Collection  
- <span style="background-color:#BB8D3F; color:white; padding:2px 6px; border-radius:3px;">SimVision</span> – Waveform viewing & simulation debug  
- <span style="background-color:#BB8D3F; color:white; padding:2px 6px; border-radius:3px;">Verisim Debug</span> – Step-by-step RTL debugging  
- Synopsys VCS – RTL simulation engine

---

## Directory Structure
```text
project/
│
├─ lab1/       # Sequence items and sequences
├─ lab2/       # Testbench top and environment
├─ rtl/        # ALU RTL files
├─ sim/        # Simulation scripts & logs
├─ coverage/   # Functional coverage reports
└─ README.md   # Project documentation
