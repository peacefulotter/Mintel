/*
 * This code is a minimal hardware described in Chisel.
 * 
 * Blinking LED: the FPGA version of Hello World
 */

import chisel3._

/**
 * The RAM component.
 */

class RAM(val size: Int = 1024, val width: Int = 32) extends Module {

    val mem = SyncReadMem(size, UInt(width.W))

    val io = IO(new Bundle {
        val WriteEn = Input(Bool())
        val ReadEn = Input(Bool())
        val Addr = Input(UInt(10.W))
        val WriteData = Input(UInt(width.W))

        val ReadData = Output(UInt(width.W))
    })

    val isValid: Bool = io.Addr >= 0.U & io.Addr < size.asUInt

    // Enable and address is valid
    when ( io.WriteEn & isValid ) {
        mem.write(io.Addr, io.WriteData)
    }
    io.ReadData := Mux(io.ReadEn, mem.read(io.Addr, io.ReadEn), 0.U)
}

object RAM extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new RAM())
}
