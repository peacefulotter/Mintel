import chisel3._
import chisel3.util.BitPat.bitPatToUInt

class Fetch extends Module  {

    val mem = Module( new InstructionMem )
    val PC = RegInit(0.U(32.W)); // PC should start at which value?
    val STALL = RegInit(0.U(5.W));

    val io = IO(new Bundle {
        // From Decode
        val Stall = Input(UInt(5.W))

        // From MEM - in case of a Branch
        val BranchAddr = Input(UInt(32.W))
        val BrEn = Input(Bool())

        val NextPC = Output(UInt(32.W))
        val Instr = Output(UInt(32.W))
    })

    STALL := Mux(
        io.Stall > 0.U,
        io.Stall,
        Mux( STALL > 0.U, STALL - 1.U, 0.U )
    )

    val isStalling: Bool = io.Stall > 0.U | STALL > 0.U


    val newPC: UInt = Mux(
        isStalling,
        PC,
        Mux( io.BrEn, io.BranchAddr + 1.U, PC + 1.U )
    )

    io.NextPC := newPC;

    mem.io.PC := Mux( io.BrEn, io.BranchAddr, PC )
    io.Instr := Mux(
        isStalling,
        bitPatToUInt(Instructions.NOP),
        mem.io.Instr
    )

    PC := newPC
}
