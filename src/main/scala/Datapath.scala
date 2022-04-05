

import chisel3._;

class Datapath extends Module {
    val fetch = Module( new Fetch )
    val decode = Module( new Decode )
    val execute = Module( new Execute )
    val memory = Module( new Mem )
    val writeback = Module( new Writeback )

    val io = IO( new Bundle {} )

    def risingEdge = clock.asBool && !RegNext(clock.asBool)

    /** FETCH **/
    // Input
    fetch.io.PCSrc := ???
    fetch.io.BranchAddr := ???
    // Output
    val fe_PcCounter = Reg(UInt());
    val fe_Instr = Reg(UInt());
    when ( risingEdge ) {
        fe_PcCounter := fetch.io.PcCounter
        fe_Instr := fetch.io.Instr
    }

    /** DECODE **/
    // Input
    decode.io.PcCounterIn := fe_PcCounter
    decode.io.Instr := fe_Instr
    decode.io.WriteAddr := ??? // WB
    decode.io.WriteEn := ??? // WB
    decode.io.WriteDataIn := ??? // WB
    // Output
    val de_Imm = Reg(UInt());
    val de_ImmSel = Reg(UInt());
    val de_PcCounterOut = Reg(UInt());
    val de_BranchAddrDelta = Reg(UInt());
    val de_WriteDataOut = Reg(UInt());
    val de_WbSel = Reg(UInt());
    val de_DataRead1 = Reg(UInt());
    val de_DataRead2 = Reg(UInt());
    when ( risingEdge ) {
        de_Imm := decode.io.Imm
        de_ImmSel := decode.io.ImmSel
        de_PcCounterOut := decode.io.PcCounterOut
        de_BranchAddrDelta := decode.io.BranchAddrDelta
        de_WriteDataOut := decode.io.WriteDataOut
        de_WbSel := decode.io.WriteDataOut
        de_DataRead1 := decode.io.WriteDataOut
        de_DataRead2 := decode.io.WriteDataOut
    }

    /** EXECUTE **/
    // Input
    execute.io.PcCounter := ???
    execute.io.BranchAddrIn := ???
    execute.io.DataRead1 := ???
    execute.io.DataRead2 := ???
    execute.io.AluOp := ???
    execute.io.AluSrc := ???
    execute.io.MemSel := ???
    execute.io.WbSel := ???
    // Output
    execute.io.AluRes := ???
    execute.io.WriteAddr := ???
    execute.io.BranchAddrOut := ???
    execute.io.DataRead2Out := ???
    execute.io.MemSelOut := ???
    execute.io.WbSelOut := ???

    /** MEMORY **/
    // Input
    memory.io.WriteEn := ???
    memory.io.ReadEn := ???
    memory.io.WbSelIn := ???
    memory.io.AluRes := ???
    memory.io.AddrIn := ???
    // Output
    memory.io.ReadData := ???
    memory.io.WbSelOut := ???
    memory.io.AddrOut := ???

    /** WRITEBACK **/
    // Input
    // Output
}
