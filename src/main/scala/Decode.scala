import chisel3._
import instr.InstructionMapping.WB_MEM

class Decode extends Module  {

    val regFile = Module( new RegisterFile )
    val control = Module( new Control )
    val signExtend = Module( new SignExtend )

    val io = IO(new Bundle {
        // From Fetch
        val pcCounter = Input(UInt(32.W))
        val instr = Input(UInt(32.W))

        // From WB
        val WriteAddr = Input(UInt(32.W))
        val WriteEn = Input(UInt(1.W))
        val InWriteData = Input(UInt(32.W))

        // To Execute
        val imm = Output(UInt(32.W))               // IMM VAL
        val immSel = Output(UInt(1.W))             // IMM SEL
        val pcCounterOut = Output(UInt(32.W))      // PC + 4
        val branchAddrDelta = Output(UInt(32.W))

        // To WB going back to Decode
        val OutWriteAddr = Output(UInt(32.W))       // RD ADDR
        val wbSel = Output(UInt(1.W))               // WB SEL

        val DataRead1 = Output(UInt(32.W))          // RS VALUE
        val DataRead2 = Output(UInt(32.W))          // RT VALUE
    })

    // CONTROL - which takes care of the actual instruction decoding
    control.io.instr := io.instr;
    val op = control.io.op;
    val rs = control.io.rs;                         // RS ADDR
    val rt = control.io.rt;                         // RT ADDR
    val rd = control.io.rd;                         // RD ADDR
    val imm = control.io.imm;                       // IMM VALUE
    val immSel = control.io.immSel                  // IMM SEL
    val wbSel = control.io.wbSel                    // WB SEL

    // REGISTER FILE
    regFile.io.ReadAddr1 := rs;
    regFile.io.ReadAddr2 := rt;
    regFile.io.WriteEnable := io.WriteEn === WB_MEM;
    regFile.io.WriteAddr := io.WriteAddr;
    regFile.io.WriteData := io.InWriteData;
    io.DataRead1 := regFile.io.ReadData1;
    io.DataRead2 := regFile.io.ReadData2;

    io.pcCounterOut := io.pcCounterOut
    io.imm := imm.asUInt;
    io.immSel := wbSel;
    io.OutWriteAddr := rd;
    io.wbSel := wbSel;

    signExtend.io.in := io.instr(15, 0)
    signExtend.io.isSigned := ???
    io.branchAddrDelta := signExtend.io.out
}
