# AMBA AHB-Lite Bus System

## Overview

This project implements a simplified AMBA AHB-Lite bus system in Verilog. The design consists of one manager (master) and four memory-mapped subordinate (slave) modules. It demonstrates the basic concepts of bus communication, including address decoding, data transfer, and read/write transactions.

## Features

* One AHB manager and four subordinates
* Memory-mapped slave architecture
* Address decoder for slave selection
* Read data multiplexer
* Single read and single write transactions
* Manager FSM for transaction control
* Functional simulation in Vivado

## Architecture

Manager → Decoder → Selected Slave → Read Data Mux → Manager

## Address Map

| Slave  | Address Range |
| ------ | ------------- |
| Slave0 | 0 – 255       |
| Slave1 | 256 – 511     |
| Slave2 | 512 – 767     |
| Slave3 | 768 – 1023    |

Each slave contains a 256 × 32-bit memory.

## Manager FSM

### Write Transaction

IDLE → WR_ADDR → WR_WAIT → DONE → IDLE

### Read Transaction

IDLE → RD_ADDR → RD_WAIT → DONE → IDLE


## Tools Used

* Verilog HDL
* SystemVerilog
* Vivado Simulator

## Future Improvements

* Wait-state insertion using HREADY
* Error response handling (HRESP)
* Burst transfers
* UVM-based verification environment

## Author

Megha

M.Sc. Applied Physics (VLSI Design Specialization)
