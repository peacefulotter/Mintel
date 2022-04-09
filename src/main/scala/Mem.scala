import chisel3._

class Mem extends Module {

    // val mem = Module( new MemoryModule )
    val mem = Module( new RAM );

    /**
     * TODO: REPLACE RAM WITH MEMORY_MODULE
     */

    val io = IO(new Bundle {
        // From Control
        val WriteEn = Input(UInt(1.W)) // MemWrite
        val ReadEn = Input(UInt(1.W)) // MemRead
        val CtrlBranchSel = Input(Bool()) // WB
        val WbSelIn = Input(UInt(1.W)) // WB

        // From Execute
        val AluRes = Input(UInt(32.W))
        val AluBranchSel = Input(Bool())
        val AddrIn = Input(UInt(32.W)) // ????

        // To WB
        val ReadData = Output(UInt(32.W)) // After reading from the Memory
        val WbSelOut = Output(UInt(1.W)) // WB
        val AddrOut = Output(UInt(32.W)) // Raw addr

        // To Datapath
        val PCSrc = Output(Bool())
    })

    mem.io.addr := io.AddrIn
    mem.io.readEn := io.ReadEn;
    mem.io.writeEn := io.WriteEn
    mem.io.writeData := io.AluRes // we write the ALU result
    io.ReadData := mem.io.readData;

    io.WbSelOut := io.WbSelIn;
    io.AddrOut := io.AddrIn;

    io.PCSrc := io.AluBranchSel & io.CtrlBranchSel;
}
