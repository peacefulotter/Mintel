

import chisel3._

class Writeback extends Module {

    val io = IO(new Bundle {
        val WbSelIn = Input(Bool())
        val WriteAddrIn = Input(UInt(32.W))
        val ReadData = Input(UInt(32.W))
        val AddrData = Input(UInt(32.W))

        // To Decode
        val WbSelOut = Input(Bool())
        val WriteAddrOut = Input(UInt(32.W))
        val WriteDataOut = Input(UInt(32.W))
    })

    io.WbSelOut := io.WbSelIn;
    io.WriteAddrOut := io.WriteAddrIn
    io.WriteDataOut := Mux(io.WbSelIn, io.ReadData, io.AddrData)
}
