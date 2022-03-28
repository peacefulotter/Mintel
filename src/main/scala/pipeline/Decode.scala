package pipeline

import chisel3._
import chisel3.experimental.IO

class Decode {

    val regFile = Module( new RegisterFile )
    val signExtend = Module( new SignExtend )

    val io = IO(new Bundle {
        // From Fetch
        val counter = Input(UInt(32.W))
        val instr = Input(Vec(32, Bool()))

        // From MEM
        val WriteEn = Input(Bool())

        // From WB
        val WriteAddr = Input(UInt(32.W))
        val WriteData = Input(UInt(32.W))

        val counterOut = Output(UInt(32.W))
        val DataRead1 = Output(UInt(32.W))
        val DataRead2 = Output(UInt(32.W))
    })

    regFile.io.ReadAddr1 := io.instr(x, y);
    regFile.io.ReadAddr2 := io.instr(y, z);
    regFile.io.WriteEnable := io.WriteEn;
    regFile.io.WriteAddr := io.WriteAddr;
    regFile.io.WriteData := io.WriteData;
    io.DataRead1 := regFile.io.ReadData1;
    io.DataRead2 := regFile.io.ReadData2;

    // signExtend.io.in = io.instr.slice(15, 0)
    // signExtend.io.isSigned = ???
    // instr(41, 10) := signExtend.io.out

    // instr(9, 5) = instr(20, 16)
    // instr(4, 0) = instr(15, 16)

    io.counterOut := io.counter
}
