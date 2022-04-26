import chisel3._
import chisel3.util.MuxCase

class MemoryModule extends Module {

    val width = 32;
    val switches = 8;

    // TODO: have the IO ports in separate component

    /****
     *
     *  REFACTOR MEMORY MODULE - STORE THE PORTS INTO A SEPARATE COMPONENT
     *
     */

    val InPort0 = Module(new FakeRegister)
    val InPort1 = Module(new FakeRegister)
    val OutPort = Module(new FakeRegister)
    val ram = Module( new RAM );

    val maxAddr: UInt = 1024.U
    val InPort0Addr: UInt = 65524.U; // FFF4 = 65524 -> Inport0
    val InPort1Addr: UInt = 65528.U; // FFF8 = 65528 -> Inport1
    val OutPortAddr: UInt = 65532.U; // FFFC = 65532 -> Outport

    val io = IO(new Bundle {
        val Inport0En: Bool = Input(Bool())
        val Inport1En: Bool = Input(Bool())
        val SwitchData: Vec[UInt] = Input(Vec(switches, UInt(width.W)))

        val readEn: Bool = Input(Bool())
        val writeEn: Bool = Input(Bool())
        val writeData: UInt = Input(UInt(width.W))
        val addr: UInt = Input(UInt(width.W)); // Could be read or write

        val readData: UInt = Output(UInt(width.W))
    })

    val OutportWrEn: Bool = io.writeEn & (io.addr === OutPortAddr);
    val mux_sel: UInt = MuxCase(3.U, Array(
        OutportWrEn -> 3.U,
        (!io.writeEn && (io.addr === InPort0Addr)) -> 2.U,
        (!io.writeEn && (io.addr === InPort1Addr)) -> 1.U
    ));
    // val delay_en = false.B;

    InPort0.io.en := io.Inport0En
    InPort0.reg := io.SwitchData(0)

    InPort1.io.en := io.Inport1En
    InPort1.reg := io.SwitchData(1)

    OutPort.reg := io.writeData;
    OutPort.io.en := OutportWrEn;

    ram.io.writeEn := io.writeEn
    ram.io.addr := io.addr;
    ram.io.writeData := io.writeData;

    io.readData := MuxCase(0.U, Array(
        (mux_sel == 1.U).B -> InPort1.reg,
        (mux_sel == 2.U).B -> InPort0.reg,
        (mux_sel == 3.U).B -> ram.io.readData
    ))
}

object MemoryModule extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new MemoryModule())
}

