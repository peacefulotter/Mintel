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
    node _newPC_T = add(io.BranchAddr, UInt<1>("h1")) @[Fetch.scala 34:37]
    node _newPC_T_1 = tail(_newPC_T, 1) @[Fetch.scala 34:37]
    node _newPC_T_2 = add(PC, UInt<1>("h1")) @[Fetch.scala 34:47]
    node _newPC_T_3 = tail(_newPC_T_2, 1) @[Fetch.scala 34:47]
    node _newPC_T_4 = mux(io.BrEn, _newPC_T_1, _newPC_T_3) @[Fetch.scala 34:12]
    node newPC = mux(isStalling, PC, _newPC_T_4) @[Fetch.scala 31:26]
    io.NextPC <= newPC @[Fetch.scala 37:15]
    node _mem_io_PC_T = mux(io.BrEn, io.BranchAddr, PC) @[Fetch.scala 39:21]
    mem.io.PC <= _mem_io_PC_T @[Fetch.scala 39:15]
    node _io_Instr_T = mux(isStalling, UInt<32>("h0"), mem.io.Instr) @[Fetch.scala 40:20]
    io.Instr <= _io_Instr_T @[Fetch.scala 40:14]
    PC <= newPC @[Fetch.scala 46:8]

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
    output io : { flip instr : UInt<32>, rs : UInt<5>, rt : UInt<5>, rd : UInt<5>, imm : UInt<16>, addr : UInt<26>, AluOp : UInt<6>, ImmEn : UInt<1>, BrEn : UInt<2>, LoadEn : UInt<1>, StoreEn : UInt<1>, WbType : UInt<1>, WbEn : UInt<1>, IsSigned : UInt<1>}

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
    node _format_T_54 = and(io.instr, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _format_T_55 = eq(UInt<28>("h8000000"), _format_T_54) @[Lookup.scala 31:38]
    node _format_T_56 = mux(_format_T_55, UInt<5>("h11"), UInt<5>("h0")) @[Lookup.scala 34:39]
    node _format_T_57 = mux(_format_T_53, UInt<5>("h0"), _format_T_56) @[Lookup.scala 34:39]
    node _format_T_58 = mux(_format_T_51, UInt<5>("h0"), _format_T_57) @[Lookup.scala 34:39]
    node _format_T_59 = mux(_format_T_49, UInt<5>("hf"), _format_T_58) @[Lookup.scala 34:39]
    node _format_T_60 = mux(_format_T_47, UInt<5>("hc"), _format_T_59) @[Lookup.scala 34:39]
    node _format_T_61 = mux(_format_T_45, UInt<5>("h11"), _format_T_60) @[Lookup.scala 34:39]
    node _format_T_62 = mux(_format_T_43, UInt<5>("h10"), _format_T_61) @[Lookup.scala 34:39]
    node _format_T_63 = mux(_format_T_41, UInt<5>("hd"), _format_T_62) @[Lookup.scala 34:39]
    node _format_T_64 = mux(_format_T_39, UInt<5>("hd"), _format_T_63) @[Lookup.scala 34:39]
    node _format_T_65 = mux(_format_T_37, UInt<5>("hc"), _format_T_64) @[Lookup.scala 34:39]
    node _format_T_66 = mux(_format_T_35, UInt<5>("hc"), _format_T_65) @[Lookup.scala 34:39]
    node _format_T_67 = mux(_format_T_33, UInt<5>("hb"), _format_T_66) @[Lookup.scala 34:39]
    node _format_T_68 = mux(_format_T_31, UInt<5>("h9"), _format_T_67) @[Lookup.scala 34:39]
    node _format_T_69 = mux(_format_T_29, UInt<5>("ha"), _format_T_68) @[Lookup.scala 34:39]
    node _format_T_70 = mux(_format_T_27, UInt<5>("h8"), _format_T_69) @[Lookup.scala 34:39]
    node _format_T_71 = mux(_format_T_25, UInt<5>("h7"), _format_T_70) @[Lookup.scala 34:39]
    node _format_T_72 = mux(_format_T_23, UInt<5>("h7"), _format_T_71) @[Lookup.scala 34:39]
    node _format_T_73 = mux(_format_T_21, UInt<5>("h6"), _format_T_72) @[Lookup.scala 34:39]
    node _format_T_74 = mux(_format_T_19, UInt<5>("h6"), _format_T_73) @[Lookup.scala 34:39]
    node _format_T_75 = mux(_format_T_17, UInt<5>("h5"), _format_T_74) @[Lookup.scala 34:39]
    node _format_T_76 = mux(_format_T_15, UInt<5>("h5"), _format_T_75) @[Lookup.scala 34:39]
    node _format_T_77 = mux(_format_T_13, UInt<5>("h3"), _format_T_76) @[Lookup.scala 34:39]
    node _format_T_78 = mux(_format_T_11, UInt<5>("h2"), _format_T_77) @[Lookup.scala 34:39]
    node _format_T_79 = mux(_format_T_9, UInt<5>("h1"), _format_T_78) @[Lookup.scala 34:39]
    node _format_T_80 = mux(_format_T_7, UInt<5>("h1"), _format_T_79) @[Lookup.scala 34:39]
    node _format_T_81 = mux(_format_T_5, UInt<5>("h0"), _format_T_80) @[Lookup.scala 34:39]
    node _format_T_82 = mux(_format_T_3, UInt<5>("h0"), _format_T_81) @[Lookup.scala 34:39]
    node format_0 = mux(_format_T_1, UInt<5>("h0"), _format_T_82) @[Lookup.scala 34:39]
    node _format_T_83 = mux(_format_T_55, UInt<1>("h1"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _format_T_84 = mux(_format_T_53, UInt<1>("h1"), _format_T_83) @[Lookup.scala 34:39]
    node _format_T_85 = mux(_format_T_51, UInt<1>("h1"), _format_T_84) @[Lookup.scala 34:39]
    node _format_T_86 = mux(_format_T_49, UInt<1>("h0"), _format_T_85) @[Lookup.scala 34:39]
    node _format_T_87 = mux(_format_T_47, UInt<1>("h0"), _format_T_86) @[Lookup.scala 34:39]
    node _format_T_88 = mux(_format_T_45, UInt<1>("h0"), _format_T_87) @[Lookup.scala 34:39]
    node _format_T_89 = mux(_format_T_43, UInt<1>("h0"), _format_T_88) @[Lookup.scala 34:39]
    node _format_T_90 = mux(_format_T_41, UInt<1>("h1"), _format_T_89) @[Lookup.scala 34:39]
    node _format_T_91 = mux(_format_T_39, UInt<1>("h0"), _format_T_90) @[Lookup.scala 34:39]
    node _format_T_92 = mux(_format_T_37, UInt<1>("h1"), _format_T_91) @[Lookup.scala 34:39]
    node _format_T_93 = mux(_format_T_35, UInt<1>("h0"), _format_T_92) @[Lookup.scala 34:39]
    node _format_T_94 = mux(_format_T_33, UInt<1>("h0"), _format_T_93) @[Lookup.scala 34:39]
    node _format_T_95 = mux(_format_T_31, UInt<1>("h0"), _format_T_94) @[Lookup.scala 34:39]
    node _format_T_96 = mux(_format_T_29, UInt<1>("h1"), _format_T_95) @[Lookup.scala 34:39]
    node _format_T_97 = mux(_format_T_27, UInt<1>("h1"), _format_T_96) @[Lookup.scala 34:39]
    node _format_T_98 = mux(_format_T_25, UInt<1>("h1"), _format_T_97) @[Lookup.scala 34:39]
    node _format_T_99 = mux(_format_T_23, UInt<1>("h0"), _format_T_98) @[Lookup.scala 34:39]
    node _format_T_100 = mux(_format_T_21, UInt<1>("h1"), _format_T_99) @[Lookup.scala 34:39]
    node _format_T_101 = mux(_format_T_19, UInt<1>("h0"), _format_T_100) @[Lookup.scala 34:39]
    node _format_T_102 = mux(_format_T_17, UInt<1>("h1"), _format_T_101) @[Lookup.scala 34:39]
    node _format_T_103 = mux(_format_T_15, UInt<1>("h0"), _format_T_102) @[Lookup.scala 34:39]
    node _format_T_104 = mux(_format_T_13, UInt<1>("h0"), _format_T_103) @[Lookup.scala 34:39]
    node _format_T_105 = mux(_format_T_11, UInt<1>("h0"), _format_T_104) @[Lookup.scala 34:39]
    node _format_T_106 = mux(_format_T_9, UInt<1>("h1"), _format_T_105) @[Lookup.scala 34:39]
    node _format_T_107 = mux(_format_T_7, UInt<1>("h0"), _format_T_106) @[Lookup.scala 34:39]
    node _format_T_108 = mux(_format_T_5, UInt<1>("h1"), _format_T_107) @[Lookup.scala 34:39]
    node _format_T_109 = mux(_format_T_3, UInt<1>("h0"), _format_T_108) @[Lookup.scala 34:39]
    node format_1 = mux(_format_T_1, UInt<1>("h0"), _format_T_109) @[Lookup.scala 34:39]
    node _format_T_110 = mux(_format_T_55, UInt<2>("h2"), UInt<2>("h0")) @[Lookup.scala 34:39]
    node _format_T_111 = mux(_format_T_53, UInt<2>("h0"), _format_T_110) @[Lookup.scala 34:39]
    node _format_T_112 = mux(_format_T_51, UInt<2>("h0"), _format_T_111) @[Lookup.scala 34:39]
    node _format_T_113 = mux(_format_T_49, UInt<2>("h1"), _format_T_112) @[Lookup.scala 34:39]
    node _format_T_114 = mux(_format_T_47, UInt<2>("h1"), _format_T_113) @[Lookup.scala 34:39]
    node _format_T_115 = mux(_format_T_45, UInt<2>("h1"), _format_T_114) @[Lookup.scala 34:39]
    node _format_T_116 = mux(_format_T_43, UInt<2>("h1"), _format_T_115) @[Lookup.scala 34:39]
    node _format_T_117 = mux(_format_T_41, UInt<2>("h0"), _format_T_116) @[Lookup.scala 34:39]
    node _format_T_118 = mux(_format_T_39, UInt<2>("h0"), _format_T_117) @[Lookup.scala 34:39]
    node _format_T_119 = mux(_format_T_37, UInt<2>("h0"), _format_T_118) @[Lookup.scala 34:39]
    node _format_T_120 = mux(_format_T_35, UInt<2>("h0"), _format_T_119) @[Lookup.scala 34:39]
    node _format_T_121 = mux(_format_T_33, UInt<2>("h0"), _format_T_120) @[Lookup.scala 34:39]
    node _format_T_122 = mux(_format_T_31, UInt<2>("h0"), _format_T_121) @[Lookup.scala 34:39]
    node _format_T_123 = mux(_format_T_29, UInt<2>("h0"), _format_T_122) @[Lookup.scala 34:39]
    node _format_T_124 = mux(_format_T_27, UInt<2>("h0"), _format_T_123) @[Lookup.scala 34:39]
    node _format_T_125 = mux(_format_T_25, UInt<2>("h0"), _format_T_124) @[Lookup.scala 34:39]
    node _format_T_126 = mux(_format_T_23, UInt<2>("h0"), _format_T_125) @[Lookup.scala 34:39]
    node _format_T_127 = mux(_format_T_21, UInt<2>("h0"), _format_T_126) @[Lookup.scala 34:39]
    node _format_T_128 = mux(_format_T_19, UInt<2>("h0"), _format_T_127) @[Lookup.scala 34:39]
    node _format_T_129 = mux(_format_T_17, UInt<2>("h0"), _format_T_128) @[Lookup.scala 34:39]
    node _format_T_130 = mux(_format_T_15, UInt<2>("h0"), _format_T_129) @[Lookup.scala 34:39]
    node _format_T_131 = mux(_format_T_13, UInt<2>("h0"), _format_T_130) @[Lookup.scala 34:39]
    node _format_T_132 = mux(_format_T_11, UInt<2>("h0"), _format_T_131) @[Lookup.scala 34:39]
    node _format_T_133 = mux(_format_T_9, UInt<2>("h0"), _format_T_132) @[Lookup.scala 34:39]
    node _format_T_134 = mux(_format_T_7, UInt<2>("h0"), _format_T_133) @[Lookup.scala 34:39]
    node _format_T_135 = mux(_format_T_5, UInt<2>("h0"), _format_T_134) @[Lookup.scala 34:39]
    node _format_T_136 = mux(_format_T_3, UInt<2>("h0"), _format_T_135) @[Lookup.scala 34:39]
    node format_2 = mux(_format_T_1, UInt<2>("h0"), _format_T_136) @[Lookup.scala 34:39]
    node _format_T_137 = mux(_format_T_55, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _format_T_138 = mux(_format_T_53, UInt<1>("h0"), _format_T_137) @[Lookup.scala 34:39]
    node _format_T_139 = mux(_format_T_51, UInt<1>("h1"), _format_T_138) @[Lookup.scala 34:39]
    node _format_T_140 = mux(_format_T_49, UInt<1>("h0"), _format_T_139) @[Lookup.scala 34:39]
    node _format_T_141 = mux(_format_T_47, UInt<1>("h0"), _format_T_140) @[Lookup.scala 34:39]
    node _format_T_142 = mux(_format_T_45, UInt<1>("h0"), _format_T_141) @[Lookup.scala 34:39]
    node _format_T_143 = mux(_format_T_43, UInt<1>("h0"), _format_T_142) @[Lookup.scala 34:39]
    node _format_T_144 = mux(_format_T_41, UInt<1>("h0"), _format_T_143) @[Lookup.scala 34:39]
    node _format_T_145 = mux(_format_T_39, UInt<1>("h0"), _format_T_144) @[Lookup.scala 34:39]
    node _format_T_146 = mux(_format_T_37, UInt<1>("h0"), _format_T_145) @[Lookup.scala 34:39]
    node _format_T_147 = mux(_format_T_35, UInt<1>("h0"), _format_T_146) @[Lookup.scala 34:39]
    node _format_T_148 = mux(_format_T_33, UInt<1>("h0"), _format_T_147) @[Lookup.scala 34:39]
    node _format_T_149 = mux(_format_T_31, UInt<1>("h0"), _format_T_148) @[Lookup.scala 34:39]
    node _format_T_150 = mux(_format_T_29, UInt<1>("h0"), _format_T_149) @[Lookup.scala 34:39]
    node _format_T_151 = mux(_format_T_27, UInt<1>("h0"), _format_T_150) @[Lookup.scala 34:39]
    node _format_T_152 = mux(_format_T_25, UInt<1>("h0"), _format_T_151) @[Lookup.scala 34:39]
    node _format_T_153 = mux(_format_T_23, UInt<1>("h0"), _format_T_152) @[Lookup.scala 34:39]
    node _format_T_154 = mux(_format_T_21, UInt<1>("h0"), _format_T_153) @[Lookup.scala 34:39]
    node _format_T_155 = mux(_format_T_19, UInt<1>("h0"), _format_T_154) @[Lookup.scala 34:39]
    node _format_T_156 = mux(_format_T_17, UInt<1>("h0"), _format_T_155) @[Lookup.scala 34:39]
    node _format_T_157 = mux(_format_T_15, UInt<1>("h0"), _format_T_156) @[Lookup.scala 34:39]
    node _format_T_158 = mux(_format_T_13, UInt<1>("h0"), _format_T_157) @[Lookup.scala 34:39]
    node _format_T_159 = mux(_format_T_11, UInt<1>("h0"), _format_T_158) @[Lookup.scala 34:39]
    node _format_T_160 = mux(_format_T_9, UInt<1>("h0"), _format_T_159) @[Lookup.scala 34:39]
    node _format_T_161 = mux(_format_T_7, UInt<1>("h0"), _format_T_160) @[Lookup.scala 34:39]
    node _format_T_162 = mux(_format_T_5, UInt<1>("h0"), _format_T_161) @[Lookup.scala 34:39]
    node _format_T_163 = mux(_format_T_3, UInt<1>("h0"), _format_T_162) @[Lookup.scala 34:39]
    node format_3 = mux(_format_T_1, UInt<1>("h0"), _format_T_163) @[Lookup.scala 34:39]
    node _format_T_164 = mux(_format_T_55, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _format_T_165 = mux(_format_T_53, UInt<1>("h1"), _format_T_164) @[Lookup.scala 34:39]
    node _format_T_166 = mux(_format_T_51, UInt<1>("h0"), _format_T_165) @[Lookup.scala 34:39]
    node _format_T_167 = mux(_format_T_49, UInt<1>("h0"), _format_T_166) @[Lookup.scala 34:39]
    node _format_T_168 = mux(_format_T_47, UInt<1>("h0"), _format_T_167) @[Lookup.scala 34:39]
    node _format_T_169 = mux(_format_T_45, UInt<1>("h0"), _format_T_168) @[Lookup.scala 34:39]
    node _format_T_170 = mux(_format_T_43, UInt<1>("h0"), _format_T_169) @[Lookup.scala 34:39]
    node _format_T_171 = mux(_format_T_41, UInt<1>("h0"), _format_T_170) @[Lookup.scala 34:39]
    node _format_T_172 = mux(_format_T_39, UInt<1>("h0"), _format_T_171) @[Lookup.scala 34:39]
    node _format_T_173 = mux(_format_T_37, UInt<1>("h0"), _format_T_172) @[Lookup.scala 34:39]
    node _format_T_174 = mux(_format_T_35, UInt<1>("h0"), _format_T_173) @[Lookup.scala 34:39]
    node _format_T_175 = mux(_format_T_33, UInt<1>("h0"), _format_T_174) @[Lookup.scala 34:39]
    node _format_T_176 = mux(_format_T_31, UInt<1>("h0"), _format_T_175) @[Lookup.scala 34:39]
    node _format_T_177 = mux(_format_T_29, UInt<1>("h0"), _format_T_176) @[Lookup.scala 34:39]
    node _format_T_178 = mux(_format_T_27, UInt<1>("h0"), _format_T_177) @[Lookup.scala 34:39]
    node _format_T_179 = mux(_format_T_25, UInt<1>("h0"), _format_T_178) @[Lookup.scala 34:39]
    node _format_T_180 = mux(_format_T_23, UInt<1>("h0"), _format_T_179) @[Lookup.scala 34:39]
    node _format_T_181 = mux(_format_T_21, UInt<1>("h0"), _format_T_180) @[Lookup.scala 34:39]
    node _format_T_182 = mux(_format_T_19, UInt<1>("h0"), _format_T_181) @[Lookup.scala 34:39]
    node _format_T_183 = mux(_format_T_17, UInt<1>("h0"), _format_T_182) @[Lookup.scala 34:39]
    node _format_T_184 = mux(_format_T_15, UInt<1>("h0"), _format_T_183) @[Lookup.scala 34:39]
    node _format_T_185 = mux(_format_T_13, UInt<1>("h0"), _format_T_184) @[Lookup.scala 34:39]
    node _format_T_186 = mux(_format_T_11, UInt<1>("h0"), _format_T_185) @[Lookup.scala 34:39]
    node _format_T_187 = mux(_format_T_9, UInt<1>("h0"), _format_T_186) @[Lookup.scala 34:39]
    node _format_T_188 = mux(_format_T_7, UInt<1>("h0"), _format_T_187) @[Lookup.scala 34:39]
    node _format_T_189 = mux(_format_T_5, UInt<1>("h0"), _format_T_188) @[Lookup.scala 34:39]
    node _format_T_190 = mux(_format_T_3, UInt<1>("h0"), _format_T_189) @[Lookup.scala 34:39]
    node format_4 = mux(_format_T_1, UInt<1>("h0"), _format_T_190) @[Lookup.scala 34:39]
    node _format_T_191 = mux(_format_T_55, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _format_T_192 = mux(_format_T_53, UInt<1>("h1"), _format_T_191) @[Lookup.scala 34:39]
    node _format_T_193 = mux(_format_T_51, UInt<1>("h0"), _format_T_192) @[Lookup.scala 34:39]
    node _format_T_194 = mux(_format_T_49, UInt<1>("h0"), _format_T_193) @[Lookup.scala 34:39]
    node _format_T_195 = mux(_format_T_47, UInt<1>("h0"), _format_T_194) @[Lookup.scala 34:39]
    node _format_T_196 = mux(_format_T_45, UInt<1>("h0"), _format_T_195) @[Lookup.scala 34:39]
    node _format_T_197 = mux(_format_T_43, UInt<1>("h0"), _format_T_196) @[Lookup.scala 34:39]
    node _format_T_198 = mux(_format_T_41, UInt<1>("h0"), _format_T_197) @[Lookup.scala 34:39]
    node _format_T_199 = mux(_format_T_39, UInt<1>("h0"), _format_T_198) @[Lookup.scala 34:39]
    node _format_T_200 = mux(_format_T_37, UInt<1>("h0"), _format_T_199) @[Lookup.scala 34:39]
    node _format_T_201 = mux(_format_T_35, UInt<1>("h0"), _format_T_200) @[Lookup.scala 34:39]
    node _format_T_202 = mux(_format_T_33, UInt<1>("h0"), _format_T_201) @[Lookup.scala 34:39]
    node _format_T_203 = mux(_format_T_31, UInt<1>("h0"), _format_T_202) @[Lookup.scala 34:39]
    node _format_T_204 = mux(_format_T_29, UInt<1>("h0"), _format_T_203) @[Lookup.scala 34:39]
    node _format_T_205 = mux(_format_T_27, UInt<1>("h0"), _format_T_204) @[Lookup.scala 34:39]
    node _format_T_206 = mux(_format_T_25, UInt<1>("h0"), _format_T_205) @[Lookup.scala 34:39]
    node _format_T_207 = mux(_format_T_23, UInt<1>("h0"), _format_T_206) @[Lookup.scala 34:39]
    node _format_T_208 = mux(_format_T_21, UInt<1>("h0"), _format_T_207) @[Lookup.scala 34:39]
    node _format_T_209 = mux(_format_T_19, UInt<1>("h0"), _format_T_208) @[Lookup.scala 34:39]
    node _format_T_210 = mux(_format_T_17, UInt<1>("h0"), _format_T_209) @[Lookup.scala 34:39]
    node _format_T_211 = mux(_format_T_15, UInt<1>("h0"), _format_T_210) @[Lookup.scala 34:39]
    node _format_T_212 = mux(_format_T_13, UInt<1>("h0"), _format_T_211) @[Lookup.scala 34:39]
    node _format_T_213 = mux(_format_T_11, UInt<1>("h0"), _format_T_212) @[Lookup.scala 34:39]
    node _format_T_214 = mux(_format_T_9, UInt<1>("h0"), _format_T_213) @[Lookup.scala 34:39]
    node _format_T_215 = mux(_format_T_7, UInt<1>("h0"), _format_T_214) @[Lookup.scala 34:39]
    node _format_T_216 = mux(_format_T_5, UInt<1>("h0"), _format_T_215) @[Lookup.scala 34:39]
    node _format_T_217 = mux(_format_T_3, UInt<1>("h0"), _format_T_216) @[Lookup.scala 34:39]
    node format_5 = mux(_format_T_1, UInt<1>("h0"), _format_T_217) @[Lookup.scala 34:39]
    node _format_T_218 = mux(_format_T_55, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _format_T_219 = mux(_format_T_53, UInt<1>("h0"), _format_T_218) @[Lookup.scala 34:39]
    node _format_T_220 = mux(_format_T_51, UInt<1>("h1"), _format_T_219) @[Lookup.scala 34:39]
    node _format_T_221 = mux(_format_T_49, UInt<1>("h0"), _format_T_220) @[Lookup.scala 34:39]
    node _format_T_222 = mux(_format_T_47, UInt<1>("h0"), _format_T_221) @[Lookup.scala 34:39]
    node _format_T_223 = mux(_format_T_45, UInt<1>("h0"), _format_T_222) @[Lookup.scala 34:39]
    node _format_T_224 = mux(_format_T_43, UInt<1>("h0"), _format_T_223) @[Lookup.scala 34:39]
    node _format_T_225 = mux(_format_T_41, UInt<1>("h1"), _format_T_224) @[Lookup.scala 34:39]
    node _format_T_226 = mux(_format_T_39, UInt<1>("h1"), _format_T_225) @[Lookup.scala 34:39]
    node _format_T_227 = mux(_format_T_37, UInt<1>("h1"), _format_T_226) @[Lookup.scala 34:39]
    node _format_T_228 = mux(_format_T_35, UInt<1>("h1"), _format_T_227) @[Lookup.scala 34:39]
    node _format_T_229 = mux(_format_T_33, UInt<1>("h1"), _format_T_228) @[Lookup.scala 34:39]
    node _format_T_230 = mux(_format_T_31, UInt<1>("h1"), _format_T_229) @[Lookup.scala 34:39]
    node _format_T_231 = mux(_format_T_29, UInt<1>("h1"), _format_T_230) @[Lookup.scala 34:39]
    node _format_T_232 = mux(_format_T_27, UInt<1>("h1"), _format_T_231) @[Lookup.scala 34:39]
    node _format_T_233 = mux(_format_T_25, UInt<1>("h1"), _format_T_232) @[Lookup.scala 34:39]
    node _format_T_234 = mux(_format_T_23, UInt<1>("h1"), _format_T_233) @[Lookup.scala 34:39]
    node _format_T_235 = mux(_format_T_21, UInt<1>("h1"), _format_T_234) @[Lookup.scala 34:39]
    node _format_T_236 = mux(_format_T_19, UInt<1>("h1"), _format_T_235) @[Lookup.scala 34:39]
    node _format_T_237 = mux(_format_T_17, UInt<1>("h1"), _format_T_236) @[Lookup.scala 34:39]
    node _format_T_238 = mux(_format_T_15, UInt<1>("h1"), _format_T_237) @[Lookup.scala 34:39]
    node _format_T_239 = mux(_format_T_13, UInt<1>("h1"), _format_T_238) @[Lookup.scala 34:39]
    node _format_T_240 = mux(_format_T_11, UInt<1>("h1"), _format_T_239) @[Lookup.scala 34:39]
    node _format_T_241 = mux(_format_T_9, UInt<1>("h1"), _format_T_240) @[Lookup.scala 34:39]
    node _format_T_242 = mux(_format_T_7, UInt<1>("h1"), _format_T_241) @[Lookup.scala 34:39]
    node _format_T_243 = mux(_format_T_5, UInt<1>("h1"), _format_T_242) @[Lookup.scala 34:39]
    node _format_T_244 = mux(_format_T_3, UInt<1>("h1"), _format_T_243) @[Lookup.scala 34:39]
    node format_6 = mux(_format_T_1, UInt<1>("h0"), _format_T_244) @[Lookup.scala 34:39]
    node _format_T_245 = mux(_format_T_55, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _format_T_246 = mux(_format_T_53, UInt<1>("h0"), _format_T_245) @[Lookup.scala 34:39]
    node _format_T_247 = mux(_format_T_51, UInt<1>("h0"), _format_T_246) @[Lookup.scala 34:39]
    node _format_T_248 = mux(_format_T_49, UInt<1>("h0"), _format_T_247) @[Lookup.scala 34:39]
    node _format_T_249 = mux(_format_T_47, UInt<1>("h0"), _format_T_248) @[Lookup.scala 34:39]
    node _format_T_250 = mux(_format_T_45, UInt<1>("h0"), _format_T_249) @[Lookup.scala 34:39]
    node _format_T_251 = mux(_format_T_43, UInt<1>("h0"), _format_T_250) @[Lookup.scala 34:39]
    node _format_T_252 = mux(_format_T_41, UInt<1>("h0"), _format_T_251) @[Lookup.scala 34:39]
    node _format_T_253 = mux(_format_T_39, UInt<1>("h0"), _format_T_252) @[Lookup.scala 34:39]
    node _format_T_254 = mux(_format_T_37, UInt<1>("h1"), _format_T_253) @[Lookup.scala 34:39]
    node _format_T_255 = mux(_format_T_35, UInt<1>("h1"), _format_T_254) @[Lookup.scala 34:39]
    node _format_T_256 = mux(_format_T_33, UInt<1>("h0"), _format_T_255) @[Lookup.scala 34:39]
    node _format_T_257 = mux(_format_T_31, UInt<1>("h0"), _format_T_256) @[Lookup.scala 34:39]
    node _format_T_258 = mux(_format_T_29, UInt<1>("h0"), _format_T_257) @[Lookup.scala 34:39]
    node _format_T_259 = mux(_format_T_27, UInt<1>("h0"), _format_T_258) @[Lookup.scala 34:39]
    node _format_T_260 = mux(_format_T_25, UInt<1>("h0"), _format_T_259) @[Lookup.scala 34:39]
    node _format_T_261 = mux(_format_T_23, UInt<1>("h0"), _format_T_260) @[Lookup.scala 34:39]
    node _format_T_262 = mux(_format_T_21, UInt<1>("h0"), _format_T_261) @[Lookup.scala 34:39]
    node _format_T_263 = mux(_format_T_19, UInt<1>("h0"), _format_T_262) @[Lookup.scala 34:39]
    node _format_T_264 = mux(_format_T_17, UInt<1>("h0"), _format_T_263) @[Lookup.scala 34:39]
    node _format_T_265 = mux(_format_T_15, UInt<1>("h0"), _format_T_264) @[Lookup.scala 34:39]
    node _format_T_266 = mux(_format_T_13, UInt<1>("h0"), _format_T_265) @[Lookup.scala 34:39]
    node _format_T_267 = mux(_format_T_11, UInt<1>("h1"), _format_T_266) @[Lookup.scala 34:39]
    node _format_T_268 = mux(_format_T_9, UInt<1>("h0"), _format_T_267) @[Lookup.scala 34:39]
    node _format_T_269 = mux(_format_T_7, UInt<1>("h0"), _format_T_268) @[Lookup.scala 34:39]
    node _format_T_270 = mux(_format_T_5, UInt<1>("h1"), _format_T_269) @[Lookup.scala 34:39]
    node _format_T_271 = mux(_format_T_3, UInt<1>("h1"), _format_T_270) @[Lookup.scala 34:39]
    node format_7 = mux(_format_T_1, UInt<1>("h0"), _format_T_271) @[Lookup.scala 34:39]
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
    output dec_io : { flip Instr : UInt<32>, flip NextPCIn : UInt<32>, flip WriteAddrIn : UInt<32>, flip WriteEnIn : UInt<1>, flip WriteTypeIn : UInt<1>, flip WriteDataIn : UInt<32>, AluOp : UInt<8>, Imm : UInt<32>, ImmEn : UInt<1>, BrEn : UInt<2>, NextPCOut : UInt<32>, ReadEn : UInt<1>, WriteEnOut : UInt<1>, WbType : UInt<1>, WbEn : UInt<1>, rs : UInt<6>, rt : UInt<6>, rd : UInt<6>, DataRead1 : UInt<32>, DataRead2 : UInt<32>}

    inst regFile of RegisterFile @[Decode.scala 6:25]
    regFile.clock <= clock
    regFile.reset <= reset
    inst control of Control @[Decode.scala 7:25]
    control.clock <= clock
    control.reset <= reset
    inst signExtend of SignExtend @[Decode.scala 8:28]
    signExtend.clock <= clock
    signExtend.reset <= reset
    control.io.instr <= dec_io.Instr @[Decode.scala 44:22]
    dec_io.rs <= control.io.rs @[Decode.scala 46:15]
    dec_io.rt <= control.io.rt @[Decode.scala 47:15]
    dec_io.rd <= control.io.rd @[Decode.scala 48:15]
    dec_io.AluOp <= control.io.AluOp @[Decode.scala 49:18]
    dec_io.BrEn <= control.io.BrEn @[Decode.scala 50:17]
    dec_io.ReadEn <= control.io.LoadEn @[Decode.scala 51:19]
    dec_io.ImmEn <= control.io.ImmEn @[Decode.scala 52:18]
    dec_io.WriteEnOut <= control.io.StoreEn @[Decode.scala 53:23]
    dec_io.WbType <= control.io.WbType @[Decode.scala 54:19]
    dec_io.WbEn <= control.io.WbEn @[Decode.scala 55:17]
    regFile.io.ReadAddr1 <= control.io.rs @[Decode.scala 58:26]
    regFile.io.ReadAddr2 <= control.io.rt @[Decode.scala 59:26]
    node _regFile_io_WriteEnable_T = eq(dec_io.WriteEnIn, UInt<1>("h1")) @[Decode.scala 60:48]
    node _regFile_io_WriteEnable_T_1 = eq(dec_io.WriteTypeIn, UInt<1>("h0")) @[Decode.scala 60:78]
    node _regFile_io_WriteEnable_T_2 = and(_regFile_io_WriteEnable_T, _regFile_io_WriteEnable_T_1) @[Decode.scala 60:57]
    regFile.io.WriteEnable <= _regFile_io_WriteEnable_T_2 @[Decode.scala 60:28]
    regFile.io.WriteAddr <= dec_io.WriteAddrIn @[Decode.scala 61:26]
    regFile.io.WriteData <= dec_io.WriteDataIn @[Decode.scala 62:26]
    dec_io.DataRead1 <= regFile.io.ReadData1 @[Decode.scala 64:22]
    dec_io.DataRead2 <= regFile.io.ReadData2 @[Decode.scala 65:22]
    dec_io.NextPCOut <= dec_io.NextPCIn @[Decode.scala 67:22]
    signExtend.io.in <= control.io.imm @[Decode.scala 69:22]
    node _signExtend_io_isSigned_T = eq(control.io.IsSigned, UInt<1>("h1")) @[Decode.scala 70:51]
    signExtend.io.isSigned <= _signExtend_io_isSigned_T @[Decode.scala 70:28]
    dec_io.Imm <= signExtend.io.out @[Decode.scala 71:16]

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
    output exec_io : { flip NextPC : UInt<32>, flip Imm : UInt<32>, flip rs : UInt<32>, flip rt : UInt<32>, flip rd : UInt<32>, flip DataRead1 : UInt<32>, flip DataRead2 : UInt<32>, flip MemWbEn : UInt<1>, flip MemWbType : UInt<1>, flip MemAddr : UInt<32>, flip MemVal : UInt<32>, flip WbWbEn : UInt<1>, flip WbWbType : UInt<1>, flip WbAddr : UInt<32>, flip WbVal : UInt<32>, flip AluOp : UInt<8>, flip ImmEn : UInt<1>, flip StoreEnIn : UInt<1>, flip LoadEnIn : UInt<1>, flip BrEnIn : UInt<2>, flip WbEnIn : UInt<1>, flip WbTypeIn : UInt<1>, AluRes : UInt<32>, zero : UInt<1>, BranchAddrOut : UInt<32>, WriteData : UInt<32>, StoreEnOut : UInt<1>, LoadEnOut : UInt<1>, BrEnOut : UInt<2>, WbTypeOut : UInt<1>, WbEnOut : UInt<1>, WriteRegAddr : UInt<32>}

    inst alu of ALU @[Execute.scala 7:21]
    alu.clock <= clock
    alu.reset <= reset
    node isImmediate = eq(exec_io.ImmEn, UInt<1>("h1")) @[Execute.scala 71:43]
    node _A_T = eq(exec_io.rs, exec_io.MemAddr) @[Execute.scala 63:14]
    node _A_T_1 = eq(exec_io.MemWbType, UInt<1>("h0")) @[Execute.scala 63:54]
    node _A_T_2 = and(_A_T, _A_T_1) @[Execute.scala 63:34]
    node _A_T_3 = eq(exec_io.MemWbEn, UInt<1>("h1")) @[Execute.scala 63:83]
    node _A_T_4 = and(_A_T_2, _A_T_3) @[Execute.scala 63:65]
    node _A_T_5 = eq(exec_io.rs, exec_io.WbAddr) @[Execute.scala 65:19]
    node _A_T_6 = eq(exec_io.WbWbType, UInt<1>("h0")) @[Execute.scala 65:57]
    node _A_T_7 = and(_A_T_5, _A_T_6) @[Execute.scala 65:38]
    node _A_T_8 = eq(exec_io.WbWbEn, UInt<1>("h1")) @[Execute.scala 65:85]
    node _A_T_9 = and(_A_T_7, _A_T_8) @[Execute.scala 65:68]
    node _A_T_10 = mux(_A_T_9, exec_io.WbVal, exec_io.DataRead1) @[Execute.scala 65:12]
    node A = mux(_A_T_4, exec_io.MemVal, _A_T_10) @[Execute.scala 62:54]
    node _B_T = eq(exec_io.rt, exec_io.MemAddr) @[Execute.scala 63:14]
    node _B_T_1 = eq(exec_io.MemWbType, UInt<1>("h0")) @[Execute.scala 63:54]
    node _B_T_2 = and(_B_T, _B_T_1) @[Execute.scala 63:34]
    node _B_T_3 = eq(exec_io.MemWbEn, UInt<1>("h1")) @[Execute.scala 63:83]
    node _B_T_4 = and(_B_T_2, _B_T_3) @[Execute.scala 63:65]
    node _B_T_5 = eq(exec_io.rt, exec_io.WbAddr) @[Execute.scala 65:19]
    node _B_T_6 = eq(exec_io.WbWbType, UInt<1>("h0")) @[Execute.scala 65:57]
    node _B_T_7 = and(_B_T_5, _B_T_6) @[Execute.scala 65:38]
    node _B_T_8 = eq(exec_io.WbWbEn, UInt<1>("h1")) @[Execute.scala 65:85]
    node _B_T_9 = and(_B_T_7, _B_T_8) @[Execute.scala 65:68]
    node _B_T_10 = mux(_B_T_9, exec_io.WbVal, exec_io.DataRead2) @[Execute.scala 65:12]
    node B = mux(_B_T_4, exec_io.MemVal, _B_T_10) @[Execute.scala 62:54]
    alu.io.A <= A @[Execute.scala 82:14]
    node _alu_io_B_T = eq(exec_io.ImmEn, UInt<1>("h1")) @[Execute.scala 83:35]
    node _alu_io_B_T_1 = mux(_alu_io_B_T, exec_io.Imm, B) @[Execute.scala 83:20]
    alu.io.B <= _alu_io_B_T_1 @[Execute.scala 83:14]
    alu.io.AluOp <= exec_io.AluOp @[Execute.scala 84:18]
    exec_io.AluRes <= alu.io.out @[Execute.scala 85:20]
    exec_io.zero <= alu.io.zero @[Execute.scala 86:18]
    node _exec_io_BranchAddrOut_T = eq(exec_io.BrEnIn, UInt<2>("h2")) @[Execute.scala 89:63]
    node _exec_io_BranchAddrOut_T_1 = mux(_exec_io_BranchAddrOut_T, UInt<1>("h0"), exec_io.NextPC) @[Execute.scala 89:47]
    node _exec_io_BranchAddrOut_T_2 = add(exec_io.Imm, _exec_io_BranchAddrOut_T_1) @[Execute.scala 89:42]
    node _exec_io_BranchAddrOut_T_3 = tail(_exec_io_BranchAddrOut_T_2, 1) @[Execute.scala 89:42]
    exec_io.BranchAddrOut <= _exec_io_BranchAddrOut_T_3 @[Execute.scala 89:27]
    exec_io.BrEnOut <= exec_io.BrEnIn @[Execute.scala 90:21]
    exec_io.WbTypeOut <= exec_io.WbTypeIn @[Execute.scala 91:23]
    exec_io.WbEnOut <= exec_io.WbEnIn @[Execute.scala 92:21]
    exec_io.LoadEnOut <= exec_io.LoadEnIn @[Execute.scala 93:23]
    exec_io.StoreEnOut <= exec_io.StoreEnIn @[Execute.scala 94:24]
    exec_io.WriteData <= B @[Execute.scala 97:23]
    node _exec_io_WriteRegAddr_T = mux(isImmediate, exec_io.rt, exec_io.rd) @[Execute.scala 100:32]
    exec_io.WriteRegAddr <= _exec_io_WriteRegAddr_T @[Execute.scala 100:26]

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
    node _isValid_T = gt(ram_io.Addr, UInt<1>("h0")) @[RAM.scala 35:33]
    node _isValid_T_1 = lt(ram_io.Addr, UInt<11>("h400")) @[RAM.scala 35:49]
    node isValid = and(_isValid_T, _isValid_T_1) @[RAM.scala 35:39]
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
    output mem_io : { flip Inport1 : UInt<8>, flip Inport2 : UInt<8>, Outport : UInt<32>, flip WbEnIn : UInt<1>, flip WbTypeIn : UInt<1>, flip LoadEnIn : UInt<1>, flip StoreEn : UInt<1>, flip CtrlBrEn : UInt<2>, flip BrAddrIn : UInt<32>, flip AluBrEn : UInt<1>, flip WriteRegAddrIn : UInt<32>, flip WriteData : UInt<32>, flip AddrIn : UInt<32>, LoadEnOut : UInt<1>, ReadData : UInt<32>, WbTypeOut : UInt<1>, WbEnOut : UInt<1>, AddrOut : UInt<32>, WriteRegAddrOut : UInt<32>, BrAddrOut : UInt<32>, BrEnOut : UInt<2>}

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
    node _ram_ram_io_ReadEn_T = eq(AddrSel, UInt<1>("h0")) @[Mem.scala 70:53]
    node _ram_ram_io_ReadEn_T_1 = and(mem_io.LoadEnIn, _ram_ram_io_ReadEn_T) @[Mem.scala 70:43]
    ram.ram_io.ReadEn <= _ram_ram_io_ReadEn_T_1 @[Mem.scala 70:23]
    node _ram_ram_io_WriteEn_T = eq(AddrSel, UInt<1>("h0")) @[Mem.scala 71:53]
    node _ram_ram_io_WriteEn_T_1 = and(mem_io.StoreEn, _ram_ram_io_WriteEn_T) @[Mem.scala 71:43]
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
    mem_io.LoadEnOut <= mem_io.LoadEnIn @[Mem.scala 81:22]
    mem_io.WbTypeOut <= mem_io.WbTypeIn @[Mem.scala 82:22]
    mem_io.WbEnOut <= mem_io.WbEnIn @[Mem.scala 83:20]
    mem_io.AddrOut <= mem_io.AddrIn @[Mem.scala 84:20]
    node _mem_io_BrEnOut_T = eq(mem_io.CtrlBrEn, UInt<2>("h2")) @[Mem.scala 86:40]
    node _mem_io_BrEnOut_T_1 = eq(mem_io.CtrlBrEn, UInt<2>("h1")) @[Mem.scala 86:87]
    node _mem_io_BrEnOut_T_2 = and(mem_io.AluBrEn, _mem_io_BrEnOut_T_1) @[Mem.scala 86:68]
    node _mem_io_BrEnOut_T_3 = or(_mem_io_BrEnOut_T, _mem_io_BrEnOut_T_2) @[Mem.scala 86:50]
    mem_io.BrEnOut <= _mem_io_BrEnOut_T_3 @[Mem.scala 86:20]
    mem_io.WriteRegAddrOut <= mem_io.WriteRegAddrIn @[Mem.scala 88:28]

  module Writeback :
    input clock : Clock
    input reset : Reset
    output wb_io : { flip LoadEn : UInt<1>, flip WbEnIn : UInt<1>, flip WbTypeIn : UInt<1>, flip WriteRegAddrIn : UInt<32>, flip ReadData : UInt<32>, flip AddrData : UInt<32>, WbEnOut : UInt<1>, WbTypeOut : UInt<1>, WriteRegAddrOut : UInt<32>, WriteDataOut : UInt<32>}

    wb_io.WbEnOut <= wb_io.WbEnIn @[Writeback.scala 23:19]
    wb_io.WbTypeOut <= wb_io.WbTypeIn @[Writeback.scala 24:21]
    wb_io.WriteRegAddrOut <= wb_io.WriteRegAddrIn @[Writeback.scala 26:27]
    node _wb_io_WriteDataOut_T = eq(wb_io.LoadEn, UInt<1>("h1")) @[Writeback.scala 27:44]
    node _wb_io_WriteDataOut_T_1 = mux(_wb_io_WriteDataOut_T, wb_io.ReadData, wb_io.AddrData) @[Writeback.scala 27:30]
    wb_io.WriteDataOut <= _wb_io_WriteDataOut_T_1 @[Writeback.scala 27:24]

  module Datapath :
    input clock : Clock
    input reset : Reset
    output io : { flip Inport1 : UInt<8>, flip Inport2 : UInt<8>, instr : UInt<32>, Outport : UInt<32>}

    inst fetch of Fetch @[Datapath.scala 7:23]
    fetch.clock <= clock
    fetch.reset <= reset
    inst decode of Decode @[Datapath.scala 8:24]
    decode.clock <= clock
    decode.reset <= reset
    inst execute of Execute @[Datapath.scala 9:25]
    execute.clock <= clock
    execute.reset <= reset
    inst memory of Mem @[Datapath.scala 10:24]
    memory.clock <= clock
    memory.reset <= reset
    inst writeback of Writeback @[Datapath.scala 11:27]
    writeback.clock <= clock
    writeback.reset <= reset
    io.instr <= fetch.io.Instr @[Datapath.scala 21:17]
    node _fetch_io_Stall_T = neq(decode.dec_io.BrEn, UInt<2>("h0")) @[Datapath.scala 24:51]
    node _fetch_io_Stall_T_1 = mux(_fetch_io_Stall_T, UInt<1>("h1"), UInt<1>("h0")) @[Datapath.scala 24:31]
    fetch.io.Stall <= _fetch_io_Stall_T_1 @[Datapath.scala 24:25]
    fetch.io.BrEn <= memory.mem_io.BrEnOut @[Datapath.scala 25:25]
    fetch.io.BranchAddr <= memory.mem_io.BrAddrOut @[Datapath.scala 26:25]
    reg decode_dec_io_Instr_REG : UInt, clock with :
      reset => (UInt<1>("h0"), decode_dec_io_Instr_REG) @[Datapath.scala 29:43]
    decode_dec_io_Instr_REG <= fetch.io.Instr @[Datapath.scala 29:43]
    decode.dec_io.Instr <= decode_dec_io_Instr_REG @[Datapath.scala 29:33]
    reg decode_dec_io_NextPCIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), decode_dec_io_NextPCIn_REG) @[Datapath.scala 30:43]
    decode_dec_io_NextPCIn_REG <= fetch.io.NextPC @[Datapath.scala 30:43]
    decode.dec_io.NextPCIn <= decode_dec_io_NextPCIn_REG @[Datapath.scala 30:33]
    decode.dec_io.WriteEnIn <= writeback.wb_io.WbEnOut @[Datapath.scala 31:33]
    decode.dec_io.WriteTypeIn <= writeback.wb_io.WbTypeOut @[Datapath.scala 32:33]
    decode.dec_io.WriteAddrIn <= writeback.wb_io.WriteRegAddrOut @[Datapath.scala 33:33]
    decode.dec_io.WriteDataIn <= writeback.wb_io.WriteDataOut @[Datapath.scala 34:33]
    reg execute_exec_io_rs_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_rs_REG) @[Datapath.scala 37:43]
    execute_exec_io_rs_REG <= decode.dec_io.rs @[Datapath.scala 37:43]
    execute.exec_io.rs <= execute_exec_io_rs_REG @[Datapath.scala 37:33]
    reg execute_exec_io_rt_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_rt_REG) @[Datapath.scala 38:43]
    execute_exec_io_rt_REG <= decode.dec_io.rt @[Datapath.scala 38:43]
    execute.exec_io.rt <= execute_exec_io_rt_REG @[Datapath.scala 38:33]
    reg execute_exec_io_rd_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_rd_REG) @[Datapath.scala 39:43]
    execute_exec_io_rd_REG <= decode.dec_io.rd @[Datapath.scala 39:43]
    execute.exec_io.rd <= execute_exec_io_rd_REG @[Datapath.scala 39:33]
    reg execute_exec_io_DataRead1_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_DataRead1_REG) @[Datapath.scala 40:43]
    execute_exec_io_DataRead1_REG <= decode.dec_io.DataRead1 @[Datapath.scala 40:43]
    execute.exec_io.DataRead1 <= execute_exec_io_DataRead1_REG @[Datapath.scala 40:33]
    reg execute_exec_io_DataRead2_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_DataRead2_REG) @[Datapath.scala 41:43]
    execute_exec_io_DataRead2_REG <= decode.dec_io.DataRead2 @[Datapath.scala 41:43]
    execute.exec_io.DataRead2 <= execute_exec_io_DataRead2_REG @[Datapath.scala 41:33]
    execute.exec_io.MemWbEn <= memory.mem_io.WbEnOut @[Datapath.scala 42:33]
    execute.exec_io.MemWbType <= memory.mem_io.WbTypeOut @[Datapath.scala 43:33]
    execute.exec_io.MemAddr <= memory.mem_io.WriteRegAddrOut @[Datapath.scala 44:33]
    node _execute_exec_io_MemVal_T = eq(memory.mem_io.LoadEnIn, UInt<1>("h1")) @[Datapath.scala 45:63]
    reg execute_exec_io_MemVal_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_MemVal_REG) @[Datapath.scala 45:104]
    execute_exec_io_MemVal_REG <= execute.exec_io.AluRes @[Datapath.scala 45:104]
    node _execute_exec_io_MemVal_T_1 = mux(_execute_exec_io_MemVal_T, memory.mem_io.ReadData, execute_exec_io_MemVal_REG) @[Datapath.scala 45:39]
    execute.exec_io.MemVal <= _execute_exec_io_MemVal_T_1 @[Datapath.scala 45:33]
    execute.exec_io.WbWbEn <= writeback.wb_io.WbEnOut @[Datapath.scala 46:33]
    execute.exec_io.WbWbType <= writeback.wb_io.WbTypeOut @[Datapath.scala 47:33]
    execute.exec_io.WbAddr <= writeback.wb_io.WriteRegAddrOut @[Datapath.scala 48:33]
    execute.exec_io.WbVal <= writeback.wb_io.WriteDataOut @[Datapath.scala 49:33]
    reg execute_exec_io_AluOp_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_AluOp_REG) @[Datapath.scala 50:43]
    execute_exec_io_AluOp_REG <= decode.dec_io.AluOp @[Datapath.scala 50:43]
    execute.exec_io.AluOp <= execute_exec_io_AluOp_REG @[Datapath.scala 50:33]
    reg execute_exec_io_Imm_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_Imm_REG) @[Datapath.scala 51:43]
    execute_exec_io_Imm_REG <= decode.dec_io.Imm @[Datapath.scala 51:43]
    execute.exec_io.Imm <= execute_exec_io_Imm_REG @[Datapath.scala 51:33]
    reg execute_exec_io_ImmEn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_ImmEn_REG) @[Datapath.scala 52:43]
    execute_exec_io_ImmEn_REG <= decode.dec_io.ImmEn @[Datapath.scala 52:43]
    execute.exec_io.ImmEn <= execute_exec_io_ImmEn_REG @[Datapath.scala 52:33]
    reg execute_exec_io_BrEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_BrEnIn_REG) @[Datapath.scala 53:43]
    execute_exec_io_BrEnIn_REG <= decode.dec_io.BrEn @[Datapath.scala 53:43]
    execute.exec_io.BrEnIn <= execute_exec_io_BrEnIn_REG @[Datapath.scala 53:33]
    reg execute_exec_io_NextPC_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_NextPC_REG) @[Datapath.scala 54:43]
    execute_exec_io_NextPC_REG <= decode.dec_io.NextPCOut @[Datapath.scala 54:43]
    execute.exec_io.NextPC <= execute_exec_io_NextPC_REG @[Datapath.scala 54:33]
    reg execute_exec_io_LoadEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_LoadEnIn_REG) @[Datapath.scala 55:43]
    execute_exec_io_LoadEnIn_REG <= decode.dec_io.ReadEn @[Datapath.scala 55:43]
    execute.exec_io.LoadEnIn <= execute_exec_io_LoadEnIn_REG @[Datapath.scala 55:33]
    reg execute_exec_io_StoreEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_StoreEnIn_REG) @[Datapath.scala 56:43]
    execute_exec_io_StoreEnIn_REG <= decode.dec_io.WriteEnOut @[Datapath.scala 56:43]
    execute.exec_io.StoreEnIn <= execute_exec_io_StoreEnIn_REG @[Datapath.scala 56:33]
    reg execute_exec_io_WbTypeIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_WbTypeIn_REG) @[Datapath.scala 57:43]
    execute_exec_io_WbTypeIn_REG <= decode.dec_io.WbType @[Datapath.scala 57:43]
    execute.exec_io.WbTypeIn <= execute_exec_io_WbTypeIn_REG @[Datapath.scala 57:33]
    reg execute_exec_io_WbEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_WbEnIn_REG) @[Datapath.scala 58:43]
    execute_exec_io_WbEnIn_REG <= decode.dec_io.WbEn @[Datapath.scala 58:43]
    execute.exec_io.WbEnIn <= execute_exec_io_WbEnIn_REG @[Datapath.scala 58:33]
    reg memory_mem_io_LoadEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_LoadEnIn_REG) @[Datapath.scala 61:47]
    memory_mem_io_LoadEnIn_REG <= execute.exec_io.LoadEnOut @[Datapath.scala 61:47]
    memory.mem_io.LoadEnIn <= memory_mem_io_LoadEnIn_REG @[Datapath.scala 61:37]
    reg memory_mem_io_StoreEn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_StoreEn_REG) @[Datapath.scala 62:47]
    memory_mem_io_StoreEn_REG <= execute.exec_io.StoreEnOut @[Datapath.scala 62:47]
    memory.mem_io.StoreEn <= memory_mem_io_StoreEn_REG @[Datapath.scala 62:37]
    reg memory_mem_io_AddrIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_AddrIn_REG) @[Datapath.scala 63:47]
    memory_mem_io_AddrIn_REG <= execute.exec_io.AluRes @[Datapath.scala 63:47]
    memory.mem_io.AddrIn <= memory_mem_io_AddrIn_REG @[Datapath.scala 63:37]
    reg memory_mem_io_WbEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_WbEnIn_REG) @[Datapath.scala 64:47]
    memory_mem_io_WbEnIn_REG <= execute.exec_io.WbEnOut @[Datapath.scala 64:47]
    memory.mem_io.WbEnIn <= memory_mem_io_WbEnIn_REG @[Datapath.scala 64:37]
    reg memory_mem_io_WbTypeIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_WbTypeIn_REG) @[Datapath.scala 65:47]
    memory_mem_io_WbTypeIn_REG <= execute.exec_io.WbTypeOut @[Datapath.scala 65:47]
    memory.mem_io.WbTypeIn <= memory_mem_io_WbTypeIn_REG @[Datapath.scala 65:37]
    reg memory_mem_io_WriteData_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_WriteData_REG) @[Datapath.scala 66:47]
    memory_mem_io_WriteData_REG <= execute.exec_io.WriteData @[Datapath.scala 66:47]
    memory.mem_io.WriteData <= memory_mem_io_WriteData_REG @[Datapath.scala 66:37]
    reg memory_mem_io_CtrlBrEn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_CtrlBrEn_REG) @[Datapath.scala 67:47]
    memory_mem_io_CtrlBrEn_REG <= execute.exec_io.BrEnOut @[Datapath.scala 67:47]
    memory.mem_io.CtrlBrEn <= memory_mem_io_CtrlBrEn_REG @[Datapath.scala 67:37]
    reg memory_mem_io_AluBrEn_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_AluBrEn_REG) @[Datapath.scala 68:47]
    memory_mem_io_AluBrEn_REG <= execute.exec_io.zero @[Datapath.scala 68:47]
    memory.mem_io.AluBrEn <= memory_mem_io_AluBrEn_REG @[Datapath.scala 68:37]
    reg memory_mem_io_BrAddrIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_BrAddrIn_REG) @[Datapath.scala 69:47]
    memory_mem_io_BrAddrIn_REG <= execute.exec_io.BranchAddrOut @[Datapath.scala 69:47]
    memory.mem_io.BrAddrIn <= memory_mem_io_BrAddrIn_REG @[Datapath.scala 69:37]
    reg memory_mem_io_WriteRegAddrIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_WriteRegAddrIn_REG) @[Datapath.scala 70:47]
    memory_mem_io_WriteRegAddrIn_REG <= execute.exec_io.WriteRegAddr @[Datapath.scala 70:47]
    memory.mem_io.WriteRegAddrIn <= memory_mem_io_WriteRegAddrIn_REG @[Datapath.scala 70:37]
    memory.mem_io.Inport1 <= io.Inport1 @[Datapath.scala 72:27]
    memory.mem_io.Inport2 <= io.Inport2 @[Datapath.scala 73:27]
    io.Outport <= memory.mem_io.Outport @[Datapath.scala 74:27]
    reg writeback_wb_io_LoadEn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_LoadEn_REG) @[Datapath.scala 77:47]
    writeback_wb_io_LoadEn_REG <= memory.mem_io.LoadEnOut @[Datapath.scala 77:47]
    writeback.wb_io.LoadEn <= writeback_wb_io_LoadEn_REG @[Datapath.scala 77:37]
    reg writeback_wb_io_WbEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_WbEnIn_REG) @[Datapath.scala 78:47]
    writeback_wb_io_WbEnIn_REG <= memory.mem_io.WbEnOut @[Datapath.scala 78:47]
    writeback.wb_io.WbEnIn <= writeback_wb_io_WbEnIn_REG @[Datapath.scala 78:37]
    reg writeback_wb_io_WbTypeIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_WbTypeIn_REG) @[Datapath.scala 79:47]
    writeback_wb_io_WbTypeIn_REG <= memory.mem_io.WbTypeOut @[Datapath.scala 79:47]
    writeback.wb_io.WbTypeIn <= writeback_wb_io_WbTypeIn_REG @[Datapath.scala 79:37]
    reg writeback_wb_io_ReadData_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_ReadData_REG) @[Datapath.scala 80:47]
    writeback_wb_io_ReadData_REG <= memory.mem_io.ReadData @[Datapath.scala 80:47]
    writeback.wb_io.ReadData <= writeback_wb_io_ReadData_REG @[Datapath.scala 80:37]
    reg writeback_wb_io_AddrData_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_AddrData_REG) @[Datapath.scala 81:47]
    writeback_wb_io_AddrData_REG <= memory.mem_io.AddrOut @[Datapath.scala 81:47]
    writeback.wb_io.AddrData <= writeback_wb_io_AddrData_REG @[Datapath.scala 81:37]
    reg writeback_wb_io_WriteRegAddrIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_WriteRegAddrIn_REG) @[Datapath.scala 82:47]
    writeback_wb_io_WriteRegAddrIn_REG <= memory.mem_io.WriteRegAddrOut @[Datapath.scala 82:47]
    writeback.wb_io.WriteRegAddrIn <= writeback_wb_io_WriteRegAddrIn_REG @[Datapath.scala 82:37]

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
    output io : { flip SW : UInt<18>, instr : UInt<32>, txd_instr : UInt<1>, hex7 : UInt<7>, hex6 : UInt<7>, hex5 : UInt<7>, hex4 : UInt<7>, hex3 : UInt<7>, hex2 : UInt<7>, hex1 : UInt<7>, hex0 : UInt<7>, LEDR : UInt<18>, LEDG : UInt<8>, flip KEY : UInt<4>}

    inst datapath of Datapath @[Mintel.scala 44:26]
    datapath.clock <= clock
    datapath.reset <= reset
    io.instr <= datapath.io.instr @[Mintel.scala 46:18]
    node Inport1 = bits(io.SW, 7, 0) @[Mintel.scala 48:25]
    node Inport2 = bits(io.SW, 15, 8) @[Mintel.scala 49:25]
    reg Outport : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[Mintel.scala 50:27]
    datapath.io.Inport1 <= Inport1 @[Mintel.scala 52:25]
    datapath.io.Inport2 <= Inport2 @[Mintel.scala 53:25]
    node _T = neq(datapath.io.Outport, UInt<1>("h0")) @[Mintel.scala 55:32]
    when _T : @[Mintel.scala 55:41]
      Outport <= datapath.io.Outport @[Mintel.scala 56:17]
    inst U_decoder7seg_7 of decoder7seg @[Mintel.scala 60:33]
    U_decoder7seg_7.clock <= clock
    U_decoder7seg_7.reset <= reset
    inst U_decoder7seg_6 of decoder7seg_1 @[Mintel.scala 61:33]
    U_decoder7seg_6.clock <= clock
    U_decoder7seg_6.reset <= reset
    inst U_decoder7seg_5 of decoder7seg_2 @[Mintel.scala 62:33]
    U_decoder7seg_5.clock <= clock
    U_decoder7seg_5.reset <= reset
    inst U_decoder7seg_4 of decoder7seg_3 @[Mintel.scala 63:33]
    U_decoder7seg_4.clock <= clock
    U_decoder7seg_4.reset <= reset
    inst U_decoder7seg_3 of decoder7seg_4 @[Mintel.scala 64:33]
    U_decoder7seg_3.clock <= clock
    U_decoder7seg_3.reset <= reset
    inst U_decoder7seg_2 of decoder7seg_5 @[Mintel.scala 65:33]
    U_decoder7seg_2.clock <= clock
    U_decoder7seg_2.reset <= reset
    inst U_decoder7seg_1 of decoder7seg_6 @[Mintel.scala 66:33]
    U_decoder7seg_1.clock <= clock
    U_decoder7seg_1.reset <= reset
    inst U_decoder7seg_0 of decoder7seg_7 @[Mintel.scala 67:33]
    U_decoder7seg_0.clock <= clock
    U_decoder7seg_0.reset <= reset
    node _U_decoder7seg_7_io_in_T = bits(Inport1, 7, 4) @[Mintel.scala 69:37]
    U_decoder7seg_7.io.in <= _U_decoder7seg_7_io_in_T @[Mintel.scala 69:27]
    node _U_decoder7seg_6_io_in_T = bits(Inport1, 3, 0) @[Mintel.scala 70:37]
    U_decoder7seg_6.io.in <= _U_decoder7seg_6_io_in_T @[Mintel.scala 70:27]
    node _U_decoder7seg_5_io_in_T = bits(Inport2, 7, 4) @[Mintel.scala 71:37]
    U_decoder7seg_5.io.in <= _U_decoder7seg_5_io_in_T @[Mintel.scala 71:27]
    node _U_decoder7seg_4_io_in_T = bits(Inport2, 3, 0) @[Mintel.scala 72:37]
    U_decoder7seg_4.io.in <= _U_decoder7seg_4_io_in_T @[Mintel.scala 72:27]
    node _U_decoder7seg_3_io_in_T = bits(Outport, 15, 12) @[Mintel.scala 74:37]
    U_decoder7seg_3.io.in <= _U_decoder7seg_3_io_in_T @[Mintel.scala 74:27]
    node _U_decoder7seg_2_io_in_T = bits(Outport, 11, 8) @[Mintel.scala 75:37]
    U_decoder7seg_2.io.in <= _U_decoder7seg_2_io_in_T @[Mintel.scala 75:27]
    node _U_decoder7seg_1_io_in_T = bits(Outport, 7, 4) @[Mintel.scala 76:37]
    U_decoder7seg_1.io.in <= _U_decoder7seg_1_io_in_T @[Mintel.scala 76:27]
    node _U_decoder7seg_0_io_in_T = bits(Outport, 3, 0) @[Mintel.scala 77:37]
    U_decoder7seg_0.io.in <= _U_decoder7seg_0_io_in_T @[Mintel.scala 77:27]
    io.hex7 <= U_decoder7seg_7.io.out @[Mintel.scala 79:13]
    io.hex6 <= U_decoder7seg_6.io.out @[Mintel.scala 80:13]
    io.hex5 <= U_decoder7seg_5.io.out @[Mintel.scala 81:13]
    io.hex4 <= U_decoder7seg_4.io.out @[Mintel.scala 82:13]
    io.hex3 <= U_decoder7seg_3.io.out @[Mintel.scala 83:13]
    io.hex2 <= U_decoder7seg_2.io.out @[Mintel.scala 84:13]
    io.hex1 <= U_decoder7seg_1.io.out @[Mintel.scala 85:13]
    io.hex0 <= U_decoder7seg_0.io.out @[Mintel.scala 86:13]
    inst tx of BufferedTx @[Mintel.scala 89:20]
    tx.clock <= clock
    tx.reset <= reset
    io.txd_instr <= tx.io.txd @[Mintel.scala 90:18]
    reg cntReg2 : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[Mintel.scala 92:26]
    node _instr_bit7_T = bits(io.instr, 31, 28) @[Mintel.scala 94:50]
    node instr_bit7_nibble = and(_instr_bit7_T, UInt<4>("hf")) @[Mintel.scala 128:25]
    node _instr_bit7_format_T = add(UInt<8>("h30"), instr_bit7_nibble) @[Mintel.scala 130:57]
    node _instr_bit7_format_T_1 = tail(_instr_bit7_format_T, 1) @[Mintel.scala 130:57]
    node _instr_bit7_format_T_2 = eq(UInt<4>("ha"), instr_bit7_nibble) @[Mux.scala 81:61]
    node _instr_bit7_format_T_3 = mux(_instr_bit7_format_T_2, UInt<7>("h41"), _instr_bit7_format_T_1) @[Mux.scala 81:58]
    node _instr_bit7_format_T_4 = eq(UInt<4>("hb"), instr_bit7_nibble) @[Mux.scala 81:61]
    node _instr_bit7_format_T_5 = mux(_instr_bit7_format_T_4, UInt<7>("h42"), _instr_bit7_format_T_3) @[Mux.scala 81:58]
    node _instr_bit7_format_T_6 = eq(UInt<4>("hc"), instr_bit7_nibble) @[Mux.scala 81:61]
    node _instr_bit7_format_T_7 = mux(_instr_bit7_format_T_6, UInt<7>("h43"), _instr_bit7_format_T_5) @[Mux.scala 81:58]
    node _instr_bit7_format_T_8 = eq(UInt<4>("hd"), instr_bit7_nibble) @[Mux.scala 81:61]
    node _instr_bit7_format_T_9 = mux(_instr_bit7_format_T_8, UInt<7>("h44"), _instr_bit7_format_T_7) @[Mux.scala 81:58]
    node _instr_bit7_format_T_10 = eq(UInt<4>("he"), instr_bit7_nibble) @[Mux.scala 81:61]
    node _instr_bit7_format_T_11 = mux(_instr_bit7_format_T_10, UInt<7>("h45"), _instr_bit7_format_T_9) @[Mux.scala 81:58]
    node _instr_bit7_format_T_12 = eq(UInt<4>("hf"), instr_bit7_nibble) @[Mux.scala 81:61]
    node instr_bit7 = mux(_instr_bit7_format_T_12, UInt<7>("h46"), _instr_bit7_format_T_11) @[Mux.scala 81:58]
    node _instr_bit6_T = bits(io.instr, 27, 24) @[Mintel.scala 95:50]
    node instr_bit6_nibble = and(_instr_bit6_T, UInt<4>("hf")) @[Mintel.scala 128:25]
    node _instr_bit6_format_T = add(UInt<8>("h30"), instr_bit6_nibble) @[Mintel.scala 130:57]
    node _instr_bit6_format_T_1 = tail(_instr_bit6_format_T, 1) @[Mintel.scala 130:57]
    node _instr_bit6_format_T_2 = eq(UInt<4>("ha"), instr_bit6_nibble) @[Mux.scala 81:61]
    node _instr_bit6_format_T_3 = mux(_instr_bit6_format_T_2, UInt<7>("h41"), _instr_bit6_format_T_1) @[Mux.scala 81:58]
    node _instr_bit6_format_T_4 = eq(UInt<4>("hb"), instr_bit6_nibble) @[Mux.scala 81:61]
    node _instr_bit6_format_T_5 = mux(_instr_bit6_format_T_4, UInt<7>("h42"), _instr_bit6_format_T_3) @[Mux.scala 81:58]
    node _instr_bit6_format_T_6 = eq(UInt<4>("hc"), instr_bit6_nibble) @[Mux.scala 81:61]
    node _instr_bit6_format_T_7 = mux(_instr_bit6_format_T_6, UInt<7>("h43"), _instr_bit6_format_T_5) @[Mux.scala 81:58]
    node _instr_bit6_format_T_8 = eq(UInt<4>("hd"), instr_bit6_nibble) @[Mux.scala 81:61]
    node _instr_bit6_format_T_9 = mux(_instr_bit6_format_T_8, UInt<7>("h44"), _instr_bit6_format_T_7) @[Mux.scala 81:58]
    node _instr_bit6_format_T_10 = eq(UInt<4>("he"), instr_bit6_nibble) @[Mux.scala 81:61]
    node _instr_bit6_format_T_11 = mux(_instr_bit6_format_T_10, UInt<7>("h45"), _instr_bit6_format_T_9) @[Mux.scala 81:58]
    node _instr_bit6_format_T_12 = eq(UInt<4>("hf"), instr_bit6_nibble) @[Mux.scala 81:61]
    node instr_bit6 = mux(_instr_bit6_format_T_12, UInt<7>("h46"), _instr_bit6_format_T_11) @[Mux.scala 81:58]
    node _instr_bit5_T = bits(io.instr, 23, 20) @[Mintel.scala 96:50]
    node instr_bit5_nibble = and(_instr_bit5_T, UInt<4>("hf")) @[Mintel.scala 128:25]
    node _instr_bit5_format_T = add(UInt<8>("h30"), instr_bit5_nibble) @[Mintel.scala 130:57]
    node _instr_bit5_format_T_1 = tail(_instr_bit5_format_T, 1) @[Mintel.scala 130:57]
    node _instr_bit5_format_T_2 = eq(UInt<4>("ha"), instr_bit5_nibble) @[Mux.scala 81:61]
    node _instr_bit5_format_T_3 = mux(_instr_bit5_format_T_2, UInt<7>("h41"), _instr_bit5_format_T_1) @[Mux.scala 81:58]
    node _instr_bit5_format_T_4 = eq(UInt<4>("hb"), instr_bit5_nibble) @[Mux.scala 81:61]
    node _instr_bit5_format_T_5 = mux(_instr_bit5_format_T_4, UInt<7>("h42"), _instr_bit5_format_T_3) @[Mux.scala 81:58]
    node _instr_bit5_format_T_6 = eq(UInt<4>("hc"), instr_bit5_nibble) @[Mux.scala 81:61]
    node _instr_bit5_format_T_7 = mux(_instr_bit5_format_T_6, UInt<7>("h43"), _instr_bit5_format_T_5) @[Mux.scala 81:58]
    node _instr_bit5_format_T_8 = eq(UInt<4>("hd"), instr_bit5_nibble) @[Mux.scala 81:61]
    node _instr_bit5_format_T_9 = mux(_instr_bit5_format_T_8, UInt<7>("h44"), _instr_bit5_format_T_7) @[Mux.scala 81:58]
    node _instr_bit5_format_T_10 = eq(UInt<4>("he"), instr_bit5_nibble) @[Mux.scala 81:61]
    node _instr_bit5_format_T_11 = mux(_instr_bit5_format_T_10, UInt<7>("h45"), _instr_bit5_format_T_9) @[Mux.scala 81:58]
    node _instr_bit5_format_T_12 = eq(UInt<4>("hf"), instr_bit5_nibble) @[Mux.scala 81:61]
    node instr_bit5 = mux(_instr_bit5_format_T_12, UInt<7>("h46"), _instr_bit5_format_T_11) @[Mux.scala 81:58]
    node _instr_bit4_T = bits(io.instr, 19, 16) @[Mintel.scala 97:50]
    node instr_bit4_nibble = and(_instr_bit4_T, UInt<4>("hf")) @[Mintel.scala 128:25]
    node _instr_bit4_format_T = add(UInt<8>("h30"), instr_bit4_nibble) @[Mintel.scala 130:57]
    node _instr_bit4_format_T_1 = tail(_instr_bit4_format_T, 1) @[Mintel.scala 130:57]
    node _instr_bit4_format_T_2 = eq(UInt<4>("ha"), instr_bit4_nibble) @[Mux.scala 81:61]
    node _instr_bit4_format_T_3 = mux(_instr_bit4_format_T_2, UInt<7>("h41"), _instr_bit4_format_T_1) @[Mux.scala 81:58]
    node _instr_bit4_format_T_4 = eq(UInt<4>("hb"), instr_bit4_nibble) @[Mux.scala 81:61]
    node _instr_bit4_format_T_5 = mux(_instr_bit4_format_T_4, UInt<7>("h42"), _instr_bit4_format_T_3) @[Mux.scala 81:58]
    node _instr_bit4_format_T_6 = eq(UInt<4>("hc"), instr_bit4_nibble) @[Mux.scala 81:61]
    node _instr_bit4_format_T_7 = mux(_instr_bit4_format_T_6, UInt<7>("h43"), _instr_bit4_format_T_5) @[Mux.scala 81:58]
    node _instr_bit4_format_T_8 = eq(UInt<4>("hd"), instr_bit4_nibble) @[Mux.scala 81:61]
    node _instr_bit4_format_T_9 = mux(_instr_bit4_format_T_8, UInt<7>("h44"), _instr_bit4_format_T_7) @[Mux.scala 81:58]
    node _instr_bit4_format_T_10 = eq(UInt<4>("he"), instr_bit4_nibble) @[Mux.scala 81:61]
    node _instr_bit4_format_T_11 = mux(_instr_bit4_format_T_10, UInt<7>("h45"), _instr_bit4_format_T_9) @[Mux.scala 81:58]
    node _instr_bit4_format_T_12 = eq(UInt<4>("hf"), instr_bit4_nibble) @[Mux.scala 81:61]
    node instr_bit4 = mux(_instr_bit4_format_T_12, UInt<7>("h46"), _instr_bit4_format_T_11) @[Mux.scala 81:58]
    node _instr_bit3_T = bits(io.instr, 15, 12) @[Mintel.scala 98:50]
    node instr_bit3_nibble = and(_instr_bit3_T, UInt<4>("hf")) @[Mintel.scala 128:25]
    node _instr_bit3_format_T = add(UInt<8>("h30"), instr_bit3_nibble) @[Mintel.scala 130:57]
    node _instr_bit3_format_T_1 = tail(_instr_bit3_format_T, 1) @[Mintel.scala 130:57]
    node _instr_bit3_format_T_2 = eq(UInt<4>("ha"), instr_bit3_nibble) @[Mux.scala 81:61]
    node _instr_bit3_format_T_3 = mux(_instr_bit3_format_T_2, UInt<7>("h41"), _instr_bit3_format_T_1) @[Mux.scala 81:58]
    node _instr_bit3_format_T_4 = eq(UInt<4>("hb"), instr_bit3_nibble) @[Mux.scala 81:61]
    node _instr_bit3_format_T_5 = mux(_instr_bit3_format_T_4, UInt<7>("h42"), _instr_bit3_format_T_3) @[Mux.scala 81:58]
    node _instr_bit3_format_T_6 = eq(UInt<4>("hc"), instr_bit3_nibble) @[Mux.scala 81:61]
    node _instr_bit3_format_T_7 = mux(_instr_bit3_format_T_6, UInt<7>("h43"), _instr_bit3_format_T_5) @[Mux.scala 81:58]
    node _instr_bit3_format_T_8 = eq(UInt<4>("hd"), instr_bit3_nibble) @[Mux.scala 81:61]
    node _instr_bit3_format_T_9 = mux(_instr_bit3_format_T_8, UInt<7>("h44"), _instr_bit3_format_T_7) @[Mux.scala 81:58]
    node _instr_bit3_format_T_10 = eq(UInt<4>("he"), instr_bit3_nibble) @[Mux.scala 81:61]
    node _instr_bit3_format_T_11 = mux(_instr_bit3_format_T_10, UInt<7>("h45"), _instr_bit3_format_T_9) @[Mux.scala 81:58]
    node _instr_bit3_format_T_12 = eq(UInt<4>("hf"), instr_bit3_nibble) @[Mux.scala 81:61]
    node instr_bit3 = mux(_instr_bit3_format_T_12, UInt<7>("h46"), _instr_bit3_format_T_11) @[Mux.scala 81:58]
    node _instr_bit2_T = bits(io.instr, 11, 8) @[Mintel.scala 99:50]
    node instr_bit2_nibble = and(_instr_bit2_T, UInt<4>("hf")) @[Mintel.scala 128:25]
    node _instr_bit2_format_T = add(UInt<8>("h30"), instr_bit2_nibble) @[Mintel.scala 130:57]
    node _instr_bit2_format_T_1 = tail(_instr_bit2_format_T, 1) @[Mintel.scala 130:57]
    node _instr_bit2_format_T_2 = eq(UInt<4>("ha"), instr_bit2_nibble) @[Mux.scala 81:61]
    node _instr_bit2_format_T_3 = mux(_instr_bit2_format_T_2, UInt<7>("h41"), _instr_bit2_format_T_1) @[Mux.scala 81:58]
    node _instr_bit2_format_T_4 = eq(UInt<4>("hb"), instr_bit2_nibble) @[Mux.scala 81:61]
    node _instr_bit2_format_T_5 = mux(_instr_bit2_format_T_4, UInt<7>("h42"), _instr_bit2_format_T_3) @[Mux.scala 81:58]
    node _instr_bit2_format_T_6 = eq(UInt<4>("hc"), instr_bit2_nibble) @[Mux.scala 81:61]
    node _instr_bit2_format_T_7 = mux(_instr_bit2_format_T_6, UInt<7>("h43"), _instr_bit2_format_T_5) @[Mux.scala 81:58]
    node _instr_bit2_format_T_8 = eq(UInt<4>("hd"), instr_bit2_nibble) @[Mux.scala 81:61]
    node _instr_bit2_format_T_9 = mux(_instr_bit2_format_T_8, UInt<7>("h44"), _instr_bit2_format_T_7) @[Mux.scala 81:58]
    node _instr_bit2_format_T_10 = eq(UInt<4>("he"), instr_bit2_nibble) @[Mux.scala 81:61]
    node _instr_bit2_format_T_11 = mux(_instr_bit2_format_T_10, UInt<7>("h45"), _instr_bit2_format_T_9) @[Mux.scala 81:58]
    node _instr_bit2_format_T_12 = eq(UInt<4>("hf"), instr_bit2_nibble) @[Mux.scala 81:61]
    node instr_bit2 = mux(_instr_bit2_format_T_12, UInt<7>("h46"), _instr_bit2_format_T_11) @[Mux.scala 81:58]
    node _instr_bit1_T = bits(io.instr, 7, 4) @[Mintel.scala 100:50]
    node instr_bit1_nibble = and(_instr_bit1_T, UInt<4>("hf")) @[Mintel.scala 128:25]
    node _instr_bit1_format_T = add(UInt<8>("h30"), instr_bit1_nibble) @[Mintel.scala 130:57]
    node _instr_bit1_format_T_1 = tail(_instr_bit1_format_T, 1) @[Mintel.scala 130:57]
    node _instr_bit1_format_T_2 = eq(UInt<4>("ha"), instr_bit1_nibble) @[Mux.scala 81:61]
    node _instr_bit1_format_T_3 = mux(_instr_bit1_format_T_2, UInt<7>("h41"), _instr_bit1_format_T_1) @[Mux.scala 81:58]
    node _instr_bit1_format_T_4 = eq(UInt<4>("hb"), instr_bit1_nibble) @[Mux.scala 81:61]
    node _instr_bit1_format_T_5 = mux(_instr_bit1_format_T_4, UInt<7>("h42"), _instr_bit1_format_T_3) @[Mux.scala 81:58]
    node _instr_bit1_format_T_6 = eq(UInt<4>("hc"), instr_bit1_nibble) @[Mux.scala 81:61]
    node _instr_bit1_format_T_7 = mux(_instr_bit1_format_T_6, UInt<7>("h43"), _instr_bit1_format_T_5) @[Mux.scala 81:58]
    node _instr_bit1_format_T_8 = eq(UInt<4>("hd"), instr_bit1_nibble) @[Mux.scala 81:61]
    node _instr_bit1_format_T_9 = mux(_instr_bit1_format_T_8, UInt<7>("h44"), _instr_bit1_format_T_7) @[Mux.scala 81:58]
    node _instr_bit1_format_T_10 = eq(UInt<4>("he"), instr_bit1_nibble) @[Mux.scala 81:61]
    node _instr_bit1_format_T_11 = mux(_instr_bit1_format_T_10, UInt<7>("h45"), _instr_bit1_format_T_9) @[Mux.scala 81:58]
    node _instr_bit1_format_T_12 = eq(UInt<4>("hf"), instr_bit1_nibble) @[Mux.scala 81:61]
    node instr_bit1 = mux(_instr_bit1_format_T_12, UInt<7>("h46"), _instr_bit1_format_T_11) @[Mux.scala 81:58]
    node _instr_bit0_T = bits(io.instr, 3, 0) @[Mintel.scala 101:50]
    node instr_bit0_nibble = and(_instr_bit0_T, UInt<4>("hf")) @[Mintel.scala 128:25]
    node _instr_bit0_format_T = add(UInt<8>("h30"), instr_bit0_nibble) @[Mintel.scala 130:57]
    node _instr_bit0_format_T_1 = tail(_instr_bit0_format_T, 1) @[Mintel.scala 130:57]
    node _instr_bit0_format_T_2 = eq(UInt<4>("ha"), instr_bit0_nibble) @[Mux.scala 81:61]
    node _instr_bit0_format_T_3 = mux(_instr_bit0_format_T_2, UInt<7>("h41"), _instr_bit0_format_T_1) @[Mux.scala 81:58]
    node _instr_bit0_format_T_4 = eq(UInt<4>("hb"), instr_bit0_nibble) @[Mux.scala 81:61]
    node _instr_bit0_format_T_5 = mux(_instr_bit0_format_T_4, UInt<7>("h42"), _instr_bit0_format_T_3) @[Mux.scala 81:58]
    node _instr_bit0_format_T_6 = eq(UInt<4>("hc"), instr_bit0_nibble) @[Mux.scala 81:61]
    node _instr_bit0_format_T_7 = mux(_instr_bit0_format_T_6, UInt<7>("h43"), _instr_bit0_format_T_5) @[Mux.scala 81:58]
    node _instr_bit0_format_T_8 = eq(UInt<4>("hd"), instr_bit0_nibble) @[Mux.scala 81:61]
    node _instr_bit0_format_T_9 = mux(_instr_bit0_format_T_8, UInt<7>("h44"), _instr_bit0_format_T_7) @[Mux.scala 81:58]
    node _instr_bit0_format_T_10 = eq(UInt<4>("he"), instr_bit0_nibble) @[Mux.scala 81:61]
    node _instr_bit0_format_T_11 = mux(_instr_bit0_format_T_10, UInt<7>("h45"), _instr_bit0_format_T_9) @[Mux.scala 81:58]
    node _instr_bit0_format_T_12 = eq(UInt<4>("hf"), instr_bit0_nibble) @[Mux.scala 81:61]
    node instr_bit0 = mux(_instr_bit0_format_T_12, UInt<7>("h46"), _instr_bit0_format_T_11) @[Mux.scala 81:58]
    node _string_temp0_T = cat(instr_bit1, instr_bit0) @[Cat.scala 31:58]
    node _string_temp0_T_1 = cat(instr_bit2, _string_temp0_T) @[Cat.scala 31:58]
    node _string_temp0_T_2 = cat(instr_bit3, _string_temp0_T_1) @[Cat.scala 31:58]
    node _string_temp0_T_3 = cat(instr_bit4, _string_temp0_T_2) @[Cat.scala 31:58]
    node _string_temp0_T_4 = cat(instr_bit5, _string_temp0_T_3) @[Cat.scala 31:58]
    node _string_temp0_T_5 = cat(instr_bit6, _string_temp0_T_4) @[Cat.scala 31:58]
    node string = cat(instr_bit7, _string_temp0_T_5) @[Cat.scala 31:58]
    wire text : UInt<64>[1] @[Mintel.scala 105:23]
    text[0] <= string @[Mintel.scala 105:23]
    tx.io.channel.bits <= text[UInt<1>("h0")] @[Mintel.scala 109:24]
    node _tx_io_channel_valid_T = neq(cntReg2, UInt<7>("h40")) @[Mintel.scala 110:36]
    tx.io.channel.valid <= _tx_io_channel_valid_T @[Mintel.scala 110:25]
    node _T_1 = neq(cntReg2, UInt<7>("h40")) @[Mintel.scala 112:41]
    node _T_2 = and(tx.io.channel.ready, _T_1) @[Mintel.scala 112:30]
    when _T_2 : @[Mintel.scala 112:50]
      node _cntReg2_T = add(cntReg2, UInt<1>("h1")) @[Mintel.scala 114:28]
      node _cntReg2_T_1 = tail(_cntReg2_T, 1) @[Mintel.scala 114:28]
      cntReg2 <= _cntReg2_T_1 @[Mintel.scala 114:17]
    else :
      node _T_3 = eq(cntReg2, UInt<7>("h40")) @[Mintel.scala 115:25]
      when _T_3 : @[Mintel.scala 115:33]
        cntReg2 <= UInt<1>("h0") @[Mintel.scala 116:17]
    wire LEDG : UInt<8>
    LEDG <= UInt<8>("h0")
    io.LEDR <= io.SW @[Mintel.scala 122:19]
    node _LEDG_T = not(io.KEY) @[Mintel.scala 123:26]
    node _LEDG_T_1 = not(io.KEY) @[Mintel.scala 123:35]
    node _LEDG_T_2 = cat(_LEDG_T, _LEDG_T_1) @[Cat.scala 31:58]
    LEDG <= _LEDG_T_2 @[Mintel.scala 123:19]
    io.LEDG <= LEDG @[Mintel.scala 124:19]

