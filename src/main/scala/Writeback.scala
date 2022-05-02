

import Instructions.LD_Y
import chisel3._

class Writeback extends Module {

    val wb_io = IO(new Bundle {
        val LoadEn = Input(UInt(1.W))
        val WbEnIn = Input(UInt(1.W))
        val WbTypeIn = Input(UInt(1.W))
        val WriteRegAddrIn = Input(UInt(32.W))
        val ReadData = Input(UInt(32.W))
        val AddrData = Input(UInt(32.W))

        // To Decode
        val WbEnOut = Output(UInt(1.W))
        val WbTypeOut = Output(UInt(1.W))
        val WriteRegAddrOut = Output(UInt(32.W))
        val WriteDataOut = Output(UInt(32.W))
    })

    wb_io.WbEnOut := wb_io.WbEnIn;
    wb_io.WbTypeOut := wb_io.WbTypeIn;

    wb_io.WriteRegAddrOut := wb_io.WriteRegAddrIn
    wb_io.WriteDataOut := Mux(wb_io.LoadEn === LD_Y, wb_io.ReadData, wb_io.AddrData)
}
