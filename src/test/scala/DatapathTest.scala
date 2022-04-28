import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class DatapathTest extends AnyFlatSpec with ChiselScalatestTester {
    "Datapath" should "pass" in {
        test(new Datapath).withAnnotations(Seq(WriteVcdAnnotation)) { d =>

            for (i <- 0 until 10) {
                println(i)
                println(d.io.instr.peek())
                println(d.io.WriteData.peek())
                println(d.io.ReadData.peek())
                d.clock.step(1)
            }

        }
    }
}
