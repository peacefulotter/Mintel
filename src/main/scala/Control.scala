import chisel3._
import chisel3.util.ListLookup
import instr.InstructionMapping._
import instr.Instructions

class Control extends Module  {
    val io = IO(new Bundle {
        val instr = Input(UInt(32.W))

        val op = Output(UInt(6.W))
        val rs = Output(UInt(5.W))
        val rt = Output(UInt(5.W))
        val rd = Output(UInt(5.W))
        val imm = Output(UInt(16.W))
        val immSel = Output(UInt(1.W))
        val addr = Output(UInt(26.W))
        val funct = Output(UInt(6.W))
        val MemSel = Output(Bool())
        val WbSel = Output(UInt(1.W))
    })

    def assign(out: UInt, loc: UInt) = {
        def low = loc.litValue.toInt
        def high = low + loc.getWidth
        out( high, low ) := io.instr( high, low )
    }

    val format = ListLookup(io.instr.asUInt, default, Instructions.map);
    assign(io.op, format(0))
    assign(io.rs, format(1))
    assign(io.rt, format(2))
    assign(io.rd, format(3))
    assign(io.imm, format(4))
    assign(io.immSel, format(5))
    assign(io.addr, format(6))
    assign(io.funct, format(7))
    assign(io.WbSel, format(8))
    // assign MemSel

    /*
    Make the 1.W -> BOOL()

    alu_op -> default ALU_ADD
    br_op
    st_op
    lo_op
    readRegAddr1
    readRegAddr2
    writeRegAddr1
     */
    // ADD WB ENABLE
}
