import chisel3._
import chisel3.util.MuxCase

class MemoryModule extends Module {

    val width = 32;
    val switches = 8;

    val maxAddr: UInt = 1024.U
    val Inport0Addr: UInt = 65524.U; // FFF4 = 65524 -> Inport0
    val Inport1Addr: UInt = 65528.U; // FFF8 = 65528 -> Inport1
    val OutportAddr: UInt = 65532.U; // FFFC = 65532 -> Outport

    val io = IO(new Bundle {
        val addr: UInt = Input(UInt(width.W));
        val Inport0En: Bool = Input(Bool())
        val Inport1En: Bool = Input(Bool())
        val MemWrite: Bool = Input(Bool())
        val SwitchData: Vec[UInt] = Input(Vec(switches, UInt(width.W)))
        val WrData: UInt = Input(UInt(width.W))

        val RdData: UInt = Output(UInt(width.W))
    })

    val WrEn: Bool = io.MemWrite & (io.addr >= 0.U) & (io.addr < maxAddr)
    val OutportWrEn: Bool = io.MemWrite & (io.addr == OutportAddr);
    val mux_sel: UInt = MuxCase(3.U, Array(
        OutportWrEn -> 3.U,
        !io.MemWrite & (io.addr == Inport0Addr) -> 2.U,
        !io.MemWrite & (io.addr == Inport1Addr) -> 1.U
    ));
    // val delay_en = false.B;

    val Inport0 = Module(new FakeRegister)
    Inport0.io.en := io.Inport0En
    Inport0.reg := io.SwitchData(0)

    val Inport1 = Module(new FakeRegister)
    Inport1.io.en := io.Inport1En
    Inport1.reg := io.SwitchData(1)

    val Outport = Module(new FakeRegister)
    Outport.reg := io.WrData;
    Outport.io.en := OutportWrEn;

    val ram = Module( new RAM );
    ram.io.enable := WrEn;
    ram.io.addr := io.addr;
    ram.io.dataIn := io.WrData;

    io.RdData := MuxCase(0.U, Array(
        (mux_sel == 1.U).B -> Inport1.reg,
        (mux_sel == 2.U).B -> Inport0.reg,
        (mux_sel == 3.U).B -> ram.io.dataOut
    ))
}

object MemoryModule extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new MemoryModule())
}

