import chisel3._

class SignExtend extends Module  {
    val io = IO(new Bundle {
        val in = Input(UInt(16.W))
        val isSigned = Input(Bool())
        val out = Output(UInt(32.W))
    })

    io.out(15, 0) := io.in(15, 0)
    io.out(31, 16) := Mux(io.isSigned && io.in(15) === 1.U, 32767.U, 0.U)
}
