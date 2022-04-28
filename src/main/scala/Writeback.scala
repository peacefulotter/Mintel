

import chisel3._

class Writeback extends Module {

    val wb_io = IO(new Bundle {
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

    wb_io.WbEnOut := wb_io.WbEnIn;
    wb_io.WriteRegAddrOut := wb_io.WriteRegAddrIn
    wb_io.WriteDataOut := Mux(wb_io.WbTypeIn, wb_io.ReadData, wb_io.AddrData)
}
