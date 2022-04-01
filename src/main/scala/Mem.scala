import chisel3._

class Mem extends Module {

    val mem = Module( new MemoryModule )

    val io = IO(new Bundle {
        // From Control basically
        val writeEn = Input(UInt(1.W))

        // From Execute
        val aluRes = Input(UInt(32.W))
        val writeAddr = Input(UInt(32.W))

        val readData = Output(UInt(32.W))
    })

    mem.io.addr := ???
    mem.io.writeEn := io.writeEn
    mem.io.writeData := io.aluRes // we write the ALU result
    io.readData := mem.io.readData
}
