package pipeline

import chisel3._
import chisel3.experimental.IO

class RegisterFile {

    val reg = RegInit(VecInit(Seq.fill(4)(0.U(32.W))));

    val io = IO(new Bundle {
        val ReadAddr1  = Input(UInt(4.W))
        val ReadAddr2  = Input(UInt(4.W))
        val WriteAddr = Input(UInt(4.W))
        val WriteData = Input(Vec(32, UInt(1.W)));
        val WriteEnable = Input(Bool())

        val ReadData1 = Output(Vec(32, UInt(1.W)))
        val ReadData2 = Output(Vec(32, UInt(1.W)))
    })

    when ( io.WriteEnable ) {
        reg( io.WriteAddr ) := io.WriteData
    }

    io.ReadData1 := reg( io.ReadAddr1 );
    io.ReadData2 := reg( io.ReadAddr2 );
}
