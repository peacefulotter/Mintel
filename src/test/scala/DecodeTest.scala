import chisel3.{fromBooleanToLiteral, fromIntToLiteral}
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class DecodeTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Decode"
  it should "pass" in {
    test(new Decode) { d =>
        // d.io.
    }
  }
}
