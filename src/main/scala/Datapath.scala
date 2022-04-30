

import chisel3._;

class Datapath extends Module {
    val fetch = Module( new Fetch )
    val decode = Module( new Decode )
    val execute = Module( new Execute )
    val memory = Module( new Mem )
    val writeback = Module( new Writeback )

    val io = IO( new Bundle {
        // Input 1
        val switches1 = Input(UInt(8.W)) // 7:AB26, 6:AD26, 5:AC26, 4:AB27, 3:AD27, 2:AC27, 1:AC28, 0:AB28
        // Input 2
        val switches2 = Input(UInt(8.W)) // 7:AA22, 6:AA23, 5:AA24, 4:AB23, 3:AB24, 2:AC24, 1:AB25, 0:AC25

        val instr     = Output(UInt(32.W))
        val txd_instr = Output(UInt(1.W)) // G9

        // Input 1 Display
        val hex7     = Output(UInt(7.W)) // 6:AA14, 5:AG18, 4:AF17, 3:AH17, 2:AG17, 1:AE17, 0:AD17
        val hex6     = Output(UInt(7.W)) // 6:AC17, 5:AA15, 4:AB15, 3:AB17, 2:AA16, 1:AB16, 0:AA17

        // Input 2 Display
        val hex5     = Output(UInt(7.W)) // 6:AH18, 5:AF18, 4:AG19, 3:AH19, 2:AB18, 1:AC18, 0:AD18
        val hex4     = Output(UInt(7.W)) // 6:AE18, 5:AF19, 4:AE19, 3:AH21, 2:AG21, 1:AA19, 0:AB19

        // Output Display
        val hex3     = Output(UInt(7.W)) // 6:Y19, 5:AF23, 4:AD24, 3:AA21, 2:AB20, 1:U21, 0:V21
        val hex2     = Output(UInt(7.W)) // 6:W28, 5:W27, 4:Y26, 3:W26, 2:Y25, 1:AA26, 0:AA25
        val hex1     = Output(UInt(7.W)) // 6:U24, 5:U23, 4:W25, 3:W22, 2:W21, 1:Y22, 0:M24
        val hex0     = Output(UInt(7.W)) // 6:H22, 5:J22, 4:L25, 3:L26, 2:E17, 1:F22, 0:G18
    } )

    val input1  = io.switches1
    val input2  = io.switches2
    val output  = WireDefault(0.U(32.W))
    output      := execute.exec_io.AluRes

    io.instr    := fetch.io.Instr;

    /** FETCH **/
    fetch.io.Stall      := decode.dec_io.BrEn // stall for 2 CC if branching occurs (1 + reg update)
    fetch.io.BrEn       := memory.mem_io.BrEnOut
    fetch.io.BranchAddr := memory.mem_io.BrAddrOut

    /** DECODE **/
    decode.dec_io.Instr         := RegNext( fetch.io.Instr )
    decode.dec_io.NextPCIn      := RegNext( fetch.io.NextPC )
    decode.dec_io.WriteEnIn     := writeback.wb_io.WbEnOut // no RegNext
    decode.dec_io.WriteAddrIn   := writeback.wb_io.WriteRegAddrOut // no RegNext
    decode.dec_io.WriteDataIn   := writeback.wb_io.WriteDataOut // no RegNext

    /** EXECUTE **/
    execute.exec_io.rs          := RegNext(decode.dec_io.rs)
    execute.exec_io.rt          := RegNext(decode.dec_io.rt)
    execute.exec_io.rd          := RegNext(decode.dec_io.rd)
    execute.exec_io.DataRead1   := RegNext(decode.dec_io.DataRead1)
    execute.exec_io.DataRead2   := RegNext(decode.dec_io.DataRead2)
    execute.exec_io.MemWbEn     := memory.mem_io.WbEnOut // no RegNext
    execute.exec_io.MemAddr     := memory.mem_io.WriteRegAddrOut // no RegNext
    execute.exec_io.MemVal      := RegNext(execute.exec_io.AluRes)
    execute.exec_io.WbWbEn      := writeback.wb_io.WbEnOut // no RegNext
    execute.exec_io.WbAddr      := writeback.wb_io.WriteRegAddrOut // no RegNext
    execute.exec_io.WbVal       := writeback.wb_io.WriteDataOut // no RegNext
    execute.exec_io.AluOp       := RegNext(decode.dec_io.AluOp)
    execute.exec_io.Imm         := RegNext(decode.dec_io.Imm)
    execute.exec_io.ImmEn       := RegNext(decode.dec_io.ImmEn)
    execute.exec_io.BrEnIn      := RegNext(decode.dec_io.BrEn)
    execute.exec_io.NextPC      := RegNext(decode.dec_io.NextPCOut)
    execute.exec_io.ReadEnIn    := RegNext(decode.dec_io.ReadEn)
    execute.exec_io.WriteEnIn   := RegNext(decode.dec_io.WriteEnOut)
    execute.exec_io.WbTypeIn    := RegNext(decode.dec_io.WbType)
    execute.exec_io.WbEnIn      := RegNext(decode.dec_io.WbEn)

