import chisel3._
import chisel3.util._


class decoder7seg extends Module {
    val io = IO(new Bundle {
        val in = Input(UInt(4.W))
        val out = Output(UInt(7.W))
    })

    val sel = io.in
    val result = WireDefault(0.U(7.W))

    switch(sel) {
        is (0.U) { result   := "b0000001".U}
        is (1.U) { result   := "b1001111".U}
        is (2.U) { result   := "b0010010".U}
        is (3.U) { result   := "b0000110".U}
        is (4.U) { result   := "b1001100".U}
        is (5.U) { result   := "b0100100".U}
        is (6.U) { result   := "b0100000".U}
        is (7.U) { result   := "b0001111".U}
        is (8.U) { result   := "b0000000".U}
        is (9.U) { result   := "b0001100".U}
        is (10.U) { result  := "b0001000".U}
        is (11.U) { result  := "b1100000".U}
        is (12.U) { result  := "b0110001".U}
        is (13.U) { result  := "b1000010".U}
        is (14.U) { result  := "b0110000".U}
        is (15.U) { result  := "b0111000".U}
        //is (other) { result := "b1111111".U}
    }

    io.out := result
}