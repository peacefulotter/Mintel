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
        is (0.U) { result   := "b1000000".U} // 0
        is (1.U) { result   := "b1111001".U} // 1
        is (2.U) { result   := "b0100100".U} // 2
        is (3.U) { result   := "b0110000".U} // 3
        is (4.U) { result   := "b0011001".U} // 4
        is (5.U) { result   := "b0010010".U} // 5
        is (6.U) { result   := "b0000010".U} // 6
        is (7.U) { result   := "b1111000".U} // 7
        is (8.U) { result   := "b0000000".U} // 8
        is (9.U) { result   := "b0011000".U} // 9
        is (10.U) { result  := "b0001000".U} // A
        is (11.U) { result  := "b0000011".U} // b
        is (12.U) { result  := "b1000110".U} // C
        is (13.U) { result  := "b0100001".U} // d
        is (14.U) { result  := "b0000110".U} // E
        is (15.U) { result  := "b0001110".U} // F
        //is (other) { result := "b1111111".U}
    }

    io.out := result
}