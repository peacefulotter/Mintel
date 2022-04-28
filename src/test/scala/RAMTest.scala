import chisel3.{fromBooleanToLiteral, fromIntToLiteral}
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class RAMTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "RAM"
    it should "pass" in {
        test(new RAM).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
            c.clock.setTimeout(0)

            c.io.Addr.poke(0.U);
            c.io.ReadEn.poke(true.B)

            // Read at 0x0
            c.clock.step(1)
            val r2 = c.io.ReadData.peek().litValue
            println(r2)

            // Write 4 at 0x0
            c.clock.step(1)
            c.io.ReadEn.poke(true.B);
            c.io.WriteEn.poke(true.B);
            c.io.WriteData.poke(4.U);
            println(c.io.ReadData.peek().litValue);

            // Read at 0x0
            c.clock.step(1);
            c.io.ReadEn.poke(true.B);
            val r3 = c.io.ReadData.peek().litValue;
            println(r3)
        }
    }
}
