import chisel3._
import chisel3.util.Cat

class  SignExtend(width: Int) extends Module  {
    val io = IO(new Bundle {
        val in: UInt = Input(UInt(width.W))
        val isSigned: Bool = Input(Bool())
        val out: UInt = Output(UInt(32.W))
    })

    val low: UInt = io.in(width-1, 0)
    val high: UInt = Mux(io.isSigned && io.in(width-1) === 1.U, 32767.U, 0.U)
    io.out := Cat(high, low)
}
