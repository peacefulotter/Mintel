import chisel3._

class RegisterFile extends Module {

    val regs = Mem(32, UInt(32.W))

    val io = IO(new Bundle {
        val ReadAddr1  = Input(UInt(5.W))
        val ReadAddr2  = Input(UInt(5.W))
        val WriteAddr = Input(UInt(5.W))
        val WriteData = Input(UInt(32.W));
        val WriteEnable = Input(Bool())

        val ReadData1 = Output(UInt(32.W))
        val ReadData2 = Output(UInt(32.W))
    })

    when ( io.WriteEnable & io.WriteAddr.orR ) {
        regs( io.WriteAddr ) := io.WriteData
    }

    io.ReadData1 := Mux(io.ReadAddr1.orR, regs( io.ReadAddr1 ), 0.U)
    io.ReadData2 := Mux(io.ReadAddr2.orR, regs( io.ReadAddr2 ), 0.U)
}
