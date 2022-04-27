

import chisel3._

class Writeback extends Module {

    val io = IO(new Bundle {
        val WbEnIn = Input(Bool())
        val WbTypeIn = Input(Bool())
        val WriteRegAddrIn = Input(UInt(32.W))
        val ReadData = Input(UInt(32.W))
        val AddrData = Input(UInt(32.W))

        // To Decode
        val WbEnOut = Output(Bool())
        val WriteRegAddrOut = Output(UInt(32.W))
        val WriteDataOut = Output(UInt(32.W))
    })

    io.WbEnOut := io.WbEnIn;
    io.WriteRegAddrOut := io.WriteRegAddrIn
    io.WriteDataOut := Mux(io.WbTypeIn, io.ReadData, io.AddrData)
}
