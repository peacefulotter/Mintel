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
    val writeEn = Input(Bool())
    val readEn = Input(Bool())
    val addr = Input(UInt(10.W))
    val writeData = Input(UInt(width.W))

    val readData = Output(UInt(width.W))
  })

  def isValid(addr: UInt) = addr >= 0.U & addr < size.asUInt

  // Enable and address is valid
  when ( io.writeEn & isValid(io.addr) ) {
    mem.write(io.addr, io.writeData)
  }
  io.readData := Mux(io.readEn, mem.read(io.addr, io.readEn), 0.U)
}

object RAM extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new RAM())
}
