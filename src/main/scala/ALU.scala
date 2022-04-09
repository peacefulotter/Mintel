import ALU._
import chisel3._
import chisel3.util._

object ALU {
    val add :: sub :: and :: or :: xor :: sll ::
        slt :: sltu :: ge :: geu :: srl :: sra ::
        copy_a :: copy_b :: xxx :: Nil = Enum(16)
}

class ALU extends Module {
    val io = IO(new Bundle {
        val A = Input(UInt(32.W))
        val B = Input(UInt(32.W))
        val alu_op = Input(UInt(5.W))

        val out = Output(UInt(32.W))
        val sum = Output(UInt(32.W))
    })

    val shamt = io.B(4, 0).asUInt

    io.out := MuxLookup(
        io.alu_op,
        io.B,
        Seq(
            add -> (io.A + io.B),
            sub -> (io.A - io.B),
            sra -> (io.A.asSInt >> shamt).asUInt,
            srl -> (io.A >> shamt),
            sll -> (io.A << shamt),
            slt -> (io.A.asSInt < io.B.asSInt),
            sltu -> (io.A < io.B),
            ge -> (io.A.asSInt >= io.B.asSInt),
            geu -> (io.A >= io.B),
            and -> (io.A & io.B),
            or -> (io.A | io.B),
            xor -> (io.A ^ io.B),
            copy_a -> io.A,
            copy_b -> io.B
        )
    )

    io.sum := io.A + Mux(io.alu_op(0), -io.B, io.B)
}