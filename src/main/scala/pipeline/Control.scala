package pipeline

import chisel3._
import chisel3.util.ListLookup
import instr.InstructionMapping._
import instr.Instructions

class Control extends Module  {
    val io = IO(new Bundle {
        val instr = Input(Vec(32, Bool()))

        val op = Output(Vec(6, Bool())) // UInt(6.W))
        val rs = Output(Vec(5, Bool()))
        val rt = Output(Vec(5, Bool()))
        val rd = Output(Vec(5, Bool()))
        val imm = Output(Vec(16, Bool()))
        val addr = Output(Vec(26, Bool()))
        val funct = Output(Vec(6, Bool()))
    })

    def first(u: UInt) = u.litValue.toInt
    def last(u: UInt) = u.litValue.toInt + u.getWidth
    def assign(out: Vec[Bool], loc: UInt) = {
        val instrPart = io.instr.slice( first(loc), last(loc) )
        out.zip(instrPart).foreach { case (a, b) => a := b }
    }

    val format = ListLookup(io.instr.asUInt, default, Instructions.map);
    assign(io.op, format(0))
    assign(io.rs, format(1))
    assign(io.rt, format(2))
    assign(io.rd, format(3))
    assign(io.imm, format(4))
    assign(io.addr, format(5))
    assign(io.funct, format(6))
}
