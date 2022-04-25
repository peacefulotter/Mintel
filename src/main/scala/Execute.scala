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
        val ImmSel = Input(Bool()) // 0 = dataRead2, 1 = Imm
        val WriteSelIn = Input(UInt(1.W))
        val ReadSelIn = Input(UInt(1.W))
        val BranchSelIn = Input(UInt(1.W))
        val WbSel = Input(UInt(1.W))

        // From ALU to MEM
        val AluRes = Output(UInt(32.W))
        val BranchCond = Output(Bool())
        val WriteAddr = Output(UInt(32.W))

        val BranchAddrOut = Output(UInt(32.W)) // used for branch addr

        // To MEM
        val DataRead2Out = Output(UInt(32.W))
        val ReadSelOut = Output(UInt(1.W))
        val WriteSelOut = Output(UInt(1.W))
        val BranchSelOut = Output(UInt(1.W))

        // To MEM -> WB
        val WbSelOut = Output(UInt(1.W))
    })

    alu.io.A := io.DataRead1;
    alu.io.B := Mux(io.ImmSel, io.Imm, io.DataRead2);
    alu.io.alu_op := io.AluOp
    io.AluRes := alu.io.out
    io.BranchCond := alu.io.out === 1.U

    io.BranchAddrOut := io.PcCounter + (io.Imm << 2)
    io.DataRead2Out := io.DataRead2;
    io.WriteSelOut := io.WriteSelIn
    io.ReadSelOut := io.ReadSelIn
    io.BranchSelOut := io.BranchSelIn
    io.WbSelOut := io.WbSel;

    io.WriteAddr := io.DataRead2;
}
