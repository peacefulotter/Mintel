# Mintel

Mintel is a 5-stage pipelined RISC microprocessor written in Scala using Chisel. It has a data forwarding system to prevent data dependencies and a stall system when a branch / jump instruction is detected. It can be used along the [MIPS Assembler](https://www.github.com/PeacefulOtter/MIPSAssembler) to program assembly code running on Mintel.

Stages: Fetch, Decode, Execute, Memory, Writeback.

The Scala code can be turned to Verilog / VHDL thanks to Chisel. Mintel is therefore able to be programmed on any FPGA.

Max clock frequency: 56MHz (did not focus on performance, but fixing bottlenecks can be done to improve the clock freq)

## Datapath

![datapath img](./datapath.jpg)

- More on Chisel: https://www.chisel-lang.org/
