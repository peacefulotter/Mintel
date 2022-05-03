import Instructions.{BR_J, BR_Y}
import chisel3._
import chisel3.util.MuxCase

class Mem extends Module {

    val ram = Module( new RAM );


    val Inport1 = Module( new EnRegister(8) ) // 1021
    val Inport2 = Module( new EnRegister(8) ) // 1022
    val Outport = Module( new EnRegister(16) ) // 1023

    val Inport1Addr = 1021.U
    val Inport2Addr = 1022.U
    val OutportAddr = 1023.U

    val mem_io = IO(new Bundle {
        // Switches
        val Inport1 = Input(UInt(8.W))
        val Inport2 = Input(UInt(8.W))

        val Outport = Output(UInt(32.W))

        // From Control
        val WbEnIn = Input(UInt(1.W))
        val WbTypeIn = Input(UInt(1.W))
        val LoadEnIn = Input(UInt(1.W))
        val StoreEn = Input(UInt(1.W))
        val CtrlBrEn = Input(UInt(2.W))

        val BrAddrIn = Input(UInt(32.W))
        val AluBrEn = Input(Bool())
        val WriteRegAddrIn = Input(UInt(32.W))

        // From Execute
        val WriteData = Input(UInt(32.W))
        val AddrIn = Input(UInt(32.W))

        // To WB
        val LoadEnOut = Output(UInt(1.W))
        val ReadData = Output(UInt(32.W))
        val WbTypeOut = Output(UInt(1.W))
        val WbEnOut = Output(UInt(1.W))
        val AddrOut = Output(UInt(32.W))
        // To WB -> Decode
        val WriteRegAddrOut = Output(UInt(32.W))

        // Datapath -> To Fetch
        val BrAddrOut = Output(UInt(32.W))
        val BrEnOut = Output(UInt(2.W))
    })

    val AddrSel = MuxCase( 0.U, Array(
        (mem_io.AddrIn === Inport1Addr) -> 1.U, // Switches1
        (mem_io.AddrIn === Inport2Addr) -> 2.U, // Switches2
        (mem_io.AddrIn === OutportAddr) -> 3.U, // Outport
    ) )

    Inport1.io.DataIn := mem_io.Inport1
    Inport1.io.WrEn := true.B // := mem_io.WriteEn & AddrSel === 1.U
    Inport2.io.DataIn := mem_io.Inport2
    Inport2.io.WrEn := true.B // := mem_io.WriteEn & AddrSel === 2.U
    Outport.io.DataIn := mem_io.WriteData
    Outport.io.WrEn := mem_io.StoreEn & AddrSel === 3.U

    mem_io.Outport := Outport.io.DataOut

    ram.ram_io.Addr := mem_io.AddrIn
    ram.ram_io.ReadEn := (mem_io.LoadEnIn & AddrSel === 0.U)
    ram.ram_io.WriteEn := (mem_io.StoreEn & AddrSel === 0.U)
    ram.ram_io.WriteData := mem_io.WriteData
    mem_io.ReadData := MuxCase( ram.ram_io.ReadData, Array(
        (mem_io.AddrIn === Inport1Addr) -> Inport1.io.DataOut, // Switches1
        (mem_io.AddrIn === Inport2Addr) -> Inport2.io.DataOut, // Switches2
        (mem_io.AddrIn === OutportAddr) -> Outport.io.DataOut, // Outport
    ) )

    mem_io.BrAddrOut := mem_io.BrAddrIn

    mem_io.LoadEnOut := mem_io.LoadEnIn
    mem_io.WbTypeOut := mem_io.WbTypeIn
    mem_io.WbEnOut := mem_io.WbEnIn
    mem_io.AddrOut := mem_io.AddrIn

    mem_io.BrEnOut := (mem_io.CtrlBrEn === BR_J) | (mem_io.AluBrEn & (mem_io.CtrlBrEn === BR_Y))

    mem_io.WriteRegAddrOut := mem_io.WriteRegAddrIn
}
