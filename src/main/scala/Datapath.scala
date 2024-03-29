

import Instructions.{BR_N, LD_Y}
import chisel3._;

class Datapath extends Module {
    val fetch = Module( new Fetch )
    val decode = Module( new Decode )
    val execute = Module( new Execute )
    val memory = Module( new Mem )
    val writeback = Module( new Writeback )

    val io = IO( new Bundle {

        val Inport1   = Input(UInt(8.W))
        val Inport2   = Input(UInt(8.W))
        val instr     = Output(UInt(32.W))
        val Outport  = Output(UInt(32.W))
    } )

    io.instr    := fetch.io.Instr

    /** FETCH **/
    fetch.io.Stall      := Mux(decode.dec_io.BrEn =/= BR_N, 1.U, 0.U) // stall for 2 CC if branching occurs (1 + reg update)
    fetch.io.BrEn       := memory.mem_io.BrEnOut
    fetch.io.BranchAddr := memory.mem_io.BrAddrOut

    /** DECODE **/
    decode.dec_io.Instr         := RegNext( fetch.io.Instr )
    decode.dec_io.NextPCIn      := RegNext( fetch.io.NextPC )
    decode.dec_io.WriteEnIn     := writeback.wb_io.WbEnOut.asUInt // no RegNext
    decode.dec_io.WriteTypeIn   := writeback.wb_io.WbTypeOut // no RegNext
    decode.dec_io.WriteAddrIn   := writeback.wb_io.WriteRegAddrOut // no RegNext
    decode.dec_io.WriteDataIn   := writeback.wb_io.WriteDataOut // no RegNext

    /** EXECUTE **/
    execute.exec_io.rs          := RegNext(decode.dec_io.rs)
    execute.exec_io.rt          := RegNext(decode.dec_io.rt)
    execute.exec_io.rd          := RegNext(decode.dec_io.rd)
    execute.exec_io.DataRead1   := RegNext(decode.dec_io.DataRead1)
    execute.exec_io.DataRead2   := RegNext(decode.dec_io.DataRead2)
    execute.exec_io.MemWbEn     := memory.mem_io.WbEnOut // no RegNext
    execute.exec_io.MemWbType   := memory.mem_io.WbTypeOut // no RegNext
    execute.exec_io.MemAddr     := memory.mem_io.WriteRegAddrOut // no RegNext
    execute.exec_io.MemVal      := Mux(memory.mem_io.LoadEnIn === LD_Y, memory.mem_io.ReadData, RegNext(execute.exec_io.AluRes))
    execute.exec_io.WbWbEn      := writeback.wb_io.WbEnOut // no RegNext
    execute.exec_io.WbWbType    := writeback.wb_io.WbTypeOut // no RegNext
    execute.exec_io.WbAddr      := writeback.wb_io.WriteRegAddrOut // no RegNext
    execute.exec_io.WbVal       := writeback.wb_io.WriteDataOut // no RegNext
    execute.exec_io.AluOp       := RegNext(decode.dec_io.AluOp)
    execute.exec_io.Imm         := RegNext(decode.dec_io.Imm)
    execute.exec_io.ImmEn       := RegNext(decode.dec_io.ImmEn)
    execute.exec_io.BrEnIn      := RegNext(decode.dec_io.BrEn)
    execute.exec_io.NextPC      := RegNext(decode.dec_io.NextPCOut)
    execute.exec_io.LoadEnIn    := RegNext(decode.dec_io.ReadEn)
    execute.exec_io.StoreEnIn   := RegNext(decode.dec_io.WriteEnOut)
    execute.exec_io.WbTypeIn    := RegNext(decode.dec_io.WbType)
    execute.exec_io.WbEnIn      := RegNext(decode.dec_io.WbEn)

    /** MEMORY **/
    memory.mem_io.LoadEnIn          := RegNext(execute.exec_io.LoadEnOut)
    memory.mem_io.StoreEn           := RegNext(execute.exec_io.StoreEnOut)
    memory.mem_io.AddrIn            := RegNext(execute.exec_io.AluRes)
    memory.mem_io.WbEnIn            := RegNext(execute.exec_io.WbEnOut)
    memory.mem_io.WbTypeIn          := RegNext(execute.exec_io.WbTypeOut)
    memory.mem_io.WriteData         := RegNext(execute.exec_io.WriteData)
    memory.mem_io.CtrlBrEn          := RegNext(execute.exec_io.BrEnOut)
    memory.mem_io.AluBrEn           := RegNext(execute.exec_io.zero)
    memory.mem_io.BrAddrIn          := RegNext(execute.exec_io.BranchAddrOut)
    memory.mem_io.WriteRegAddrIn    := RegNext(execute.exec_io.WriteRegAddr)
    // Switches
    memory.mem_io.Inport1 := io.Inport1
    memory.mem_io.Inport2 := io.Inport2
    io.Outport            := memory.mem_io.Outport
    
    /** WRITEBACK **/
    writeback.wb_io.LoadEn          := RegNext( memory.mem_io.LoadEnOut )
    writeback.wb_io.WbEnIn          := RegNext( memory.mem_io.WbEnOut )
    writeback.wb_io.WbTypeIn        := RegNext( memory.mem_io.WbTypeOut )
    writeback.wb_io.ReadData        := RegNext( memory.mem_io.ReadData ) // already one clock delay from the RAM
    writeback.wb_io.AddrData        := RegNext( memory.mem_io.AddrOut )
    writeback.wb_io.WriteRegAddrIn  := RegNext( memory.mem_io.WriteRegAddrOut )
}

//object Datapath extends App {
//    (new chisel3.stage.ChiselStage).emitVerilog(new Datapath, Array("--target-dir", "generated_verilog"))
//}
