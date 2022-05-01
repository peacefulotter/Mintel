import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class MintelTest extends AnyFlatSpec with ChiselScalatestTester {
  "Mintel" should "pass" in {
    test(new Mintel).withAnnotations(Seq(WriteVcdAnnotation)) { d =>
      d.io.SW.poke(12820.U) // 0011 0010 (50) 0001 0100 (20) = 00 0011 0010 0001 0100
      for (i <- 0 until 30) {
        println(i, d.io.instr.peek().litValue)
        d.clock.step()
      }

    }
  }
}