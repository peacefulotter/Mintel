import ALU._
import chisel3._
import chisel3.util._

object ALU {
    val add :: sub :: and :: or :: xor :: sll :: srl :: slt :: lt :: lte :: ge :: ne :: eq :: Nil = Enum(16)
}

class ALU extends Module {
    val io = IO(new Bundle {
        val A = Input(UInt(32.W))
        val B = Input(UInt(32.W))
        val alu_op = Input(UInt(5.W))

        val out = Output(UInt(32.W))
        val zero = Output(Bool())
    })

    def shamt: UInt = io.B(4, 0).asUInt

    def zero: Bool = MuxLookup(
        io.alu_op,
        false.B,
        Seq(
            ALU.lt ->   (io.A.asSInt < io.B.asSInt),
            ALU.ge ->   (io.A.asSInt >= io.B.asSInt),
            ALU.ne ->   (io.A =/= io.B),
            ALU.eq ->   (io.A === io.B)
        )
    )

    io.out := MuxLookup(
        io.alu_op,
        zero.asUInt,
        Seq(
            add ->  (io.A + io.B),
            sub ->  (io.A - io.B),
            srl ->  (io.A >> io.B),
            sll ->  (io.A << io.B),
            slt ->  (io.A.asSInt < io.B.asSInt),
            and ->  (io.A & io.B),
            or ->   (io.A | io.B),
            xor ->  (io.A ^ io.B)
        )
    )

    io.zero := zero
    // io.sum := io.A + Mux(io.alu_op(0), -io.B, io.B)
}