import chisel3._
import chisel3.util._

object ALU {
    def ALU_ADD = 0.U(4.W)
    def ALU_SUB = 1.U(4.W)
    def ALU_AND = 2.U(4.W)
    def ALU_OR = 3.U(4.W)
    def ALU_XOR = 4.U(4.W)
    def ALU_SLT = 5.U(4.W)
    def ALU_SLL = 6.U(4.W)
    def ALU_SLTU = 7.U(4.W)
    def ALU_SRL = 8.U(4.W)
    def ALU_SRA = 9.U(4.W)
    def ALU_COPY_A = 10.U(4.W)
    def ALU_COPY_B = 11.U(4.W)
    def ALU_XXX = 15.U(4.W)
}

class ALU extends Module {
    val io = IO(new Bundle {
        val A = Input(UInt(32.W))
        val B = Input(UInt(32.W))
        val alu_op = Input(UInt(4.W))

        val out = Output(UInt(32.W))
        val sum = Output(UInt(32.W))
    })

    val shamt = io.B(4, 0).asUInt

    io.out := MuxLookup(
        io.alu_op,
        io.B,
        Seq(
            ALU_ADD -> (io.A + io.B),
            ALU_SUB -> (io.A - io.B),
            ALU_SRA -> (io.A.asSInt >> shamt).asUInt,
            ALU_SRL -> (io.A >> shamt),
            ALU_SLL -> (io.A << shamt),
            ALU_SLT -> (io.A.asSInt < io.B.asSInt),
            ALU_SLTU -> (io.A < io.B),
            ALU_AND -> (io.A & io.B),
            ALU_OR -> (io.A | io.B),
            ALU_XOR -> (io.A ^ io.B),
            ALU_COPY_A -> io.A
        )
    )

    io.sum := io.A + Mux(io.alu_op(0), -io.B, io.B)
}