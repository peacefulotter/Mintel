import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class SignExtendTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "SignExtend"
  it should "pass" in {
    test(new SignExtend) { se =>
        // se.io.
    }
  }
}
