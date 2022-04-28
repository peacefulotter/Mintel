import chisel3._

class Fetch extends Module  {

    val mem = Module( new InstructionMem )
    val PC = RegInit(0.U(32.W)); // TODO: PC should start at which value?

    val io = IO(new Bundle {
        // From MEM - in case of a Branch
        val BranchAddr = Input(UInt(32.W))
        val BrEn = Input(Bool())

        val NextPC = Output(UInt(32.W))
        val Instr = Output(UInt(32.W))
    })

    io.NextPC := PC + 1.U;
    val newPC = Mux( io.BrEn, io.BranchAddr, io.NextPC )

    mem.io.PC := PC
    io.Instr := mem.io.Instr;

    PC := newPC
}
