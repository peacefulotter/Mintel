

import chisel3._

class Writeback extends Module {

    val io = IO(new Bundle {
        val WbEnIn = Input(Bool())
        val WbTypeIn = Input(Bool())
        val WriteAddrIn = Input(UInt(32.W))
        val ReadData = Input(UInt(32.W))
        val AddrData = Input(UInt(32.W))

        // To Decode
        val WbEnOut = Input(Bool())
        val WriteAddrOut = Input(UInt(32.W))
        val WriteDataOut = Input(UInt(32.W))
    })

    io.WbEnOut := io.WbEnIn;
    io.WriteAddrOut := io.WriteAddrIn
    io.WriteDataOut := Mux(io.WbTypeIn, io.ReadData, io.AddrData)
}
