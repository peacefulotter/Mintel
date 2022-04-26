import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ControlTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Control"
  it should "pass" in {
    test(new Control) { ctrl =>
      // ctrl.io.instr.poke()
    }
  }
}
