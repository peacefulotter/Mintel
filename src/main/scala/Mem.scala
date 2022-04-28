import chisel3._

class Mem extends Module {

    // val mem = Module( new MemoryModule )
    val mem = Module( new RAM );

    /**
     * TODO: REPLACE RAM WITH MEMORY_MODULE
     */

    val mem_io = IO(new Bundle {
        // From Control
        val WriteEn = Input(UInt(1.W))
        val ReadEn = Input(UInt(1.W))
        val CtrlBrEn = Input(Bool())
        val WbTypeIn = Input(UInt(1.W))
        val WbEnIn = Input(UInt(1.W))

        // From Control -> Execute
        val AluBrEn = Input(Bool())
        val BrAddrIn = Input(UInt(32.W))
        val WriteRegAddrIn = Input(UInt(32.W))

        // From Execute
        val WriteData = Input(UInt(32.W))
        val AddrIn = Input(UInt(32.W))

        // To WB
        val ReadData = Output(UInt(32.W))
        val WbTypeOut = Output(UInt(1.W))
        val WbEnOut = Output(UInt(1.W))
        val AddrOut = Output(UInt(32.W))
        // To WB -> Decode
        val WriteRegAddrOut = Output(UInt(32.W))

        // Datapath -> To Fetch
        val BrAddrOut = Output(UInt(32.W))
        val BrEnOut = Output(Bool())
    })

    mem.io.Addr := mem_io.AddrIn
    mem.io.ReadEn := mem_io.ReadEn
    mem.io.WriteEn := mem_io.WriteEn
    mem.io.WriteData := mem_io.WriteData // we write the ALU result ???
    mem_io.ReadData := mem.io.ReadData

    mem_io.BrAddrOut := mem_io.BrAddrIn

    mem_io.WbTypeOut := mem_io.WbTypeIn
    mem_io.WbEnOut := mem_io.WbEnIn
    mem_io.AddrOut := mem_io.AddrIn

    mem_io.BrEnOut := mem_io.AluBrEn & mem_io.CtrlBrEn

    mem_io.WriteRegAddrOut := mem_io.WriteRegAddrIn
}
