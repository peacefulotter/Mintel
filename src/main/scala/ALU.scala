import ALU._
import chisel3._
import chisel3.util._

object ALU {
    val add :: sub :: and :: or :: xor :: sll :: srl :: slt :: lt :: lte :: ge :: ne :: eq :: Nil = Enum(13)
}

class ALU extends Module {
    val io = IO(new Bundle {
        val A = Input(UInt(32.W))
        val B = Input(UInt(32.W))
        val AluOp = Input(UInt(5.W))

        val out = Output(UInt(32.W))
        val zero = Output(Bool())
    })

    def shamt: UInt = io.B(4, 0).asUInt

    def zero: Bool = MuxLookup(
        io.AluOp,
        false.B,
        Seq(
            ALU.lt ->   (io.A.asSInt < io.B.asSInt),
            ALU.ge ->   (io.A.asSInt >= io.B.asSInt),
            ALU.ne ->   (io.A =/= io.B),
            ALU.eq ->   (io.A === io.B)
        )
    )

    io.out := MuxLookup(
        io.AluOp,
        zero.asUInt,
        Seq(
            add ->  (io.A + io.B),
            sub ->  (io.A - io.B),
            // TODO add sra
            // TODO add mult
            // TODO add ..
            srl ->  (io.A >> shamt),
            sll ->  (io.A << shamt),
            slt ->  (io.A.asSInt < io.B.asSInt),
            and ->  (io.A & io.B),
            or ->   (io.A | io.B),
            xor ->  (io.A ^ io.B)
        )
    )

    io.zero := zero
    // io.sum := io.A + Mux(io.alu_op(0), -io.B, io.B)
}