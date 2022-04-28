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

    val io = IO(new Bundle {
        val WriteEn = Input(Bool())
        val ReadEn = Input(Bool())
        val Addr = Input(UInt(10.W))
        val WriteData = Input(UInt(32.W))

        val ReadData = Output(UInt(32.W))
    })

    val WrData = RegNext ( io.WriteData )
    val WrAddr = RegNext ( io.Addr )
    val doForwardReg = RegNext ( io.Addr === io.Addr & io.WriteEn )
    val isValid: Bool = io.Addr >= 0.U & io.Addr < size.asUInt

    // Enable and address is valid
    when ( io.WriteEn & isValid ) {
        mem.write(io.Addr, io.WriteData)
    }

    val ReadMem = Mux(io.ReadEn, mem.read(io.Addr), 0.U)
    io.ReadData := Mux( doForwardReg, WrData, ReadMem )
}

object RAM extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new RAM())
}
