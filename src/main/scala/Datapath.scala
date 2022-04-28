

import chisel3._;

class Datapath extends Module {
    val fetch = Module( new Fetch )
    val decode = Module( new Decode )
    val execute = Module( new Execute )
    val memory = Module( new Mem )
    val writeback = Module( new Writeback )

    val io = IO( new Bundle {
        val switches1 = Input(UInt(8.W)) // Input 1
        val switches2 = Input(UInt(8.W)) // Input 2

        val instr     = Output(UInt(32.W))

        // Input 1
        val disp0     = Output(UInt(6.W))
        val disp1     = Output(UInt(6.W))

        // Input 2
        val disp2     = Output(UInt(6.W))
        val disp3     = Output(UInt(6.W))

        // Output
        val disp4     = Output(UInt(6.W))
        val disp5     = Output(UInt(6.W))
        val disp6     = Output(UInt(6.W))
        val disp7     = Output(UInt(6.W))
    } )

    val input1 = io.switches1
    val input2 = io.switches2
    val output = WireDefault(0.U(32.W))
    output := execute.io.AluRes

    io.instr := fetch.io.Instr;

    /** FETCH **/
    fetch.io.Stall := decode.io.BrEn // stall for 2 CC if branching occurs (1 + reg update)
    fetch.io.BrEn := memory.io.BrEnOut
    fetch.io.BranchAddr := memory.io.BrAddrOut

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

    /** 7-Seg Displays **/
    val U_decoder7seg_0 = Module( new decoder7seg )
    val U_decoder7seg_1 = Module( new decoder7seg )
    val U_decoder7seg_2 = Module( new decoder7seg )
    val U_decoder7seg_3 = Module( new decoder7seg )
    val U_decoder7seg_4 = Module( new decoder7seg )
    val U_decoder7seg_5 = Module( new decoder7seg )
    val U_decoder7seg_6 = Module( new decoder7seg )
    val U_decoder7seg_7 = Module( new decoder7seg )

    U_decoder7seg_0.io.in := input1(3,0)
    U_decoder7seg_1.io.in := input1(7,4)
    U_decoder7seg_2.io.in := input2(3,0)
    U_decoder7seg_3.io.in := input2(7,4)

    U_decoder7seg_4.io.in := output(3,0)
    U_decoder7seg_5.io.in := output(7,4)
    U_decoder7seg_6.io.in := output(11,8)
    U_decoder7seg_7.io.in := output(15,12)

    io.disp0 := U_decoder7seg_0.io.out // Input1 -> Switches(3:0)
    io.disp1 := U_decoder7seg_1.io.out // Input1 -> Switches(7:4)
    io.disp2 := U_decoder7seg_2.io.out // Input1 -> Switches(3:0)
    io.disp3 := U_decoder7seg_3.io.out // Input1 -> Switches(7:4)
    io.disp4 := U_decoder7seg_4.io.out // Output -> Output(3:0)
    io.disp5 := U_decoder7seg_5.io.out // Output -> Output(7:4)
    io.disp6 := U_decoder7seg_6.io.out // Output -> Output(11:8)
    io.disp7 := U_decoder7seg_7.io.out // Output -> Output(15:12)



}
