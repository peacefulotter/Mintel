import chisel3.{fromBooleanToLiteral, fromIntToLiteral}
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class RAMTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "RAM"
    it should "pass" in {
        test(new RAM).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
            c.clock.setTimeout(0)

            c.ram_io.Addr.poke(0.U);
            c.ram_io.ReadEn.poke(true.B)

            // Read at 0x0
            c.clock.step(1)
            val r2 = c.ram_io.ReadData.peek().litValue
            println(r2)

            // Write 4 at 0x0
            c.clock.step(1)
            c.ram_io.ReadEn.poke(true.B);
            c.ram_io.WriteEn.poke(true.B);
            c.ram_io.WriteData.poke(4.U);
            println(c.ram_io.ReadData.peek().litValue);

            // Read at 0x0
            c.clock.step(1);
            c.ram_io.ReadEn.poke(true.B);
            val r3 = c.ram_io.ReadData.peek().litValue;
            println(r3)
        }
    }
}
