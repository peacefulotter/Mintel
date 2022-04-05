

import chisel3._
import chisel3.util.experimental.loadMemoryFromFile

class InstructionMem extends Module {

    val MEM_DEPTH = 1024
    val memory = Mem(MEM_DEPTH, UInt(32.W))

    val io = IO(new Bundle {
        val PC = Input(UInt(32.W))
        val Instr = Output(UInt(32.W))
    })

    io.Instr := memory(io.PC)
    loadMemoryFromFile(memory, "/res/test.txt")
}
