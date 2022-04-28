import chisel3._

class Forwarding extends Module  {
    val io = IO(new Bundle {

        // From Decode
        val rs = Input(UInt(32.W)) // reg1 addr
        val rt = Input(UInt(32.W)) // reg2 addr
        val AIn = Input(UInt(32.W)) // reg1 val
        val BIn = Input(UInt(32.W)) // reg2 val

        // From Mem
        val MemAddr = Input(UInt(32.W))
        val MemVal = Input(UInt(32.W))

        // From Writeback
        val WbAddr = Input(UInt(32.W))
        val WbVal = Input(UInt(32.W))

        val AOut = Output(UInt(32.W))
        val BOut = Output(UInt(32.W))
    })

    def forward(signal: UInt, defVal: UInt) = Mux(
        signal === io.MemAddr,
        io.MemVal,
        Mux( signal === io.WbAddr,
            io.WbVal,
            defVal
        )
    )

    io.AOut := forward(io.rs, io.AIn)
    io.BOut := forward(io.rt, io.BIn)
}
