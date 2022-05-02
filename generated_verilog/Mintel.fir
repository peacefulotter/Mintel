circuit Mintel :
  module InstructionMem :
    input clock : Clock
    input reset : Reset
    output io : { flip PC : UInt<32>, Instr : UInt<32>}

    cmem memory : UInt<32> [1024] @[InstructionMem.scala 8:21]
    node _io_Instr_T = bits(io.PC, 9, 0) @[InstructionMem.scala 15:23]
    infer mport io_Instr_MPORT = memory[_io_Instr_T], clock @[InstructionMem.scala 15:23]
    io.Instr <= io_Instr_MPORT @[InstructionMem.scala 15:14]

  module Fetch :
    input clock : Clock
    input reset : Reset
    output io : { flip Stall : UInt<5>, flip BranchAddr : UInt<32>, flip BrEn : UInt<1>, NextPC : UInt<32>, Instr : UInt<32>}

    inst mem of InstructionMem @[Fetch.scala 6:21]
    mem.clock <= clock
    mem.reset <= reset
    reg PC : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[Fetch.scala 7:21]
    reg STALL : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[Fetch.scala 8:24]
    node _STALL_T = gt(io.Stall, UInt<1>("h0")) @[Fetch.scala 23:18]
    node _STALL_T_1 = gt(STALL, UInt<1>("h0")) @[Fetch.scala 25:20]
    node _STALL_T_2 = sub(STALL, UInt<1>("h1")) @[Fetch.scala 25:33]
    node _STALL_T_3 = tail(_STALL_T_2, 1) @[Fetch.scala 25:33]
    node _STALL_T_4 = mux(_STALL_T_1, _STALL_T_3, UInt<1>("h0")) @[Fetch.scala 25:12]
    node _STALL_T_5 = mux(_STALL_T, io.Stall, _STALL_T_4) @[Fetch.scala 22:17]
    STALL <= _STALL_T_5 @[Fetch.scala 22:11]
    node _isStalling_T = gt(io.Stall, UInt<1>("h0")) @[Fetch.scala 28:37]
    node _isStalling_T_1 = gt(STALL, UInt<1>("h0")) @[Fetch.scala 28:51]
    node isStalling = or(_isStalling_T, _isStalling_T_1) @[Fetch.scala 28:43]
    node _io_NextPC_T = add(PC, UInt<1>("h1")) @[Fetch.scala 30:21]
    node _io_NextPC_T_1 = tail(_io_NextPC_T, 1) @[Fetch.scala 30:21]
    io.NextPC <= _io_NextPC_T_1 @[Fetch.scala 30:15]
    node _newPC_T = mux(io.BrEn, io.BranchAddr, io.NextPC) @[Fetch.scala 34:12]
    node newPC = mux(isStalling, PC, _newPC_T) @[Fetch.scala 31:26]
    node _mem_io_PC_T = mux(io.BrEn, io.BranchAddr, PC) @[Fetch.scala 37:21]
    mem.io.PC <= _mem_io_PC_T @[Fetch.scala 37:15]
    node _io_Instr_T = mux(isStalling, UInt<32>("h0"), mem.io.Instr) @[Fetch.scala 38:20]
    io.Instr <= _io_Instr_T @[Fetch.scala 38:14]
    PC <= newPC @[Fetch.scala 44:8]

  module RegisterFile :
    input clock : Clock
    input reset : Reset
    output io : { flip ReadAddr1 : UInt<5>, flip ReadAddr2 : UInt<5>, flip WriteAddr : UInt<5>, flip WriteData : UInt<32>, flip WriteEnable : UInt<1>, ReadData1 : UInt<32>, ReadData2 : UInt<32>}

    wire _regs_WIRE : UInt<32>[32] @[RegisterFile.scala 5:31]
    _regs_WIRE[0] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[1] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[2] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[3] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[4] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[5] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[6] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[7] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[8] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[9] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[10] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[11] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[12] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[13] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[14] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[15] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[16] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[17] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[18] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[19] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[20] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[21] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[22] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[23] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[24] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[25] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[26] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[27] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[28] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[29] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[30] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    _regs_WIRE[31] <= UInt<32>("h0") @[RegisterFile.scala 5:31]
    reg regs : UInt<32>[32], clock with :
      reset => (reset, _regs_WIRE) @[RegisterFile.scala 5:23]
    node _T = orr(io.WriteAddr) @[RegisterFile.scala 18:42]
    node _T_1 = and(io.WriteEnable, _T) @[RegisterFile.scala 18:27]
    when _T_1 : @[RegisterFile.scala 18:48]
      regs[io.WriteAddr] <= io.WriteData @[RegisterFile.scala 19:30]
    node _io_ReadData1_T = orr(io.ReadAddr1) @[RegisterFile.scala 22:38]
    node _io_ReadData1_T_1 = mux(_io_ReadData1_T, regs[io.ReadAddr1], UInt<1>("h0")) @[RegisterFile.scala 22:24]
    io.ReadData1 <= _io_ReadData1_T_1 @[RegisterFile.scala 22:18]
    node _io_ReadData2_T = orr(io.ReadAddr2) @[RegisterFile.scala 23:38]
    node _io_ReadData2_T_1 = mux(_io_ReadData2_T, regs[io.ReadAddr2], UInt<1>("h0")) @[RegisterFile.scala 23:24]
    io.ReadData2 <= _io_ReadData2_T_1 @[RegisterFile.scala 23:18]

  module Control :
    input clock : Clock
    input reset : Reset
    output io : { flip instr : UInt<32>, rs : UInt<5>, rt : UInt<5>, rd : UInt<5>, imm : UInt<16>, addr : UInt<26>, ImmEn : UInt<1>, AluOp : UInt<6>, BrEn : UInt<1>, LoadEn : UInt<1>, StoreEn : UInt<1>, WbType : UInt<1>, WbEn : UInt<1>, IsSigned : UInt<1>}

    node _io_rs_T = bits(io.instr, 25, 21) @[Control.scala 25:33]
    io.rs <= _io_rs_T @[Control.scala 25:16]
    node _io_rt_T = bits(io.instr, 20, 16) @[Control.scala 26:33]
    io.rt <= _io_rt_T @[Control.scala 26:16]
    node _io_rd_T = bits(io.instr, 15, 11) @[Control.scala 27:33]
    io.rd <= _io_rd_T @[Control.scala 27:16]
    node _io_imm_T = bits(io.instr, 15, 0) @[Control.scala 28:33]
    io.imm <= _io_imm_T @[Control.scala 28:16]
    node _io_addr_T = bits(io.instr, 25, 0) @[Control.scala 29:33]
    io.addr <= _io_addr_T @[Control.scala 29:16]
    node _format_T = and(io.instr, UInt<32>("hffffffff")) @[Lookup.scala 31:38]
    node _format_T_1 = eq(UInt<1>("h0"), _format_T) @[Lookup.scala 31:38]
    node _format_T_2 = and(io.instr, UInt<32>("hfc0007ff")) @[Lookup.scala 31:38]
    node _format_T_3 = eq(UInt<6>("h20"), _format_T_2) @[Lookup.scala 31:38]
    node _format_T_4 = and(io.instr, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _format_T_5 = eq(UInt<30>("h20000000"), _format_T_4) @[Lookup.scala 31:38]
    node _format_T_6 = and(io.instr, UInt<32>("hfc0007ff")) @[Lookup.scala 31:38]
    node _format_T_7 = eq(UInt<6>("h21"), _format_T_6) @[Lookup.scala 31:38]
    node _format_T_8 = and(io.instr, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _format_T_9 = eq(UInt<30>("h24000000"), _format_T_8) @[Lookup.scala 31:38]
    node _format_T_10 = and(io.instr, UInt<32>("hfc0007ff")) @[Lookup.scala 31:38]
    node _format_T_11 = eq(UInt<6>("h22"), _format_T_10) @[Lookup.scala 31:38]
    node _format_T_12 = and(io.instr, UInt<32>("hfc0007ff")) @[Lookup.scala 31:38]
    node _format_T_13 = eq(UInt<6>("h23"), _format_T_12) @[Lookup.scala 31:38]
    node _format_T_14 = and(io.instr, UInt<32>("hfc0007ff")) @[Lookup.scala 31:38]
    node _format_T_15 = eq(UInt<6>("h24"), _format_T_14) @[Lookup.scala 31:38]
    node _format_T_16 = and(io.instr, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _format_T_17 = eq(UInt<30>("h30000000"), _format_T_16) @[Lookup.scala 31:38]
    node _format_T_18 = and(io.instr, UInt<32>("hfc0007ff")) @[Lookup.scala 31:38]
    node _format_T_19 = eq(UInt<6>("h25"), _format_T_18) @[Lookup.scala 31:38]
    node _format_T_20 = and(io.instr, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _format_T_21 = eq(UInt<30>("h34000000"), _format_T_20) @[Lookup.scala 31:38]
    node _format_T_22 = and(io.instr, UInt<32>("hfc0007ff")) @[Lookup.scala 31:38]
    node _format_T_23 = eq(UInt<6>("h26"), _format_T_22) @[Lookup.scala 31:38]
    node _format_T_24 = and(io.instr, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _format_T_25 = eq(UInt<30>("h38000000"), _format_T_24) @[Lookup.scala 31:38]
    node _format_T_26 = and(io.instr, UInt<32>("hffe0003f")) @[Lookup.scala 31:38]
    node _format_T_27 = eq(UInt<1>("h0"), _format_T_26) @[Lookup.scala 31:38]
    node _format_T_28 = and(io.instr, UInt<32>("hffe0003f")) @[Lookup.scala 31:38]
    node _format_T_29 = eq(UInt<2>("h2"), _format_T_28) @[Lookup.scala 31:38]
    node _format_T_30 = and(io.instr, UInt<32>("hfc0007ff")) @[Lookup.scala 31:38]
    node _format_T_31 = eq(UInt<3>("h4"), _format_T_30) @[Lookup.scala 31:38]
    node _format_T_32 = and(io.instr, UInt<32>("hfc0007ff")) @[Lookup.scala 31:38]
    node _format_T_33 = eq(UInt<3>("h6"), _format_T_32) @[Lookup.scala 31:38]
    node _format_T_34 = and(io.instr, UInt<32>("hfc0007ff")) @[Lookup.scala 31:38]
    node _format_T_35 = eq(UInt<6>("h2a"), _format_T_34) @[Lookup.scala 31:38]
    node _format_T_36 = and(io.instr, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _format_T_37 = eq(UInt<30>("h28000000"), _format_T_36) @[Lookup.scala 31:38]
    node _format_T_38 = and(io.instr, UInt<32>("hfc0007ff")) @[Lookup.scala 31:38]
    node _format_T_39 = eq(UInt<6>("h2b"), _format_T_38) @[Lookup.scala 31:38]
    node _format_T_40 = and(io.instr, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _format_T_41 = eq(UInt<30>("h2c000000"), _format_T_40) @[Lookup.scala 31:38]
    node _format_T_42 = and(io.instr, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _format_T_43 = eq(UInt<29>("h14000000"), _format_T_42) @[Lookup.scala 31:38]
    node _format_T_44 = and(io.instr, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _format_T_45 = eq(UInt<29>("h10000000"), _format_T_44) @[Lookup.scala 31:38]
    node _format_T_46 = and(io.instr, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _format_T_47 = eq(UInt<29>("h18000000"), _format_T_46) @[Lookup.scala 31:38]
    node _format_T_48 = and(io.instr, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _format_T_49 = eq(UInt<29>("h1c000000"), _format_T_48) @[Lookup.scala 31:38]
    node _format_T_50 = and(io.instr, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _format_T_51 = eq(UInt<32>("h8c000000"), _format_T_50) @[Lookup.scala 31:38]
    node _format_T_52 = and(io.instr, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _format_T_53 = eq(UInt<32>("hac000000"), _format_T_52) @[Lookup.scala 31:38]
    node _format_T_54 = mux(_format_T_53, UInt<5>("h0"), UInt<5>("h0")) @[Lookup.scala 34:39]
    node _format_T_55 = mux(_format_T_51, UInt<5>("h0"), _format_T_54) @[Lookup.scala 34:39]
    node _format_T_56 = mux(_format_T_49, UInt<5>("hf"), _format_T_55) @[Lookup.scala 34:39]
    node _format_T_57 = mux(_format_T_47, UInt<5>("hc"), _format_T_56) @[Lookup.scala 34:39]
    node _format_T_58 = mux(_format_T_45, UInt<5>("h11"), _format_T_57) @[Lookup.scala 34:39]
    node _format_T_59 = mux(_format_T_43, UInt<5>("h10"), _format_T_58) @[Lookup.scala 34:39]
    node _format_T_60 = mux(_format_T_41, UInt<5>("hd"), _format_T_59) @[Lookup.scala 34:39]
    node _format_T_61 = mux(_format_T_39, UInt<5>("hd"), _format_T_60) @[Lookup.scala 34:39]
    node _format_T_62 = mux(_format_T_37, UInt<5>("hc"), _format_T_61) @[Lookup.scala 34:39]
    node _format_T_63 = mux(_format_T_35, UInt<5>("hc"), _format_T_62) @[Lookup.scala 34:39]
    node _format_T_64 = mux(_format_T_33, UInt<5>("hb"), _format_T_63) @[Lookup.scala 34:39]
    node _format_T_65 = mux(_format_T_31, UInt<5>("h9"), _format_T_64) @[Lookup.scala 34:39]
    node _format_T_66 = mux(_format_T_29, UInt<5>("ha"), _format_T_65) @[Lookup.scala 34:39]
    node _format_T_67 = mux(_format_T_27, UInt<5>("h8"), _format_T_66) @[Lookup.scala 34:39]
    node _format_T_68 = mux(_format_T_25, UInt<5>("h7"), _format_T_67) @[Lookup.scala 34:39]
    node _format_T_69 = mux(_format_T_23, UInt<5>("h7"), _format_T_68) @[Lookup.scala 34:39]
    node _format_T_70 = mux(_format_T_21, UInt<5>("h6"), _format_T_69) @[Lookup.scala 34:39]
    node _format_T_71 = mux(_format_T_19, UInt<5>("h6"), _format_T_70) @[Lookup.scala 34:39]
    node _format_T_72 = mux(_format_T_17, UInt<5>("h5"), _format_T_71) @[Lookup.scala 34:39]
    node _format_T_73 = mux(_format_T_15, UInt<5>("h5"), _format_T_72) @[Lookup.scala 34:39]
    node _format_T_74 = mux(_format_T_13, UInt<5>("h3"), _format_T_73) @[Lookup.scala 34:39]
    node _format_T_75 = mux(_format_T_11, UInt<5>("h2"), _format_T_74) @[Lookup.scala 34:39]
    node _format_T_76 = mux(_format_T_9, UInt<5>("h1"), _format_T_75) @[Lookup.scala 34:39]
    node _format_T_77 = mux(_format_T_7, UInt<5>("h1"), _format_T_76) @[Lookup.scala 34:39]
    node _format_T_78 = mux(_format_T_5, UInt<5>("h0"), _format_T_77) @[Lookup.scala 34:39]
    node _format_T_79 = mux(_format_T_3, UInt<5>("h0"), _format_T_78) @[Lookup.scala 34:39]
    node format_0 = mux(_format_T_1, UInt<5>("h0"), _format_T_79) @[Lookup.scala 34:39]
    node _format_T_80 = mux(_format_T_53, UInt<1>("h1"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _format_T_81 = mux(_format_T_51, UInt<1>("h1"), _format_T_80) @[Lookup.scala 34:39]
    node _format_T_82 = mux(_format_T_49, UInt<1>("h0"), _format_T_81) @[Lookup.scala 34:39]
    node _format_T_83 = mux(_format_T_47, UInt<1>("h0"), _format_T_82) @[Lookup.scala 34:39]
    node _format_T_84 = mux(_format_T_45, UInt<1>("h0"), _format_T_83) @[Lookup.scala 34:39]
    node _format_T_85 = mux(_format_T_43, UInt<1>("h0"), _format_T_84) @[Lookup.scala 34:39]
    node _format_T_86 = mux(_format_T_41, UInt<1>("h1"), _format_T_85) @[Lookup.scala 34:39]
    node _format_T_87 = mux(_format_T_39, UInt<1>("h0"), _format_T_86) @[Lookup.scala 34:39]
    node _format_T_88 = mux(_format_T_37, UInt<1>("h1"), _format_T_87) @[Lookup.scala 34:39]
    node _format_T_89 = mux(_format_T_35, UInt<1>("h0"), _format_T_88) @[Lookup.scala 34:39]
    node _format_T_90 = mux(_format_T_33, UInt<1>("h0"), _format_T_89) @[Lookup.scala 34:39]
    node _format_T_91 = mux(_format_T_31, UInt<1>("h0"), _format_T_90) @[Lookup.scala 34:39]
    node _format_T_92 = mux(_format_T_29, UInt<1>("h1"), _format_T_91) @[Lookup.scala 34:39]
    node _format_T_93 = mux(_format_T_27, UInt<1>("h1"), _format_T_92) @[Lookup.scala 34:39]
    node _format_T_94 = mux(_format_T_25, UInt<1>("h1"), _format_T_93) @[Lookup.scala 34:39]
    node _format_T_95 = mux(_format_T_23, UInt<1>("h0"), _format_T_94) @[Lookup.scala 34:39]
    node _format_T_96 = mux(_format_T_21, UInt<1>("h1"), _format_T_95) @[Lookup.scala 34:39]
    node _format_T_97 = mux(_format_T_19, UInt<1>("h0"), _format_T_96) @[Lookup.scala 34:39]
    node _format_T_98 = mux(_format_T_17, UInt<1>("h1"), _format_T_97) @[Lookup.scala 34:39]
    node _format_T_99 = mux(_format_T_15, UInt<1>("h0"), _format_T_98) @[Lookup.scala 34:39]
    node _format_T_100 = mux(_format_T_13, UInt<1>("h0"), _format_T_99) @[Lookup.scala 34:39]
    node _format_T_101 = mux(_format_T_11, UInt<1>("h0"), _format_T_100) @[Lookup.scala 34:39]
    node _format_T_102 = mux(_format_T_9, UInt<1>("h1"), _format_T_101) @[Lookup.scala 34:39]
    node _format_T_103 = mux(_format_T_7, UInt<1>("h0"), _format_T_102) @[Lookup.scala 34:39]
    node _format_T_104 = mux(_format_T_5, UInt<1>("h1"), _format_T_103) @[Lookup.scala 34:39]
    node _format_T_105 = mux(_format_T_3, UInt<1>("h0"), _format_T_104) @[Lookup.scala 34:39]
    node format_1 = mux(_format_T_1, UInt<1>("h0"), _format_T_105) @[Lookup.scala 34:39]
    node _format_T_106 = mux(_format_T_53, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _format_T_107 = mux(_format_T_51, UInt<1>("h0"), _format_T_106) @[Lookup.scala 34:39]
    node _format_T_108 = mux(_format_T_49, UInt<1>("h1"), _format_T_107) @[Lookup.scala 34:39]
    node _format_T_109 = mux(_format_T_47, UInt<1>("h1"), _format_T_108) @[Lookup.scala 34:39]
    node _format_T_110 = mux(_format_T_45, UInt<1>("h1"), _format_T_109) @[Lookup.scala 34:39]
    node _format_T_111 = mux(_format_T_43, UInt<1>("h1"), _format_T_110) @[Lookup.scala 34:39]
    node _format_T_112 = mux(_format_T_41, UInt<1>("h0"), _format_T_111) @[Lookup.scala 34:39]
    node _format_T_113 = mux(_format_T_39, UInt<1>("h0"), _format_T_112) @[Lookup.scala 34:39]
    node _format_T_114 = mux(_format_T_37, UInt<1>("h0"), _format_T_113) @[Lookup.scala 34:39]
    node _format_T_115 = mux(_format_T_35, UInt<1>("h0"), _format_T_114) @[Lookup.scala 34:39]
    node _format_T_116 = mux(_format_T_33, UInt<1>("h0"), _format_T_115) @[Lookup.scala 34:39]
    node _format_T_117 = mux(_format_T_31, UInt<1>("h0"), _format_T_116) @[Lookup.scala 34:39]
    node _format_T_118 = mux(_format_T_29, UInt<1>("h0"), _format_T_117) @[Lookup.scala 34:39]
    node _format_T_119 = mux(_format_T_27, UInt<1>("h0"), _format_T_118) @[Lookup.scala 34:39]
    node _format_T_120 = mux(_format_T_25, UInt<1>("h0"), _format_T_119) @[Lookup.scala 34:39]
    node _format_T_121 = mux(_format_T_23, UInt<1>("h0"), _format_T_120) @[Lookup.scala 34:39]
    node _format_T_122 = mux(_format_T_21, UInt<1>("h0"), _format_T_121) @[Lookup.scala 34:39]
    node _format_T_123 = mux(_format_T_19, UInt<1>("h0"), _format_T_122) @[Lookup.scala 34:39]
    node _format_T_124 = mux(_format_T_17, UInt<1>("h0"), _format_T_123) @[Lookup.scala 34:39]
    node _format_T_125 = mux(_format_T_15, UInt<1>("h0"), _format_T_124) @[Lookup.scala 34:39]
    node _format_T_126 = mux(_format_T_13, UInt<1>("h0"), _format_T_125) @[Lookup.scala 34:39]
    node _format_T_127 = mux(_format_T_11, UInt<1>("h0"), _format_T_126) @[Lookup.scala 34:39]
    node _format_T_128 = mux(_format_T_9, UInt<1>("h0"), _format_T_127) @[Lookup.scala 34:39]
    node _format_T_129 = mux(_format_T_7, UInt<1>("h0"), _format_T_128) @[Lookup.scala 34:39]
    node _format_T_130 = mux(_format_T_5, UInt<1>("h0"), _format_T_129) @[Lookup.scala 34:39]
    node _format_T_131 = mux(_format_T_3, UInt<1>("h0"), _format_T_130) @[Lookup.scala 34:39]
    node format_2 = mux(_format_T_1, UInt<1>("h0"), _format_T_131) @[Lookup.scala 34:39]
    node _format_T_132 = mux(_format_T_53, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _format_T_133 = mux(_format_T_51, UInt<1>("h1"), _format_T_132) @[Lookup.scala 34:39]
    node _format_T_134 = mux(_format_T_49, UInt<1>("h0"), _format_T_133) @[Lookup.scala 34:39]
    node _format_T_135 = mux(_format_T_47, UInt<1>("h0"), _format_T_134) @[Lookup.scala 34:39]
    node _format_T_136 = mux(_format_T_45, UInt<1>("h0"), _format_T_135) @[Lookup.scala 34:39]
    node _format_T_137 = mux(_format_T_43, UInt<1>("h0"), _format_T_136) @[Lookup.scala 34:39]
    node _format_T_138 = mux(_format_T_41, UInt<1>("h0"), _format_T_137) @[Lookup.scala 34:39]
    node _format_T_139 = mux(_format_T_39, UInt<1>("h0"), _format_T_138) @[Lookup.scala 34:39]
    node _format_T_140 = mux(_format_T_37, UInt<1>("h0"), _format_T_139) @[Lookup.scala 34:39]
    node _format_T_141 = mux(_format_T_35, UInt<1>("h0"), _format_T_140) @[Lookup.scala 34:39]
    node _format_T_142 = mux(_format_T_33, UInt<1>("h0"), _format_T_141) @[Lookup.scala 34:39]
    node _format_T_143 = mux(_format_T_31, UInt<1>("h0"), _format_T_142) @[Lookup.scala 34:39]
    node _format_T_144 = mux(_format_T_29, UInt<1>("h0"), _format_T_143) @[Lookup.scala 34:39]
    node _format_T_145 = mux(_format_T_27, UInt<1>("h0"), _format_T_144) @[Lookup.scala 34:39]
    node _format_T_146 = mux(_format_T_25, UInt<1>("h0"), _format_T_145) @[Lookup.scala 34:39]
    node _format_T_147 = mux(_format_T_23, UInt<1>("h0"), _format_T_146) @[Lookup.scala 34:39]
    node _format_T_148 = mux(_format_T_21, UInt<1>("h0"), _format_T_147) @[Lookup.scala 34:39]
    node _format_T_149 = mux(_format_T_19, UInt<1>("h0"), _format_T_148) @[Lookup.scala 34:39]
    node _format_T_150 = mux(_format_T_17, UInt<1>("h0"), _format_T_149) @[Lookup.scala 34:39]
    node _format_T_151 = mux(_format_T_15, UInt<1>("h0"), _format_T_150) @[Lookup.scala 34:39]
    node _format_T_152 = mux(_format_T_13, UInt<1>("h0"), _format_T_151) @[Lookup.scala 34:39]
    node _format_T_153 = mux(_format_T_11, UInt<1>("h0"), _format_T_152) @[Lookup.scala 34:39]
    node _format_T_154 = mux(_format_T_9, UInt<1>("h0"), _format_T_153) @[Lookup.scala 34:39]
    node _format_T_155 = mux(_format_T_7, UInt<1>("h0"), _format_T_154) @[Lookup.scala 34:39]
    node _format_T_156 = mux(_format_T_5, UInt<1>("h0"), _format_T_155) @[Lookup.scala 34:39]
    node _format_T_157 = mux(_format_T_3, UInt<1>("h0"), _format_T_156) @[Lookup.scala 34:39]
    node format_3 = mux(_format_T_1, UInt<1>("h0"), _format_T_157) @[Lookup.scala 34:39]
    node _format_T_158 = mux(_format_T_53, UInt<1>("h1"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _format_T_159 = mux(_format_T_51, UInt<1>("h0"), _format_T_158) @[Lookup.scala 34:39]
    node _format_T_160 = mux(_format_T_49, UInt<1>("h0"), _format_T_159) @[Lookup.scala 34:39]
    node _format_T_161 = mux(_format_T_47, UInt<1>("h0"), _format_T_160) @[Lookup.scala 34:39]
    node _format_T_162 = mux(_format_T_45, UInt<1>("h0"), _format_T_161) @[Lookup.scala 34:39]
    node _format_T_163 = mux(_format_T_43, UInt<1>("h0"), _format_T_162) @[Lookup.scala 34:39]
    node _format_T_164 = mux(_format_T_41, UInt<1>("h0"), _format_T_163) @[Lookup.scala 34:39]
    node _format_T_165 = mux(_format_T_39, UInt<1>("h0"), _format_T_164) @[Lookup.scala 34:39]
    node _format_T_166 = mux(_format_T_37, UInt<1>("h0"), _format_T_165) @[Lookup.scala 34:39]
    node _format_T_167 = mux(_format_T_35, UInt<1>("h0"), _format_T_166) @[Lookup.scala 34:39]
    node _format_T_168 = mux(_format_T_33, UInt<1>("h0"), _format_T_167) @[Lookup.scala 34:39]
    node _format_T_169 = mux(_format_T_31, UInt<1>("h0"), _format_T_168) @[Lookup.scala 34:39]
    node _format_T_170 = mux(_format_T_29, UInt<1>("h0"), _format_T_169) @[Lookup.scala 34:39]
    node _format_T_171 = mux(_format_T_27, UInt<1>("h0"), _format_T_170) @[Lookup.scala 34:39]
    node _format_T_172 = mux(_format_T_25, UInt<1>("h0"), _format_T_171) @[Lookup.scala 34:39]
    node _format_T_173 = mux(_format_T_23, UInt<1>("h0"), _format_T_172) @[Lookup.scala 34:39]
    node _format_T_174 = mux(_format_T_21, UInt<1>("h0"), _format_T_173) @[Lookup.scala 34:39]
    node _format_T_175 = mux(_format_T_19, UInt<1>("h0"), _format_T_174) @[Lookup.scala 34:39]
    node _format_T_176 = mux(_format_T_17, UInt<1>("h0"), _format_T_175) @[Lookup.scala 34:39]
    node _format_T_177 = mux(_format_T_15, UInt<1>("h0"), _format_T_176) @[Lookup.scala 34:39]
    node _format_T_178 = mux(_format_T_13, UInt<1>("h0"), _format_T_177) @[Lookup.scala 34:39]
    node _format_T_179 = mux(_format_T_11, UInt<1>("h0"), _format_T_178) @[Lookup.scala 34:39]
    node _format_T_180 = mux(_format_T_9, UInt<1>("h0"), _format_T_179) @[Lookup.scala 34:39]
    node _format_T_181 = mux(_format_T_7, UInt<1>("h0"), _format_T_180) @[Lookup.scala 34:39]
    node _format_T_182 = mux(_format_T_5, UInt<1>("h0"), _format_T_181) @[Lookup.scala 34:39]
    node _format_T_183 = mux(_format_T_3, UInt<1>("h0"), _format_T_182) @[Lookup.scala 34:39]
    node format_4 = mux(_format_T_1, UInt<1>("h0"), _format_T_183) @[Lookup.scala 34:39]
    node _format_T_184 = mux(_format_T_53, UInt<1>("h1"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _format_T_185 = mux(_format_T_51, UInt<1>("h0"), _format_T_184) @[Lookup.scala 34:39]
    node _format_T_186 = mux(_format_T_49, UInt<1>("h0"), _format_T_185) @[Lookup.scala 34:39]
    node _format_T_187 = mux(_format_T_47, UInt<1>("h0"), _format_T_186) @[Lookup.scala 34:39]
    node _format_T_188 = mux(_format_T_45, UInt<1>("h0"), _format_T_187) @[Lookup.scala 34:39]
    node _format_T_189 = mux(_format_T_43, UInt<1>("h0"), _format_T_188) @[Lookup.scala 34:39]
    node _format_T_190 = mux(_format_T_41, UInt<1>("h0"), _format_T_189) @[Lookup.scala 34:39]
    node _format_T_191 = mux(_format_T_39, UInt<1>("h0"), _format_T_190) @[Lookup.scala 34:39]
    node _format_T_192 = mux(_format_T_37, UInt<1>("h0"), _format_T_191) @[Lookup.scala 34:39]
    node _format_T_193 = mux(_format_T_35, UInt<1>("h0"), _format_T_192) @[Lookup.scala 34:39]
    node _format_T_194 = mux(_format_T_33, UInt<1>("h0"), _format_T_193) @[Lookup.scala 34:39]
    node _format_T_195 = mux(_format_T_31, UInt<1>("h0"), _format_T_194) @[Lookup.scala 34:39]
    node _format_T_196 = mux(_format_T_29, UInt<1>("h0"), _format_T_195) @[Lookup.scala 34:39]
    node _format_T_197 = mux(_format_T_27, UInt<1>("h0"), _format_T_196) @[Lookup.scala 34:39]
    node _format_T_198 = mux(_format_T_25, UInt<1>("h0"), _format_T_197) @[Lookup.scala 34:39]
    node _format_T_199 = mux(_format_T_23, UInt<1>("h0"), _format_T_198) @[Lookup.scala 34:39]
    node _format_T_200 = mux(_format_T_21, UInt<1>("h0"), _format_T_199) @[Lookup.scala 34:39]
    node _format_T_201 = mux(_format_T_19, UInt<1>("h0"), _format_T_200) @[Lookup.scala 34:39]
    node _format_T_202 = mux(_format_T_17, UInt<1>("h0"), _format_T_201) @[Lookup.scala 34:39]
    node _format_T_203 = mux(_format_T_15, UInt<1>("h0"), _format_T_202) @[Lookup.scala 34:39]
    node _format_T_204 = mux(_format_T_13, UInt<1>("h0"), _format_T_203) @[Lookup.scala 34:39]
    node _format_T_205 = mux(_format_T_11, UInt<1>("h0"), _format_T_204) @[Lookup.scala 34:39]
    node _format_T_206 = mux(_format_T_9, UInt<1>("h0"), _format_T_205) @[Lookup.scala 34:39]
    node _format_T_207 = mux(_format_T_7, UInt<1>("h0"), _format_T_206) @[Lookup.scala 34:39]
    node _format_T_208 = mux(_format_T_5, UInt<1>("h0"), _format_T_207) @[Lookup.scala 34:39]
    node _format_T_209 = mux(_format_T_3, UInt<1>("h0"), _format_T_208) @[Lookup.scala 34:39]
    node format_5 = mux(_format_T_1, UInt<1>("h0"), _format_T_209) @[Lookup.scala 34:39]
    node _format_T_210 = mux(_format_T_53, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _format_T_211 = mux(_format_T_51, UInt<1>("h1"), _format_T_210) @[Lookup.scala 34:39]
    node _format_T_212 = mux(_format_T_49, UInt<1>("h0"), _format_T_211) @[Lookup.scala 34:39]
    node _format_T_213 = mux(_format_T_47, UInt<1>("h0"), _format_T_212) @[Lookup.scala 34:39]
    node _format_T_214 = mux(_format_T_45, UInt<1>("h0"), _format_T_213) @[Lookup.scala 34:39]
    node _format_T_215 = mux(_format_T_43, UInt<1>("h0"), _format_T_214) @[Lookup.scala 34:39]
    node _format_T_216 = mux(_format_T_41, UInt<1>("h1"), _format_T_215) @[Lookup.scala 34:39]
    node _format_T_217 = mux(_format_T_39, UInt<1>("h1"), _format_T_216) @[Lookup.scala 34:39]
    node _format_T_218 = mux(_format_T_37, UInt<1>("h1"), _format_T_217) @[Lookup.scala 34:39]
    node _format_T_219 = mux(_format_T_35, UInt<1>("h1"), _format_T_218) @[Lookup.scala 34:39]
    node _format_T_220 = mux(_format_T_33, UInt<1>("h1"), _format_T_219) @[Lookup.scala 34:39]
    node _format_T_221 = mux(_format_T_31, UInt<1>("h1"), _format_T_220) @[Lookup.scala 34:39]
    node _format_T_222 = mux(_format_T_29, UInt<1>("h1"), _format_T_221) @[Lookup.scala 34:39]
    node _format_T_223 = mux(_format_T_27, UInt<1>("h1"), _format_T_222) @[Lookup.scala 34:39]
    node _format_T_224 = mux(_format_T_25, UInt<1>("h1"), _format_T_223) @[Lookup.scala 34:39]
    node _format_T_225 = mux(_format_T_23, UInt<1>("h1"), _format_T_224) @[Lookup.scala 34:39]
    node _format_T_226 = mux(_format_T_21, UInt<1>("h1"), _format_T_225) @[Lookup.scala 34:39]
    node _format_T_227 = mux(_format_T_19, UInt<1>("h1"), _format_T_226) @[Lookup.scala 34:39]
    node _format_T_228 = mux(_format_T_17, UInt<1>("h1"), _format_T_227) @[Lookup.scala 34:39]
    node _format_T_229 = mux(_format_T_15, UInt<1>("h1"), _format_T_228) @[Lookup.scala 34:39]
    node _format_T_230 = mux(_format_T_13, UInt<1>("h1"), _format_T_229) @[Lookup.scala 34:39]
    node _format_T_231 = mux(_format_T_11, UInt<1>("h1"), _format_T_230) @[Lookup.scala 34:39]
    node _format_T_232 = mux(_format_T_9, UInt<1>("h1"), _format_T_231) @[Lookup.scala 34:39]
    node _format_T_233 = mux(_format_T_7, UInt<1>("h1"), _format_T_232) @[Lookup.scala 34:39]
    node _format_T_234 = mux(_format_T_5, UInt<1>("h1"), _format_T_233) @[Lookup.scala 34:39]
    node _format_T_235 = mux(_format_T_3, UInt<1>("h1"), _format_T_234) @[Lookup.scala 34:39]
    node format_6 = mux(_format_T_1, UInt<1>("h0"), _format_T_235) @[Lookup.scala 34:39]
    node _format_T_236 = mux(_format_T_53, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _format_T_237 = mux(_format_T_51, UInt<1>("h0"), _format_T_236) @[Lookup.scala 34:39]
    node _format_T_238 = mux(_format_T_49, UInt<1>("h0"), _format_T_237) @[Lookup.scala 34:39]
    node _format_T_239 = mux(_format_T_47, UInt<1>("h0"), _format_T_238) @[Lookup.scala 34:39]
    node _format_T_240 = mux(_format_T_45, UInt<1>("h0"), _format_T_239) @[Lookup.scala 34:39]
    node _format_T_241 = mux(_format_T_43, UInt<1>("h0"), _format_T_240) @[Lookup.scala 34:39]
    node _format_T_242 = mux(_format_T_41, UInt<1>("h0"), _format_T_241) @[Lookup.scala 34:39]
    node _format_T_243 = mux(_format_T_39, UInt<1>("h0"), _format_T_242) @[Lookup.scala 34:39]
    node _format_T_244 = mux(_format_T_37, UInt<1>("h1"), _format_T_243) @[Lookup.scala 34:39]
    node _format_T_245 = mux(_format_T_35, UInt<1>("h1"), _format_T_244) @[Lookup.scala 34:39]
    node _format_T_246 = mux(_format_T_33, UInt<1>("h0"), _format_T_245) @[Lookup.scala 34:39]
    node _format_T_247 = mux(_format_T_31, UInt<1>("h0"), _format_T_246) @[Lookup.scala 34:39]
    node _format_T_248 = mux(_format_T_29, UInt<1>("h0"), _format_T_247) @[Lookup.scala 34:39]
    node _format_T_249 = mux(_format_T_27, UInt<1>("h0"), _format_T_248) @[Lookup.scala 34:39]
    node _format_T_250 = mux(_format_T_25, UInt<1>("h0"), _format_T_249) @[Lookup.scala 34:39]
    node _format_T_251 = mux(_format_T_23, UInt<1>("h0"), _format_T_250) @[Lookup.scala 34:39]
    node _format_T_252 = mux(_format_T_21, UInt<1>("h0"), _format_T_251) @[Lookup.scala 34:39]
    node _format_T_253 = mux(_format_T_19, UInt<1>("h0"), _format_T_252) @[Lookup.scala 34:39]
    node _format_T_254 = mux(_format_T_17, UInt<1>("h0"), _format_T_253) @[Lookup.scala 34:39]
    node _format_T_255 = mux(_format_T_15, UInt<1>("h0"), _format_T_254) @[Lookup.scala 34:39]
    node _format_T_256 = mux(_format_T_13, UInt<1>("h0"), _format_T_255) @[Lookup.scala 34:39]
    node _format_T_257 = mux(_format_T_11, UInt<1>("h1"), _format_T_256) @[Lookup.scala 34:39]
    node _format_T_258 = mux(_format_T_9, UInt<1>("h0"), _format_T_257) @[Lookup.scala 34:39]
    node _format_T_259 = mux(_format_T_7, UInt<1>("h0"), _format_T_258) @[Lookup.scala 34:39]
    node _format_T_260 = mux(_format_T_5, UInt<1>("h1"), _format_T_259) @[Lookup.scala 34:39]
    node _format_T_261 = mux(_format_T_3, UInt<1>("h1"), _format_T_260) @[Lookup.scala 34:39]
    node format_7 = mux(_format_T_1, UInt<1>("h0"), _format_T_261) @[Lookup.scala 34:39]
    io.AluOp <= format_0 @[Control.scala 32:17]
    io.ImmEn <= format_1 @[Control.scala 33:17]
    io.BrEn <= format_2 @[Control.scala 34:17]
    io.LoadEn <= format_3 @[Control.scala 35:17]
    io.StoreEn <= format_4 @[Control.scala 36:17]
    io.WbType <= format_5 @[Control.scala 37:17]
    io.WbEn <= format_6 @[Control.scala 38:17]
    io.IsSigned <= format_7 @[Control.scala 39:17]

  module SignExtend :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<16>, flip isSigned : UInt<1>, out : UInt<32>}

    node low = bits(io.in, 15, 0) @[SignExtend.scala 11:26]
    node _high_T = bits(io.in, 15, 15) @[SignExtend.scala 12:46]
    node _high_T_1 = eq(_high_T, UInt<1>("h1")) @[SignExtend.scala 12:56]
    node _high_T_2 = and(io.isSigned, _high_T_1) @[SignExtend.scala 12:38]
    node high = mux(_high_T_2, UInt<15>("h7fff"), UInt<1>("h0")) @[SignExtend.scala 12:25]
    node _io_out_T = cat(high, low) @[Cat.scala 31:58]
    io.out <= _io_out_T @[SignExtend.scala 13:12]

  module Decode :
    input clock : Clock
    input reset : Reset
    output dec_io : { flip Instr : UInt<32>, flip NextPCIn : UInt<32>, flip WriteAddrIn : UInt<32>, flip WriteEnIn : UInt<1>, flip WriteDataIn : UInt<32>, AluOp : UInt<8>, Imm : UInt<32>, ImmEn : UInt<1>, BrEn : UInt<1>, NextPCOut : UInt<32>, ReadEn : UInt<1>, WriteEnOut : UInt<1>, WbType : UInt<1>, WbEn : UInt<1>, rs : UInt<6>, rt : UInt<6>, rd : UInt<6>, DataRead1 : UInt<32>, DataRead2 : UInt<32>}

    inst regFile of RegisterFile @[Decode.scala 6:25]
    regFile.clock <= clock
    regFile.reset <= reset
    inst control of Control @[Decode.scala 7:25]
    control.clock <= clock
    control.reset <= reset
    inst signExtend of SignExtend @[Decode.scala 8:28]
    signExtend.clock <= clock
    signExtend.reset <= reset
    control.io.instr <= dec_io.Instr @[Decode.scala 43:22]
    dec_io.rs <= control.io.rs @[Decode.scala 45:15]
    dec_io.rt <= control.io.rt @[Decode.scala 46:15]
    dec_io.rd <= control.io.rd @[Decode.scala 47:15]
    dec_io.AluOp <= control.io.AluOp @[Decode.scala 48:18]
    dec_io.BrEn <= control.io.BrEn @[Decode.scala 49:17]
    dec_io.ReadEn <= control.io.LoadEn @[Decode.scala 50:19]
    dec_io.ImmEn <= control.io.ImmEn @[Decode.scala 51:18]
    dec_io.WriteEnOut <= control.io.StoreEn @[Decode.scala 52:23]
    dec_io.WbType <= control.io.WbType @[Decode.scala 53:19]
    dec_io.WbEn <= control.io.WbEn @[Decode.scala 54:17]
    regFile.io.ReadAddr1 <= control.io.rs @[Decode.scala 57:26]
    regFile.io.ReadAddr2 <= control.io.rt @[Decode.scala 58:26]
    node _regFile_io_WriteEnable_T = eq(dec_io.WriteEnIn, UInt<1>("h1")) @[Decode.scala 59:48]
    regFile.io.WriteEnable <= _regFile_io_WriteEnable_T @[Decode.scala 59:28]
    regFile.io.WriteAddr <= dec_io.WriteAddrIn @[Decode.scala 60:26]
    regFile.io.WriteData <= dec_io.WriteDataIn @[Decode.scala 61:26]
    dec_io.DataRead1 <= regFile.io.ReadData1 @[Decode.scala 63:22]
    dec_io.DataRead2 <= regFile.io.ReadData2 @[Decode.scala 64:22]
    dec_io.NextPCOut <= dec_io.NextPCIn @[Decode.scala 66:22]
    signExtend.io.in <= control.io.imm @[Decode.scala 68:22]
    node _signExtend_io_isSigned_T = eq(control.io.IsSigned, UInt<1>("h1")) @[Decode.scala 69:51]
    signExtend.io.isSigned <= _signExtend_io_isSigned_T @[Decode.scala 69:28]
    dec_io.Imm <= signExtend.io.out @[Decode.scala 70:16]

  module ALU :
    input clock : Clock
    input reset : Reset
    output io : { flip A : UInt<32>, flip B : UInt<32>, flip AluOp : UInt<8>, out : UInt<32>, zero : UInt<1>}

    node shamt = bits(io.B, 10, 6) @[ALU.scala 19:33]
    node _io_out_T = asSInt(io.A) @[ALU.scala 25:31]
    node _io_out_T_1 = asSInt(io.B) @[ALU.scala 25:45]
    node _io_out_T_2 = lt(_io_out_T, _io_out_T_1) @[ALU.scala 25:38]
    node _io_out_T_3 = asSInt(io.A) @[ALU.scala 26:31]
    node _io_out_T_4 = asSInt(io.B) @[ALU.scala 26:46]
    node _io_out_T_5 = geq(_io_out_T_3, _io_out_T_4) @[ALU.scala 26:38]
    node _io_out_T_6 = neq(io.A, io.B) @[ALU.scala 27:31]
    node _io_out_T_7 = eq(io.A, io.B) @[ALU.scala 28:31]
    node _io_out_T_8 = eq(UInt<5>("hc"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_9 = mux(_io_out_T_8, _io_out_T_2, UInt<1>("h0")) @[Mux.scala 81:58]
    node _io_out_T_10 = eq(UInt<5>("hf"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_11 = mux(_io_out_T_10, _io_out_T_5, _io_out_T_9) @[Mux.scala 81:58]
    node _io_out_T_12 = eq(UInt<5>("h10"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_13 = mux(_io_out_T_12, _io_out_T_6, _io_out_T_11) @[Mux.scala 81:58]
    node _io_out_T_14 = eq(UInt<5>("h11"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_15 = mux(_io_out_T_14, _io_out_T_7, _io_out_T_13) @[Mux.scala 81:58]
    node _io_out_T_16 = asSInt(io.A) @[ALU.scala 36:27]
    node _io_out_T_17 = asSInt(io.B) @[ALU.scala 36:41]
    node _io_out_T_18 = add(_io_out_T_16, _io_out_T_17) @[ALU.scala 36:34]
    node _io_out_T_19 = tail(_io_out_T_18, 1) @[ALU.scala 36:34]
    node _io_out_T_20 = asSInt(_io_out_T_19) @[ALU.scala 36:34]
    node _io_out_T_21 = asUInt(_io_out_T_20) @[ALU.scala 36:49]
    node _io_out_T_22 = add(io.A, io.B) @[ALU.scala 37:27]
    node _io_out_T_23 = tail(_io_out_T_22, 1) @[ALU.scala 37:27]
    node _io_out_T_24 = asSInt(io.A) @[ALU.scala 38:27]
    node _io_out_T_25 = asSInt(io.B) @[ALU.scala 38:41]
    node _io_out_T_26 = sub(_io_out_T_24, _io_out_T_25) @[ALU.scala 38:34]
    node _io_out_T_27 = tail(_io_out_T_26, 1) @[ALU.scala 38:34]
    node _io_out_T_28 = asSInt(_io_out_T_27) @[ALU.scala 38:34]
    node _io_out_T_29 = asUInt(_io_out_T_28) @[ALU.scala 38:49]
    node _io_out_T_30 = sub(io.A, io.B) @[ALU.scala 39:27]
    node _io_out_T_31 = tail(_io_out_T_30, 1) @[ALU.scala 39:27]
    node _io_out_T_32 = asSInt(io.A) @[ALU.scala 40:27]
    node _io_out_T_33 = asSInt(io.B) @[ALU.scala 40:41]
    node _io_out_T_34 = mul(_io_out_T_32, _io_out_T_33) @[ALU.scala 40:34]
    node _io_out_T_35 = asUInt(_io_out_T_34) @[ALU.scala 40:49]
    node _io_out_T_36 = and(io.A, io.B) @[ALU.scala 42:27]
    node _io_out_T_37 = or(io.A, io.B) @[ALU.scala 43:27]
    node _io_out_T_38 = xor(io.A, io.B) @[ALU.scala 44:27]
    node _io_out_T_39 = dshl(io.A, shamt) @[ALU.scala 46:27]
    node _io_out_T_40 = dshr(io.A, shamt) @[ALU.scala 47:27]
    node _io_out_T_41 = bits(io.B, 4, 0) @[ALU.scala 48:40]
    node _io_out_T_42 = dshl(io.A, _io_out_T_41) @[ALU.scala 48:27]
    node _io_out_T_43 = bits(io.B, 4, 0) @[ALU.scala 49:40]
    node _io_out_T_44 = dshr(io.A, _io_out_T_43) @[ALU.scala 49:27]
    node _io_out_T_45 = lt(io.A, io.B) @[ALU.scala 51:27]
    node _io_out_T_46 = eq(UInt<5>("h0"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_47 = mux(_io_out_T_46, _io_out_T_21, _io_out_T_15) @[Mux.scala 81:58]
    node _io_out_T_48 = eq(UInt<5>("h1"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_49 = mux(_io_out_T_48, _io_out_T_23, _io_out_T_47) @[Mux.scala 81:58]
    node _io_out_T_50 = eq(UInt<5>("h2"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_51 = mux(_io_out_T_50, _io_out_T_29, _io_out_T_49) @[Mux.scala 81:58]
    node _io_out_T_52 = eq(UInt<5>("h3"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_53 = mux(_io_out_T_52, _io_out_T_31, _io_out_T_51) @[Mux.scala 81:58]
    node _io_out_T_54 = eq(UInt<5>("h4"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_55 = mux(_io_out_T_54, _io_out_T_35, _io_out_T_53) @[Mux.scala 81:58]
    node _io_out_T_56 = eq(UInt<5>("h5"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_57 = mux(_io_out_T_56, _io_out_T_36, _io_out_T_55) @[Mux.scala 81:58]
    node _io_out_T_58 = eq(UInt<5>("h6"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_59 = mux(_io_out_T_58, _io_out_T_37, _io_out_T_57) @[Mux.scala 81:58]
    node _io_out_T_60 = eq(UInt<5>("h7"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_61 = mux(_io_out_T_60, _io_out_T_38, _io_out_T_59) @[Mux.scala 81:58]
    node _io_out_T_62 = eq(UInt<5>("h8"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_63 = mux(_io_out_T_62, _io_out_T_39, _io_out_T_61) @[Mux.scala 81:58]
    node _io_out_T_64 = eq(UInt<5>("ha"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_65 = mux(_io_out_T_64, _io_out_T_40, _io_out_T_63) @[Mux.scala 81:58]
    node _io_out_T_66 = eq(UInt<5>("h9"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_67 = mux(_io_out_T_66, _io_out_T_42, _io_out_T_65) @[Mux.scala 81:58]
    node _io_out_T_68 = eq(UInt<5>("hb"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_69 = mux(_io_out_T_68, _io_out_T_44, _io_out_T_67) @[Mux.scala 81:58]
    node _io_out_T_70 = eq(UInt<5>("hd"), io.AluOp) @[Mux.scala 81:61]
    node _io_out_T_71 = mux(_io_out_T_70, _io_out_T_45, _io_out_T_69) @[Mux.scala 81:58]
    io.out <= _io_out_T_71 @[ALU.scala 32:12]
    node _io_zero_T = asSInt(io.A) @[ALU.scala 25:31]
    node _io_zero_T_1 = asSInt(io.B) @[ALU.scala 25:45]
    node _io_zero_T_2 = lt(_io_zero_T, _io_zero_T_1) @[ALU.scala 25:38]
    node _io_zero_T_3 = asSInt(io.A) @[ALU.scala 26:31]
    node _io_zero_T_4 = asSInt(io.B) @[ALU.scala 26:46]
    node _io_zero_T_5 = geq(_io_zero_T_3, _io_zero_T_4) @[ALU.scala 26:38]
    node _io_zero_T_6 = neq(io.A, io.B) @[ALU.scala 27:31]
    node _io_zero_T_7 = eq(io.A, io.B) @[ALU.scala 28:31]
    node _io_zero_T_8 = eq(UInt<5>("hc"), io.AluOp) @[Mux.scala 81:61]
    node _io_zero_T_9 = mux(_io_zero_T_8, _io_zero_T_2, UInt<1>("h0")) @[Mux.scala 81:58]
    node _io_zero_T_10 = eq(UInt<5>("hf"), io.AluOp) @[Mux.scala 81:61]
    node _io_zero_T_11 = mux(_io_zero_T_10, _io_zero_T_5, _io_zero_T_9) @[Mux.scala 81:58]
    node _io_zero_T_12 = eq(UInt<5>("h10"), io.AluOp) @[Mux.scala 81:61]
    node _io_zero_T_13 = mux(_io_zero_T_12, _io_zero_T_6, _io_zero_T_11) @[Mux.scala 81:58]
    node _io_zero_T_14 = eq(UInt<5>("h11"), io.AluOp) @[Mux.scala 81:61]
    node _io_zero_T_15 = mux(_io_zero_T_14, _io_zero_T_7, _io_zero_T_13) @[Mux.scala 81:58]
    io.zero <= _io_zero_T_15 @[ALU.scala 55:13]

  module Execute :
    input clock : Clock
    input reset : Reset
    output exec_io : { flip NextPC : UInt<32>, flip Imm : UInt<32>, flip rs : UInt<32>, flip rt : UInt<32>, flip rd : UInt<32>, flip DataRead1 : UInt<32>, flip DataRead2 : UInt<32>, flip MemWbEn : UInt<1>, flip MemAddr : UInt<32>, flip MemVal : UInt<32>, flip WbWbEn : UInt<1>, flip WbAddr : UInt<32>, flip WbVal : UInt<32>, flip AluOp : UInt<8>, flip ImmEn : UInt<1>, flip WriteEnIn : UInt<1>, flip ReadEnIn : UInt<1>, flip BrEnIn : UInt<1>, flip WbEnIn : UInt<1>, flip WbTypeIn : UInt<1>, AluRes : UInt<32>, zero : UInt<1>, BranchAddrOut : UInt<32>, WriteData : UInt<32>, ReadEnOut : UInt<1>, WriteEnOut : UInt<1>, BrEnOut : UInt<1>, WbTypeOut : UInt<1>, WbEnOut : UInt<1>, WriteRegAddr : UInt<32>}

    inst alu of ALU @[Execute.scala 7:21]
    alu.clock <= clock
    alu.reset <= reset
    node isImmediate = eq(exec_io.ImmEn, UInt<1>("h1")) @[Execute.scala 68:43]
    node _A_T = eq(exec_io.rs, exec_io.MemAddr) @[Execute.scala 60:14]
    node _A_T_1 = eq(exec_io.MemWbEn, UInt<1>("h0")) @[Execute.scala 60:52]
    node _A_T_2 = and(_A_T, _A_T_1) @[Execute.scala 60:34]
    node _A_T_3 = eq(exec_io.rs, exec_io.WbAddr) @[Execute.scala 62:19]
    node _A_T_4 = eq(exec_io.WbWbEn, UInt<1>("h0")) @[Execute.scala 62:55]
    node _A_T_5 = and(_A_T_3, _A_T_4) @[Execute.scala 62:38]
    node _A_T_6 = mux(_A_T_5, exec_io.WbVal, exec_io.DataRead1) @[Execute.scala 62:12]
    node A = mux(_A_T_2, exec_io.MemVal, _A_T_6) @[Execute.scala 59:54]
    node _B_T = eq(exec_io.rt, exec_io.MemAddr) @[Execute.scala 60:14]
    node _B_T_1 = eq(exec_io.MemWbEn, UInt<1>("h0")) @[Execute.scala 60:52]
    node _B_T_2 = and(_B_T, _B_T_1) @[Execute.scala 60:34]
    node _B_T_3 = eq(exec_io.rt, exec_io.WbAddr) @[Execute.scala 62:19]
    node _B_T_4 = eq(exec_io.WbWbEn, UInt<1>("h0")) @[Execute.scala 62:55]
    node _B_T_5 = and(_B_T_3, _B_T_4) @[Execute.scala 62:38]
    node _B_T_6 = mux(_B_T_5, exec_io.WbVal, exec_io.DataRead2) @[Execute.scala 62:12]
    node B = mux(_B_T_2, exec_io.MemVal, _B_T_6) @[Execute.scala 59:54]
    alu.io.A <= A @[Execute.scala 79:14]
    node _alu_io_B_T = mux(exec_io.ImmEn, exec_io.Imm, B) @[Execute.scala 80:20]
    alu.io.B <= _alu_io_B_T @[Execute.scala 80:14]
    alu.io.AluOp <= exec_io.AluOp @[Execute.scala 81:18]
    exec_io.AluRes <= alu.io.out @[Execute.scala 82:20]
    exec_io.zero <= alu.io.zero @[Execute.scala 83:18]
    exec_io.BranchAddrOut <= exec_io.Imm @[Execute.scala 86:27]
    exec_io.BrEnOut <= exec_io.BrEnIn @[Execute.scala 87:21]
    exec_io.WbTypeOut <= exec_io.WbTypeIn @[Execute.scala 88:23]
    exec_io.WbEnOut <= exec_io.WbEnIn @[Execute.scala 89:21]
    exec_io.ReadEnOut <= exec_io.ReadEnIn @[Execute.scala 90:23]
    exec_io.WriteEnOut <= exec_io.WriteEnIn @[Execute.scala 91:24]
    exec_io.WriteData <= B @[Execute.scala 94:23]
    node _exec_io_WriteRegAddr_T = mux(isImmediate, exec_io.rt, exec_io.rd) @[Execute.scala 97:32]
    exec_io.WriteRegAddr <= _exec_io_WriteRegAddr_T @[Execute.scala 97:26]

  module RAM :
    input clock : Clock
    input reset : Reset
    output ram_io : { flip WriteEn : UInt<1>, flip ReadEn : UInt<1>, flip Addr : UInt<10>, flip WriteData : UInt<32>, ReadData : UInt<32>}

    smem mem : UInt<32> [1024] @[RAM.scala 15:26]
    reg PrevAddr : UInt, clock with :
      reset => (UInt<1>("h0"), PrevAddr) @[RAM.scala 29:28]
    PrevAddr <= ram_io.Addr @[RAM.scala 29:28]
    reg PrevReadEn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), PrevReadEn) @[RAM.scala 30:30]
    PrevReadEn <= ram_io.ReadEn @[RAM.scala 30:30]
    reg PrevWrEn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), PrevWrEn) @[RAM.scala 32:28]
    PrevWrEn <= ram_io.WriteEn @[RAM.scala 32:28]
    reg PrevWrData : UInt, clock with :
      reset => (UInt<1>("h0"), PrevWrData) @[RAM.scala 33:29]
    PrevWrData <= ram_io.WriteData @[RAM.scala 33:29]
    node _isValid_T = geq(ram_io.Addr, UInt<1>("h0")) @[RAM.scala 35:33]
    node _isValid_T_1 = lt(ram_io.Addr, UInt<11>("h400")) @[RAM.scala 35:50]
    node isValid = and(_isValid_T, _isValid_T_1) @[RAM.scala 35:40]
    node _T = and(ram_io.WriteEn, isValid) @[RAM.scala 37:27]
    when _T : @[RAM.scala 37:39]
      write mport MPORT = mem[ram_io.Addr], clock
      MPORT <= ram_io.WriteData
    reg RegAddr : UInt, clock with :
      reset => (UInt<1>("h0"), RegAddr) @[RAM.scala 41:22]
    node ReadAllowed = and(ram_io.ReadEn, isValid) @[RAM.scala 42:33]
    when ReadAllowed : @[RAM.scala 43:26]
      RegAddr <= ram_io.Addr @[RAM.scala 43:36]
    wire _ReadData_WIRE : UInt @[RAM.scala 44:46]
    _ReadData_WIRE is invalid @[RAM.scala 44:46]
    when UInt<1>("h1") : @[RAM.scala 44:46]
      _ReadData_WIRE <= RegAddr @[RAM.scala 44:46]
      node _ReadData_T = or(_ReadData_WIRE, UInt<10>("h0")) @[RAM.scala 44:46]
      node _ReadData_T_1 = bits(_ReadData_T, 9, 0) @[RAM.scala 44:46]
      read mport ReadData_MPORT = mem[_ReadData_T_1], clock @[RAM.scala 44:46]
    node ReadData = mux(ReadAllowed, ReadData_MPORT, UInt<1>("h0")) @[RAM.scala 44:23]
    node _doForwardWr_T = eq(ram_io.Addr, PrevAddr) @[RAM.scala 46:31]
    node _doForwardWr_T_1 = and(_doForwardWr_T, PrevWrEn) @[RAM.scala 46:44]
    node doForwardWr = and(_doForwardWr_T_1, ram_io.ReadEn) @[RAM.scala 46:55]
    node _ram_io_ReadData_T = mux(doForwardWr, PrevWrData, ReadData) @[RAM.scala 47:27]
    ram_io.ReadData <= _ram_io_ReadData_T @[RAM.scala 47:21]

  module SignExtend_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<8>, flip isSigned : UInt<1>, out : UInt<32>}

    node low = bits(io.in, 7, 0) @[SignExtend.scala 11:26]
    node _high_T = bits(io.in, 7, 7) @[SignExtend.scala 12:46]
    node _high_T_1 = eq(_high_T, UInt<1>("h1")) @[SignExtend.scala 12:56]
    node _high_T_2 = and(io.isSigned, _high_T_1) @[SignExtend.scala 12:38]
    node high = mux(_high_T_2, UInt<15>("h7fff"), UInt<1>("h0")) @[SignExtend.scala 12:25]
    node _io_out_T = cat(high, low) @[Cat.scala 31:58]
    io.out <= _io_out_T @[SignExtend.scala 13:12]

  module EnRegister :
    input clock : Clock
    input reset : Reset
    output io : { flip DataIn : UInt<8>, flip WrEn : UInt<1>, DataOut : UInt<32>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[EnRegister.scala 6:22]
    inst signExtend of SignExtend_1 @[EnRegister.scala 8:28]
    signExtend.clock <= clock
    signExtend.reset <= reset
    when io.WrEn : @[EnRegister.scala 16:20]
      reg <= io.DataIn @[EnRegister.scala 16:26]
    signExtend.io.isSigned <= UInt<1>("h0") @[EnRegister.scala 17:28]
    signExtend.io.in <= reg @[EnRegister.scala 18:22]
    io.DataOut <= signExtend.io.out @[EnRegister.scala 19:16]

  module SignExtend_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<8>, flip isSigned : UInt<1>, out : UInt<32>}

    node low = bits(io.in, 7, 0) @[SignExtend.scala 11:26]
    node _high_T = bits(io.in, 7, 7) @[SignExtend.scala 12:46]
    node _high_T_1 = eq(_high_T, UInt<1>("h1")) @[SignExtend.scala 12:56]
    node _high_T_2 = and(io.isSigned, _high_T_1) @[SignExtend.scala 12:38]
    node high = mux(_high_T_2, UInt<15>("h7fff"), UInt<1>("h0")) @[SignExtend.scala 12:25]
    node _io_out_T = cat(high, low) @[Cat.scala 31:58]
    io.out <= _io_out_T @[SignExtend.scala 13:12]

  module EnRegister_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip DataIn : UInt<8>, flip WrEn : UInt<1>, DataOut : UInt<32>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[EnRegister.scala 6:22]
    inst signExtend of SignExtend_2 @[EnRegister.scala 8:28]
    signExtend.clock <= clock
    signExtend.reset <= reset
    when io.WrEn : @[EnRegister.scala 16:20]
      reg <= io.DataIn @[EnRegister.scala 16:26]
    signExtend.io.isSigned <= UInt<1>("h0") @[EnRegister.scala 17:28]
    signExtend.io.in <= reg @[EnRegister.scala 18:22]
    io.DataOut <= signExtend.io.out @[EnRegister.scala 19:16]

  module SignExtend_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<16>, flip isSigned : UInt<1>, out : UInt<32>}

    node low = bits(io.in, 15, 0) @[SignExtend.scala 11:26]
    node _high_T = bits(io.in, 15, 15) @[SignExtend.scala 12:46]
    node _high_T_1 = eq(_high_T, UInt<1>("h1")) @[SignExtend.scala 12:56]
    node _high_T_2 = and(io.isSigned, _high_T_1) @[SignExtend.scala 12:38]
    node high = mux(_high_T_2, UInt<15>("h7fff"), UInt<1>("h0")) @[SignExtend.scala 12:25]
    node _io_out_T = cat(high, low) @[Cat.scala 31:58]
    io.out <= _io_out_T @[SignExtend.scala 13:12]

  module EnRegister_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip DataIn : UInt<16>, flip WrEn : UInt<1>, DataOut : UInt<32>}

    reg reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[EnRegister.scala 6:22]
    inst signExtend of SignExtend_3 @[EnRegister.scala 8:28]
    signExtend.clock <= clock
    signExtend.reset <= reset
    when io.WrEn : @[EnRegister.scala 16:20]
      reg <= io.DataIn @[EnRegister.scala 16:26]
    signExtend.io.isSigned <= UInt<1>("h0") @[EnRegister.scala 17:28]
    signExtend.io.in <= reg @[EnRegister.scala 18:22]
    io.DataOut <= signExtend.io.out @[EnRegister.scala 19:16]

  module Mem :
    input clock : Clock
    input reset : Reset
    output mem_io : { flip Inport1 : UInt<8>, flip Inport2 : UInt<8>, Outport : UInt<16>, flip WriteEn : UInt<1>, flip ReadEn : UInt<1>, flip CtrlBrEn : UInt<1>, flip WbTypeIn : UInt<1>, flip WbEnIn : UInt<1>, flip AluBrEn : UInt<1>, flip BrAddrIn : UInt<32>, flip WriteRegAddrIn : UInt<32>, flip WriteData : UInt<32>, flip AddrIn : UInt<32>, ReadData : UInt<32>, WbTypeOut : UInt<1>, WbEnOut : UInt<1>, AddrOut : UInt<32>, WriteRegAddrOut : UInt<32>, BrAddrOut : UInt<32>, BrEnOut : UInt<1>}

    inst ram of RAM @[Mem.scala 7:21]
    ram.clock <= clock
    ram.reset <= reset
    inst Inport1 of EnRegister @[Mem.scala 10:25]
    Inport1.clock <= clock
    Inport1.reset <= reset
    inst Inport2 of EnRegister_1 @[Mem.scala 11:25]
    Inport2.clock <= clock
    Inport2.reset <= reset
    inst Outport of EnRegister_2 @[Mem.scala 12:25]
    Outport.clock <= clock
    Outport.reset <= reset
    node _AddrSel_T = eq(mem_io.AddrIn, UInt<10>("h3fd")) @[Mem.scala 55:24]
    node _AddrSel_T_1 = eq(mem_io.AddrIn, UInt<10>("h3fe")) @[Mem.scala 56:24]
    node _AddrSel_T_2 = eq(mem_io.AddrIn, UInt<10>("h3ff")) @[Mem.scala 57:24]
    node _AddrSel_T_3 = mux(_AddrSel_T_2, UInt<2>("h3"), UInt<1>("h0")) @[Mux.scala 101:16]
    node _AddrSel_T_4 = mux(_AddrSel_T_1, UInt<2>("h2"), _AddrSel_T_3) @[Mux.scala 101:16]
    node AddrSel = mux(_AddrSel_T, UInt<1>("h1"), _AddrSel_T_4) @[Mux.scala 101:16]
    Inport1.io.DataIn <= mem_io.Inport1 @[Mem.scala 60:23]
    Inport1.io.WrEn <= UInt<1>("h1") @[Mem.scala 61:21]
    Inport2.io.DataIn <= mem_io.Inport2 @[Mem.scala 62:23]
    Inport2.io.WrEn <= UInt<1>("h1") @[Mem.scala 63:21]
    Outport.io.DataIn <= mem_io.WriteData @[Mem.scala 64:23]
    Outport.io.WrEn <= UInt<1>("h1") @[Mem.scala 65:21]
    mem_io.Outport <= Outport.io.DataOut @[Mem.scala 67:20]
    ram.ram_io.Addr <= mem_io.AddrIn @[Mem.scala 69:21]
    node _ram_ram_io_ReadEn_T = eq(AddrSel, UInt<1>("h0")) @[Mem.scala 70:51]
    node _ram_ram_io_ReadEn_T_1 = and(mem_io.ReadEn, _ram_ram_io_ReadEn_T) @[Mem.scala 70:41]
    ram.ram_io.ReadEn <= _ram_ram_io_ReadEn_T_1 @[Mem.scala 70:23]
    node _ram_ram_io_WriteEn_T = eq(AddrSel, UInt<1>("h0")) @[Mem.scala 71:53]
    node _ram_ram_io_WriteEn_T_1 = and(mem_io.WriteEn, _ram_ram_io_WriteEn_T) @[Mem.scala 71:43]
    ram.ram_io.WriteEn <= _ram_ram_io_WriteEn_T_1 @[Mem.scala 71:24]
    ram.ram_io.WriteData <= mem_io.WriteData @[Mem.scala 72:26]
    node _mem_io_ReadData_T = eq(mem_io.AddrIn, UInt<10>("h3fd")) @[Mem.scala 74:24]
    node _mem_io_ReadData_T_1 = eq(mem_io.AddrIn, UInt<10>("h3fe")) @[Mem.scala 75:24]
    node _mem_io_ReadData_T_2 = eq(mem_io.AddrIn, UInt<10>("h3ff")) @[Mem.scala 76:24]
    node _mem_io_ReadData_T_3 = mux(_mem_io_ReadData_T_2, Outport.io.DataOut, ram.ram_io.ReadData) @[Mux.scala 101:16]
    node _mem_io_ReadData_T_4 = mux(_mem_io_ReadData_T_1, Inport2.io.DataOut, _mem_io_ReadData_T_3) @[Mux.scala 101:16]
    node _mem_io_ReadData_T_5 = mux(_mem_io_ReadData_T, Inport1.io.DataOut, _mem_io_ReadData_T_4) @[Mux.scala 101:16]
    mem_io.ReadData <= _mem_io_ReadData_T_5 @[Mem.scala 73:21]
    mem_io.BrAddrOut <= mem_io.BrAddrIn @[Mem.scala 79:22]
    mem_io.WbTypeOut <= mem_io.WbTypeIn @[Mem.scala 81:22]
    mem_io.WbEnOut <= mem_io.WbEnIn @[Mem.scala 82:20]
    mem_io.AddrOut <= mem_io.AddrIn @[Mem.scala 83:20]
    node _mem_io_BrEnOut_T = and(mem_io.AluBrEn, mem_io.CtrlBrEn) @[Mem.scala 85:38]
    mem_io.BrEnOut <= _mem_io_BrEnOut_T @[Mem.scala 85:20]
    mem_io.WriteRegAddrOut <= mem_io.WriteRegAddrIn @[Mem.scala 87:28]

  module Writeback :
    input clock : Clock
    input reset : Reset
    output wb_io : { flip WbEnIn : UInt<1>, flip WbTypeIn : UInt<1>, flip WriteRegAddrIn : UInt<32>, flip ReadData : UInt<32>, flip AddrData : UInt<32>, WbEnOut : UInt<1>, WriteRegAddrOut : UInt<32>, WriteDataOut : UInt<32>}

    wb_io.WbEnOut <= wb_io.WbEnIn @[Writeback.scala 20:19]
    wb_io.WriteRegAddrOut <= wb_io.WriteRegAddrIn @[Writeback.scala 21:27]
    node _wb_io_WriteDataOut_T = mux(wb_io.WbTypeIn, wb_io.ReadData, wb_io.AddrData) @[Writeback.scala 22:30]
    wb_io.WriteDataOut <= _wb_io_WriteDataOut_T @[Writeback.scala 22:24]

  module Datapath :
    input clock : Clock
    input reset : Reset
    output io : { flip Inport1 : UInt<8>, flip Inport2 : UInt<8>, instr : UInt<32>, Outport : UInt<16>}

    inst fetch of Fetch @[Datapath.scala 6:23]
    fetch.clock <= clock
    fetch.reset <= reset
    inst decode of Decode @[Datapath.scala 7:24]
    decode.clock <= clock
    decode.reset <= reset
    inst execute of Execute @[Datapath.scala 8:25]
    execute.clock <= clock
    execute.reset <= reset
    inst memory of Mem @[Datapath.scala 9:24]
    memory.clock <= clock
    memory.reset <= reset
    inst writeback of Writeback @[Datapath.scala 10:27]
    writeback.clock <= clock
    writeback.reset <= reset
    io.instr <= fetch.io.Instr @[Datapath.scala 20:17]
    fetch.io.Stall <= decode.dec_io.BrEn @[Datapath.scala 23:25]
    fetch.io.BrEn <= memory.mem_io.BrEnOut @[Datapath.scala 24:25]
    fetch.io.BranchAddr <= memory.mem_io.BrAddrOut @[Datapath.scala 25:25]
    reg decode_dec_io_Instr_REG : UInt, clock with :
      reset => (UInt<1>("h0"), decode_dec_io_Instr_REG) @[Datapath.scala 28:43]
    decode_dec_io_Instr_REG <= fetch.io.Instr @[Datapath.scala 28:43]
    decode.dec_io.Instr <= decode_dec_io_Instr_REG @[Datapath.scala 28:33]
    reg decode_dec_io_NextPCIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), decode_dec_io_NextPCIn_REG) @[Datapath.scala 29:43]
    decode_dec_io_NextPCIn_REG <= fetch.io.NextPC @[Datapath.scala 29:43]
    decode.dec_io.NextPCIn <= decode_dec_io_NextPCIn_REG @[Datapath.scala 29:33]
    decode.dec_io.WriteEnIn <= writeback.wb_io.WbEnOut @[Datapath.scala 30:33]
    decode.dec_io.WriteAddrIn <= writeback.wb_io.WriteRegAddrOut @[Datapath.scala 31:33]
    decode.dec_io.WriteDataIn <= writeback.wb_io.WriteDataOut @[Datapath.scala 32:33]
    reg execute_exec_io_rs_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_rs_REG) @[Datapath.scala 35:43]
    execute_exec_io_rs_REG <= decode.dec_io.rs @[Datapath.scala 35:43]
    execute.exec_io.rs <= execute_exec_io_rs_REG @[Datapath.scala 35:33]
    reg execute_exec_io_rt_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_rt_REG) @[Datapath.scala 36:43]
    execute_exec_io_rt_REG <= decode.dec_io.rt @[Datapath.scala 36:43]
    execute.exec_io.rt <= execute_exec_io_rt_REG @[Datapath.scala 36:33]
    reg execute_exec_io_rd_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_rd_REG) @[Datapath.scala 37:43]
    execute_exec_io_rd_REG <= decode.dec_io.rd @[Datapath.scala 37:43]
    execute.exec_io.rd <= execute_exec_io_rd_REG @[Datapath.scala 37:33]
    reg execute_exec_io_DataRead1_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_DataRead1_REG) @[Datapath.scala 38:43]
    execute_exec_io_DataRead1_REG <= decode.dec_io.DataRead1 @[Datapath.scala 38:43]
    execute.exec_io.DataRead1 <= execute_exec_io_DataRead1_REG @[Datapath.scala 38:33]
    reg execute_exec_io_DataRead2_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_DataRead2_REG) @[Datapath.scala 39:43]
    execute_exec_io_DataRead2_REG <= decode.dec_io.DataRead2 @[Datapath.scala 39:43]
    execute.exec_io.DataRead2 <= execute_exec_io_DataRead2_REG @[Datapath.scala 39:33]
    execute.exec_io.MemWbEn <= memory.mem_io.WbEnOut @[Datapath.scala 40:33]
    execute.exec_io.MemAddr <= memory.mem_io.WriteRegAddrOut @[Datapath.scala 41:33]
    reg execute_exec_io_MemVal_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_MemVal_REG) @[Datapath.scala 42:43]
    execute_exec_io_MemVal_REG <= execute.exec_io.AluRes @[Datapath.scala 42:43]
    execute.exec_io.MemVal <= execute_exec_io_MemVal_REG @[Datapath.scala 42:33]
    execute.exec_io.WbWbEn <= writeback.wb_io.WbEnOut @[Datapath.scala 43:33]
    execute.exec_io.WbAddr <= writeback.wb_io.WriteRegAddrOut @[Datapath.scala 44:33]
    execute.exec_io.WbVal <= writeback.wb_io.WriteDataOut @[Datapath.scala 45:33]
    reg execute_exec_io_AluOp_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_AluOp_REG) @[Datapath.scala 46:43]
    execute_exec_io_AluOp_REG <= decode.dec_io.AluOp @[Datapath.scala 46:43]
    execute.exec_io.AluOp <= execute_exec_io_AluOp_REG @[Datapath.scala 46:33]
    reg execute_exec_io_Imm_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_Imm_REG) @[Datapath.scala 47:43]
    execute_exec_io_Imm_REG <= decode.dec_io.Imm @[Datapath.scala 47:43]
    execute.exec_io.Imm <= execute_exec_io_Imm_REG @[Datapath.scala 47:33]
    reg execute_exec_io_ImmEn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_ImmEn_REG) @[Datapath.scala 48:43]
    execute_exec_io_ImmEn_REG <= decode.dec_io.ImmEn @[Datapath.scala 48:43]
    execute.exec_io.ImmEn <= execute_exec_io_ImmEn_REG @[Datapath.scala 48:33]
    reg execute_exec_io_BrEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_BrEnIn_REG) @[Datapath.scala 49:43]
    execute_exec_io_BrEnIn_REG <= decode.dec_io.BrEn @[Datapath.scala 49:43]
    execute.exec_io.BrEnIn <= execute_exec_io_BrEnIn_REG @[Datapath.scala 49:33]
    reg execute_exec_io_NextPC_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_NextPC_REG) @[Datapath.scala 50:43]
    execute_exec_io_NextPC_REG <= decode.dec_io.NextPCOut @[Datapath.scala 50:43]
    execute.exec_io.NextPC <= execute_exec_io_NextPC_REG @[Datapath.scala 50:33]
    reg execute_exec_io_ReadEnIn_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_ReadEnIn_REG) @[Datapath.scala 51:43]
    execute_exec_io_ReadEnIn_REG <= decode.dec_io.ReadEn @[Datapath.scala 51:43]
    execute.exec_io.ReadEnIn <= execute_exec_io_ReadEnIn_REG @[Datapath.scala 51:33]
    reg execute_exec_io_WriteEnIn_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_WriteEnIn_REG) @[Datapath.scala 52:43]
    execute_exec_io_WriteEnIn_REG <= decode.dec_io.WriteEnOut @[Datapath.scala 52:43]
    execute.exec_io.WriteEnIn <= execute_exec_io_WriteEnIn_REG @[Datapath.scala 52:33]
    reg execute_exec_io_WbTypeIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_WbTypeIn_REG) @[Datapath.scala 53:43]
    execute_exec_io_WbTypeIn_REG <= decode.dec_io.WbType @[Datapath.scala 53:43]
    execute.exec_io.WbTypeIn <= execute_exec_io_WbTypeIn_REG @[Datapath.scala 53:33]
    reg execute_exec_io_WbEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_WbEnIn_REG) @[Datapath.scala 54:43]
    execute_exec_io_WbEnIn_REG <= decode.dec_io.WbEn @[Datapath.scala 54:43]
    execute.exec_io.WbEnIn <= execute_exec_io_WbEnIn_REG @[Datapath.scala 54:33]
    reg memory_mem_io_ReadEn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_ReadEn_REG) @[Datapath.scala 57:47]
    memory_mem_io_ReadEn_REG <= execute.exec_io.ReadEnOut @[Datapath.scala 57:47]
    memory.mem_io.ReadEn <= memory_mem_io_ReadEn_REG @[Datapath.scala 57:37]
    reg memory_mem_io_AddrIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_AddrIn_REG) @[Datapath.scala 58:47]
    memory_mem_io_AddrIn_REG <= execute.exec_io.AluRes @[Datapath.scala 58:47]
    memory.mem_io.AddrIn <= memory_mem_io_AddrIn_REG @[Datapath.scala 58:37]
    reg memory_mem_io_WriteEn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_WriteEn_REG) @[Datapath.scala 59:47]
    memory_mem_io_WriteEn_REG <= execute.exec_io.WriteEnOut @[Datapath.scala 59:47]
    memory.mem_io.WriteEn <= memory_mem_io_WriteEn_REG @[Datapath.scala 59:37]
    reg memory_mem_io_WbEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_WbEnIn_REG) @[Datapath.scala 60:47]
    memory_mem_io_WbEnIn_REG <= execute.exec_io.WbEnOut @[Datapath.scala 60:47]
    memory.mem_io.WbEnIn <= memory_mem_io_WbEnIn_REG @[Datapath.scala 60:37]
    reg memory_mem_io_WbTypeIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_WbTypeIn_REG) @[Datapath.scala 61:47]
    memory_mem_io_WbTypeIn_REG <= execute.exec_io.WbTypeOut @[Datapath.scala 61:47]
    memory.mem_io.WbTypeIn <= memory_mem_io_WbTypeIn_REG @[Datapath.scala 61:37]
    reg memory_mem_io_WriteData_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_WriteData_REG) @[Datapath.scala 62:47]
    memory_mem_io_WriteData_REG <= execute.exec_io.WriteData @[Datapath.scala 62:47]
    memory.mem_io.WriteData <= memory_mem_io_WriteData_REG @[Datapath.scala 62:37]
    reg memory_mem_io_CtrlBrEn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_CtrlBrEn_REG) @[Datapath.scala 63:47]
    memory_mem_io_CtrlBrEn_REG <= execute.exec_io.BrEnOut @[Datapath.scala 63:47]
    memory.mem_io.CtrlBrEn <= memory_mem_io_CtrlBrEn_REG @[Datapath.scala 63:37]
    reg memory_mem_io_AluBrEn_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_AluBrEn_REG) @[Datapath.scala 64:47]
    memory_mem_io_AluBrEn_REG <= execute.exec_io.zero @[Datapath.scala 64:47]
    memory.mem_io.AluBrEn <= memory_mem_io_AluBrEn_REG @[Datapath.scala 64:37]
    reg memory_mem_io_BrAddrIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_BrAddrIn_REG) @[Datapath.scala 65:47]
    memory_mem_io_BrAddrIn_REG <= execute.exec_io.BranchAddrOut @[Datapath.scala 65:47]
    memory.mem_io.BrAddrIn <= memory_mem_io_BrAddrIn_REG @[Datapath.scala 65:37]
    reg memory_mem_io_WriteRegAddrIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_WriteRegAddrIn_REG) @[Datapath.scala 66:47]
    memory_mem_io_WriteRegAddrIn_REG <= execute.exec_io.WriteRegAddr @[Datapath.scala 66:47]
    memory.mem_io.WriteRegAddrIn <= memory_mem_io_WriteRegAddrIn_REG @[Datapath.scala 66:37]
    memory.mem_io.Inport1 <= io.Inport1 @[Datapath.scala 68:27]
    memory.mem_io.Inport2 <= io.Inport2 @[Datapath.scala 69:27]
    io.Outport <= memory.mem_io.Outport @[Datapath.scala 70:27]
    reg writeback_wb_io_WbEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_WbEnIn_REG) @[Datapath.scala 73:47]
    writeback_wb_io_WbEnIn_REG <= memory.mem_io.WbEnOut @[Datapath.scala 73:47]
    writeback.wb_io.WbEnIn <= writeback_wb_io_WbEnIn_REG @[Datapath.scala 73:37]
    reg writeback_wb_io_WbTypeIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_WbTypeIn_REG) @[Datapath.scala 74:47]
    writeback_wb_io_WbTypeIn_REG <= memory.mem_io.WbTypeOut @[Datapath.scala 74:47]
    writeback.wb_io.WbTypeIn <= writeback_wb_io_WbTypeIn_REG @[Datapath.scala 74:37]
    reg writeback_wb_io_ReadData_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_ReadData_REG) @[Datapath.scala 75:47]
    writeback_wb_io_ReadData_REG <= memory.mem_io.ReadData @[Datapath.scala 75:47]
    writeback.wb_io.ReadData <= writeback_wb_io_ReadData_REG @[Datapath.scala 75:37]
    reg writeback_wb_io_AddrData_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_AddrData_REG) @[Datapath.scala 76:47]
    writeback_wb_io_AddrData_REG <= memory.mem_io.AddrOut @[Datapath.scala 76:47]
    writeback.wb_io.AddrData <= writeback_wb_io_AddrData_REG @[Datapath.scala 76:37]
    reg writeback_wb_io_WriteRegAddrIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_WriteRegAddrIn_REG) @[Datapath.scala 77:47]
    writeback_wb_io_WriteRegAddrIn_REG <= memory.mem_io.WriteRegAddrOut @[Datapath.scala 77:47]
    writeback.wb_io.WriteRegAddrIn <= writeback_wb_io_WriteRegAddrIn_REG @[Datapath.scala 77:37]

  module decoder7seg :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module decoder7seg_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module decoder7seg_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module decoder7seg_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module decoder7seg_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module decoder7seg_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module decoder7seg_6 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module decoder7seg_7 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire result : UInt<7>
    result <= UInt<7>("h0")
    node _T = eq(UInt<1>("h0"), io.in) @[decoder7seg.scala 14:17]
    when _T : @[decoder7seg.scala 14:17]
      result <= UInt<7>("h40") @[decoder7seg.scala 15:29]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[decoder7seg.scala 14:17]
      when _T_1 : @[decoder7seg.scala 14:17]
        result <= UInt<7>("h79") @[decoder7seg.scala 16:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[decoder7seg.scala 14:17]
        when _T_2 : @[decoder7seg.scala 14:17]
          result <= UInt<6>("h24") @[decoder7seg.scala 17:29]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[decoder7seg.scala 14:17]
          when _T_3 : @[decoder7seg.scala 14:17]
            result <= UInt<6>("h30") @[decoder7seg.scala 18:29]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[decoder7seg.scala 14:17]
            when _T_4 : @[decoder7seg.scala 14:17]
              result <= UInt<5>("h19") @[decoder7seg.scala 19:29]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[decoder7seg.scala 14:17]
              when _T_5 : @[decoder7seg.scala 14:17]
                result <= UInt<5>("h12") @[decoder7seg.scala 20:29]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[decoder7seg.scala 14:17]
                when _T_6 : @[decoder7seg.scala 14:17]
                  result <= UInt<2>("h2") @[decoder7seg.scala 21:29]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[decoder7seg.scala 14:17]
                  when _T_7 : @[decoder7seg.scala 14:17]
                    result <= UInt<7>("h78") @[decoder7seg.scala 22:29]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[decoder7seg.scala 14:17]
                    when _T_8 : @[decoder7seg.scala 14:17]
                      result <= UInt<1>("h0") @[decoder7seg.scala 23:29]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[decoder7seg.scala 14:17]
                      when _T_9 : @[decoder7seg.scala 14:17]
                        result <= UInt<5>("h18") @[decoder7seg.scala 24:29]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[decoder7seg.scala 14:17]
                        when _T_10 : @[decoder7seg.scala 14:17]
                          result <= UInt<4>("h8") @[decoder7seg.scala 25:29]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[decoder7seg.scala 14:17]
                          when _T_11 : @[decoder7seg.scala 14:17]
                            result <= UInt<2>("h3") @[decoder7seg.scala 26:29]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[decoder7seg.scala 14:17]
                            when _T_12 : @[decoder7seg.scala 14:17]
                              result <= UInt<7>("h46") @[decoder7seg.scala 27:29]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[decoder7seg.scala 14:17]
                              when _T_13 : @[decoder7seg.scala 14:17]
                                result <= UInt<6>("h21") @[decoder7seg.scala 28:29]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[decoder7seg.scala 14:17]
                                when _T_14 : @[decoder7seg.scala 14:17]
                                  result <= UInt<3>("h6") @[decoder7seg.scala 29:29]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[decoder7seg.scala 14:17]
                                  when _T_15 : @[decoder7seg.scala 14:17]
                                    result <= UInt<4>("he") @[decoder7seg.scala 30:29]
    io.out <= result @[decoder7seg.scala 34:12]

  module Tx :
    input clock : Clock
    input reset : Reset
    output io : { txd : UInt<1>, flip channel : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg shiftReg : UInt, clock with :
      reset => (reset, UInt<11>("h7ff")) @[Uart.scala 29:25]
    reg cntReg : UInt<20>, clock with :
      reset => (reset, UInt<20>("h0")) @[Uart.scala 30:23]
    reg bitsReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[Uart.scala 31:24]
    node _io_channel_ready_T = eq(cntReg, UInt<1>("h0")) @[Uart.scala 33:31]
    node _io_channel_ready_T_1 = eq(bitsReg, UInt<1>("h0")) @[Uart.scala 33:52]
    node _io_channel_ready_T_2 = and(_io_channel_ready_T, _io_channel_ready_T_1) @[Uart.scala 33:40]
    io.channel.ready <= _io_channel_ready_T_2 @[Uart.scala 33:20]
    node _io_txd_T = bits(shiftReg, 0, 0) @[Uart.scala 34:21]
    io.txd <= _io_txd_T @[Uart.scala 34:10]
    node _T = eq(cntReg, UInt<1>("h0")) @[Uart.scala 36:15]
    when _T : @[Uart.scala 36:24]
      cntReg <= UInt<9>("h1b1") @[Uart.scala 38:12]
      node _T_1 = neq(bitsReg, UInt<1>("h0")) @[Uart.scala 39:18]
      when _T_1 : @[Uart.scala 39:27]
        node shift = shr(shiftReg, 1) @[Uart.scala 40:28]
        node _shiftReg_T = bits(shift, 9, 0) @[Uart.scala 41:33]
        node _shiftReg_T_1 = cat(UInt<1>("h1"), _shiftReg_T) @[Cat.scala 31:58]
        shiftReg <= _shiftReg_T_1 @[Uart.scala 41:16]
        node _bitsReg_T = sub(bitsReg, UInt<1>("h1")) @[Uart.scala 42:26]
        node _bitsReg_T_1 = tail(_bitsReg_T, 1) @[Uart.scala 42:26]
        bitsReg <= _bitsReg_T_1 @[Uart.scala 42:15]
      else :
        when io.channel.valid : @[Uart.scala 44:30]
          node _shiftReg_T_2 = cat(UInt<2>("h3"), io.channel.bits) @[Cat.scala 31:58]
          node _shiftReg_T_3 = cat(_shiftReg_T_2, UInt<1>("h0")) @[Cat.scala 31:58]
          shiftReg <= _shiftReg_T_3 @[Uart.scala 45:18]
          bitsReg <= UInt<4>("hb") @[Uart.scala 46:17]
        else :
          shiftReg <= UInt<11>("h7ff") @[Uart.scala 48:18]
    else :
      node _cntReg_T = sub(cntReg, UInt<1>("h1")) @[Uart.scala 53:22]
      node _cntReg_T_1 = tail(_cntReg_T, 1) @[Uart.scala 53:22]
      cntReg <= _cntReg_T_1 @[Uart.scala 53:12]

  module Buffer :
    input clock : Clock
    input reset : Reset
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg stateReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Uart.scala 115:25]
    reg dataReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[Uart.scala 116:24]
    node _io_in_ready_T = eq(stateReg, UInt<1>("h0")) @[Uart.scala 118:27]
    io.in.ready <= _io_in_ready_T @[Uart.scala 118:15]
    node _io_out_valid_T = eq(stateReg, UInt<1>("h1")) @[Uart.scala 119:28]
    io.out.valid <= _io_out_valid_T @[Uart.scala 119:16]
    node _T = eq(stateReg, UInt<1>("h0")) @[Uart.scala 121:17]
    when _T : @[Uart.scala 121:28]
      when io.in.valid : @[Uart.scala 122:23]
        dataReg <= io.in.bits @[Uart.scala 123:15]
        stateReg <= UInt<1>("h1") @[Uart.scala 124:16]
    else :
      when io.out.ready : @[Uart.scala 127:24]
        stateReg <= UInt<1>("h0") @[Uart.scala 128:16]
    io.out.bits <= dataReg @[Uart.scala 131:15]

  module BufferedTx :
    input clock : Clock
    input reset : Reset
    output io : { txd : UInt<1>, flip channel : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    inst tx of Tx @[Uart.scala 142:18]
    tx.clock <= clock
    tx.reset <= reset
    inst buf of Buffer @[Uart.scala 143:19]
    buf.clock <= clock
    buf.reset <= reset
    buf.io.in.bits <= io.channel.bits @[Uart.scala 145:13]
    buf.io.in.valid <= io.channel.valid @[Uart.scala 145:13]
    io.channel.ready <= buf.io.in.ready @[Uart.scala 145:13]
    tx.io.channel.bits <= buf.io.out.bits @[Uart.scala 146:17]
    tx.io.channel.valid <= buf.io.out.valid @[Uart.scala 146:17]
    buf.io.out.ready <= tx.io.channel.ready @[Uart.scala 146:17]
    io.txd <= tx.io.txd @[Uart.scala 147:10]

  module Mintel :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip SW : UInt<18>, instr : UInt<32>, txd_instr : UInt<1>, hex7 : UInt<7>, hex6 : UInt<7>, hex5 : UInt<7>, hex4 : UInt<7>, hex3 : UInt<7>, hex2 : UInt<7>, hex1 : UInt<7>, hex0 : UInt<7>, LEDR : UInt<18>, LEDG : UInt<8>, flip KEY : UInt<4>, string : UInt<8>}

    inst datapath of Datapath @[Mintel.scala 44:26]
    datapath.clock <= clock
    datapath.reset <= reset
    io.instr <= datapath.io.instr @[Mintel.scala 46:18]
    node Inport1 = bits(io.SW, 7, 0) @[Mintel.scala 48:25]
    node Inport2 = bits(io.SW, 15, 8) @[Mintel.scala 49:25]
    wire Outport : UInt<16>
    Outport <= UInt<16>("h0")
    datapath.io.Inport1 <= Inport1 @[Mintel.scala 52:25]
    datapath.io.Inport2 <= Inport2 @[Mintel.scala 53:25]
    Outport <= datapath.io.Outport @[Mintel.scala 55:13]
    inst U_decoder7seg_7 of decoder7seg @[Mintel.scala 58:33]
    U_decoder7seg_7.clock <= clock
    U_decoder7seg_7.reset <= reset
    inst U_decoder7seg_6 of decoder7seg_1 @[Mintel.scala 59:33]
    U_decoder7seg_6.clock <= clock
    U_decoder7seg_6.reset <= reset
    inst U_decoder7seg_5 of decoder7seg_2 @[Mintel.scala 60:33]
    U_decoder7seg_5.clock <= clock
    U_decoder7seg_5.reset <= reset
    inst U_decoder7seg_4 of decoder7seg_3 @[Mintel.scala 61:33]
    U_decoder7seg_4.clock <= clock
    U_decoder7seg_4.reset <= reset
    inst U_decoder7seg_3 of decoder7seg_4 @[Mintel.scala 62:33]
    U_decoder7seg_3.clock <= clock
    U_decoder7seg_3.reset <= reset
    inst U_decoder7seg_2 of decoder7seg_5 @[Mintel.scala 63:33]
    U_decoder7seg_2.clock <= clock
    U_decoder7seg_2.reset <= reset
    inst U_decoder7seg_1 of decoder7seg_6 @[Mintel.scala 64:33]
    U_decoder7seg_1.clock <= clock
    U_decoder7seg_1.reset <= reset
    inst U_decoder7seg_0 of decoder7seg_7 @[Mintel.scala 65:33]
    U_decoder7seg_0.clock <= clock
    U_decoder7seg_0.reset <= reset
    node _U_decoder7seg_7_io_in_T = bits(Inport1, 7, 4) @[Mintel.scala 67:37]
    U_decoder7seg_7.io.in <= _U_decoder7seg_7_io_in_T @[Mintel.scala 67:27]
    node _U_decoder7seg_6_io_in_T = bits(Inport1, 3, 0) @[Mintel.scala 68:37]
    U_decoder7seg_6.io.in <= _U_decoder7seg_6_io_in_T @[Mintel.scala 68:27]
    node _U_decoder7seg_5_io_in_T = bits(Inport2, 7, 4) @[Mintel.scala 69:37]
    U_decoder7seg_5.io.in <= _U_decoder7seg_5_io_in_T @[Mintel.scala 69:27]
    node _U_decoder7seg_4_io_in_T = bits(Inport2, 3, 0) @[Mintel.scala 70:37]
    U_decoder7seg_4.io.in <= _U_decoder7seg_4_io_in_T @[Mintel.scala 70:27]
    node _U_decoder7seg_3_io_in_T = bits(Outport, 15, 12) @[Mintel.scala 72:37]
    U_decoder7seg_3.io.in <= _U_decoder7seg_3_io_in_T @[Mintel.scala 72:27]
    node _U_decoder7seg_2_io_in_T = bits(Outport, 11, 8) @[Mintel.scala 73:37]
    U_decoder7seg_2.io.in <= _U_decoder7seg_2_io_in_T @[Mintel.scala 73:27]
    node _U_decoder7seg_1_io_in_T = bits(Outport, 7, 4) @[Mintel.scala 74:37]
    U_decoder7seg_1.io.in <= _U_decoder7seg_1_io_in_T @[Mintel.scala 74:27]
    node _U_decoder7seg_0_io_in_T = bits(Outport, 3, 0) @[Mintel.scala 75:37]
    U_decoder7seg_0.io.in <= _U_decoder7seg_0_io_in_T @[Mintel.scala 75:27]
    io.hex7 <= U_decoder7seg_7.io.out @[Mintel.scala 77:13]
    io.hex6 <= U_decoder7seg_6.io.out @[Mintel.scala 78:13]
    io.hex5 <= U_decoder7seg_5.io.out @[Mintel.scala 79:13]
    io.hex4 <= U_decoder7seg_4.io.out @[Mintel.scala 80:13]
    io.hex3 <= U_decoder7seg_3.io.out @[Mintel.scala 81:13]
    io.hex2 <= U_decoder7seg_2.io.out @[Mintel.scala 82:13]
    io.hex1 <= U_decoder7seg_1.io.out @[Mintel.scala 83:13]
    io.hex0 <= U_decoder7seg_0.io.out @[Mintel.scala 84:13]
    inst tx of BufferedTx @[Mintel.scala 87:20]
    tx.clock <= clock
    tx.reset <= reset
    reg cntReg2 : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[Mintel.scala 90:26]
    reg h : UInt<8>, clock with :
      reset => (reset, UInt<8>("h30")) @[Mintel.scala 91:20]
    reg entire_thing : UInt<8>, clock with :
      reset => (reset, UInt<8>("h30")) @[Mintel.scala 92:31]
    node _nibble_T = bits(io.instr, 3, 0) @[Mintel.scala 95:30]
    node nibble = and(_nibble_T, UInt<4>("hf")) @[Mintel.scala 95:42]
    io.txd_instr <= tx.io.txd @[Mintel.scala 96:22]
    node _T = gt(nibble, UInt<4>("h9")) @[Mintel.scala 98:22]
    when _T : @[Mintel.scala 98:29]
      node _T_1 = eq(nibble, UInt<4>("ha")) @[Mintel.scala 99:26]
      when _T_1 : @[Mintel.scala 99:36]
        node _h_T = sub(UInt<7>("h41"), UInt<4>("ha")) @[Mintel.scala 100:28]
        node _h_T_1 = tail(_h_T, 1) @[Mintel.scala 100:28]
        node _h_T_2 = add(_h_T_1, nibble) @[Mintel.scala 100:35]
        node _h_T_3 = tail(_h_T_2, 1) @[Mintel.scala 100:35]
        h <= _h_T_3 @[Mintel.scala 100:19]
      else :
        node _T_2 = eq(nibble, UInt<4>("hb")) @[Mintel.scala 102:33]
        when _T_2 : @[Mintel.scala 102:43]
          node _h_T_4 = sub(UInt<7>("h42"), UInt<4>("hb")) @[Mintel.scala 103:28]
          node _h_T_5 = tail(_h_T_4, 1) @[Mintel.scala 103:28]
          node _h_T_6 = add(_h_T_5, nibble) @[Mintel.scala 103:35]
          node _h_T_7 = tail(_h_T_6, 1) @[Mintel.scala 103:35]
          h <= _h_T_7 @[Mintel.scala 103:19]
        else :
          node _T_3 = eq(nibble, UInt<4>("hc")) @[Mintel.scala 105:33]
          when _T_3 : @[Mintel.scala 105:43]
            node _h_T_8 = sub(UInt<7>("h43"), UInt<4>("hc")) @[Mintel.scala 106:28]
            node _h_T_9 = tail(_h_T_8, 1) @[Mintel.scala 106:28]
            node _h_T_10 = add(_h_T_9, nibble) @[Mintel.scala 106:35]
            node _h_T_11 = tail(_h_T_10, 1) @[Mintel.scala 106:35]
            h <= _h_T_11 @[Mintel.scala 106:19]
          else :
            node _T_4 = eq(nibble, UInt<4>("hd")) @[Mintel.scala 108:33]
            when _T_4 : @[Mintel.scala 108:43]
              node _h_T_12 = sub(UInt<7>("h44"), UInt<4>("hd")) @[Mintel.scala 109:28]
              node _h_T_13 = tail(_h_T_12, 1) @[Mintel.scala 109:28]
              node _h_T_14 = add(_h_T_13, nibble) @[Mintel.scala 109:35]
              node _h_T_15 = tail(_h_T_14, 1) @[Mintel.scala 109:35]
              h <= _h_T_15 @[Mintel.scala 109:19]
            else :
              node _T_5 = eq(nibble, UInt<4>("he")) @[Mintel.scala 111:33]
              when _T_5 : @[Mintel.scala 111:43]
                node _h_T_16 = sub(UInt<7>("h45"), UInt<4>("he")) @[Mintel.scala 112:28]
                node _h_T_17 = tail(_h_T_16, 1) @[Mintel.scala 112:28]
                node _h_T_18 = add(_h_T_17, nibble) @[Mintel.scala 112:35]
                node _h_T_19 = tail(_h_T_18, 1) @[Mintel.scala 112:35]
                h <= _h_T_19 @[Mintel.scala 112:19]
              else :
                node _T_6 = eq(nibble, UInt<4>("hf")) @[Mintel.scala 114:33]
                when _T_6 : @[Mintel.scala 114:43]
                  node _h_T_20 = sub(UInt<7>("h46"), UInt<4>("hf")) @[Mintel.scala 115:28]
                  node _h_T_21 = tail(_h_T_20, 1) @[Mintel.scala 115:28]
                  node _h_T_22 = add(_h_T_21, nibble) @[Mintel.scala 115:35]
                  node _h_T_23 = tail(_h_T_22, 1) @[Mintel.scala 115:35]
                  h <= _h_T_23 @[Mintel.scala 115:19]
                else :
                  h <= UInt<7>("h57") @[Mintel.scala 118:19]
    else :
      node _h_T_24 = add(UInt<6>("h30"), nibble) @[Mintel.scala 122:24]
      node _h_T_25 = tail(_h_T_24, 1) @[Mintel.scala 122:24]
      h <= _h_T_25 @[Mintel.scala 122:15]
    io.string <= nibble @[Mintel.scala 126:19]
    wire text : UInt<8>[1] @[Mintel.scala 129:27]
    text[0] <= h @[Mintel.scala 129:27]
    tx.io.channel.bits <= text[UInt<1>("h0")] @[Mintel.scala 134:28]
    node _tx_io_channel_valid_T = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 135:40]
    tx.io.channel.valid <= _tx_io_channel_valid_T @[Mintel.scala 135:29]
    node _T_7 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 137:45]
    node _T_8 = and(tx.io.channel.ready, _T_7) @[Mintel.scala 137:34]
    when _T_8 : @[Mintel.scala 137:54]
      node _cntReg2_T = add(cntReg2, UInt<1>("h1")) @[Mintel.scala 139:32]
      node _cntReg2_T_1 = tail(_cntReg2_T, 1) @[Mintel.scala 139:32]
      cntReg2 <= _cntReg2_T_1 @[Mintel.scala 139:21]
    else :
      node _T_9 = eq(cntReg2, UInt<3>("h4")) @[Mintel.scala 140:29]
      when _T_9 : @[Mintel.scala 140:37]
        cntReg2 <= UInt<1>("h0") @[Mintel.scala 141:21]
    node _nibble_T_1 = bits(io.instr, 7, 4) @[Mintel.scala 95:30]
    node nibble_1 = and(_nibble_T_1, UInt<4>("hf")) @[Mintel.scala 95:42]
    io.txd_instr <= tx.io.txd @[Mintel.scala 96:22]
    node _T_10 = gt(nibble_1, UInt<4>("h9")) @[Mintel.scala 98:22]
    when _T_10 : @[Mintel.scala 98:29]
      node _T_11 = eq(nibble_1, UInt<4>("ha")) @[Mintel.scala 99:26]
      when _T_11 : @[Mintel.scala 99:36]
        node _h_T_26 = sub(UInt<7>("h41"), UInt<4>("ha")) @[Mintel.scala 100:28]
        node _h_T_27 = tail(_h_T_26, 1) @[Mintel.scala 100:28]
        node _h_T_28 = add(_h_T_27, nibble_1) @[Mintel.scala 100:35]
        node _h_T_29 = tail(_h_T_28, 1) @[Mintel.scala 100:35]
        h <= _h_T_29 @[Mintel.scala 100:19]
      else :
        node _T_12 = eq(nibble_1, UInt<4>("hb")) @[Mintel.scala 102:33]
        when _T_12 : @[Mintel.scala 102:43]
          node _h_T_30 = sub(UInt<7>("h42"), UInt<4>("hb")) @[Mintel.scala 103:28]
          node _h_T_31 = tail(_h_T_30, 1) @[Mintel.scala 103:28]
          node _h_T_32 = add(_h_T_31, nibble_1) @[Mintel.scala 103:35]
          node _h_T_33 = tail(_h_T_32, 1) @[Mintel.scala 103:35]
          h <= _h_T_33 @[Mintel.scala 103:19]
        else :
          node _T_13 = eq(nibble_1, UInt<4>("hc")) @[Mintel.scala 105:33]
          when _T_13 : @[Mintel.scala 105:43]
            node _h_T_34 = sub(UInt<7>("h43"), UInt<4>("hc")) @[Mintel.scala 106:28]
            node _h_T_35 = tail(_h_T_34, 1) @[Mintel.scala 106:28]
            node _h_T_36 = add(_h_T_35, nibble_1) @[Mintel.scala 106:35]
            node _h_T_37 = tail(_h_T_36, 1) @[Mintel.scala 106:35]
            h <= _h_T_37 @[Mintel.scala 106:19]
          else :
            node _T_14 = eq(nibble_1, UInt<4>("hd")) @[Mintel.scala 108:33]
            when _T_14 : @[Mintel.scala 108:43]
              node _h_T_38 = sub(UInt<7>("h44"), UInt<4>("hd")) @[Mintel.scala 109:28]
              node _h_T_39 = tail(_h_T_38, 1) @[Mintel.scala 109:28]
              node _h_T_40 = add(_h_T_39, nibble_1) @[Mintel.scala 109:35]
              node _h_T_41 = tail(_h_T_40, 1) @[Mintel.scala 109:35]
              h <= _h_T_41 @[Mintel.scala 109:19]
            else :
              node _T_15 = eq(nibble_1, UInt<4>("he")) @[Mintel.scala 111:33]
              when _T_15 : @[Mintel.scala 111:43]
                node _h_T_42 = sub(UInt<7>("h45"), UInt<4>("he")) @[Mintel.scala 112:28]
                node _h_T_43 = tail(_h_T_42, 1) @[Mintel.scala 112:28]
                node _h_T_44 = add(_h_T_43, nibble_1) @[Mintel.scala 112:35]
                node _h_T_45 = tail(_h_T_44, 1) @[Mintel.scala 112:35]
                h <= _h_T_45 @[Mintel.scala 112:19]
              else :
                node _T_16 = eq(nibble_1, UInt<4>("hf")) @[Mintel.scala 114:33]
                when _T_16 : @[Mintel.scala 114:43]
                  node _h_T_46 = sub(UInt<7>("h46"), UInt<4>("hf")) @[Mintel.scala 115:28]
                  node _h_T_47 = tail(_h_T_46, 1) @[Mintel.scala 115:28]
                  node _h_T_48 = add(_h_T_47, nibble_1) @[Mintel.scala 115:35]
                  node _h_T_49 = tail(_h_T_48, 1) @[Mintel.scala 115:35]
                  h <= _h_T_49 @[Mintel.scala 115:19]
                else :
                  h <= UInt<7>("h57") @[Mintel.scala 118:19]
    else :
      node _h_T_50 = add(UInt<6>("h30"), nibble_1) @[Mintel.scala 122:24]
      node _h_T_51 = tail(_h_T_50, 1) @[Mintel.scala 122:24]
      h <= _h_T_51 @[Mintel.scala 122:15]
    io.string <= nibble_1 @[Mintel.scala 126:19]
    wire text_1 : UInt<8>[1] @[Mintel.scala 129:27]
    text_1[0] <= h @[Mintel.scala 129:27]
    tx.io.channel.bits <= text_1[UInt<1>("h0")] @[Mintel.scala 134:28]
    node _tx_io_channel_valid_T_1 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 135:40]
    tx.io.channel.valid <= _tx_io_channel_valid_T_1 @[Mintel.scala 135:29]
    node _T_17 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 137:45]
    node _T_18 = and(tx.io.channel.ready, _T_17) @[Mintel.scala 137:34]
    when _T_18 : @[Mintel.scala 137:54]
      node _cntReg2_T_2 = add(cntReg2, UInt<1>("h1")) @[Mintel.scala 139:32]
      node _cntReg2_T_3 = tail(_cntReg2_T_2, 1) @[Mintel.scala 139:32]
      cntReg2 <= _cntReg2_T_3 @[Mintel.scala 139:21]
    else :
      node _T_19 = eq(cntReg2, UInt<3>("h4")) @[Mintel.scala 140:29]
      when _T_19 : @[Mintel.scala 140:37]
        cntReg2 <= UInt<1>("h0") @[Mintel.scala 141:21]
    node _nibble_T_2 = bits(io.instr, 11, 8) @[Mintel.scala 95:30]
    node nibble_2 = and(_nibble_T_2, UInt<4>("hf")) @[Mintel.scala 95:42]
    io.txd_instr <= tx.io.txd @[Mintel.scala 96:22]
    node _T_20 = gt(nibble_2, UInt<4>("h9")) @[Mintel.scala 98:22]
    when _T_20 : @[Mintel.scala 98:29]
      node _T_21 = eq(nibble_2, UInt<4>("ha")) @[Mintel.scala 99:26]
      when _T_21 : @[Mintel.scala 99:36]
        node _h_T_52 = sub(UInt<7>("h41"), UInt<4>("ha")) @[Mintel.scala 100:28]
        node _h_T_53 = tail(_h_T_52, 1) @[Mintel.scala 100:28]
        node _h_T_54 = add(_h_T_53, nibble_2) @[Mintel.scala 100:35]
        node _h_T_55 = tail(_h_T_54, 1) @[Mintel.scala 100:35]
        h <= _h_T_55 @[Mintel.scala 100:19]
      else :
        node _T_22 = eq(nibble_2, UInt<4>("hb")) @[Mintel.scala 102:33]
        when _T_22 : @[Mintel.scala 102:43]
          node _h_T_56 = sub(UInt<7>("h42"), UInt<4>("hb")) @[Mintel.scala 103:28]
          node _h_T_57 = tail(_h_T_56, 1) @[Mintel.scala 103:28]
          node _h_T_58 = add(_h_T_57, nibble_2) @[Mintel.scala 103:35]
          node _h_T_59 = tail(_h_T_58, 1) @[Mintel.scala 103:35]
          h <= _h_T_59 @[Mintel.scala 103:19]
        else :
          node _T_23 = eq(nibble_2, UInt<4>("hc")) @[Mintel.scala 105:33]
          when _T_23 : @[Mintel.scala 105:43]
            node _h_T_60 = sub(UInt<7>("h43"), UInt<4>("hc")) @[Mintel.scala 106:28]
            node _h_T_61 = tail(_h_T_60, 1) @[Mintel.scala 106:28]
            node _h_T_62 = add(_h_T_61, nibble_2) @[Mintel.scala 106:35]
            node _h_T_63 = tail(_h_T_62, 1) @[Mintel.scala 106:35]
            h <= _h_T_63 @[Mintel.scala 106:19]
          else :
            node _T_24 = eq(nibble_2, UInt<4>("hd")) @[Mintel.scala 108:33]
            when _T_24 : @[Mintel.scala 108:43]
              node _h_T_64 = sub(UInt<7>("h44"), UInt<4>("hd")) @[Mintel.scala 109:28]
              node _h_T_65 = tail(_h_T_64, 1) @[Mintel.scala 109:28]
              node _h_T_66 = add(_h_T_65, nibble_2) @[Mintel.scala 109:35]
              node _h_T_67 = tail(_h_T_66, 1) @[Mintel.scala 109:35]
              h <= _h_T_67 @[Mintel.scala 109:19]
            else :
              node _T_25 = eq(nibble_2, UInt<4>("he")) @[Mintel.scala 111:33]
              when _T_25 : @[Mintel.scala 111:43]
                node _h_T_68 = sub(UInt<7>("h45"), UInt<4>("he")) @[Mintel.scala 112:28]
                node _h_T_69 = tail(_h_T_68, 1) @[Mintel.scala 112:28]
                node _h_T_70 = add(_h_T_69, nibble_2) @[Mintel.scala 112:35]
                node _h_T_71 = tail(_h_T_70, 1) @[Mintel.scala 112:35]
                h <= _h_T_71 @[Mintel.scala 112:19]
              else :
                node _T_26 = eq(nibble_2, UInt<4>("hf")) @[Mintel.scala 114:33]
                when _T_26 : @[Mintel.scala 114:43]
                  node _h_T_72 = sub(UInt<7>("h46"), UInt<4>("hf")) @[Mintel.scala 115:28]
                  node _h_T_73 = tail(_h_T_72, 1) @[Mintel.scala 115:28]
                  node _h_T_74 = add(_h_T_73, nibble_2) @[Mintel.scala 115:35]
                  node _h_T_75 = tail(_h_T_74, 1) @[Mintel.scala 115:35]
                  h <= _h_T_75 @[Mintel.scala 115:19]
                else :
                  h <= UInt<7>("h57") @[Mintel.scala 118:19]
    else :
      node _h_T_76 = add(UInt<6>("h30"), nibble_2) @[Mintel.scala 122:24]
      node _h_T_77 = tail(_h_T_76, 1) @[Mintel.scala 122:24]
      h <= _h_T_77 @[Mintel.scala 122:15]
    io.string <= nibble_2 @[Mintel.scala 126:19]
    wire text_2 : UInt<8>[1] @[Mintel.scala 129:27]
    text_2[0] <= h @[Mintel.scala 129:27]
    tx.io.channel.bits <= text_2[UInt<1>("h0")] @[Mintel.scala 134:28]
    node _tx_io_channel_valid_T_2 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 135:40]
    tx.io.channel.valid <= _tx_io_channel_valid_T_2 @[Mintel.scala 135:29]
    node _T_27 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 137:45]
    node _T_28 = and(tx.io.channel.ready, _T_27) @[Mintel.scala 137:34]
    when _T_28 : @[Mintel.scala 137:54]
      node _cntReg2_T_4 = add(cntReg2, UInt<1>("h1")) @[Mintel.scala 139:32]
      node _cntReg2_T_5 = tail(_cntReg2_T_4, 1) @[Mintel.scala 139:32]
      cntReg2 <= _cntReg2_T_5 @[Mintel.scala 139:21]
    else :
      node _T_29 = eq(cntReg2, UInt<3>("h4")) @[Mintel.scala 140:29]
      when _T_29 : @[Mintel.scala 140:37]
        cntReg2 <= UInt<1>("h0") @[Mintel.scala 141:21]
    node _nibble_T_3 = bits(io.instr, 15, 12) @[Mintel.scala 95:30]
    node nibble_3 = and(_nibble_T_3, UInt<4>("hf")) @[Mintel.scala 95:42]
    io.txd_instr <= tx.io.txd @[Mintel.scala 96:22]
    node _T_30 = gt(nibble_3, UInt<4>("h9")) @[Mintel.scala 98:22]
    when _T_30 : @[Mintel.scala 98:29]
      node _T_31 = eq(nibble_3, UInt<4>("ha")) @[Mintel.scala 99:26]
      when _T_31 : @[Mintel.scala 99:36]
        node _h_T_78 = sub(UInt<7>("h41"), UInt<4>("ha")) @[Mintel.scala 100:28]
        node _h_T_79 = tail(_h_T_78, 1) @[Mintel.scala 100:28]
        node _h_T_80 = add(_h_T_79, nibble_3) @[Mintel.scala 100:35]
        node _h_T_81 = tail(_h_T_80, 1) @[Mintel.scala 100:35]
        h <= _h_T_81 @[Mintel.scala 100:19]
      else :
        node _T_32 = eq(nibble_3, UInt<4>("hb")) @[Mintel.scala 102:33]
        when _T_32 : @[Mintel.scala 102:43]
          node _h_T_82 = sub(UInt<7>("h42"), UInt<4>("hb")) @[Mintel.scala 103:28]
          node _h_T_83 = tail(_h_T_82, 1) @[Mintel.scala 103:28]
          node _h_T_84 = add(_h_T_83, nibble_3) @[Mintel.scala 103:35]
          node _h_T_85 = tail(_h_T_84, 1) @[Mintel.scala 103:35]
          h <= _h_T_85 @[Mintel.scala 103:19]
        else :
          node _T_33 = eq(nibble_3, UInt<4>("hc")) @[Mintel.scala 105:33]
          when _T_33 : @[Mintel.scala 105:43]
            node _h_T_86 = sub(UInt<7>("h43"), UInt<4>("hc")) @[Mintel.scala 106:28]
            node _h_T_87 = tail(_h_T_86, 1) @[Mintel.scala 106:28]
            node _h_T_88 = add(_h_T_87, nibble_3) @[Mintel.scala 106:35]
            node _h_T_89 = tail(_h_T_88, 1) @[Mintel.scala 106:35]
            h <= _h_T_89 @[Mintel.scala 106:19]
          else :
            node _T_34 = eq(nibble_3, UInt<4>("hd")) @[Mintel.scala 108:33]
            when _T_34 : @[Mintel.scala 108:43]
              node _h_T_90 = sub(UInt<7>("h44"), UInt<4>("hd")) @[Mintel.scala 109:28]
              node _h_T_91 = tail(_h_T_90, 1) @[Mintel.scala 109:28]
              node _h_T_92 = add(_h_T_91, nibble_3) @[Mintel.scala 109:35]
              node _h_T_93 = tail(_h_T_92, 1) @[Mintel.scala 109:35]
              h <= _h_T_93 @[Mintel.scala 109:19]
            else :
              node _T_35 = eq(nibble_3, UInt<4>("he")) @[Mintel.scala 111:33]
              when _T_35 : @[Mintel.scala 111:43]
                node _h_T_94 = sub(UInt<7>("h45"), UInt<4>("he")) @[Mintel.scala 112:28]
                node _h_T_95 = tail(_h_T_94, 1) @[Mintel.scala 112:28]
                node _h_T_96 = add(_h_T_95, nibble_3) @[Mintel.scala 112:35]
                node _h_T_97 = tail(_h_T_96, 1) @[Mintel.scala 112:35]
                h <= _h_T_97 @[Mintel.scala 112:19]
              else :
                node _T_36 = eq(nibble_3, UInt<4>("hf")) @[Mintel.scala 114:33]
                when _T_36 : @[Mintel.scala 114:43]
                  node _h_T_98 = sub(UInt<7>("h46"), UInt<4>("hf")) @[Mintel.scala 115:28]
                  node _h_T_99 = tail(_h_T_98, 1) @[Mintel.scala 115:28]
                  node _h_T_100 = add(_h_T_99, nibble_3) @[Mintel.scala 115:35]
                  node _h_T_101 = tail(_h_T_100, 1) @[Mintel.scala 115:35]
                  h <= _h_T_101 @[Mintel.scala 115:19]
                else :
                  h <= UInt<7>("h57") @[Mintel.scala 118:19]
    else :
      node _h_T_102 = add(UInt<6>("h30"), nibble_3) @[Mintel.scala 122:24]
      node _h_T_103 = tail(_h_T_102, 1) @[Mintel.scala 122:24]
      h <= _h_T_103 @[Mintel.scala 122:15]
    io.string <= nibble_3 @[Mintel.scala 126:19]
    wire text_3 : UInt<8>[1] @[Mintel.scala 129:27]
    text_3[0] <= h @[Mintel.scala 129:27]
    tx.io.channel.bits <= text_3[UInt<1>("h0")] @[Mintel.scala 134:28]
    node _tx_io_channel_valid_T_3 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 135:40]
    tx.io.channel.valid <= _tx_io_channel_valid_T_3 @[Mintel.scala 135:29]
    node _T_37 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 137:45]
    node _T_38 = and(tx.io.channel.ready, _T_37) @[Mintel.scala 137:34]
    when _T_38 : @[Mintel.scala 137:54]
      node _cntReg2_T_6 = add(cntReg2, UInt<1>("h1")) @[Mintel.scala 139:32]
      node _cntReg2_T_7 = tail(_cntReg2_T_6, 1) @[Mintel.scala 139:32]
      cntReg2 <= _cntReg2_T_7 @[Mintel.scala 139:21]
    else :
      node _T_39 = eq(cntReg2, UInt<3>("h4")) @[Mintel.scala 140:29]
      when _T_39 : @[Mintel.scala 140:37]
        cntReg2 <= UInt<1>("h0") @[Mintel.scala 141:21]
    node _nibble_T_4 = bits(io.instr, 19, 16) @[Mintel.scala 95:30]
    node nibble_4 = and(_nibble_T_4, UInt<4>("hf")) @[Mintel.scala 95:42]
    io.txd_instr <= tx.io.txd @[Mintel.scala 96:22]
    node _T_40 = gt(nibble_4, UInt<4>("h9")) @[Mintel.scala 98:22]
    when _T_40 : @[Mintel.scala 98:29]
      node _T_41 = eq(nibble_4, UInt<4>("ha")) @[Mintel.scala 99:26]
      when _T_41 : @[Mintel.scala 99:36]
        node _h_T_104 = sub(UInt<7>("h41"), UInt<4>("ha")) @[Mintel.scala 100:28]
        node _h_T_105 = tail(_h_T_104, 1) @[Mintel.scala 100:28]
        node _h_T_106 = add(_h_T_105, nibble_4) @[Mintel.scala 100:35]
        node _h_T_107 = tail(_h_T_106, 1) @[Mintel.scala 100:35]
        h <= _h_T_107 @[Mintel.scala 100:19]
      else :
        node _T_42 = eq(nibble_4, UInt<4>("hb")) @[Mintel.scala 102:33]
        when _T_42 : @[Mintel.scala 102:43]
          node _h_T_108 = sub(UInt<7>("h42"), UInt<4>("hb")) @[Mintel.scala 103:28]
          node _h_T_109 = tail(_h_T_108, 1) @[Mintel.scala 103:28]
          node _h_T_110 = add(_h_T_109, nibble_4) @[Mintel.scala 103:35]
          node _h_T_111 = tail(_h_T_110, 1) @[Mintel.scala 103:35]
          h <= _h_T_111 @[Mintel.scala 103:19]
        else :
          node _T_43 = eq(nibble_4, UInt<4>("hc")) @[Mintel.scala 105:33]
          when _T_43 : @[Mintel.scala 105:43]
            node _h_T_112 = sub(UInt<7>("h43"), UInt<4>("hc")) @[Mintel.scala 106:28]
            node _h_T_113 = tail(_h_T_112, 1) @[Mintel.scala 106:28]
            node _h_T_114 = add(_h_T_113, nibble_4) @[Mintel.scala 106:35]
            node _h_T_115 = tail(_h_T_114, 1) @[Mintel.scala 106:35]
            h <= _h_T_115 @[Mintel.scala 106:19]
          else :
            node _T_44 = eq(nibble_4, UInt<4>("hd")) @[Mintel.scala 108:33]
            when _T_44 : @[Mintel.scala 108:43]
              node _h_T_116 = sub(UInt<7>("h44"), UInt<4>("hd")) @[Mintel.scala 109:28]
              node _h_T_117 = tail(_h_T_116, 1) @[Mintel.scala 109:28]
              node _h_T_118 = add(_h_T_117, nibble_4) @[Mintel.scala 109:35]
              node _h_T_119 = tail(_h_T_118, 1) @[Mintel.scala 109:35]
              h <= _h_T_119 @[Mintel.scala 109:19]
            else :
              node _T_45 = eq(nibble_4, UInt<4>("he")) @[Mintel.scala 111:33]
              when _T_45 : @[Mintel.scala 111:43]
                node _h_T_120 = sub(UInt<7>("h45"), UInt<4>("he")) @[Mintel.scala 112:28]
                node _h_T_121 = tail(_h_T_120, 1) @[Mintel.scala 112:28]
                node _h_T_122 = add(_h_T_121, nibble_4) @[Mintel.scala 112:35]
                node _h_T_123 = tail(_h_T_122, 1) @[Mintel.scala 112:35]
                h <= _h_T_123 @[Mintel.scala 112:19]
              else :
                node _T_46 = eq(nibble_4, UInt<4>("hf")) @[Mintel.scala 114:33]
                when _T_46 : @[Mintel.scala 114:43]
                  node _h_T_124 = sub(UInt<7>("h46"), UInt<4>("hf")) @[Mintel.scala 115:28]
                  node _h_T_125 = tail(_h_T_124, 1) @[Mintel.scala 115:28]
                  node _h_T_126 = add(_h_T_125, nibble_4) @[Mintel.scala 115:35]
                  node _h_T_127 = tail(_h_T_126, 1) @[Mintel.scala 115:35]
                  h <= _h_T_127 @[Mintel.scala 115:19]
                else :
                  h <= UInt<7>("h57") @[Mintel.scala 118:19]
    else :
      node _h_T_128 = add(UInt<6>("h30"), nibble_4) @[Mintel.scala 122:24]
      node _h_T_129 = tail(_h_T_128, 1) @[Mintel.scala 122:24]
      h <= _h_T_129 @[Mintel.scala 122:15]
    io.string <= nibble_4 @[Mintel.scala 126:19]
    wire text_4 : UInt<8>[1] @[Mintel.scala 129:27]
    text_4[0] <= h @[Mintel.scala 129:27]
    tx.io.channel.bits <= text_4[UInt<1>("h0")] @[Mintel.scala 134:28]
    node _tx_io_channel_valid_T_4 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 135:40]
    tx.io.channel.valid <= _tx_io_channel_valid_T_4 @[Mintel.scala 135:29]
    node _T_47 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 137:45]
    node _T_48 = and(tx.io.channel.ready, _T_47) @[Mintel.scala 137:34]
    when _T_48 : @[Mintel.scala 137:54]
      node _cntReg2_T_8 = add(cntReg2, UInt<1>("h1")) @[Mintel.scala 139:32]
      node _cntReg2_T_9 = tail(_cntReg2_T_8, 1) @[Mintel.scala 139:32]
      cntReg2 <= _cntReg2_T_9 @[Mintel.scala 139:21]
    else :
      node _T_49 = eq(cntReg2, UInt<3>("h4")) @[Mintel.scala 140:29]
      when _T_49 : @[Mintel.scala 140:37]
        cntReg2 <= UInt<1>("h0") @[Mintel.scala 141:21]
    node _nibble_T_5 = bits(io.instr, 23, 20) @[Mintel.scala 95:30]
    node nibble_5 = and(_nibble_T_5, UInt<4>("hf")) @[Mintel.scala 95:42]
    io.txd_instr <= tx.io.txd @[Mintel.scala 96:22]
    node _T_50 = gt(nibble_5, UInt<4>("h9")) @[Mintel.scala 98:22]
    when _T_50 : @[Mintel.scala 98:29]
      node _T_51 = eq(nibble_5, UInt<4>("ha")) @[Mintel.scala 99:26]
      when _T_51 : @[Mintel.scala 99:36]
        node _h_T_130 = sub(UInt<7>("h41"), UInt<4>("ha")) @[Mintel.scala 100:28]
        node _h_T_131 = tail(_h_T_130, 1) @[Mintel.scala 100:28]
        node _h_T_132 = add(_h_T_131, nibble_5) @[Mintel.scala 100:35]
        node _h_T_133 = tail(_h_T_132, 1) @[Mintel.scala 100:35]
        h <= _h_T_133 @[Mintel.scala 100:19]
      else :
        node _T_52 = eq(nibble_5, UInt<4>("hb")) @[Mintel.scala 102:33]
        when _T_52 : @[Mintel.scala 102:43]
          node _h_T_134 = sub(UInt<7>("h42"), UInt<4>("hb")) @[Mintel.scala 103:28]
          node _h_T_135 = tail(_h_T_134, 1) @[Mintel.scala 103:28]
          node _h_T_136 = add(_h_T_135, nibble_5) @[Mintel.scala 103:35]
          node _h_T_137 = tail(_h_T_136, 1) @[Mintel.scala 103:35]
          h <= _h_T_137 @[Mintel.scala 103:19]
        else :
          node _T_53 = eq(nibble_5, UInt<4>("hc")) @[Mintel.scala 105:33]
          when _T_53 : @[Mintel.scala 105:43]
            node _h_T_138 = sub(UInt<7>("h43"), UInt<4>("hc")) @[Mintel.scala 106:28]
            node _h_T_139 = tail(_h_T_138, 1) @[Mintel.scala 106:28]
            node _h_T_140 = add(_h_T_139, nibble_5) @[Mintel.scala 106:35]
            node _h_T_141 = tail(_h_T_140, 1) @[Mintel.scala 106:35]
            h <= _h_T_141 @[Mintel.scala 106:19]
          else :
            node _T_54 = eq(nibble_5, UInt<4>("hd")) @[Mintel.scala 108:33]
            when _T_54 : @[Mintel.scala 108:43]
              node _h_T_142 = sub(UInt<7>("h44"), UInt<4>("hd")) @[Mintel.scala 109:28]
              node _h_T_143 = tail(_h_T_142, 1) @[Mintel.scala 109:28]
              node _h_T_144 = add(_h_T_143, nibble_5) @[Mintel.scala 109:35]
              node _h_T_145 = tail(_h_T_144, 1) @[Mintel.scala 109:35]
              h <= _h_T_145 @[Mintel.scala 109:19]
            else :
              node _T_55 = eq(nibble_5, UInt<4>("he")) @[Mintel.scala 111:33]
              when _T_55 : @[Mintel.scala 111:43]
                node _h_T_146 = sub(UInt<7>("h45"), UInt<4>("he")) @[Mintel.scala 112:28]
                node _h_T_147 = tail(_h_T_146, 1) @[Mintel.scala 112:28]
                node _h_T_148 = add(_h_T_147, nibble_5) @[Mintel.scala 112:35]
                node _h_T_149 = tail(_h_T_148, 1) @[Mintel.scala 112:35]
                h <= _h_T_149 @[Mintel.scala 112:19]
              else :
                node _T_56 = eq(nibble_5, UInt<4>("hf")) @[Mintel.scala 114:33]
                when _T_56 : @[Mintel.scala 114:43]
                  node _h_T_150 = sub(UInt<7>("h46"), UInt<4>("hf")) @[Mintel.scala 115:28]
                  node _h_T_151 = tail(_h_T_150, 1) @[Mintel.scala 115:28]
                  node _h_T_152 = add(_h_T_151, nibble_5) @[Mintel.scala 115:35]
                  node _h_T_153 = tail(_h_T_152, 1) @[Mintel.scala 115:35]
                  h <= _h_T_153 @[Mintel.scala 115:19]
                else :
                  h <= UInt<7>("h57") @[Mintel.scala 118:19]
    else :
      node _h_T_154 = add(UInt<6>("h30"), nibble_5) @[Mintel.scala 122:24]
      node _h_T_155 = tail(_h_T_154, 1) @[Mintel.scala 122:24]
      h <= _h_T_155 @[Mintel.scala 122:15]
    io.string <= nibble_5 @[Mintel.scala 126:19]
    wire text_5 : UInt<8>[1] @[Mintel.scala 129:27]
    text_5[0] <= h @[Mintel.scala 129:27]
    tx.io.channel.bits <= text_5[UInt<1>("h0")] @[Mintel.scala 134:28]
    node _tx_io_channel_valid_T_5 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 135:40]
    tx.io.channel.valid <= _tx_io_channel_valid_T_5 @[Mintel.scala 135:29]
    node _T_57 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 137:45]
    node _T_58 = and(tx.io.channel.ready, _T_57) @[Mintel.scala 137:34]
    when _T_58 : @[Mintel.scala 137:54]
      node _cntReg2_T_10 = add(cntReg2, UInt<1>("h1")) @[Mintel.scala 139:32]
      node _cntReg2_T_11 = tail(_cntReg2_T_10, 1) @[Mintel.scala 139:32]
      cntReg2 <= _cntReg2_T_11 @[Mintel.scala 139:21]
    else :
      node _T_59 = eq(cntReg2, UInt<3>("h4")) @[Mintel.scala 140:29]
      when _T_59 : @[Mintel.scala 140:37]
        cntReg2 <= UInt<1>("h0") @[Mintel.scala 141:21]
    node _nibble_T_6 = bits(io.instr, 27, 24) @[Mintel.scala 95:30]
    node nibble_6 = and(_nibble_T_6, UInt<4>("hf")) @[Mintel.scala 95:42]
    io.txd_instr <= tx.io.txd @[Mintel.scala 96:22]
    node _T_60 = gt(nibble_6, UInt<4>("h9")) @[Mintel.scala 98:22]
    when _T_60 : @[Mintel.scala 98:29]
      node _T_61 = eq(nibble_6, UInt<4>("ha")) @[Mintel.scala 99:26]
      when _T_61 : @[Mintel.scala 99:36]
        node _h_T_156 = sub(UInt<7>("h41"), UInt<4>("ha")) @[Mintel.scala 100:28]
        node _h_T_157 = tail(_h_T_156, 1) @[Mintel.scala 100:28]
        node _h_T_158 = add(_h_T_157, nibble_6) @[Mintel.scala 100:35]
        node _h_T_159 = tail(_h_T_158, 1) @[Mintel.scala 100:35]
        h <= _h_T_159 @[Mintel.scala 100:19]
      else :
        node _T_62 = eq(nibble_6, UInt<4>("hb")) @[Mintel.scala 102:33]
        when _T_62 : @[Mintel.scala 102:43]
          node _h_T_160 = sub(UInt<7>("h42"), UInt<4>("hb")) @[Mintel.scala 103:28]
          node _h_T_161 = tail(_h_T_160, 1) @[Mintel.scala 103:28]
          node _h_T_162 = add(_h_T_161, nibble_6) @[Mintel.scala 103:35]
          node _h_T_163 = tail(_h_T_162, 1) @[Mintel.scala 103:35]
          h <= _h_T_163 @[Mintel.scala 103:19]
        else :
          node _T_63 = eq(nibble_6, UInt<4>("hc")) @[Mintel.scala 105:33]
          when _T_63 : @[Mintel.scala 105:43]
            node _h_T_164 = sub(UInt<7>("h43"), UInt<4>("hc")) @[Mintel.scala 106:28]
            node _h_T_165 = tail(_h_T_164, 1) @[Mintel.scala 106:28]
            node _h_T_166 = add(_h_T_165, nibble_6) @[Mintel.scala 106:35]
            node _h_T_167 = tail(_h_T_166, 1) @[Mintel.scala 106:35]
            h <= _h_T_167 @[Mintel.scala 106:19]
          else :
            node _T_64 = eq(nibble_6, UInt<4>("hd")) @[Mintel.scala 108:33]
            when _T_64 : @[Mintel.scala 108:43]
              node _h_T_168 = sub(UInt<7>("h44"), UInt<4>("hd")) @[Mintel.scala 109:28]
              node _h_T_169 = tail(_h_T_168, 1) @[Mintel.scala 109:28]
              node _h_T_170 = add(_h_T_169, nibble_6) @[Mintel.scala 109:35]
              node _h_T_171 = tail(_h_T_170, 1) @[Mintel.scala 109:35]
              h <= _h_T_171 @[Mintel.scala 109:19]
            else :
              node _T_65 = eq(nibble_6, UInt<4>("he")) @[Mintel.scala 111:33]
              when _T_65 : @[Mintel.scala 111:43]
                node _h_T_172 = sub(UInt<7>("h45"), UInt<4>("he")) @[Mintel.scala 112:28]
                node _h_T_173 = tail(_h_T_172, 1) @[Mintel.scala 112:28]
                node _h_T_174 = add(_h_T_173, nibble_6) @[Mintel.scala 112:35]
                node _h_T_175 = tail(_h_T_174, 1) @[Mintel.scala 112:35]
                h <= _h_T_175 @[Mintel.scala 112:19]
              else :
                node _T_66 = eq(nibble_6, UInt<4>("hf")) @[Mintel.scala 114:33]
                when _T_66 : @[Mintel.scala 114:43]
                  node _h_T_176 = sub(UInt<7>("h46"), UInt<4>("hf")) @[Mintel.scala 115:28]
                  node _h_T_177 = tail(_h_T_176, 1) @[Mintel.scala 115:28]
                  node _h_T_178 = add(_h_T_177, nibble_6) @[Mintel.scala 115:35]
                  node _h_T_179 = tail(_h_T_178, 1) @[Mintel.scala 115:35]
                  h <= _h_T_179 @[Mintel.scala 115:19]
                else :
                  h <= UInt<7>("h57") @[Mintel.scala 118:19]
    else :
      node _h_T_180 = add(UInt<6>("h30"), nibble_6) @[Mintel.scala 122:24]
      node _h_T_181 = tail(_h_T_180, 1) @[Mintel.scala 122:24]
      h <= _h_T_181 @[Mintel.scala 122:15]
    io.string <= nibble_6 @[Mintel.scala 126:19]
    wire text_6 : UInt<8>[1] @[Mintel.scala 129:27]
    text_6[0] <= h @[Mintel.scala 129:27]
    tx.io.channel.bits <= text_6[UInt<1>("h0")] @[Mintel.scala 134:28]
    node _tx_io_channel_valid_T_6 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 135:40]
    tx.io.channel.valid <= _tx_io_channel_valid_T_6 @[Mintel.scala 135:29]
    node _T_67 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 137:45]
    node _T_68 = and(tx.io.channel.ready, _T_67) @[Mintel.scala 137:34]
    when _T_68 : @[Mintel.scala 137:54]
      node _cntReg2_T_12 = add(cntReg2, UInt<1>("h1")) @[Mintel.scala 139:32]
      node _cntReg2_T_13 = tail(_cntReg2_T_12, 1) @[Mintel.scala 139:32]
      cntReg2 <= _cntReg2_T_13 @[Mintel.scala 139:21]
    else :
      node _T_69 = eq(cntReg2, UInt<3>("h4")) @[Mintel.scala 140:29]
      when _T_69 : @[Mintel.scala 140:37]
        cntReg2 <= UInt<1>("h0") @[Mintel.scala 141:21]
    node _nibble_T_7 = bits(io.instr, 31, 28) @[Mintel.scala 95:30]
    node nibble_7 = and(_nibble_T_7, UInt<4>("hf")) @[Mintel.scala 95:42]
    io.txd_instr <= tx.io.txd @[Mintel.scala 96:22]
    node _T_70 = gt(nibble_7, UInt<4>("h9")) @[Mintel.scala 98:22]
    when _T_70 : @[Mintel.scala 98:29]
      node _T_71 = eq(nibble_7, UInt<4>("ha")) @[Mintel.scala 99:26]
      when _T_71 : @[Mintel.scala 99:36]
        node _h_T_182 = sub(UInt<7>("h41"), UInt<4>("ha")) @[Mintel.scala 100:28]
        node _h_T_183 = tail(_h_T_182, 1) @[Mintel.scala 100:28]
        node _h_T_184 = add(_h_T_183, nibble_7) @[Mintel.scala 100:35]
        node _h_T_185 = tail(_h_T_184, 1) @[Mintel.scala 100:35]
        h <= _h_T_185 @[Mintel.scala 100:19]
      else :
        node _T_72 = eq(nibble_7, UInt<4>("hb")) @[Mintel.scala 102:33]
        when _T_72 : @[Mintel.scala 102:43]
          node _h_T_186 = sub(UInt<7>("h42"), UInt<4>("hb")) @[Mintel.scala 103:28]
          node _h_T_187 = tail(_h_T_186, 1) @[Mintel.scala 103:28]
          node _h_T_188 = add(_h_T_187, nibble_7) @[Mintel.scala 103:35]
          node _h_T_189 = tail(_h_T_188, 1) @[Mintel.scala 103:35]
          h <= _h_T_189 @[Mintel.scala 103:19]
        else :
          node _T_73 = eq(nibble_7, UInt<4>("hc")) @[Mintel.scala 105:33]
          when _T_73 : @[Mintel.scala 105:43]
            node _h_T_190 = sub(UInt<7>("h43"), UInt<4>("hc")) @[Mintel.scala 106:28]
            node _h_T_191 = tail(_h_T_190, 1) @[Mintel.scala 106:28]
            node _h_T_192 = add(_h_T_191, nibble_7) @[Mintel.scala 106:35]
            node _h_T_193 = tail(_h_T_192, 1) @[Mintel.scala 106:35]
            h <= _h_T_193 @[Mintel.scala 106:19]
          else :
            node _T_74 = eq(nibble_7, UInt<4>("hd")) @[Mintel.scala 108:33]
            when _T_74 : @[Mintel.scala 108:43]
              node _h_T_194 = sub(UInt<7>("h44"), UInt<4>("hd")) @[Mintel.scala 109:28]
              node _h_T_195 = tail(_h_T_194, 1) @[Mintel.scala 109:28]
              node _h_T_196 = add(_h_T_195, nibble_7) @[Mintel.scala 109:35]
              node _h_T_197 = tail(_h_T_196, 1) @[Mintel.scala 109:35]
              h <= _h_T_197 @[Mintel.scala 109:19]
            else :
              node _T_75 = eq(nibble_7, UInt<4>("he")) @[Mintel.scala 111:33]
              when _T_75 : @[Mintel.scala 111:43]
                node _h_T_198 = sub(UInt<7>("h45"), UInt<4>("he")) @[Mintel.scala 112:28]
                node _h_T_199 = tail(_h_T_198, 1) @[Mintel.scala 112:28]
                node _h_T_200 = add(_h_T_199, nibble_7) @[Mintel.scala 112:35]
                node _h_T_201 = tail(_h_T_200, 1) @[Mintel.scala 112:35]
                h <= _h_T_201 @[Mintel.scala 112:19]
              else :
                node _T_76 = eq(nibble_7, UInt<4>("hf")) @[Mintel.scala 114:33]
                when _T_76 : @[Mintel.scala 114:43]
                  node _h_T_202 = sub(UInt<7>("h46"), UInt<4>("hf")) @[Mintel.scala 115:28]
                  node _h_T_203 = tail(_h_T_202, 1) @[Mintel.scala 115:28]
                  node _h_T_204 = add(_h_T_203, nibble_7) @[Mintel.scala 115:35]
                  node _h_T_205 = tail(_h_T_204, 1) @[Mintel.scala 115:35]
                  h <= _h_T_205 @[Mintel.scala 115:19]
                else :
                  h <= UInt<7>("h57") @[Mintel.scala 118:19]
    else :
      node _h_T_206 = add(UInt<6>("h30"), nibble_7) @[Mintel.scala 122:24]
      node _h_T_207 = tail(_h_T_206, 1) @[Mintel.scala 122:24]
      h <= _h_T_207 @[Mintel.scala 122:15]
    io.string <= nibble_7 @[Mintel.scala 126:19]
    wire text_7 : UInt<8>[1] @[Mintel.scala 129:27]
    text_7[0] <= h @[Mintel.scala 129:27]
    tx.io.channel.bits <= text_7[UInt<1>("h0")] @[Mintel.scala 134:28]
    node _tx_io_channel_valid_T_7 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 135:40]
    tx.io.channel.valid <= _tx_io_channel_valid_T_7 @[Mintel.scala 135:29]
    node _T_77 = neq(cntReg2, UInt<3>("h4")) @[Mintel.scala 137:45]
    node _T_78 = and(tx.io.channel.ready, _T_77) @[Mintel.scala 137:34]
    when _T_78 : @[Mintel.scala 137:54]
      node _cntReg2_T_14 = add(cntReg2, UInt<1>("h1")) @[Mintel.scala 139:32]
      node _cntReg2_T_15 = tail(_cntReg2_T_14, 1) @[Mintel.scala 139:32]
      cntReg2 <= _cntReg2_T_15 @[Mintel.scala 139:21]
    else :
      node _T_79 = eq(cntReg2, UInt<3>("h4")) @[Mintel.scala 140:29]
      when _T_79 : @[Mintel.scala 140:37]
        cntReg2 <= UInt<1>("h0") @[Mintel.scala 141:21]
    wire LEDG : UInt<8>
    LEDG <= UInt<8>("h0")
    io.LEDR <= io.SW @[Mintel.scala 147:19]
    node _LEDG_T = not(io.KEY) @[Mintel.scala 148:26]
    node _LEDG_T_1 = not(io.KEY) @[Mintel.scala 148:35]
    node _LEDG_T_2 = cat(_LEDG_T, _LEDG_T_1) @[Cat.scala 31:58]
    LEDG <= _LEDG_T_2 @[Mintel.scala 148:19]
    io.LEDG <= LEDG @[Mintel.scala 149:19]

