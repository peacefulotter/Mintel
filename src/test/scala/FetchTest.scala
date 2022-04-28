import chisel3.{fromBooleanToLiteral, fromIntToLiteral}
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class FetchTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "Fetch"
    it should "pass" in {
        test(new Fetch) { f =>
            f.io.BranchAddr.poke(1.U)
            f.io.BrEn.poke(true.B)
            f.clock.setTimeout(0)

            f.clock.step(1)
            val pc1 = f.io.NextPC.peek().litValue
            val in1 = f.io.Instr.peek().litValue
            println(pc1)
            println(in1)

            f.clock.step(1)
            f.io.BranchAddr.poke(2.U);
            f.io.BrEn.poke(false.B);

            f.clock.step(1);
            val pc2 = f.io.NextPC.peek().litValue;
            val in2 = f.io.Instr.peek().litValue
            println(pc2)
            println(in2)
        }
    }
}