import Instructions.WB_MEM
import chisel3._

class Decode extends Module  {

    val regFile = Module( new RegisterFile )
    val control = Module( new Control )
    val signExtend = Module( new SignExtend )

    val dec_io = IO(new Bundle {
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
        val rs = Output(UInt(6.W))
        val rt = Output(UInt(6.W))
        val rd = Output(UInt(6.W))

        val DataRead1 = Output(UInt(32.W))          // RS VALUE
        val DataRead2 = Output(UInt(32.W))          // RT VALUE
    })

    // CONTROL - which takes care of the actual instruction decoding
    control.io.instr := dec_io.Instr;

    dec_io.rs := control.io.rs
    dec_io.rt := control.io.rt
    dec_io.rd := control.io.rd
    dec_io.Imm := control.io.imm;
    dec_io.AluOp := control.io.AluOp;
    dec_io.BrEn := control.io.BrEn
    dec_io.ReadEn := control.io.LoadEn
    dec_io.ImmEn := control.io.ImmEn;
    dec_io.WriteEnOut := control.io.StoreEn;
    dec_io.WbType := control.io.WbType;
    dec_io.WbEn := control.io.WbEn;

    // REGISTER FILE
    regFile.io.ReadAddr1 := control.io.rs;
    regFile.io.ReadAddr2 := control.io.rt;
    regFile.io.WriteEnable := dec_io.WriteEnIn === WB_MEM;
    regFile.io.WriteAddr := dec_io.WriteAddrIn;
    regFile.io.WriteData := dec_io.WriteDataIn;

    dec_io.DataRead1 := regFile.io.ReadData1;
    dec_io.DataRead2 := regFile.io.ReadData2;

    dec_io.NextPCOut := dec_io.NextPCIn

    signExtend.io.in := dec_io.Instr(15, 0)
    signExtend.io.isSigned := true.B // FIXME: Unsigned arithmetic
    dec_io.Imm := signExtend.io.out
}
