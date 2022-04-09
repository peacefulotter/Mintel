import chisel3._

class Execute extends Module {
    val alu = Module( new ALU )

    val io = IO(new Bundle {
        // From Fetch -> Decode
        val PcCounter = Input(UInt(32.W)) // used for branch addr

        // From Decode
        val BranchAddrIn = Input(UInt(32.W)) // signal using the SignExtend
        val DataRead1 = Input(UInt(32.W))
        val DataRead2 = Input(UInt(32.W))

        // From Control
        val AluOp = Input(UInt(4.W))
        val AluSrc = Input(Bool()) // 0 = dataRead2, 1 = branchAddrIn
        // val immSel = Input(UInt(1.W)) -> chosen in control
        val MemSel = Input(UInt(1.W))
        val WbSel = Input(UInt(1.W))

        // From ALU to MEM
        val AluRes = Output(UInt(32.W))
        val BranchSel = Output(Bool())
        val WriteAddr = Output(UInt(32.W))

        val BranchAddrOut = Output(UInt(32.W)) // used for branch addr

        // To MEM
        val DataRead2Out = Output(UInt(32.W))
        val MemSelOut = Output(UInt(1.W))

        // To MEM -> WB
        val WbSelOut = Output(UInt(1.W))
    })

    alu.io.A := io.DataRead1;
    alu.io.B := Mux(io.AluSrc, io.BranchAddrIn, io.DataRead2);
    alu.io.alu_op := io.AluOp
    io.AluRes := alu.io.out
    io.BranchSel := alu.io.out === 1.U

    io.BranchAddrOut := io.PcCounter + (io.BranchAddrIn << 2)
    io.DataRead2Out := io.DataRead2;
    io.MemSelOut := io.MemSel
    io.WbSelOut := io.WbSel;
}
