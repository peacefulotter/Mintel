import ALU._
import chisel3._
import chisel3.util._

object ALU {
    val add :: addu :: sub :: subu :: mult :: and :: or :: xor :: sll :: sllv :: srl :: srlv :: slt :: sltu :: lte :: ge :: ne :: eq :: Nil = Enum(18)
}

class ALU extends Module {
    val io = IO(new Bundle {
        val A = Input(UInt(32.W))
        val B = Input(UInt(32.W))
        val AluOp = Input(UInt(5.W))

        val out = Output(UInt(32.W))
        val zero = Output(Bool())
    })

    val shamt: UInt = io.B.apply(10,  6)

    def zero: Bool = MuxLookup(
        io.AluOp,
        false.B,
        Seq(
            ALU.slt ->  (io.A.asSInt < io.B.asSInt),
            ALU.ge  ->  (io.A.asSInt >= io.B.asSInt),
            ALU.ne  ->  (io.A =/= io.B),
            ALU.eq  ->  (io.A === io.B)
        )
    )

    io.out := MuxLookup(
        io.AluOp,
        zero.asUInt,
        Seq(
            add  -> (io.A.asSInt + io.B.asSInt).asUInt,
            addu -> (io.A + io.B),
            sub  -> (io.A.asSInt - io.B.asSInt).asUInt,
            subu -> (io.A - io.B),
            mult -> (io.A.asSInt * io.B.asSInt).asUInt,

            and  -> (io.A & io.B),
            or   -> (io.A | io.B),
            xor  -> (io.A ^ io.B),

            sll  -> (io.A << shamt),
            srl  -> (io.A >> shamt),
            sllv -> (io.A << io.B.apply(4, 0)),
            srlv -> (io.A >> io.B.apply(4, 0)),

            sltu -> (io.A < io.B).asUInt,
        )
    )

    io.zero := zero
}