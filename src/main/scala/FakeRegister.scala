
import chisel3._

class FakeRegister extends Module {
    val width = 32;
    val reg = RegInit(0.U)

    val io = IO(new Bundle {
        val en = Input(Bool())
        val out = Output(UInt(width.W))
    })

    io.out := Mux(io.en, reg, 0.U)
}
