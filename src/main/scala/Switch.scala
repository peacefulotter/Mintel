
import chisel3._

class Switch extends Module {

    val nbSwitches = 8;
    val reg = RegInit(0.U)

    val signExtend = Module( new SignExtend(nbSwitches) )

    val io = IO(new Bundle {
        val DataIn = Input(UInt(nbSwitches.W))
        val WrEn = Input(Bool())

        val DataOut = Output(UInt(32.W))
    })

    when (io.WrEn) { reg := io.DataIn }

    signExtend.io.isSigned := false.B
    signExtend.io.in := reg
    io.DataOut := signExtend.io.out
}
