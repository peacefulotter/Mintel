import Chisel.MuxLookup
import chisel3._
import chisel3.util.Cat
import uart._

class Mintel extends Module {
    val io = IO( new Bundle {
        val SW = Input(UInt(18.W))
        // Input 1
        // 7:AB26, 6:AD26, 5:AC26, 4:AB27, 3:AD27, 2:AC27, 1:AC28, 0:AB28
        // Input 2
        // 7:AA22, 6:AA23, 5:AA24, 4:AB23, 3:AB24, 2:AC24, 1:AB25, 0:AC25

        val instr = Output(UInt(32.W))

        val txd_instr = Output(UInt(1.W)) // G9

        // Input 1 Display
        val hex7     = Output(UInt(7.W)) // 6:AA14, 5:AG18, 4:AF17, 3:AH17, 2:AG17, 1:AE17, 0:AD17
        val hex6     = Output(UInt(7.W)) // 6:AC17, 5:AA15, 4:AB15, 3:AB17, 2:AA16, 1:AB16, 0:AA17

        // Input 2 Display
        val hex5     = Output(UInt(7.W)) // 6:AH18, 5:AF18, 4:AG19, 3:AH19, 2:AB18, 1:AC18, 0:AD18
        val hex4     = Output(UInt(7.W)) // 6:AE18, 5:AF19, 4:AE19, 3:AH21, 2:AG21, 1:AA19, 0:AB19

        // Output Display
        val hex3     = Output(UInt(7.W)) // 6:Y19, 5:AF23, 4:AD24, 3:AA21, 2:AB20, 1:U21, 0:V21
        val hex2     = Output(UInt(7.W)) // 6:W28, 5:W27, 4:Y26, 3:W26, 2:Y25, 1:AA26, 0:AA25
        val hex1     = Output(UInt(7.W)) // 6:U24, 5:U23, 4:W25, 3:W22, 2:W21, 1:Y22, 0:M24
        val hex0     = Output(UInt(7.W)) // 6:H22, 5:J22, 4:L25, 3:L26, 2:E17, 1:F22, 0:G18

        // Just there in case we decide to use them
        val LEDR  = Output(UInt(18.W))
        // 17:H15, 16:G16, 15:G15, 14:F15, 13:H17, 12:J16, 11:H16, 10:J15, 9:G17, 8:J17, 8:H19, 7:H19, 6:J19, 5:E18, 4:F18, 3:F21, 2:E19, 1:F19, 0:G19
        val LEDG  = Output(UInt(8.W))
        // 8:F17 7:G21, 6:G22, 5:G20, 4:H21, 3:E24, 2:E25, 1:E22, 0:E21
        val KEY   = Input(UInt(4.W))
        // 3:R24, 2:N21, 1:M21, 0:M23

//        val string = Output(UInt(8.W))
    }
    )

    val datapath = Module( new Datapath )

    io.instr     := datapath.io.instr

    val Inport1  = io.SW(7,0)
    val Inport2  = io.SW(15,8)
    val Outport  = WireDefault(0.U(32.W))

    datapath.io.Inport1 := Inport1
    datapath.io.Inport2 := Inport2

    when ( datapath.io.Outport =/= 0.U) {
        Outport := datapath.io.Outport
    }

    /** 7-Seg Displays **/
    val U_decoder7seg_7 = Module( new decoder7seg )
    val U_decoder7seg_6 = Module( new decoder7seg )
    val U_decoder7seg_5 = Module( new decoder7seg )
    val U_decoder7seg_4 = Module( new decoder7seg )
    val U_decoder7seg_3 = Module( new decoder7seg )
    val U_decoder7seg_2 = Module( new decoder7seg )
    val U_decoder7seg_1 = Module( new decoder7seg )
    val U_decoder7seg_0 = Module( new decoder7seg )

    U_decoder7seg_7.io.in := Inport1(7,4)
    U_decoder7seg_6.io.in := Inport1(3,0)
    U_decoder7seg_5.io.in := Inport2(7,4)
    U_decoder7seg_4.io.in := Inport2(3,0)

    U_decoder7seg_3.io.in := Outport(15,12)
    U_decoder7seg_2.io.in := Outport(11,8)
    U_decoder7seg_1.io.in := Outport(7,4)
    U_decoder7seg_0.io.in := Outport(3,0)

    io.hex7 := U_decoder7seg_7.io.out // Input1 -> Switches(3:0)
    io.hex6 := U_decoder7seg_6.io.out // Input1 -> Switches(7:4)
    io.hex5 := U_decoder7seg_5.io.out // Input1 -> Switches(3:0)
    io.hex4 := U_decoder7seg_4.io.out // Input1 -> Switches(7:4)
    io.hex3 := U_decoder7seg_3.io.out // Output -> Output(3:0)
    io.hex2 := U_decoder7seg_2.io.out // Output -> Output(7:4)
    io.hex1 := U_decoder7seg_1.io.out // Output -> Output(11:8)
    io.hex0 := U_decoder7seg_0.io.out // Output -> Output(15:12)


    /** UART to transmit instructions **/
    val tx = Module(new BufferedTx(50000000, 115200))
    io.txd_instr := tx.io.txd

    val cntReg2 = RegInit(0.U(8.W))

    val instr_bit7 = tohex_inascii(io.instr.apply(31,28))
    val instr_bit6 = tohex_inascii(io.instr.apply(27,24))
    val instr_bit5 = tohex_inascii(io.instr.apply(23,20))
    val instr_bit4 = tohex_inascii(io.instr.apply(19,16))
    val instr_bit3 = tohex_inascii(io.instr.apply(15,12))
    val instr_bit2 = tohex_inascii(io.instr.apply(11,8))
    val instr_bit1 = tohex_inascii(io.instr.apply(7,4))
    val instr_bit0 = tohex_inascii(io.instr.apply(3,0))

    val string = Concat(instr_bit0, instr_bit1, instr_bit2, instr_bit3, instr_bit4, instr_bit5, instr_bit6, instr_bit7)

    val text = VecInit(string)

    val len = 64.U

    tx.io.channel.bits := text(cntReg2)
    tx.io.channel.valid := cntReg2 =/= len

    when(tx.io.channel.ready && cntReg2 =/= len) {
        println(cntReg2)
        cntReg2 := cntReg2 + 1.U
    } .elsewhen(cntReg2 === len){
        cntReg2 := 0.U
    }


    // not use for anything
    val LEDG      = WireDefault(0.U(8.W))
    io.LEDR       := io.SW
    LEDG          := Cat(~io.KEY, ~io.KEY)
    io.LEDG       := LEDG

    def tohex_inascii(in: UInt): UInt   = {

        val nibble = in & 0xf.U

        val format: UInt = MuxLookup(nibble, '0'.U(8.W) + nibble, Seq(
            10.U -> 'A'.U,
            11.U -> 'B'.U,
            12.U -> 'C'.U,
            13.U -> 'D'.U,
            14.U -> 'E'.U,
            15.U -> 'F'.U
        ))
        format
    }
    def Concat(in0:UInt, in1:UInt, in2:UInt, in3:UInt, in4:UInt, in5:UInt, in6:UInt, in7:UInt): UInt ={
        val temp0 = Cat(in7, Cat(in6, Cat(in5, Cat(in4, Cat(in3, Cat(in2, Cat(in1, in0)))))))
        temp0
    }
}

object Mintel extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new Mintel, Array("--target-dir", "generated_verilog"))
}
