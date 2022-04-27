import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class DatapathTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "Datapath"
    it should "pass" in {
        test(new Datapath).withAnnotations(Seq(WriteVcdAnnotation)) { d =>
            println(d.io.instr.peek())
            d.clock.step(1)
            println(d.io.instr.peek())
            d.clock.step(1)
            println(d.io.instr.peek())
            d.clock.step(1)
            println(d.io.instr.peek())
            d.clock.step(1)
            println(d.io.instr.peek())
            d.clock.step(1)
            println(d.io.instr.peek())
            d.clock.step(1)
            println(d.io.instr.peek())
            d.clock.step(1)
        }
    }
}
