package instr

import chisel3._
import instr.InstructionFormats._

object InstructionMapping {
    val op = 0.U(6.W)

    // i-format
    def I_RS = 6.U(5.W)
    def I_RT = 11.U(5.W)
    def I_IMM = 16.U(16.W)

    // j-format
    def J_ADDR = 6.U(26.W)

    // r-format
    def R_RS = 6.U(5.W)
    def R_RT = 11.U(5.W)
    def R_RD = 16.U(5.W)
    def R_FUNCT = 26.U(6.W)

    def X = 0.U(0.W);

    // IMM SEL
    def IMM_DI = 0.U(1.W)
    def IMM_EN = 1.U(1.W)

    // WB SEL
    def WB_ALU = 0.U(1.W)
    def WB_MEM = 1.U(1.W)

    val conversion = Map(
        //         rs      rt      rd      imm     imm_sel   addr    funct     wb sel
        I -> List( I_RS,   I_RT,   X,      I_IMM,  IMM_EN,   X,      X,        WB_ALU),
        J -> List( X,      X,      X,      X,      IMM_DI,   J_ADDR, X,        WB_ALU),
        R -> List( R_RS,   R_RT,   R_RS,   X,      IMM_DI,   R_FUNCT,  WB_MEM)
    )

    val default = List( X,      X,      X,      X,      X,      X)
}
