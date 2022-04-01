import chisel3._

class Execute extends Module {
    val alu = Module( new ALU )

    val io = IO(new Bundle {
        // From Fetch -> Decode
        val pcCounter = Input(UInt(32.W)) // used for branch addr

        // From Decode
        val branchAddrIn = Input(UInt(32.W)) // signal using the SignExtend
        val dataRead1 = Input(UInt(32.W))
        val dataRead2 = Input(UInt(32.W))

        // From Control
        val aluOp = Input(UInt(4.W))
        val aluSrc = Input(Bool()) // 0 = dataRead2, 1 = branchAddrIn
        // val immSel = Input(UInt(1.W)) -> chosenBefore
        val memSel = Input(UInt(1.W))
        val wbSel = Input(UInt(1.W))

        // From ALU to MEM
        val aluRes = Output(UInt(32.W))
        val writeAddr = Output(UInt(32.W))

        val branchAddrOut = Output(UInt(32.W)) // used for branch addr

        // To MEM
        val dataRead2Out = Output(UInt(32.W))
        val memSelOut = Output(UInt(1.W))

        // To MEM -> WB
        val wbSelOut = Output(UInt(1.W))
    })



    alu.io.A := io.dataRead1;
    alu.io.B := Mux(io.aluSrc, io.branchAddrIn, io.dataRead2);
    alu.io.alu_op := io.aluOp // FIXME: PASS THIS INTO THE ALU_CONTROL
    io.aluRes := alu.io.out

    io.branchAddrOut := io.pcCounter + (io.branchAddrIn << 2)
    io.dataRead2Out := io.dataRead2;
    io.memSelOut := io.memSel
    io.wbSelOut := io.wbSel;
}
