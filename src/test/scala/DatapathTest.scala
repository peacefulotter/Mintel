import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class DatapathTest extends AnyFlatSpec with ChiselScalatestTester {
    "Datapath" should "pass" in {
        test(new Datapath).withAnnotations(Seq(WriteVcdAnnotation)) { d =>

            for (i <- 0 until 10) {
                println(i, d.io.instr.peek().litValue)
                d.clock.step()
            }

        }
    }
}
