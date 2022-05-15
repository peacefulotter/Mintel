
import chisel3._

class InstructionMem extends Module {

    val MEM_DEPTH = 1024
    val memory = VecInit(
        "b0".asUInt(32.W),
        "b10001100000100000000001111111101".asUInt(32.W),
        "b10001100000100010000001111111110".asUInt(32.W),
        "b00010101011100000000000000000010".asUInt(32.W),
        "b00010101100100010000000000000001".asUInt(32.W),
        "b00001000000000000000000000000000".asUInt(32.W),
        "b00000000000100000101100000100000".asUInt(32.W),
        "b00000000000100010110000000100000".asUInt(32.W),
        "b00010010001100000000000000000110".asUInt(32.W),
        "b00000010001100000100000000101011".asUInt(32.W),
        "b00010101000000000000000000000010".asUInt(32.W),
        "b00000010001100001000100000100011".asUInt(32.W),
        "b00001000000000000000000000001000".asUInt(32.W),
        "b00000010000100011000000000100011".asUInt(32.W),
        "b00001000000000000000000000001000".asUInt(32.W),
        "b10101100000100000000001111111111".asUInt(32.W),
        "b00001000000000000000000000000000".asUInt(32.W)
    )
    // val memory = Mem(MEM_DEPTH, UInt(32.W))

    val io = IO(new Bundle {
        val PC = Input(UInt(32.W))
        val Instr = Output(UInt(32.W))
    })

    io.Instr := memory(io.PC)
    // loadMemoryFromFile(memory, "res/test.txt")
    /*
    sub t2 t1 t0
    addi t3 t2 0xF
     */
}
