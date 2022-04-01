import chisel3._

class Fetch extends Module  {
    val PC = RegInit(0.U); // TODO: PC should start at which value?

    val io = IO(new Bundle {
        // From MEM - in case of a Branch
        val BranchAddr = Input(UInt(32.W))
        val PCSrc = Input(Bool())

        val pcCounter = Output(UInt(32.W))
        val instr = Output(Vec(32, Bool()))
    })


    // io.instr := Instruction.get(PC)
    io.pcCounter := PC + 4.U;
    PC := Mux( io.PCSrc, io.BranchAddr, io.pcCounter )
}
