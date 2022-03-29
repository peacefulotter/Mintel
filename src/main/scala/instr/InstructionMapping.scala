package instr

import chisel3._
import instr.InstructionFormats._

object InstructionMapping {
    val op = 0.U(6.W)

    // i-format
    val I_RS = 6.U(5.W)
    val I_RT = 11.U(5.W)
    val I_IMM = 16.U(16.W)

    // j-format
    val J_ADDR = 6.U(26.W)

    // r-format
    val R_RS = 6.U(5.W)
    val R_RT = 11.U(5.W)
    val R_RD = 16.U(5.W)
    val R_FUNCT = 26.U(6.W)

    val X = 0.U(0.W);

    val conversion = Map(
        I -> List( I_RS,   I_RT,   X,      I_IMM,  X,      X),
        J -> List( X,      X,      X,      X,      J_ADDR, X),
        R -> List( R_RS,   R_RT,   R_RS,   X,      X,      R_FUNCT)
    )

    val default = List( X,      X,      X,      X,      X,      X)
}
