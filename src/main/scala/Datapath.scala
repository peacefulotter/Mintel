

import chisel3._;

class Datapath extends Module {
    val fetch = Module( new Fetch )
    val decode = Module( new Decode )
    val execute = Module( new Execute )
    val memory = Module( new Mem )
    val writeback = Module( new Writeback )

    val io = IO( new Bundle {
        val instr = Output(UInt(32.W))
    } )

    /** FETCH **/
    fetch.io.BrEn := memory.io.BrEnOut
    fetch.io.BranchAddr := memory.io.BrAddrOut

    io.instr := fetch.io.Instr;

    /** DECODE **/
    decode.io.Instr := RegNext( fetch.io.Instr )
    decode.io.NextPCIn := RegNext( fetch.io.NextPC )
    decode.io.WriteEnIn := writeback.io.WbEnOut // no RegNext
    decode.io.WriteAddrIn := writeback.io.WriteRegAddrOut // no RegNext
    decode.io.WriteDataIn := writeback.io.WriteDataOut // no RegNext

    /** EXECUTE **/
    execute.io.rs := RegNext(decode.io.AluOp)
    execute.io.rt := RegNext(decode.io.rt)
    execute.io.rd := RegNext(decode.io.rd)
    execute.io.DataRead1 := RegNext(decode.io.DataRead1)
    execute.io.DataRead2 := RegNext(decode.io.DataRead2)
    execute.io.MemAddr := memory.io.WriteRegAddrOut // no RegNext
    execute.io.MemVal := memory.io.AluResOut // no RegNext
    execute.io.WbAddr := writeback.io.WriteRegAddrOut // no RegNext
    execute.io.WbVal := writeback.io.WriteDataOut // no RegNext
    execute.io.AluOp := RegNext(decode.io.AluOp)
    execute.io.Imm := RegNext(decode.io.Imm)
    execute.io.ImmEn := RegNext(decode.io.ImmEn)
    execute.io.BrEnIn := RegNext(decode.io.BrEn)
    execute.io.NextPC := RegNext(decode.io.NextPCOut)
    execute.io.ReadEnIn := RegNext(decode.io.ReadEn)
    execute.io.WriteEnIn := RegNext(decode.io.WriteEnOut)
    execute.io.WbTypeIn := RegNext(decode.io.WbType)
    execute.io.WbEnIn := RegNext(decode.io.WbEn)

    /** MEMORY **/
    memory.io.WriteEn := RegNext(execute.io.WriteEnOut)
    memory.io.ReadEn := RegNext(execute.io.ReadEnOut)
    memory.io.WbTypeIn := RegNext(execute.io.WbTypeOut)
    memory.io.WbEnIn := RegNext(execute.io.WbEnOut)
    memory.io.WriteData := RegNext(execute.io.DataRead2Out)
    memory.io.AluResIn := RegNext(execute.io.AluRes)
    memory.io.CtrlBrEn := RegNext(execute.io.BrEnOut)
    memory.io.AluBrEn := RegNext(execute.io.zero)
    memory.io.BrAddrIn := RegNext(execute.io.BranchAddrOut)
    memory.io.WriteRegAddrIn := RegNext(execute.io.WriteRegAddr)

    /** WRITEBACK **/
    writeback.io.WbTypeIn := RegNext(memory.io.WbTypeOut)
    writeback.io.WbEnIn := RegNext(memory.io.WbEnOut)
    writeback.io.ReadData := RegNext(memory.io.ReadData)
    writeback.io.AddrData := RegNext(memory.io.AluResOut)
    writeback.io.WriteRegAddrIn := RegNext(memory.io.WriteRegAddrOut)
}
