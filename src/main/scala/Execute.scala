import chisel3._

class Execute extends Module {

    val forward = Module( new Forwarding )
    val alu = Module( new ALU )

    val io = IO(new Bundle {
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
        val MemAddr = Input(UInt(32.W))
        val MemVal = Input(UInt(32.W))

        // From WB
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
        val WriteAddrOut = Output(UInt(32.W))

        val BranchAddrOut = Output(UInt(32.W))

        // To MEM
        val DataRead2Out = Output(UInt(32.W))
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
    forward.io.rs := io.rs
    forward.io.rt := io.rt
    forward.io.AIn := io.DataRead1
    forward.io.BIn := io.DataRead2
    forward.io.MemAddr := io.MemAddr
    forward.io.MemVal := io.MemVal
    forward.io.WbAddr := io.WbAddr
    forward.io.WbVal := io.WbVal
    val B: UInt = forward.io.BOut

    // ALU
    alu.io.A := forward.io.AOut;
    alu.io.B := Mux(io.ImmEn, io.Imm, B)
    alu.io.AluOp := io.AluOp
    io.AluRes := alu.io.out
    io.zero := alu.io.zero

    // Control Out := In
    io.BranchAddrOut := io.Imm // io.NextPC // + (io.Imm << 2) ONLY NEEDED IF PC + 4
    io.DataRead2Out := io.DataRead2
    io.WriteEnOut := io.WriteEnIn
    io.ReadEnOut := io.ReadEnIn
    io.BrEnOut := io.BrEnIn
    io.WbTypeOut := io.WbTypeIn
    io.WbEnOut := io.WbEnIn

    // For MEM
    io.WriteAddrOut := B
    io.WriteRegAddr := Mux( io.ImmEn, io.rt, io.rd )
}
