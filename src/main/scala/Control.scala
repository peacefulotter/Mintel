import Instructions.default
import chisel3._
import chisel3.util.ListLookup

class Control extends Module  {
    val io = IO(new Bundle {
        val instr = Input(UInt(32.W))

        val rs = Output(UInt(5.W))
        val rt = Output(UInt(5.W))
        val rd = Output(UInt(5.W))
        val imm = Output(UInt(16.W))
        val addr = Output(UInt(26.W))
        // val shamt = Output(UInt(5.W))
        val ImmEn = Output(UInt(1.W))
        val AluOp = Output(UInt(6.W))
        val BrEn = Output(UInt(1.W))
        val LoadEn = Output(UInt(1.W))
        val StoreEn = Output(UInt(1.W))
        val WbType = Output(UInt(1.W))
        val WbEn = Output(UInt(1.W))
    })


    val format = ListLookup(io.instr.asUInt, default, Instructions.map);
    io.rs      := io.instr.apply(25,  21)
    io.rt      := io.instr.apply(20, 16)
    io.rd      := io.instr.apply(15, 11)
    io.imm     := io.instr.apply(15, 0)
    io.addr    := io.instr.apply(25,  0)
    // io.shamt   := 0.U; // io.instr(21, 26)
    io.AluOp   := format(0)
    io.ImmEn   := format(1)
    io.BrEn    := format(2)
    io.LoadEn  := format(3)
    io.StoreEn := format(4)
    io.WbType  := format(5)
    io.WbEn    := format(6)
}