    /** MEMORY **/
    memory.mem_io.ReadEn            := (execute.exec_io.ReadEnOut)
    memory.mem_io.AddrIn            := (execute.exec_io.AluRes)
    memory.mem_io.WriteEn           := RegNext(execute.exec_io.WriteEnOut)
    memory.mem_io.WbEnIn            := RegNext(execute.exec_io.WbEnOut)
    memory.mem_io.WbTypeIn          := RegNext(execute.exec_io.WbTypeOut)
    memory.mem_io.WriteData         := RegNext(execute.exec_io.WriteData)
    memory.mem_io.CtrlBrEn          := RegNext(execute.exec_io.BrEnOut)
    memory.mem_io.AluBrEn           := RegNext(execute.exec_io.zero)
    memory.mem_io.BrAddrIn          := RegNext(execute.exec_io.BranchAddrOut)
    memory.mem_io.WriteRegAddrIn    := RegNext(execute.exec_io.WriteRegAddr)

    /** WRITEBACK **/
    writeback.wb_io.WbEnIn          := RegNext(memory.mem_io.WbEnOut)
    writeback.wb_io.WbTypeIn        := RegNext(memory.mem_io.WbTypeOut)
    writeback.wb_io.ReadData        := memory.mem_io.ReadData // already one clock delay from the RAM
    writeback.wb_io.AddrData        := RegNext(memory.mem_io.AddrOut)
    writeback.wb_io.WriteRegAddrIn  := RegNext(memory.mem_io.WriteRegAddrOut)

    /** 7-Seg Displays **/
    val U_decoder7seg_7 = Module( new decoder7seg )
    val U_decoder7seg_6 = Module( new decoder7seg )
    val U_decoder7seg_5 = Module( new decoder7seg )
    val U_decoder7seg_4 = Module( new decoder7seg )
    val U_decoder7seg_3 = Module( new decoder7seg )
    val U_decoder7seg_2 = Module( new decoder7seg )
    val U_decoder7seg_1 = Module( new decoder7seg )
    val U_decoder7seg_0 = Module( new decoder7seg )

    U_decoder7seg_7.io.in := input1(7,4)
    U_decoder7seg_6.io.in := input1(3,0)
    U_decoder7seg_5.io.in := input2(7,4)
    U_decoder7seg_4.io.in := input2(3,0)

    U_decoder7seg_3.io.in := output(15,12)
    U_decoder7seg_2.io.in := output(11,8)
    U_decoder7seg_1.io.in := output(7,4)
    U_decoder7seg_0.io.in := output(3,0)

    io.hex7 := U_decoder7seg_7.io.out // Input1 -> Switches(3:0)
    io.hex6 := U_decoder7seg_6.io.out // Input1 -> Switches(7:4)
    io.hex5 := U_decoder7seg_5.io.out // Input1 -> Switches(3:0)
    io.hex4 := U_decoder7seg_4.io.out // Input1 -> Switches(7:4)
    io.hex3 := U_decoder7seg_3.io.out // Output -> Output(3:0)
    io.hex2 := U_decoder7seg_2.io.out // Output -> Output(7:4)
    io.hex1 := U_decoder7seg_1.io.out // Output -> Output(11:8)
    io.hex0 := U_decoder7seg_0.io.out // Output -> Output(15:12)

    /** UART to transmit instructions **/


}

object Datapath extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new Datapath, Array("--target-dir", "generated_verilog"))
}
