

import chisel3._;

class Datapath extends Module {
    val fetch = Module( new Fetch )
    val decode = Module( new Decode )
    val execute = Module( new Execute )
    val memory = Module( new Mem )
    val writeback = Module( new Writeback )

    val io = IO( new Bundle {} )

    /** FETCH **/
    fetch.io.PCSrc := memory.io.PCSrc
    fetch.io.BranchAddr := memory.io.BranchAddrOut

    /** DECODE **/
    decode.io.PcCounterIn := RegNext( fetch.io.PcCounter )
    decode.io.Instr := RegNext( fetch.io.Instr )
    decode.io.WriteAddrIn := writeback.io.WriteAddrOut // no RegNext
    decode.io.WriteDataIn := writeback.io.WriteDataOut // no RegNext
    decode.io.WriteEn := writeback.io.WbSelOut // no RegNext

    /** EXECUTE **/
    execute.io.PcCounter := RegNext(decode.io.PcCounterOut)
    execute.io.Imm := RegNext(decode.io.Imm)
    execute.io.DataRead1 := RegNext(decode.io.DataRead1)
    execute.io.DataRead2 := RegNext(decode.io.DataRead2)
    execute.io.WriteAddr := RegNext(decode.io.WriteAddrOut)
    execute.io.AluOp := RegNext(decode.io.AluOp)
    execute.io.ImmSel := RegNext(decode.io.ImmSel)
    execute.io.WriteSelIn := RegNext(decode.io.WriteSelOut)
    execute.io.ReadSelIn := RegNext(decode.io.ReadSelOut)
    execute.io.BranchSelIn := RegNext(decode.io.BranchSelIn)
    execute.io.WbSel := RegNext(decode.io.WbSel)

    /** MEMORY **/
    // Input
    memory.io.WriteEn := RegNext(execute.io.WriteSelOut)
    memory.io.ReadEn := RegNext(execute.io.ReadSelOut)
    memory.io.WbSelIn := RegNext(execute.io.WbSelOut)
    memory.io.WriteData := RegNext(execute.io.DataRead2Out)
    memory.io.WriteAddr := RegNext(execute.io.AluRes)
    memory.io.CtrlBranchSel := RegNext(execute.io.BranchSelOut)
    memory.io.AluBranchSel := RegNext(execute.io.BranchCond)
    memory.io.WriteAddr := RegNext(execute.io.WriteAddr)
    memory.io.BranchAddrIn := RegNext(execute.io.BranchAddrOut)

    /** WRITEBACK **/
    writeback.io.WbSelIn := RegNext(memory.io.WbSelOut)
    writeback.io.WriteAddrIn := ???
    writeback.io.ReadData := RegNext(memory.io.ReadData)
    writeback.io.AddrData := RegNext(memory.io.AddrOut)
}
