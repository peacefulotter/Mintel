import chisel3._
import chisel3.util.ListLookup
import Instructions.{ default, map }

class Control extends Module  {
    val io = IO(new Bundle {
        val instr = Input(UInt(32.W))

        val rs = Output(UInt(5.W))
        val rt = Output(UInt(5.W))
        val rd = Output(UInt(5.W))
        val imm = Output(UInt(16.W))
        val addr = Output(UInt(26.W))

        val AluOp = Output(UInt(6.W))
        val ImmEn = Output(UInt(1.W))
        val BrEn = Output(UInt(2.W))
        val LoadEn = Output(UInt(1.W))
        val StoreEn = Output(UInt(1.W))
        val WbType = Output(UInt(1.W))
        val WbEn = Output(UInt(1.W))
        val IsSigned = Output(UInt(1.W))
    })

    io.rs      := io.instr.apply(25,  21)
    io.rt      := io.instr.apply(20, 16)
    io.rd      := io.instr.apply(15, 11)
    io.imm     := io.instr.apply(15, 0)
    io.addr    := io.instr.apply(25,  0)

    val format: List[UInt] = ListLookup(io.instr.asUInt, default, map);
    io.AluOp    := format(0)
    io.ImmEn    := format(1)
    io.BrEn     := format(2)
    io.LoadEn   := format(3)
    io.StoreEn  := format(4)
    io.WbType   := format(5)
    io.WbEn     := format(6)
    io.IsSigned := format(7)
}
