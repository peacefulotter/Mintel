import chisel3._

class Mem extends Module {

    // val mem = Module( new MemoryModule )
    val mem = Module( new RAM );

    /**
     * TODO: REPLACE RAM WITH MEMORY_MODULE
     */

    val io = IO(new Bundle {
        // From Control
        val WriteEn = Input(UInt(1.W))
        val ReadEn = Input(UInt(1.W))
        val CtrlBrEn = Input(Bool())
        val WbTypeIn = Input(UInt(1.W))
        val WbEnIn = Input(UInt(1.W))

        // From Execute
        val WriteData = Input(UInt(32.W))
        val AluBrEn = Input(Bool())
        val AluResIn = Input(UInt(32.W))
        val BrAddrIn = Input(UInt(32.W))
        val WriteRegAddrIn = Input(UInt(32.W))

        // To WB
        val ReadData = Output(UInt(32.W))
        val WbTypeOut = Output(UInt(1.W))
        val WbEnOut = Output(UInt(1.W))
        val AluResOut = Output(UInt(32.W))
        // To WB -> Decode
        val WriteRegAddrOut = Output(UInt(32.W))

        // Datapath -> To Fetch
        val BrAddrOut = Output(UInt(32.W))
        val BrEnOut = Output(Bool())
    })

    mem.io.addr := io.AluResIn
    mem.io.readEn := io.ReadEn
    mem.io.writeEn := io.WriteEn
    mem.io.writeData := io.WriteData // we write the ALU result ???
    io.ReadData := mem.io.readData

    io.BrAddrOut := io.BrAddrIn

    io.WbTypeOut := io.WbTypeIn
    io.WbEnOut := io.WbEnIn
    io.AluResOut := io.AluResIn

    io.BrEnOut := io.AluBrEn & io.CtrlBrEn

    io.WriteRegAddrOut := io.WriteRegAddrIn
}
