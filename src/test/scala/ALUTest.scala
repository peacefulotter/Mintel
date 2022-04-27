import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ALUTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ALUTest"
  it should "pass" in {
    test(new ALU).withAnnotations(Seq(WriteVcdAnnotation)) { alu =>
      var a = 0
      var b = 0

      def bubl(): Int = {
        0
      }

      def pass(a: Int, b: Int): Int = {
        a
      }

      def inc(a: Int, b: Int): Int = {
        a + 1
      }

      def dec(a: Int, b: Int): Int = {
        a - 1
      }

      def add(a: Int, b: Int): Int = {
        a + b
      }

      def sub(a: Int, b: Int): Int = {
        a - b
      }

      def not(a: Int, b: Int): Int = {
        ~a
      }

      def and(a: Int, b: Int): Int = {
        a & b
      }

      def or(a: Int, b: Int): Int = {
        a | b
      }

      def xor(a: Int, b: Int): Int = {
        a ^ b
      }

      for (j <- 0 until 10) {

        a = j
        alu.io.A.poke(a.U)

        for (k <- 0 until 10) {

          b = k
          alu.io.B.poke(b.U)
          val functions = Vector(bubl(), pass(a, b), inc(a, b), dec(a, b), add(a, b), sub(a, b), not(a, b), and(a, b), or(a, b), xor(a, b))

          for (i <- 0 until 10) {

            alu.io.alu_op.poke(i.U)

            if (functions(index = i) >= 0) { // ALU does not support negative numbers
              //alu.io.out.expect(functions(index = i).U)
            }
            alu.clock.step(1)

          }
        }
      }
    }
  }
}
