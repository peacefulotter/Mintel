

import chisel3._;

class Datapath extends Module {
    val fetch = Module( new Fetch )
    val decode = Module( new Decode )
    val execute = Module( new Execute )
    val memory = Module( new Mem )
    val writeback = Module( new Writeback )

    val io = IO( new Bundle {} )

    /** FETCH **/
    fetch.io.PCSrc := memory.io.BrEnOut
    fetch.io.BranchAddr := memory.io.BrAddrOut

    /** DECODE **/
    decode.io.Instr := RegNext( fetch.io.Instr )
    decode.io.PcCounterIn := RegNext( fetch.io.PcCounter )
    decode.io.WriteEnIn := writeback.io.WbEnOut // no RegNext
    decode.io.WriteAddrIn := writeback.io.WriteAddrOut // no RegNext
    decode.io.WriteDataIn := writeback.io.WriteDataOut // no RegNext

    /** EXECUTE **/
    execute.io.AluOp := RegNext(decode.io.AluOp)
    execute.io.Imm := RegNext(decode.io.Imm)
    execute.io.ImmEn := RegNext(decode.io.ImmEn)
    execute.io.BrEnIn := RegNext(decode.io.BrEn)
    execute.io.PcCounter := RegNext(decode.io.PcCounterOut)
    execute.io.ReadEnIn := RegNext(decode.io.ReadEn)
    execute.io.WriteEnIn := RegNext(decode.io.WriteEnOut)
    execute.io.WbTypeIn := RegNext(decode.io.WbType)
    execute.io.WbEnIn := RegNext(decode.io.WbEn)
    execute.io.WriteAddr := RegNext(decode.io.WriteAddrOut)
    execute.io.DataRead1 := RegNext(decode.io.DataRead1)
    execute.io.DataRead2 := RegNext(decode.io.DataRead2)

    /** MEMORY **/
    // Input
    memory.io.WriteEn := RegNext(execute.io.WriteEnOut)
    memory.io.ReadEn := RegNext(execute.io.ReadEnOut)
    memory.io.WbTypeIn := RegNext(execute.io.WbTypeOut)
    memory.io.WbEnIn := RegNext(execute.io.WbEnOut)
    memory.io.WriteData := RegNext(execute.io.DataRead2Out)
    memory.io.WriteAddr := RegNext(execute.io.AluRes)
    memory.io.CtrlBrEn := RegNext(execute.io.BrEnOut)
    memory.io.AluBrEn := RegNext(execute.io.zero)
    memory.io.WriteAddr := RegNext(execute.io.WriteAddr)
    memory.io.BrAddrIn := RegNext(execute.io.BranchAddrOut)

    /** WRITEBACK **/
    writeback.io.WbTypeIn := RegNext(memory.io.WbTypeOut)
    writeback.io.WbEnIn := RegNext(memory.io.WbEnOut)
    writeback.io.WriteAddrIn := ???
    writeback.io.ReadData := RegNext(memory.io.ReadData)
    writeback.io.AddrData := RegNext(memory.io.AddrOut)
}
