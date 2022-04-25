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
        val WriteData = Input(UInt(32.W))
        val AluBranchSel = Input(Bool())
        val WriteAddr = Input(UInt(32.W)) // ????
        val BranchAddrIn = Input(UInt(32.W))

        // To Fetch
        val BranchAddrOut = Input(UInt(32.W))

        // To WB
        val ReadData = Output(UInt(32.W)) // After reading from the Memory
        val WbSelOut = Output(UInt(1.W)) // WB
        val AddrOut = Output(UInt(32.W)) // Raw addr

        // To Datapath
        val PCSrc = Output(Bool())
    })

    mem.io.addr := io.WriteAddr
    mem.io.readEn := io.ReadEn;
    mem.io.writeEn := io.WriteEn
    mem.io.writeData := io.WriteData // we write the ALU result
    io.ReadData := mem.io.readData;

    io.BranchAddrOut := io.BranchAddrIn;

    io.WbSelOut := io.WbSelIn;
    io.AddrOut := io.WriteAddr;

    io.PCSrc := io.AluBranchSel & io.CtrlBranchSel;
}
