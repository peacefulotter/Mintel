import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ALUTest extends AnyFlatSpec with ChiselScalatestTester {
  "ALU" should "pass" in {

    test(new ALU) { dut =>
      var a = 0
      var b = 0

      def add(a: Int, b: Int): Int   = {a + b}
      def sub(a: Int, b: Int): Int   = {a - b}
      def and(a: Int, b: Int): Int   = {a & b}
      def or (a: Int, b: Int): Int   = {a | b}
      def xor(a: Int, b: Int): Int   = {a ^ b}

      def sll(a: Int, b: Int): Int   = {a << b}
      def srl(a: Int, b: Int): Int   = {a >> b}
      //def slt(a: Int, b: Int): Int   = {(a.asSInt < b.asSInt).litValue.toInt}

      for (j <- 0 until 10) {

        a = j
        dut.io.A.poke(a.U)

        println("A = " + a.toString)

        for (k <- 0 until 10) {

          b = k
          dut.io.B.poke(b.U)

          println("B = " + b.toString)

          val functions = Vector(add(a,b), sub(a,b), and(a,b), or(a,b), xor(a,b), sll(a,b), srl(a,b))
          //al functions = Vector(add(a,b), sub(a,b), and(a,b), or(a,b), xor(a,b))

          for (i <- 0 until functions.length) {

            println("AluOp = " + i.toString)
            dut.io.AluOp.poke(i.U)

            println("Result should be = " + functions(i).toString)
            println("Result is = " + dut.io.out.peek().litValue)

            if(functions(i) >= 0){    // ALU does not support negative numbers
              dut.io.out.expect(functions(i).U)
            }
            dut.clock.step()

          }
        }
      }


//      dut.io.A.poke(1.U)
//      dut.io.B.poke(2.U)
//      dut.io.AluOp.poke(ALU.add)
//      dut.clock.step()
//
//      dut.io.out.expect(3.U)
//      println("Addition passes since " + dut.io.A.toString() + "+" + dut.io.B + " is indeed ")
//
//      dut.io.A.poke(1.U)
//      dut.io.B.poke(2.U)
//      dut.io.AluOp.poke(ALU.add)
//      dut.clock.step()
//
//      dut.io.out.expect(3.U)
//      println("")
    }
  }
}