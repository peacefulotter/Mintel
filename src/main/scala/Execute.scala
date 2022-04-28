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
        val MemAddr = Input(UInt(32.W))
        val MemVal = Input(UInt(32.W))

        // From WB
        val WbWbEn = Input(UInt(1.W))
        val WbAddr = Input(UInt(32.W))
        val WbVal = Input(UInt(32.W))

        // From Control
        val AluOp = Input(UInt(4.W))
        val ImmEn = Input(Bool()) // 0 = dataRead2, 1 = Imm
        val WriteEnIn = Input(UInt(1.W))
        val ReadEnIn = Input(UInt(1.W))
        val BrEnIn = Input(UInt(1.W))
        val WbEnIn = Input(UInt(1.W))
        val WbTypeIn = Input(UInt(1.W))

        // From ALU to MEM
        val AluRes = Output(UInt(32.W))
        val zero = Output(Bool())

        val BranchAddrOut = Output(UInt(32.W))

        // To MEM
        val WriteData = Output(UInt(32.W))
        val ReadEnOut = Output(UInt(1.W))
        val WriteEnOut = Output(UInt(1.W))
        val BrEnOut = Output(UInt(1.W))
        // To MEM -> WB
        val WbTypeOut = Output(UInt(1.W))
        val WbEnOut = Output(UInt(1.W))
        // To MEM -> Decode
        val WriteRegAddr = Output(UInt(32.W))
    })

    // Forwarding Unit
    /*forward.io.Attr1Addr := Attr1Addr
    forward.io.Attr2Addr := Attr2Addr
    forward.io.Attr1ValIn := Attr1Val
    forward.io.Attr2ValIn := Attr2Val
    forward.io.MemWbEn := exec_io.MemWbEn;
    forward.io.MemAddr := exec_io.MemAddr
    forward.io.MemVal := exec_io.MemVal
    forward.io.WbWbEn := exec_io.WbWbEn;
    forward.io.WbAddr := exec_io.WbAddr
    forward.io.WbVal := exec_io.WbVal
    val A: UInt = forward.io.Attr1ValOut
    val B: UInt = forward.io.Attr2ValOut*/

    def forward(addr: UInt, defVal: UInt): UInt = Mux(
        addr === exec_io.MemAddr & exec_io.MemWbEn === 1.U,
        exec_io.MemVal,
        Mux( addr === exec_io.WbAddr & exec_io.WbWbEn === 1.U,
            exec_io.WbVal,
            defVal
        )
    )

    val isImmediate: Bool = exec_io.ImmEn === 1.U

    val Attr1Addr: UInt = exec_io.rs
    val Attr1Val: UInt = exec_io.DataRead1
    val Attr2Addr: UInt = exec_io.rt
    val Attr2Val: UInt = exec_io.DataRead2

    val A: UInt = forward(Attr1Addr, Attr1Val)
    val B: UInt = forward(Attr2Addr, Attr2Val)

    // ALU
    alu.io.A := A
    alu.io.B := Mux(exec_io.ImmEn, exec_io.Imm, B)
    alu.io.AluOp := exec_io.AluOp
    exec_io.AluRes := alu.io.out
    exec_io.zero := alu.io.zero

    // Control Out := In
    exec_io.BranchAddrOut := exec_io.Imm // io.NextPC // + (io.Imm << 2) ONLY NEEDED IF PC + 4
    exec_io.BrEnOut := exec_io.BrEnIn
    exec_io.WbTypeOut := exec_io.WbTypeIn
    exec_io.WbEnOut := exec_io.WbEnIn
    exec_io.ReadEnOut := exec_io.ReadEnIn
    exec_io.WriteEnOut := exec_io.WriteEnIn

    // To Mem
    exec_io.WriteData := B // using path forwarding

    // To MEM -> Decode
    exec_io.WriteRegAddr := Mux(isImmediate, exec_io.rt, exec_io.rd)
}
