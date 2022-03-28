package pipeline

import chisel3._
import chisel3.experimental.IO

class SignExtend {
    val io = IO(new Bundle {
        val in = Input(Vec(16, Bool()))
        val isSigned = Input(Bool())
        val out = Output(Vec(32, Bool()))
    })

    val zeros: Vec[Bool] = VecInit(Seq.fill(16)(false.B))
    val ones: Vec[Bool]  = VecInit(Seq.fill(16)(true.B))

    // WHY NOT POSSIBLE
    // io.out.zip(io.in).slice(0, 16).foreach { case (a, b) => a := b }
    // io.out.slice(0, 16) := io.in

    // io.out.slice(0, 16) := io.in.slice(0, 16)
    // io.out.slice(16, 32) := = Mux(io.isSigned && io.in(15) === true.B, ones, zeros)

    val forward: Vec[Bool] = Mux(io.isSigned && io.in(15) === true.B, ones, zeros)
    io.out.zip(io.in).slice(0, 16).foreach { case (a, b) => a:= b }
    io.out.zip(forward).slice(16, 32).foreach { case (a, b) => a:= b }
}
