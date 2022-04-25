import chisel3.{fromBooleanToLiteral, fromIntToLiteral}
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class RAMTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "RAM"
  it should "pass" in {
    test(new RAM) { c =>
      c.clock.setTimeout(0)
      println("Start the blinking LED")

      c.io.addr.poke(0.U);
      c.io.readEn.poke(true.B)

      // Read at 0x0
      c.clock.step(1)
      val r2 = c.io.readData.peek().litValue
      println(r2)

      // Write 4 at 0x0
      c.clock.step(1)
      c.io.writeEn.poke(true.B);
      c.io.writeData.poke(4.U);

      // Read at 0x0
      c.clock.step(1);
      val r3 = c.io.readData.peek().litValue;
      println(r3)

      println("\nEnd the blinking LED")
    }
  }
}
