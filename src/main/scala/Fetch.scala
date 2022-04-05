import chisel3._

class Fetch extends Module  {

    val mem = Module( new InstructionMem )
    val PC = RegInit(0.U); // TODO: PC should start at which value?

    val io = IO(new Bundle {
        // From MEM - in case of a Branch
        val BranchAddr = Input(UInt(32.W))
        val PCSrc = Input(Bool())

        val PcCounter = Output(UInt(32.W))
        val Instr = Output(Vec(32, Bool()))
    })


    mem.io.PC := PC
    io.Instr := mem.io.Instr;

    io.PcCounter := PC + 4.U;
    PC := Mux( io.PCSrc, io.BranchAddr, io.PcCounter )
}
