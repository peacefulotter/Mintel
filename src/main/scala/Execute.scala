import chisel3._

class Execute extends Module {
    val alu = Module( new ALU )

    val io = IO(new Bundle {
        // From Fetch -> Decode
        val PcCounter = Input(UInt(32.W)) // used for branch addr

        // From Decode
        val Imm = Input(UInt(32.W)) // signal using the SignExtend
        val DataRead1 = Input(UInt(32.W))
        val DataRead2 = Input(UInt(32.W))

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
        val WriteAddr = Output(UInt(32.W))

        val BranchAddrOut = Output(UInt(32.W))

        // To MEM
        val DataRead2Out = Output(UInt(32.W))
        val ReadEnOut = Output(UInt(1.W))
        val WriteEnOut = Output(UInt(1.W))
        val BrEnOut = Output(UInt(1.W))
        // To MEM -> WB
        val WbTypeOut = Output(UInt(1.W))
        val WbEnOut = Output(UInt(1.W))
    })

    alu.io.A := io.DataRead1;
    alu.io.B := Mux(io.ImmEn, io.Imm, io.DataRead2);
    alu.io.alu_op := io.AluOp
    io.AluRes := alu.io.out
    io.zero := alu.io.zero

    io.BranchAddrOut := io.PcCounter + (io.Imm << 2)
    io.DataRead2Out := io.DataRead2;
    io.WriteEnOut := io.WriteEnIn
    io.ReadEnOut := io.ReadEnIn
    io.BrEnOut := io.BrEnIn
    io.WbTypeOut := io.WbTypeIn
    io.WbEnOut := io.WbEnIn

    io.WriteAddr := io.DataRead2;
}
