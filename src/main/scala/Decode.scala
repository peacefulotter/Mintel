import Instructions.WB_MEM
import chisel3._

class Decode extends Module  {

    val regFile = Module( new RegisterFile )
    val control = Module( new Control )
    val signExtend = Module( new SignExtend )

    val io = IO(new Bundle {
        // From Fetch
        val Instr = Input(UInt(32.W))
        val NextPCIn = Input(UInt(32.W))

        // From WB
        val WriteAddrIn = Input(UInt(32.W))
        val WriteEnIn = Input(UInt(1.W))
        val WriteDataIn = Input(UInt(32.W))

        // To Execute
        val AluOp = Output(UInt(32.W))
        val Imm = Output(UInt(32.W))               // IMM VAL
        val ImmEn = Output(UInt(1.W))              // IMM SEL
        val BrEn = Output(UInt(1.W))
        val NextPCOut = Output(UInt(32.W))      // PC + 4

        // To Mem
        val ReadEn = Output(Bool())
        val WriteEnOut = Output(Bool())

        // To WB going back to Decode
        val WbType = Output(UInt(1.W))
        val WbEn = Output(UInt(1.W))
        val rd = Output(UInt(6.W))
        val rt = Output(UInt(6.W))

        val DataRead1 = Output(UInt(32.W))          // RS VALUE
        val DataRead2 = Output(UInt(32.W))          // RT VALUE
    })

    // CONTROL - which takes care of the actual instruction decoding
    control.io.instr := io.Instr;
    io.rd := control.io.rd
    io.rt := control.io.rt
    io.Imm := control.io.imm;
    io.AluOp := control.io.AluOp;
    io.BrEn := control.io.BrEn
    io.ReadEn := control.io.LoadEn
    io.ImmEn := control.io.ImmEn;
    io.WriteEnOut := control.io.StoreEn;
    io.WbType := control.io.WbType;
    io.WbEn := control.io.WbEn;

    // REGISTER FILE
    regFile.io.ReadAddr1 := control.io.rs;
    regFile.io.ReadAddr2 := control.io.rt;
    regFile.io.WriteEnable := io.WriteEnIn === WB_MEM;
    regFile.io.WriteAddr := io.WriteAddrIn;
    regFile.io.WriteData := io.WriteDataIn;

    io.DataRead1 := regFile.io.ReadData1;
    io.DataRead2 := regFile.io.ReadData2;

    io.NextPCOut := io.NextPCIn

    signExtend.io.in := io.Instr(15, 0)
    signExtend.io.isSigned := true.B // FIXME: Unsigned arithmetic
    io.Imm := signExtend.io.out
}
