///**
// * Arithmetic Logic Unit - ALU
// */
//
//import chisel3._
//import chisel3.util._
//
//object Types {
//  val nop :: add :: sub :: and :: or :: xor :: ld :: sra :: srl :: sll :: slt :: sltu :: cpy :: Nil = Enum(13)
//}
//
//class Alu(size: Int) extends Module {
//
//  import Types._
//
//  val io = IO(new Bundle {
//    val op = Input(UInt(4.W))     /** Operation */
//    val a = Input(SInt(size.W))   /** Operand 1 */
//    val b = Input(SInt(size.W))   /** Operand 2 */
//    val y = Output(SInt(size.W))  /** Output */
//  })
//
//  val op = io.op
//  val a = io.a
//  val b = io.b
//  val res = WireDefault(0.S(size.W))
//  val shamt = io.b(4, 0).asUInt
//
//  switch(op) {
//    is(add) {
//      res := a + b
//    }
//    is(sub) {
//      res := a - b
//    }
//    is(and) {
//      res := a & b
//    }
//    is(or) {
//      res := a | b
//    }
//    is(xor) {
//      res := a ^ b
//    }
//    is(sra) {
//      res := a >> shamt
//    }
//    is(srl) {
//      when (shamt === 0.U) {res := a}
//        .otherwise {
//          val tmp = (a >> 1).asSInt & 0x7fffffff.S
//          when(shamt > 1.U) {res := tmp >> (shamt - 1.U)}
//            .otherwise {res := tmp}
//        }
//    }
//    is(sll) {
//      res := a << shamt
//    }
//    is(slt) {
//      when (a < b) {res := 1.S}
//        .otherwise {res := 0.S}
//    }
//    is(sltu) {
//      when (a.asUInt < b.asUInt) {res := 1.S}
//        .otherwise {res := 0.S}
//    }
//    is(ld) {
//      res := b
//    }
//    is(cpy) {
//      res := a
//    }
//  }
//
//  io.y := res
//
//}
//
//object Alu extends App {
//  emitVerilog(new Alu(32))
//}
