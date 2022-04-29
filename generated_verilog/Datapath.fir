circuit Datapath :
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
    node _format_T_185 = mux(_format_T_51, UInt<1>("h1"), _format_T_184) @[Lookup.scala 34:39]
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
    node _high_T_1 = eq(_high_T, UInt<1>("h1")) @[SignExtend.scala 12:51]
    node _high_T_2 = and(io.isSigned, _high_T_1) @[SignExtend.scala 12:38]
    node high = mux(_high_T_2, UInt<15>("h7fff"), UInt<1>("h0")) @[SignExtend.scala 12:25]
    node _io_out_T = cat(high, low) @[Cat.scala 31:58]
    io.out <= _io_out_T @[SignExtend.scala 13:12]

  module Decode :
    input clock : Clock
    input reset : Reset
    output dec_io : { flip Instr : UInt<32>, flip NextPCIn : UInt<32>, flip WriteAddrIn : UInt<32>, flip WriteEnIn : UInt<1>, flip WriteDataIn : UInt<32>, AluOp : UInt<32>, Imm : UInt<32>, ImmEn : UInt<1>, BrEn : UInt<1>, NextPCOut : UInt<32>, ReadEn : UInt<1>, WriteEnOut : UInt<1>, WbType : UInt<1>, WbEn : UInt<1>, rs : UInt<6>, rt : UInt<6>, rd : UInt<6>, DataRead1 : UInt<32>, DataRead2 : UInt<32>}

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
    output io : { flip A : UInt<32>, flip B : UInt<32>, flip AluOp : UInt<5>, out : UInt<32>, zero : UInt<1>}

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
    output exec_io : { flip NextPC : UInt<32>, flip Imm : UInt<32>, flip rs : UInt<32>, flip rt : UInt<32>, flip rd : UInt<32>, flip DataRead1 : UInt<32>, flip DataRead2 : UInt<32>, flip MemWbEn : UInt<1>, flip MemAddr : UInt<32>, flip MemVal : UInt<32>, flip WbWbEn : UInt<1>, flip WbAddr : UInt<32>, flip WbVal : UInt<32>, flip AluOp : UInt<4>, flip ImmEn : UInt<1>, flip WriteEnIn : UInt<1>, flip ReadEnIn : UInt<1>, flip BrEnIn : UInt<1>, flip WbEnIn : UInt<1>, flip WbTypeIn : UInt<1>, AluRes : UInt<32>, zero : UInt<1>, BranchAddrOut : UInt<32>, WriteData : UInt<32>, ReadEnOut : UInt<1>, WriteEnOut : UInt<1>, BrEnOut : UInt<1>, WbTypeOut : UInt<1>, WbEnOut : UInt<1>, WriteRegAddr : UInt<32>}

    inst alu of ALU @[Execute.scala 6:21]
    alu.clock <= clock
    alu.reset <= reset
    node isImmediate = eq(exec_io.ImmEn, UInt<1>("h1")) @[Execute.scala 67:43]
    node _A_T = eq(exec_io.rs, exec_io.MemAddr) @[Execute.scala 59:14]
    node _A_T_1 = eq(exec_io.MemWbEn, UInt<1>("h1")) @[Execute.scala 59:52]
    node _A_T_2 = and(_A_T, _A_T_1) @[Execute.scala 59:34]
    node _A_T_3 = eq(exec_io.rs, exec_io.WbAddr) @[Execute.scala 61:19]
    node _A_T_4 = eq(exec_io.WbWbEn, UInt<1>("h1")) @[Execute.scala 61:55]
    node _A_T_5 = and(_A_T_3, _A_T_4) @[Execute.scala 61:38]
    node _A_T_6 = mux(_A_T_5, exec_io.WbVal, exec_io.DataRead1) @[Execute.scala 61:12]
    node A = mux(_A_T_2, exec_io.MemVal, _A_T_6) @[Execute.scala 58:54]
    node _B_T = eq(exec_io.rt, exec_io.MemAddr) @[Execute.scala 59:14]
    node _B_T_1 = eq(exec_io.MemWbEn, UInt<1>("h1")) @[Execute.scala 59:52]
    node _B_T_2 = and(_B_T, _B_T_1) @[Execute.scala 59:34]
    node _B_T_3 = eq(exec_io.rt, exec_io.WbAddr) @[Execute.scala 61:19]
    node _B_T_4 = eq(exec_io.WbWbEn, UInt<1>("h1")) @[Execute.scala 61:55]
    node _B_T_5 = and(_B_T_3, _B_T_4) @[Execute.scala 61:38]
    node _B_T_6 = mux(_B_T_5, exec_io.WbVal, exec_io.DataRead2) @[Execute.scala 61:12]
    node B = mux(_B_T_2, exec_io.MemVal, _B_T_6) @[Execute.scala 58:54]
    alu.io.A <= A @[Execute.scala 78:14]
    node _alu_io_B_T = mux(exec_io.ImmEn, exec_io.Imm, B) @[Execute.scala 79:20]
    alu.io.B <= _alu_io_B_T @[Execute.scala 79:14]
    alu.io.AluOp <= exec_io.AluOp @[Execute.scala 80:18]
    exec_io.AluRes <= alu.io.out @[Execute.scala 81:20]
    exec_io.zero <= alu.io.zero @[Execute.scala 82:18]
    exec_io.BranchAddrOut <= exec_io.Imm @[Execute.scala 85:27]
    exec_io.BrEnOut <= exec_io.BrEnIn @[Execute.scala 86:21]
    exec_io.WbTypeOut <= exec_io.WbTypeIn @[Execute.scala 87:23]
    exec_io.WbEnOut <= exec_io.WbEnIn @[Execute.scala 88:21]
    exec_io.ReadEnOut <= exec_io.ReadEnIn @[Execute.scala 89:23]
    exec_io.WriteEnOut <= exec_io.WriteEnIn @[Execute.scala 90:24]
    exec_io.WriteData <= B @[Execute.scala 93:23]
    node _exec_io_WriteRegAddr_T = mux(isImmediate, exec_io.rt, exec_io.rd) @[Execute.scala 96:32]
    exec_io.WriteRegAddr <= _exec_io_WriteRegAddr_T @[Execute.scala 96:26]

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
    reg reg_raddr : UInt, clock with :
      reset => (UInt<1>("h0"), reg_raddr) @[RAM.scala 41:24]
    node _T_1 = and(ram_io.ReadEn, isValid) @[RAM.scala 42:22]
    when _T_1 : @[RAM.scala 42:34]
      reg_raddr <= ram_io.Addr @[RAM.scala 42:46]
    wire _ReadData_WIRE : UInt @[RAM.scala 43:28]
    _ReadData_WIRE is invalid @[RAM.scala 43:28]
    when UInt<1>("h1") : @[RAM.scala 43:28]
      _ReadData_WIRE <= reg_raddr @[RAM.scala 43:28]
      node _ReadData_T = or(_ReadData_WIRE, UInt<10>("h0")) @[RAM.scala 43:28]
      node _ReadData_T_1 = bits(_ReadData_T, 9, 0) @[RAM.scala 43:28]
      read mport ReadData = mem[_ReadData_T_1], clock @[RAM.scala 43:28]
    node _doForwardWr_T = eq(ram_io.Addr, PrevAddr) @[RAM.scala 46:40]
    node _doForwardWr_T_1 = and(_doForwardWr_T, PrevWrEn) @[RAM.scala 46:53]
    node _doForwardWr_T_2 = and(_doForwardWr_T_1, ram_io.ReadEn) @[RAM.scala 46:64]
    reg doForwardWr : UInt<1>, clock with :
      reset => (UInt<1>("h0"), doForwardWr) @[RAM.scala 46:30]
    doForwardWr <= _doForwardWr_T_2 @[RAM.scala 46:30]
    node _ram_io_ReadData_T = mux(doForwardWr, PrevWrData, ReadData) @[RAM.scala 48:27]
    ram_io.ReadData <= _ram_io_ReadData_T @[RAM.scala 48:21]

  module Mem :
    input clock : Clock
    input reset : Reset
    output mem_io : { flip WriteEn : UInt<1>, flip ReadEn : UInt<1>, flip CtrlBrEn : UInt<1>, flip WbTypeIn : UInt<1>, flip WbEnIn : UInt<1>, flip AluBrEn : UInt<1>, flip BrAddrIn : UInt<32>, flip WriteRegAddrIn : UInt<32>, flip WriteData : UInt<32>, flip AddrIn : UInt<32>, ReadData : UInt<32>, WbTypeOut : UInt<1>, WbEnOut : UInt<1>, AddrOut : UInt<32>, WriteRegAddrOut : UInt<32>, BrAddrOut : UInt<32>, BrEnOut : UInt<1>}

    inst ram of RAM @[Mem.scala 6:21]
    ram.clock <= clock
    ram.reset <= reset
    ram.ram_io.Addr <= mem_io.AddrIn @[Mem.scala 42:21]
    ram.ram_io.ReadEn <= mem_io.ReadEn @[Mem.scala 43:23]
    ram.ram_io.WriteEn <= mem_io.WriteEn @[Mem.scala 44:24]
    ram.ram_io.WriteData <= mem_io.WriteData @[Mem.scala 45:26]
    mem_io.ReadData <= ram.ram_io.ReadData @[Mem.scala 46:21]
    mem_io.BrAddrOut <= mem_io.BrAddrIn @[Mem.scala 48:22]
    mem_io.WbTypeOut <= mem_io.WbTypeIn @[Mem.scala 50:22]
    mem_io.WbEnOut <= mem_io.WbEnIn @[Mem.scala 51:20]
    mem_io.AddrOut <= mem_io.AddrIn @[Mem.scala 52:20]
    node _mem_io_BrEnOut_T = and(mem_io.AluBrEn, mem_io.CtrlBrEn) @[Mem.scala 54:38]
    mem_io.BrEnOut <= _mem_io_BrEnOut_T @[Mem.scala 54:20]
    mem_io.WriteRegAddrOut <= mem_io.WriteRegAddrIn @[Mem.scala 56:28]

  module Writeback :
    input clock : Clock
    input reset : Reset
    output wb_io : { flip WbEnIn : UInt<1>, flip WbTypeIn : UInt<1>, flip WriteRegAddrIn : UInt<32>, flip ReadData : UInt<32>, flip AddrData : UInt<32>, WbEnOut : UInt<1>, WriteRegAddrOut : UInt<32>, WriteDataOut : UInt<32>}

    wb_io.WbEnOut <= wb_io.WbEnIn @[Writeback.scala 20:19]
    wb_io.WriteRegAddrOut <= wb_io.WriteRegAddrIn @[Writeback.scala 21:27]
    node _wb_io_WriteDataOut_T = mux(wb_io.WbTypeIn, wb_io.ReadData, wb_io.AddrData) @[Writeback.scala 22:30]
    wb_io.WriteDataOut <= _wb_io_WriteDataOut_T @[Writeback.scala 22:24]

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

  module Datapath :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip switches1 : UInt<8>, flip switches2 : UInt<8>, instr : UInt<32>, hex7 : UInt<7>, hex6 : UInt<7>, hex5 : UInt<7>, hex4 : UInt<7>, hex3 : UInt<7>, hex2 : UInt<7>, hex1 : UInt<7>, hex0 : UInt<7>}

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
    wire output : UInt<32>
    output <= UInt<32>("h0")
    output <= execute.exec_io.AluRes @[Datapath.scala 36:12]
    io.instr <= fetch.io.Instr @[Datapath.scala 38:14]
    fetch.io.Stall <= decode.dec_io.BrEn @[Datapath.scala 41:20]
    fetch.io.BrEn <= memory.mem_io.BrEnOut @[Datapath.scala 42:19]
    fetch.io.BranchAddr <= memory.mem_io.BrAddrOut @[Datapath.scala 43:25]
    reg decode_dec_io_Instr_REG : UInt, clock with :
      reset => (UInt<1>("h0"), decode_dec_io_Instr_REG) @[Datapath.scala 46:35]
    decode_dec_io_Instr_REG <= fetch.io.Instr @[Datapath.scala 46:35]
    decode.dec_io.Instr <= decode_dec_io_Instr_REG @[Datapath.scala 46:25]
    reg decode_dec_io_NextPCIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), decode_dec_io_NextPCIn_REG) @[Datapath.scala 47:38]
    decode_dec_io_NextPCIn_REG <= fetch.io.NextPC @[Datapath.scala 47:38]
    decode.dec_io.NextPCIn <= decode_dec_io_NextPCIn_REG @[Datapath.scala 47:28]
    decode.dec_io.WriteEnIn <= writeback.wb_io.WbEnOut @[Datapath.scala 48:29]
    decode.dec_io.WriteAddrIn <= writeback.wb_io.WriteRegAddrOut @[Datapath.scala 49:31]
    decode.dec_io.WriteDataIn <= writeback.wb_io.WriteDataOut @[Datapath.scala 50:31]
    reg execute_exec_io_rs_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_rs_REG) @[Datapath.scala 53:34]
    execute_exec_io_rs_REG <= decode.dec_io.rs @[Datapath.scala 53:34]
    execute.exec_io.rs <= execute_exec_io_rs_REG @[Datapath.scala 53:24]
    reg execute_exec_io_rt_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_rt_REG) @[Datapath.scala 54:34]
    execute_exec_io_rt_REG <= decode.dec_io.rt @[Datapath.scala 54:34]
    execute.exec_io.rt <= execute_exec_io_rt_REG @[Datapath.scala 54:24]
    reg execute_exec_io_rd_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_rd_REG) @[Datapath.scala 55:34]
    execute_exec_io_rd_REG <= decode.dec_io.rd @[Datapath.scala 55:34]
    execute.exec_io.rd <= execute_exec_io_rd_REG @[Datapath.scala 55:24]
    reg execute_exec_io_DataRead1_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_DataRead1_REG) @[Datapath.scala 56:41]
    execute_exec_io_DataRead1_REG <= decode.dec_io.DataRead1 @[Datapath.scala 56:41]
    execute.exec_io.DataRead1 <= execute_exec_io_DataRead1_REG @[Datapath.scala 56:31]
    reg execute_exec_io_DataRead2_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_DataRead2_REG) @[Datapath.scala 57:41]
    execute_exec_io_DataRead2_REG <= decode.dec_io.DataRead2 @[Datapath.scala 57:41]
    execute.exec_io.DataRead2 <= execute_exec_io_DataRead2_REG @[Datapath.scala 57:31]
    execute.exec_io.MemWbEn <= memory.mem_io.WbEnOut @[Datapath.scala 58:29]
    execute.exec_io.MemAddr <= memory.mem_io.WriteRegAddrOut @[Datapath.scala 59:29]
    reg execute_exec_io_MemVal_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_MemVal_REG) @[Datapath.scala 60:38]
    execute_exec_io_MemVal_REG <= execute.exec_io.AluRes @[Datapath.scala 60:38]
    execute.exec_io.MemVal <= execute_exec_io_MemVal_REG @[Datapath.scala 60:28]
    execute.exec_io.WbWbEn <= writeback.wb_io.WbEnOut @[Datapath.scala 61:28]
    execute.exec_io.WbAddr <= writeback.wb_io.WriteRegAddrOut @[Datapath.scala 62:28]
    execute.exec_io.WbVal <= writeback.wb_io.WriteDataOut @[Datapath.scala 63:27]
    reg execute_exec_io_AluOp_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_AluOp_REG) @[Datapath.scala 64:37]
    execute_exec_io_AluOp_REG <= decode.dec_io.AluOp @[Datapath.scala 64:37]
    execute.exec_io.AluOp <= execute_exec_io_AluOp_REG @[Datapath.scala 64:27]
    reg execute_exec_io_Imm_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_Imm_REG) @[Datapath.scala 65:35]
    execute_exec_io_Imm_REG <= decode.dec_io.Imm @[Datapath.scala 65:35]
    execute.exec_io.Imm <= execute_exec_io_Imm_REG @[Datapath.scala 65:25]
    reg execute_exec_io_ImmEn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_ImmEn_REG) @[Datapath.scala 66:37]
    execute_exec_io_ImmEn_REG <= decode.dec_io.ImmEn @[Datapath.scala 66:37]
    execute.exec_io.ImmEn <= execute_exec_io_ImmEn_REG @[Datapath.scala 66:27]
    reg execute_exec_io_BrEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_BrEnIn_REG) @[Datapath.scala 67:38]
    execute_exec_io_BrEnIn_REG <= decode.dec_io.BrEn @[Datapath.scala 67:38]
    execute.exec_io.BrEnIn <= execute_exec_io_BrEnIn_REG @[Datapath.scala 67:28]
    reg execute_exec_io_NextPC_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_NextPC_REG) @[Datapath.scala 68:38]
    execute_exec_io_NextPC_REG <= decode.dec_io.NextPCOut @[Datapath.scala 68:38]
    execute.exec_io.NextPC <= execute_exec_io_NextPC_REG @[Datapath.scala 68:28]
    reg execute_exec_io_ReadEnIn_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_ReadEnIn_REG) @[Datapath.scala 69:40]
    execute_exec_io_ReadEnIn_REG <= decode.dec_io.ReadEn @[Datapath.scala 69:40]
    execute.exec_io.ReadEnIn <= execute_exec_io_ReadEnIn_REG @[Datapath.scala 69:30]
    reg execute_exec_io_WriteEnIn_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_WriteEnIn_REG) @[Datapath.scala 70:41]
    execute_exec_io_WriteEnIn_REG <= decode.dec_io.WriteEnOut @[Datapath.scala 70:41]
    execute.exec_io.WriteEnIn <= execute_exec_io_WriteEnIn_REG @[Datapath.scala 70:31]
    reg execute_exec_io_WbTypeIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_WbTypeIn_REG) @[Datapath.scala 71:40]
    execute_exec_io_WbTypeIn_REG <= decode.dec_io.WbType @[Datapath.scala 71:40]
    execute.exec_io.WbTypeIn <= execute_exec_io_WbTypeIn_REG @[Datapath.scala 71:30]
    reg execute_exec_io_WbEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), execute_exec_io_WbEnIn_REG) @[Datapath.scala 72:38]
    execute_exec_io_WbEnIn_REG <= decode.dec_io.WbEn @[Datapath.scala 72:38]
    execute.exec_io.WbEnIn <= execute_exec_io_WbEnIn_REG @[Datapath.scala 72:28]
    memory.mem_io.ReadEn <= execute.exec_io.ReadEnOut @[Datapath.scala 75:26]
    memory.mem_io.AddrIn <= execute.exec_io.AluRes @[Datapath.scala 76:26]
    reg memory_mem_io_WriteEn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_WriteEn_REG) @[Datapath.scala 77:37]
    memory_mem_io_WriteEn_REG <= execute.exec_io.WriteEnOut @[Datapath.scala 77:37]
    memory.mem_io.WriteEn <= memory_mem_io_WriteEn_REG @[Datapath.scala 77:27]
    reg memory_mem_io_WbEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_WbEnIn_REG) @[Datapath.scala 78:36]
    memory_mem_io_WbEnIn_REG <= execute.exec_io.WbEnOut @[Datapath.scala 78:36]
    memory.mem_io.WbEnIn <= memory_mem_io_WbEnIn_REG @[Datapath.scala 78:26]
    reg memory_mem_io_WbTypeIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_WbTypeIn_REG) @[Datapath.scala 79:38]
    memory_mem_io_WbTypeIn_REG <= execute.exec_io.WbTypeOut @[Datapath.scala 79:38]
    memory.mem_io.WbTypeIn <= memory_mem_io_WbTypeIn_REG @[Datapath.scala 79:28]
    reg memory_mem_io_WriteData_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_WriteData_REG) @[Datapath.scala 80:39]
    memory_mem_io_WriteData_REG <= execute.exec_io.WriteData @[Datapath.scala 80:39]
    memory.mem_io.WriteData <= memory_mem_io_WriteData_REG @[Datapath.scala 80:29]
    reg memory_mem_io_CtrlBrEn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_CtrlBrEn_REG) @[Datapath.scala 81:38]
    memory_mem_io_CtrlBrEn_REG <= execute.exec_io.BrEnOut @[Datapath.scala 81:38]
    memory.mem_io.CtrlBrEn <= memory_mem_io_CtrlBrEn_REG @[Datapath.scala 81:28]
    reg memory_mem_io_AluBrEn_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_AluBrEn_REG) @[Datapath.scala 82:37]
    memory_mem_io_AluBrEn_REG <= execute.exec_io.zero @[Datapath.scala 82:37]
    memory.mem_io.AluBrEn <= memory_mem_io_AluBrEn_REG @[Datapath.scala 82:27]
    reg memory_mem_io_BrAddrIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_BrAddrIn_REG) @[Datapath.scala 83:38]
    memory_mem_io_BrAddrIn_REG <= execute.exec_io.BranchAddrOut @[Datapath.scala 83:38]
    memory.mem_io.BrAddrIn <= memory_mem_io_BrAddrIn_REG @[Datapath.scala 83:28]
    reg memory_mem_io_WriteRegAddrIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), memory_mem_io_WriteRegAddrIn_REG) @[Datapath.scala 84:44]
    memory_mem_io_WriteRegAddrIn_REG <= execute.exec_io.WriteRegAddr @[Datapath.scala 84:44]
    memory.mem_io.WriteRegAddrIn <= memory_mem_io_WriteRegAddrIn_REG @[Datapath.scala 84:34]
    reg writeback_wb_io_WbEnIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_WbEnIn_REG) @[Datapath.scala 87:38]
    writeback_wb_io_WbEnIn_REG <= memory.mem_io.WbEnOut @[Datapath.scala 87:38]
    writeback.wb_io.WbEnIn <= writeback_wb_io_WbEnIn_REG @[Datapath.scala 87:28]
    reg writeback_wb_io_WbTypeIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_WbTypeIn_REG) @[Datapath.scala 88:40]
    writeback_wb_io_WbTypeIn_REG <= memory.mem_io.WbTypeOut @[Datapath.scala 88:40]
    writeback.wb_io.WbTypeIn <= writeback_wb_io_WbTypeIn_REG @[Datapath.scala 88:30]
    writeback.wb_io.ReadData <= memory.mem_io.ReadData @[Datapath.scala 89:30]
    reg writeback_wb_io_AddrData_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_AddrData_REG) @[Datapath.scala 90:40]
    writeback_wb_io_AddrData_REG <= memory.mem_io.AddrOut @[Datapath.scala 90:40]
    writeback.wb_io.AddrData <= writeback_wb_io_AddrData_REG @[Datapath.scala 90:30]
    reg writeback_wb_io_WriteRegAddrIn_REG : UInt, clock with :
      reset => (UInt<1>("h0"), writeback_wb_io_WriteRegAddrIn_REG) @[Datapath.scala 91:46]
    writeback_wb_io_WriteRegAddrIn_REG <= memory.mem_io.WriteRegAddrOut @[Datapath.scala 91:46]
    writeback.wb_io.WriteRegAddrIn <= writeback_wb_io_WriteRegAddrIn_REG @[Datapath.scala 91:36]
    inst U_decoder7seg_7 of decoder7seg @[Datapath.scala 94:33]
    U_decoder7seg_7.clock <= clock
    U_decoder7seg_7.reset <= reset
    inst U_decoder7seg_6 of decoder7seg_1 @[Datapath.scala 95:33]
    U_decoder7seg_6.clock <= clock
    U_decoder7seg_6.reset <= reset
    inst U_decoder7seg_5 of decoder7seg_2 @[Datapath.scala 96:33]
    U_decoder7seg_5.clock <= clock
    U_decoder7seg_5.reset <= reset
    inst U_decoder7seg_4 of decoder7seg_3 @[Datapath.scala 97:33]
    U_decoder7seg_4.clock <= clock
    U_decoder7seg_4.reset <= reset
    inst U_decoder7seg_3 of decoder7seg_4 @[Datapath.scala 98:33]
    U_decoder7seg_3.clock <= clock
    U_decoder7seg_3.reset <= reset
    inst U_decoder7seg_2 of decoder7seg_5 @[Datapath.scala 99:33]
    U_decoder7seg_2.clock <= clock
    U_decoder7seg_2.reset <= reset
    inst U_decoder7seg_1 of decoder7seg_6 @[Datapath.scala 100:33]
    U_decoder7seg_1.clock <= clock
    U_decoder7seg_1.reset <= reset
    inst U_decoder7seg_0 of decoder7seg_7 @[Datapath.scala 101:33]
    U_decoder7seg_0.clock <= clock
    U_decoder7seg_0.reset <= reset
    node _U_decoder7seg_7_io_in_T = bits(io.switches1, 7, 4) @[Datapath.scala 103:36]
    U_decoder7seg_7.io.in <= _U_decoder7seg_7_io_in_T @[Datapath.scala 103:27]
    node _U_decoder7seg_6_io_in_T = bits(io.switches1, 3, 0) @[Datapath.scala 104:36]
    U_decoder7seg_6.io.in <= _U_decoder7seg_6_io_in_T @[Datapath.scala 104:27]
    node _U_decoder7seg_5_io_in_T = bits(io.switches2, 7, 4) @[Datapath.scala 105:36]
    U_decoder7seg_5.io.in <= _U_decoder7seg_5_io_in_T @[Datapath.scala 105:27]
    node _U_decoder7seg_4_io_in_T = bits(io.switches2, 3, 0) @[Datapath.scala 106:36]
    U_decoder7seg_4.io.in <= _U_decoder7seg_4_io_in_T @[Datapath.scala 106:27]
    node _U_decoder7seg_3_io_in_T = bits(output, 15, 12) @[Datapath.scala 108:36]
    U_decoder7seg_3.io.in <= _U_decoder7seg_3_io_in_T @[Datapath.scala 108:27]
    node _U_decoder7seg_2_io_in_T = bits(output, 11, 8) @[Datapath.scala 109:36]
    U_decoder7seg_2.io.in <= _U_decoder7seg_2_io_in_T @[Datapath.scala 109:27]
    node _U_decoder7seg_1_io_in_T = bits(output, 7, 4) @[Datapath.scala 110:36]
    U_decoder7seg_1.io.in <= _U_decoder7seg_1_io_in_T @[Datapath.scala 110:27]
    node _U_decoder7seg_0_io_in_T = bits(output, 3, 0) @[Datapath.scala 111:36]
    U_decoder7seg_0.io.in <= _U_decoder7seg_0_io_in_T @[Datapath.scala 111:27]
    io.hex7 <= U_decoder7seg_7.io.out @[Datapath.scala 113:13]
    io.hex6 <= U_decoder7seg_6.io.out @[Datapath.scala 114:13]
    io.hex5 <= U_decoder7seg_5.io.out @[Datapath.scala 115:13]
    io.hex4 <= U_decoder7seg_4.io.out @[Datapath.scala 116:13]
    io.hex3 <= U_decoder7seg_3.io.out @[Datapath.scala 117:13]
    io.hex2 <= U_decoder7seg_2.io.out @[Datapath.scala 118:13]
    io.hex1 <= U_decoder7seg_1.io.out @[Datapath.scala 119:13]
    io.hex0 <= U_decoder7seg_0.io.out @[Datapath.scala 120:13]

