import chisel3._

class Forwarding extends Module  {
    val io = IO(new Bundle {

        // From Decode
        val Attr1Addr = Input(UInt(32.W)) // reg1 addr
        val Attr2Addr = Input(UInt(32.W)) // reg2 addr
        val Attr1ValIn = Input(UInt(32.W)) // reg1 val
        val Attr2ValIn = Input(UInt(32.W)) // reg2 val

        // From Mem
        val MemWbEn = Input(UInt(1.W))
        val MemAddr = Input(UInt(32.W))
        val MemVal = Input(UInt(32.W))

        // From Writeback
        val WbWbEn = Input(UInt(1.W))
        val WbAddr = Input(UInt(32.W))
        val WbVal = Input(UInt(32.W))

        val Attr1ValOut = Output(UInt(32.W))
        val Attr2ValOut = Output(UInt(32.W))
    })


}
