package pipeline

import chisel3._

class Fetch extends Module  {
    val PC = RegInit(0.U);

    val io = IO(new Bundle {
        val BranchAddr = Input(UInt(32.W))
        val PCSrc = Input(Bool())
        val counter = Output(UInt(32.W))
        val instr = Output(Vec(32, Bool()))
    })


    // counter and instr in the same vector??

    io.counter := PC + 4.U;
    PC := Mux( io.PCSrc, io.BranchAddr, io.counter )
    // io.instr := Instruction.get(PC)
}
