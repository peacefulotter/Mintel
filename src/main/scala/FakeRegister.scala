
import Chisel.{ when }
import chisel3._

class FakeRegister extends Module {
    val width = 32;

    val io = IO(new Bundle {
        val en = Bool();
        val reg = Reg(0.U)
        val out = UInt(width.W)
    })

    io.out := Mux(io.en, io.reg, 0.U)
}
