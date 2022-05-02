/*
 * This code is a minimal hardware described in Chisel.
 *
 * Blinking LED: the FPGA version of Hello World
 */

import chisel3._

/**
 * The RAM component.
 */

class RAM(val size: Int = 1024) extends Module {

    val mem = SyncReadMem(size, UInt(32.W))

    val ram_io = IO(new Bundle {
        val WriteEn = Input(Bool())
        val ReadEn = Input(Bool())
        val Addr = Input(UInt(10.W))
        val WriteData = Input(UInt(32.W))

        val ReadData = Output(UInt(32.W))
    })

    val CurReadEn = ram_io.ReadEn
    val CurAddr = ram_io.Addr

    val PrevAddr = RegNext ( CurAddr )
    val PrevReadEn = RegNext ( CurReadEn )

    val PrevWrEn = RegNext ( ram_io.WriteEn )
    val PrevWrData = RegNext( ram_io.WriteData )

    val isValid: Bool = CurAddr > 0.U & CurAddr < size.asUInt

    when ( ram_io.WriteEn & isValid ) {
        mem.write(CurAddr, ram_io.WriteData)
    }

    val RegAddr = Reg(UInt())
    val ReadAllowed = CurReadEn & isValid
    when ( ReadAllowed ) { RegAddr := CurAddr }
    val ReadData = Mux( ReadAllowed, mem.read(RegAddr), 0.U)

    val doForwardWr = CurAddr === PrevAddr & PrevWrEn & CurReadEn
    ram_io.ReadData := Mux( doForwardWr, PrevWrData, ReadData )
}

//object RAM extends App {
//    (new chisel3.stage.ChiselStage).emitVerilog(new RAM())
//}
