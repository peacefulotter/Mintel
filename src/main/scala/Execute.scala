import Instructions.{BR_J, IMM_Y, WB_ALU, WB_Y}
import chisel3._

class Execute extends Module {

    // val forward = Module( new Forwarding )
    val alu = Module( new ALU )

    val exec_io = IO(new Bundle {
        // From Fetch -> Decode
        val NextPC = Input(UInt(32.W)) // used for branch addr

        // From Decode
        val Imm = Input(UInt(32.W))
        val rs = Input(UInt(32.W))
        val rt = Input(UInt(32.W))
        val rd = Input(UInt(32.W))
        val DataRead1 = Input(UInt(32.W))
        val DataRead2 = Input(UInt(32.W))

        // From MEM
        val MemWbEn = Input(UInt(1.W))
        val MemWbType = Input(UInt(1.W))
        val MemAddr = Input(UInt(32.W))
        val MemVal = Input(UInt(32.W))

        // From WB
        val WbWbEn = Input(UInt(1.W))
        val WbWbType = Input(UInt(1.W))
        val WbAddr = Input(UInt(32.W))
        val WbVal = Input(UInt(32.W))

        // From Control
        val AluOp = Input(UInt(8.W))
        val ImmEn = Input(UInt(1.W))
        val StoreEnIn = Input(UInt(1.W))
        val LoadEnIn = Input(UInt(1.W))
        val BrEnIn = Input(UInt(2.W))
        val WbEnIn = Input(UInt(1.W))
        val WbTypeIn = Input(UInt(1.W))


        // From ALU to MEM
        val AluRes = Output(UInt(32.W))
        val zero = Output(Bool())

        val BranchAddrOut = Output(UInt(32.W))

        // To MEM
        val WriteData = Output(UInt(32.W))
        val StoreEnOut = Output(UInt(1.W))
        val LoadEnOut = Output(UInt(1.W))
        val BrEnOut = Output(UInt(2.W))
        // To MEM -> WB
        val WbTypeOut = Output(UInt(1.W))
        val WbEnOut = Output(UInt(1.W))
        // To MEM -> Decode
        val WriteRegAddr = Output(UInt(32.W))
    })

    // Forwarding Unit
    def forward(addr: UInt, defVal: UInt): UInt = Mux(
        addr === exec_io.MemAddr & exec_io.MemWbType === WB_ALU & exec_io.MemWbEn === WB_Y,
        exec_io.MemVal,
        Mux( addr === exec_io.WbAddr & exec_io.WbWbType === WB_ALU & exec_io.WbWbEn === WB_Y,
            exec_io.WbVal,
            defVal
        )
    )

    val isImmediate: Bool = exec_io.ImmEn === IMM_Y

    val Attr1Addr: UInt = exec_io.rs
    val Attr1Val: UInt = exec_io.DataRead1
    val Attr2Addr: UInt = exec_io.rt
    val Attr2Val: UInt = exec_io.DataRead2

    val A: UInt = forward(Attr1Addr, Attr1Val)
    val B: UInt = forward(Attr2Addr, Attr2Val)

    // ALU
    alu.io.A := A
    alu.io.B := Mux(isImmediate, exec_io.Imm, B)
    alu.io.AluOp := exec_io.AluOp
    exec_io.AluRes := alu.io.out
    exec_io.zero := alu.io.zero

    // Control Out := In
    exec_io.BranchAddrOut := exec_io.Imm + Mux(exec_io.BrEnIn === BR_J, 0.U, exec_io.NextPC)
    exec_io.BrEnOut := exec_io.BrEnIn
    exec_io.WbTypeOut := exec_io.WbTypeIn
    exec_io.WbEnOut := exec_io.WbEnIn
    exec_io.LoadEnOut := exec_io.LoadEnIn
    exec_io.StoreEnOut := exec_io.StoreEnIn

    // To Mem
    exec_io.WriteData := B // using path forwarding

    // To MEM -> Decode
    exec_io.WriteRegAddr := Mux(isImmediate, exec_io.rt, exec_io.rd)
}
