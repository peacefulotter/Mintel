
import chisel3._
import chisel3.util.MuxCase

class MemoryModule extends Module {

    val ram = Module( new RAM );

    val Switches1 = Module( new Switch ) // 1021
    val Switches2 = Module( new Switch ) // 1022
    val Switches3 = Module( new Switch ) // 1023

    val io = IO(new Bundle {
        val Switches1 = Input(UInt(8.W))
        val Switches2 = Input(UInt(8.W))

        val readEn: Bool = Input(Bool())
        val writeEn: Bool = Input(Bool())
        val writeData: UInt = Input(UInt(32.W))
        val addr: UInt = Input(UInt(32.W)); // Could be read or write
        val readData: UInt = Output(UInt(32.W))
    })

    val OutportWrEn: Bool = io.writeEn & (io.addr === OutPortAddr);
    val mux_sel: UInt = MuxCase(3.U, Array(
        OutportWrEn -> 3.U,
        (!io.writeEn && (io.addr === InPort0Addr)) -> 2.U,
        (!io.writeEn && (io.addr === InPort1Addr)) -> 1.U
    ));

    io.readData := MuxCase(0.U, Array(
        (mux_sel == 1.U).B -> InPort1,
        (mux_sel == 2.U).B -> InPort0,
        (mux_sel == 3.U).B -> ram.io.readData
    ))
}

object MemoryModule extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new MemoryModule())
}


