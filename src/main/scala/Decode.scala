import chisel3._
import instr.InstructionMapping.WB_MEM

class Decode extends Module  {

    val regFile = Module( new RegisterFile )
    val control = Module( new Control )
    val signExtend = Module( new SignExtend )

    val io = IO(new Bundle {
        // From Fetch
        val PcCounterIn = Input(UInt(32.W))
        val Instr = Input(UInt(32.W))

        // From WB
        val WriteAddrIn = Input(UInt(32.W))
        val WriteEn = Input(UInt(1.W))
        val WriteDataIn = Input(UInt(32.W))

        // To Execute
        val AluOp = Output(UInt(32.W))
        val Imm = Output(UInt(32.W))               // IMM VAL
        val ImmSel = Output(UInt(1.W))             // IMM SEL
        val PcCounterOut = Output(UInt(32.W))      // PC + 4

        // To Mem
        val MemSel = Output(Bool())

        // To WB going back to Decode
        val WbSel = Output(UInt(1.W))               // WB SEL
        val WriteAddrOut = Output(UInt(1.W))               // WB SEL

        val DataRead1 = Output(UInt(32.W))          // RS VALUE
        val DataRead2 = Output(UInt(32.W))          // RT VALUE
    })

    // CONTROL - which takes care of the actual instruction decoding
    control.io.instr := io.Instr;
    io.AluOp := control.io.op;
    io.MemSel := control.io.MemSel
    val rd = control.io.rd;                         // RD ADDR
    val imm = control.io.imm;                       // IMM VALUE
    val immSel = control.io.immSel                  // IMM SEL
    val wbSel = control.io.WbSel                    // WB SEL

    // REGISTER FILE
    regFile.io.ReadAddr1 := control.io.rs;
    regFile.io.ReadAddr2 := control.io.rt;
    regFile.io.WriteEnable := io.WriteEn === WB_MEM;
    regFile.io.WriteAddr := io.WriteAddrIn;
    regFile.io.WriteData := io.WriteDataIn;
    io.DataRead1 := regFile.io.ReadData1;
    io.DataRead2 := regFile.io.ReadData2;

    io.PcCounterOut := io.PcCounterIn
    io.Imm := imm.asUInt;
    io.ImmSel := wbSel;
    io.WbSel := wbSel;

    signExtend.io.in := io.Instr(15, 0)
    signExtend.io.isSigned := ???
    io.Imm := signExtend.io.out
}
