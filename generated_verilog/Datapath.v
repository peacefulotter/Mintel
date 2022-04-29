module InstructionMem(
  input         clock,
  input  [31:0] io_PC,
  output [31:0] io_Instr
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] memory [0:1023]; // @[InstructionMem.scala 8:21]
  wire  memory_io_Instr_MPORT_en; // @[InstructionMem.scala 8:21]
  wire [9:0] memory_io_Instr_MPORT_addr; // @[InstructionMem.scala 8:21]
  wire [31:0] memory_io_Instr_MPORT_data; // @[InstructionMem.scala 8:21]
  assign memory_io_Instr_MPORT_en = 1'h1;
  assign memory_io_Instr_MPORT_addr = io_PC[9:0];
  assign memory_io_Instr_MPORT_data = memory[memory_io_Instr_MPORT_addr]; // @[InstructionMem.scala 8:21]
  assign io_Instr = memory_io_Instr_MPORT_data; // @[InstructionMem.scala 15:14]
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    memory[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Fetch(
  input         clock,
  input         reset,
  input  [4:0]  io_Stall,
  input  [31:0] io_BranchAddr,
  input         io_BrEn,
  output [31:0] io_NextPC,
  output [31:0] io_Instr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  mem_clock; // @[Fetch.scala 6:21]
  wire [31:0] mem_io_PC; // @[Fetch.scala 6:21]
  wire [31:0] mem_io_Instr; // @[Fetch.scala 6:21]
  reg [31:0] PC; // @[Fetch.scala 7:21]
  reg [4:0] STALL; // @[Fetch.scala 8:24]
  wire  _STALL_T = io_Stall > 5'h0; // @[Fetch.scala 23:18]
  wire  _STALL_T_1 = STALL > 5'h0; // @[Fetch.scala 25:20]
  wire [4:0] _STALL_T_3 = STALL - 5'h1; // @[Fetch.scala 25:33]
  wire  isStalling = _STALL_T | _STALL_T_1; // @[Fetch.scala 28:43]
  InstructionMem mem ( // @[Fetch.scala 6:21]
    .clock(mem_clock),
    .io_PC(mem_io_PC),
    .io_Instr(mem_io_Instr)
  );
  assign io_NextPC = PC + 32'h1; // @[Fetch.scala 30:21]
  assign io_Instr = isStalling ? 32'h0 : mem_io_Instr; // @[Fetch.scala 38:20]
  assign mem_clock = clock;
  assign mem_io_PC = io_BrEn ? io_BranchAddr : PC; // @[Fetch.scala 37:21]
  always @(posedge clock) begin
    if (reset) begin // @[Fetch.scala 7:21]
      PC <= 32'h0; // @[Fetch.scala 7:21]
    end else if (!(isStalling)) begin // @[Fetch.scala 31:26]
      if (io_BrEn) begin // @[Fetch.scala 34:12]
        PC <= io_BranchAddr;
      end else begin
        PC <= io_NextPC;
      end
    end
    if (reset) begin // @[Fetch.scala 8:24]
      STALL <= 5'h0; // @[Fetch.scala 8:24]
    end else if (_STALL_T) begin // @[Fetch.scala 22:17]
      STALL <= io_Stall;
    end else if (STALL > 5'h0) begin // @[Fetch.scala 25:12]
      STALL <= _STALL_T_3;
    end else begin
      STALL <= 5'h0;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  PC = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  STALL = _RAND_1[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RegisterFile(
  input         clock,
  input         reset,
  input  [4:0]  io_ReadAddr1,
  input  [4:0]  io_ReadAddr2,
  input  [4:0]  io_WriteAddr,
  input  [31:0] io_WriteData,
  input         io_WriteEnable,
  output [31:0] io_ReadData1,
  output [31:0] io_ReadData2
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regs_0; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_1; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_2; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_3; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_4; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_5; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_6; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_7; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_8; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_9; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_10; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_11; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_12; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_13; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_14; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_15; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_16; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_17; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_18; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_19; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_20; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_21; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_22; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_23; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_24; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_25; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_26; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_27; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_28; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_29; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_30; // @[RegisterFile.scala 5:23]
  reg [31:0] regs_31; // @[RegisterFile.scala 5:23]
  wire [31:0] _GEN_65 = 5'h1 == io_ReadAddr1 ? regs_1 : regs_0; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_66 = 5'h2 == io_ReadAddr1 ? regs_2 : _GEN_65; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_67 = 5'h3 == io_ReadAddr1 ? regs_3 : _GEN_66; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_68 = 5'h4 == io_ReadAddr1 ? regs_4 : _GEN_67; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_69 = 5'h5 == io_ReadAddr1 ? regs_5 : _GEN_68; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_70 = 5'h6 == io_ReadAddr1 ? regs_6 : _GEN_69; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_71 = 5'h7 == io_ReadAddr1 ? regs_7 : _GEN_70; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_72 = 5'h8 == io_ReadAddr1 ? regs_8 : _GEN_71; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_73 = 5'h9 == io_ReadAddr1 ? regs_9 : _GEN_72; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_74 = 5'ha == io_ReadAddr1 ? regs_10 : _GEN_73; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_75 = 5'hb == io_ReadAddr1 ? regs_11 : _GEN_74; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_76 = 5'hc == io_ReadAddr1 ? regs_12 : _GEN_75; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_77 = 5'hd == io_ReadAddr1 ? regs_13 : _GEN_76; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_78 = 5'he == io_ReadAddr1 ? regs_14 : _GEN_77; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_79 = 5'hf == io_ReadAddr1 ? regs_15 : _GEN_78; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_80 = 5'h10 == io_ReadAddr1 ? regs_16 : _GEN_79; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_81 = 5'h11 == io_ReadAddr1 ? regs_17 : _GEN_80; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_82 = 5'h12 == io_ReadAddr1 ? regs_18 : _GEN_81; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_83 = 5'h13 == io_ReadAddr1 ? regs_19 : _GEN_82; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_84 = 5'h14 == io_ReadAddr1 ? regs_20 : _GEN_83; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_85 = 5'h15 == io_ReadAddr1 ? regs_21 : _GEN_84; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_86 = 5'h16 == io_ReadAddr1 ? regs_22 : _GEN_85; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_87 = 5'h17 == io_ReadAddr1 ? regs_23 : _GEN_86; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_88 = 5'h18 == io_ReadAddr1 ? regs_24 : _GEN_87; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_89 = 5'h19 == io_ReadAddr1 ? regs_25 : _GEN_88; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_90 = 5'h1a == io_ReadAddr1 ? regs_26 : _GEN_89; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_91 = 5'h1b == io_ReadAddr1 ? regs_27 : _GEN_90; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_92 = 5'h1c == io_ReadAddr1 ? regs_28 : _GEN_91; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_93 = 5'h1d == io_ReadAddr1 ? regs_29 : _GEN_92; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_94 = 5'h1e == io_ReadAddr1 ? regs_30 : _GEN_93; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_95 = 5'h1f == io_ReadAddr1 ? regs_31 : _GEN_94; // @[RegisterFile.scala 22:{24,24}]
  wire [31:0] _GEN_97 = 5'h1 == io_ReadAddr2 ? regs_1 : regs_0; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_98 = 5'h2 == io_ReadAddr2 ? regs_2 : _GEN_97; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_99 = 5'h3 == io_ReadAddr2 ? regs_3 : _GEN_98; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_100 = 5'h4 == io_ReadAddr2 ? regs_4 : _GEN_99; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_101 = 5'h5 == io_ReadAddr2 ? regs_5 : _GEN_100; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_102 = 5'h6 == io_ReadAddr2 ? regs_6 : _GEN_101; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_103 = 5'h7 == io_ReadAddr2 ? regs_7 : _GEN_102; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_104 = 5'h8 == io_ReadAddr2 ? regs_8 : _GEN_103; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_105 = 5'h9 == io_ReadAddr2 ? regs_9 : _GEN_104; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_106 = 5'ha == io_ReadAddr2 ? regs_10 : _GEN_105; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_107 = 5'hb == io_ReadAddr2 ? regs_11 : _GEN_106; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_108 = 5'hc == io_ReadAddr2 ? regs_12 : _GEN_107; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_109 = 5'hd == io_ReadAddr2 ? regs_13 : _GEN_108; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_110 = 5'he == io_ReadAddr2 ? regs_14 : _GEN_109; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_111 = 5'hf == io_ReadAddr2 ? regs_15 : _GEN_110; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_112 = 5'h10 == io_ReadAddr2 ? regs_16 : _GEN_111; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_113 = 5'h11 == io_ReadAddr2 ? regs_17 : _GEN_112; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_114 = 5'h12 == io_ReadAddr2 ? regs_18 : _GEN_113; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_115 = 5'h13 == io_ReadAddr2 ? regs_19 : _GEN_114; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_116 = 5'h14 == io_ReadAddr2 ? regs_20 : _GEN_115; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_117 = 5'h15 == io_ReadAddr2 ? regs_21 : _GEN_116; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_118 = 5'h16 == io_ReadAddr2 ? regs_22 : _GEN_117; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_119 = 5'h17 == io_ReadAddr2 ? regs_23 : _GEN_118; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_120 = 5'h18 == io_ReadAddr2 ? regs_24 : _GEN_119; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_121 = 5'h19 == io_ReadAddr2 ? regs_25 : _GEN_120; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_122 = 5'h1a == io_ReadAddr2 ? regs_26 : _GEN_121; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_123 = 5'h1b == io_ReadAddr2 ? regs_27 : _GEN_122; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_124 = 5'h1c == io_ReadAddr2 ? regs_28 : _GEN_123; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_125 = 5'h1d == io_ReadAddr2 ? regs_29 : _GEN_124; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_126 = 5'h1e == io_ReadAddr2 ? regs_30 : _GEN_125; // @[RegisterFile.scala 23:{24,24}]
  wire [31:0] _GEN_127 = 5'h1f == io_ReadAddr2 ? regs_31 : _GEN_126; // @[RegisterFile.scala 23:{24,24}]
  assign io_ReadData1 = |io_ReadAddr1 ? _GEN_95 : 32'h0; // @[RegisterFile.scala 22:24]
  assign io_ReadData2 = |io_ReadAddr2 ? _GEN_127 : 32'h0; // @[RegisterFile.scala 23:24]
  always @(posedge clock) begin
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_0 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h0 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_0 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_1 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h1 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_1 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_2 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h2 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_2 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_3 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h3 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_3 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_4 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h4 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_4 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_5 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h5 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_5 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_6 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h6 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_6 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_7 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h7 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_7 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_8 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h8 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_8 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_9 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h9 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_9 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_10 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'ha == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_10 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_11 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'hb == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_11 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_12 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'hc == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_12 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_13 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'hd == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_13 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_14 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'he == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_14 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_15 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'hf == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_15 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_16 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h10 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_16 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_17 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h11 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_17 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_18 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h12 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_18 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_19 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h13 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_19 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_20 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h14 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_20 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_21 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h15 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_21 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_22 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h16 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_22 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_23 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h17 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_23 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_24 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h18 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_24 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_25 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h19 == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_25 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_26 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h1a == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_26 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_27 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h1b == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_27 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_28 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h1c == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_28 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_29 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h1d == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_29 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_30 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h1e == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_30 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
    if (reset) begin // @[RegisterFile.scala 5:23]
      regs_31 <= 32'h0; // @[RegisterFile.scala 5:23]
    end else if (io_WriteEnable & |io_WriteAddr) begin // @[RegisterFile.scala 18:48]
      if (5'h1f == io_WriteAddr) begin // @[RegisterFile.scala 19:30]
        regs_31 <= io_WriteData; // @[RegisterFile.scala 19:30]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regs_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  regs_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  regs_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  regs_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  regs_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  regs_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  regs_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  regs_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  regs_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  regs_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  regs_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  regs_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  regs_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  regs_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  regs_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  regs_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  regs_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  regs_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  regs_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  regs_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  regs_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  regs_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  regs_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  regs_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  regs_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  regs_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  regs_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  regs_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  regs_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  regs_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  regs_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  regs_31 = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Control(
  input  [31:0] io_instr,
  output [4:0]  io_rs,
  output [4:0]  io_rt,
  output [4:0]  io_rd,
  output [15:0] io_imm,
  output        io_ImmEn,
  output [5:0]  io_AluOp,
  output        io_BrEn,
  output        io_LoadEn,
  output        io_StoreEn,
  output        io_WbType,
  output        io_WbEn,
  output        io_IsSigned
);
  wire  _format_T_1 = 32'h0 == io_instr; // @[Lookup.scala 31:38]
  wire [31:0] _format_T_2 = io_instr & 32'hfc0007ff; // @[Lookup.scala 31:38]
  wire  _format_T_3 = 32'h20 == _format_T_2; // @[Lookup.scala 31:38]
  wire [31:0] _format_T_4 = io_instr & 32'hfc000000; // @[Lookup.scala 31:38]
  wire  _format_T_5 = 32'h20000000 == _format_T_4; // @[Lookup.scala 31:38]
  wire  _format_T_7 = 32'h21 == _format_T_2; // @[Lookup.scala 31:38]
  wire  _format_T_9 = 32'h24000000 == _format_T_4; // @[Lookup.scala 31:38]
  wire  _format_T_11 = 32'h22 == _format_T_2; // @[Lookup.scala 31:38]
  wire  _format_T_13 = 32'h23 == _format_T_2; // @[Lookup.scala 31:38]
  wire  _format_T_15 = 32'h24 == _format_T_2; // @[Lookup.scala 31:38]
  wire  _format_T_17 = 32'h30000000 == _format_T_4; // @[Lookup.scala 31:38]
  wire  _format_T_19 = 32'h25 == _format_T_2; // @[Lookup.scala 31:38]
  wire  _format_T_21 = 32'h34000000 == _format_T_4; // @[Lookup.scala 31:38]
  wire  _format_T_23 = 32'h26 == _format_T_2; // @[Lookup.scala 31:38]
  wire  _format_T_25 = 32'h38000000 == _format_T_4; // @[Lookup.scala 31:38]
  wire [31:0] _format_T_26 = io_instr & 32'hffe0003f; // @[Lookup.scala 31:38]
  wire  _format_T_27 = 32'h0 == _format_T_26; // @[Lookup.scala 31:38]
  wire  _format_T_29 = 32'h2 == _format_T_26; // @[Lookup.scala 31:38]
  wire  _format_T_31 = 32'h4 == _format_T_2; // @[Lookup.scala 31:38]
  wire  _format_T_33 = 32'h6 == _format_T_2; // @[Lookup.scala 31:38]
  wire  _format_T_35 = 32'h2a == _format_T_2; // @[Lookup.scala 31:38]
  wire  _format_T_37 = 32'h28000000 == _format_T_4; // @[Lookup.scala 31:38]
  wire  _format_T_39 = 32'h2b == _format_T_2; // @[Lookup.scala 31:38]
  wire  _format_T_41 = 32'h2c000000 == _format_T_4; // @[Lookup.scala 31:38]
  wire  _format_T_43 = 32'h14000000 == _format_T_4; // @[Lookup.scala 31:38]
  wire  _format_T_45 = 32'h10000000 == _format_T_4; // @[Lookup.scala 31:38]
  wire  _format_T_47 = 32'h18000000 == _format_T_4; // @[Lookup.scala 31:38]
  wire  _format_T_49 = 32'h1c000000 == _format_T_4; // @[Lookup.scala 31:38]
  wire  _format_T_51 = 32'h8c000000 == _format_T_4; // @[Lookup.scala 31:38]
  wire  _format_T_53 = 32'hac000000 == _format_T_4; // @[Lookup.scala 31:38]
  wire [4:0] _format_T_56 = _format_T_49 ? 5'hf : 5'h0; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_57 = _format_T_47 ? 5'hc : _format_T_56; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_58 = _format_T_45 ? 5'h11 : _format_T_57; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_59 = _format_T_43 ? 5'h10 : _format_T_58; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_60 = _format_T_41 ? 5'hd : _format_T_59; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_61 = _format_T_39 ? 5'hd : _format_T_60; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_62 = _format_T_37 ? 5'hc : _format_T_61; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_63 = _format_T_35 ? 5'hc : _format_T_62; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_64 = _format_T_33 ? 5'hb : _format_T_63; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_65 = _format_T_31 ? 5'h9 : _format_T_64; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_66 = _format_T_29 ? 5'ha : _format_T_65; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_67 = _format_T_27 ? 5'h8 : _format_T_66; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_68 = _format_T_25 ? 5'h7 : _format_T_67; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_69 = _format_T_23 ? 5'h7 : _format_T_68; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_70 = _format_T_21 ? 5'h6 : _format_T_69; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_71 = _format_T_19 ? 5'h6 : _format_T_70; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_72 = _format_T_17 ? 5'h5 : _format_T_71; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_73 = _format_T_15 ? 5'h5 : _format_T_72; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_74 = _format_T_13 ? 5'h3 : _format_T_73; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_75 = _format_T_11 ? 5'h2 : _format_T_74; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_76 = _format_T_9 ? 5'h1 : _format_T_75; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_77 = _format_T_7 ? 5'h1 : _format_T_76; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_78 = _format_T_5 ? 5'h0 : _format_T_77; // @[Lookup.scala 34:39]
  wire [4:0] _format_T_79 = _format_T_3 ? 5'h0 : _format_T_78; // @[Lookup.scala 34:39]
  wire [4:0] format_0 = _format_T_1 ? 5'h0 : _format_T_79; // @[Lookup.scala 34:39]
  wire  _format_T_82 = _format_T_49 ? 1'h0 : _format_T_51 | _format_T_53; // @[Lookup.scala 34:39]
  wire  _format_T_83 = _format_T_47 ? 1'h0 : _format_T_82; // @[Lookup.scala 34:39]
  wire  _format_T_84 = _format_T_45 ? 1'h0 : _format_T_83; // @[Lookup.scala 34:39]
  wire  _format_T_85 = _format_T_43 ? 1'h0 : _format_T_84; // @[Lookup.scala 34:39]
  wire  _format_T_87 = _format_T_39 ? 1'h0 : _format_T_41 | _format_T_85; // @[Lookup.scala 34:39]
  wire  _format_T_89 = _format_T_35 ? 1'h0 : _format_T_37 | _format_T_87; // @[Lookup.scala 34:39]
  wire  _format_T_90 = _format_T_33 ? 1'h0 : _format_T_89; // @[Lookup.scala 34:39]
  wire  _format_T_91 = _format_T_31 ? 1'h0 : _format_T_90; // @[Lookup.scala 34:39]
  wire  _format_T_95 = _format_T_23 ? 1'h0 : _format_T_25 | (_format_T_27 | (_format_T_29 | _format_T_91)); // @[Lookup.scala 34:39]
  wire  _format_T_97 = _format_T_19 ? 1'h0 : _format_T_21 | _format_T_95; // @[Lookup.scala 34:39]
  wire  _format_T_99 = _format_T_15 ? 1'h0 : _format_T_17 | _format_T_97; // @[Lookup.scala 34:39]
  wire  _format_T_100 = _format_T_13 ? 1'h0 : _format_T_99; // @[Lookup.scala 34:39]
  wire  _format_T_101 = _format_T_11 ? 1'h0 : _format_T_100; // @[Lookup.scala 34:39]
  wire  _format_T_103 = _format_T_7 ? 1'h0 : _format_T_9 | _format_T_101; // @[Lookup.scala 34:39]
  wire  _format_T_105 = _format_T_3 ? 1'h0 : _format_T_5 | _format_T_103; // @[Lookup.scala 34:39]
  wire  _format_T_112 = _format_T_41 ? 1'h0 : _format_T_43 | (_format_T_45 | (_format_T_47 | _format_T_49)); // @[Lookup.scala 34:39]
  wire  _format_T_113 = _format_T_39 ? 1'h0 : _format_T_112; // @[Lookup.scala 34:39]
  wire  _format_T_114 = _format_T_37 ? 1'h0 : _format_T_113; // @[Lookup.scala 34:39]
  wire  _format_T_115 = _format_T_35 ? 1'h0 : _format_T_114; // @[Lookup.scala 34:39]
  wire  _format_T_116 = _format_T_33 ? 1'h0 : _format_T_115; // @[Lookup.scala 34:39]
  wire  _format_T_117 = _format_T_31 ? 1'h0 : _format_T_116; // @[Lookup.scala 34:39]
  wire  _format_T_118 = _format_T_29 ? 1'h0 : _format_T_117; // @[Lookup.scala 34:39]
  wire  _format_T_119 = _format_T_27 ? 1'h0 : _format_T_118; // @[Lookup.scala 34:39]
  wire  _format_T_120 = _format_T_25 ? 1'h0 : _format_T_119; // @[Lookup.scala 34:39]
  wire  _format_T_121 = _format_T_23 ? 1'h0 : _format_T_120; // @[Lookup.scala 34:39]
  wire  _format_T_122 = _format_T_21 ? 1'h0 : _format_T_121; // @[Lookup.scala 34:39]
  wire  _format_T_123 = _format_T_19 ? 1'h0 : _format_T_122; // @[Lookup.scala 34:39]
  wire  _format_T_124 = _format_T_17 ? 1'h0 : _format_T_123; // @[Lookup.scala 34:39]
  wire  _format_T_125 = _format_T_15 ? 1'h0 : _format_T_124; // @[Lookup.scala 34:39]
  wire  _format_T_126 = _format_T_13 ? 1'h0 : _format_T_125; // @[Lookup.scala 34:39]
  wire  _format_T_127 = _format_T_11 ? 1'h0 : _format_T_126; // @[Lookup.scala 34:39]
  wire  _format_T_128 = _format_T_9 ? 1'h0 : _format_T_127; // @[Lookup.scala 34:39]
  wire  _format_T_129 = _format_T_7 ? 1'h0 : _format_T_128; // @[Lookup.scala 34:39]
  wire  _format_T_130 = _format_T_5 ? 1'h0 : _format_T_129; // @[Lookup.scala 34:39]
  wire  _format_T_131 = _format_T_3 ? 1'h0 : _format_T_130; // @[Lookup.scala 34:39]
  wire  _format_T_134 = _format_T_49 ? 1'h0 : _format_T_51; // @[Lookup.scala 34:39]
  wire  _format_T_135 = _format_T_47 ? 1'h0 : _format_T_134; // @[Lookup.scala 34:39]
  wire  _format_T_136 = _format_T_45 ? 1'h0 : _format_T_135; // @[Lookup.scala 34:39]
  wire  _format_T_137 = _format_T_43 ? 1'h0 : _format_T_136; // @[Lookup.scala 34:39]
  wire  _format_T_138 = _format_T_41 ? 1'h0 : _format_T_137; // @[Lookup.scala 34:39]
  wire  _format_T_139 = _format_T_39 ? 1'h0 : _format_T_138; // @[Lookup.scala 34:39]
  wire  _format_T_140 = _format_T_37 ? 1'h0 : _format_T_139; // @[Lookup.scala 34:39]
  wire  _format_T_141 = _format_T_35 ? 1'h0 : _format_T_140; // @[Lookup.scala 34:39]
  wire  _format_T_142 = _format_T_33 ? 1'h0 : _format_T_141; // @[Lookup.scala 34:39]
  wire  _format_T_143 = _format_T_31 ? 1'h0 : _format_T_142; // @[Lookup.scala 34:39]
  wire  _format_T_144 = _format_T_29 ? 1'h0 : _format_T_143; // @[Lookup.scala 34:39]
  wire  _format_T_145 = _format_T_27 ? 1'h0 : _format_T_144; // @[Lookup.scala 34:39]
  wire  _format_T_146 = _format_T_25 ? 1'h0 : _format_T_145; // @[Lookup.scala 34:39]
  wire  _format_T_147 = _format_T_23 ? 1'h0 : _format_T_146; // @[Lookup.scala 34:39]
  wire  _format_T_148 = _format_T_21 ? 1'h0 : _format_T_147; // @[Lookup.scala 34:39]
  wire  _format_T_149 = _format_T_19 ? 1'h0 : _format_T_148; // @[Lookup.scala 34:39]
  wire  _format_T_150 = _format_T_17 ? 1'h0 : _format_T_149; // @[Lookup.scala 34:39]
  wire  _format_T_151 = _format_T_15 ? 1'h0 : _format_T_150; // @[Lookup.scala 34:39]
  wire  _format_T_152 = _format_T_13 ? 1'h0 : _format_T_151; // @[Lookup.scala 34:39]
  wire  _format_T_153 = _format_T_11 ? 1'h0 : _format_T_152; // @[Lookup.scala 34:39]
  wire  _format_T_154 = _format_T_9 ? 1'h0 : _format_T_153; // @[Lookup.scala 34:39]
  wire  _format_T_155 = _format_T_7 ? 1'h0 : _format_T_154; // @[Lookup.scala 34:39]
  wire  _format_T_156 = _format_T_5 ? 1'h0 : _format_T_155; // @[Lookup.scala 34:39]
  wire  _format_T_157 = _format_T_3 ? 1'h0 : _format_T_156; // @[Lookup.scala 34:39]
  wire  _format_T_159 = _format_T_51 ? 1'h0 : _format_T_53; // @[Lookup.scala 34:39]
  wire  _format_T_160 = _format_T_49 ? 1'h0 : _format_T_159; // @[Lookup.scala 34:39]
  wire  _format_T_161 = _format_T_47 ? 1'h0 : _format_T_160; // @[Lookup.scala 34:39]
  wire  _format_T_162 = _format_T_45 ? 1'h0 : _format_T_161; // @[Lookup.scala 34:39]
  wire  _format_T_163 = _format_T_43 ? 1'h0 : _format_T_162; // @[Lookup.scala 34:39]
  wire  _format_T_164 = _format_T_41 ? 1'h0 : _format_T_163; // @[Lookup.scala 34:39]
  wire  _format_T_165 = _format_T_39 ? 1'h0 : _format_T_164; // @[Lookup.scala 34:39]
  wire  _format_T_166 = _format_T_37 ? 1'h0 : _format_T_165; // @[Lookup.scala 34:39]
  wire  _format_T_167 = _format_T_35 ? 1'h0 : _format_T_166; // @[Lookup.scala 34:39]
  wire  _format_T_168 = _format_T_33 ? 1'h0 : _format_T_167; // @[Lookup.scala 34:39]
  wire  _format_T_169 = _format_T_31 ? 1'h0 : _format_T_168; // @[Lookup.scala 34:39]
  wire  _format_T_170 = _format_T_29 ? 1'h0 : _format_T_169; // @[Lookup.scala 34:39]
  wire  _format_T_171 = _format_T_27 ? 1'h0 : _format_T_170; // @[Lookup.scala 34:39]
  wire  _format_T_172 = _format_T_25 ? 1'h0 : _format_T_171; // @[Lookup.scala 34:39]
  wire  _format_T_173 = _format_T_23 ? 1'h0 : _format_T_172; // @[Lookup.scala 34:39]
  wire  _format_T_174 = _format_T_21 ? 1'h0 : _format_T_173; // @[Lookup.scala 34:39]
  wire  _format_T_175 = _format_T_19 ? 1'h0 : _format_T_174; // @[Lookup.scala 34:39]
  wire  _format_T_176 = _format_T_17 ? 1'h0 : _format_T_175; // @[Lookup.scala 34:39]
  wire  _format_T_177 = _format_T_15 ? 1'h0 : _format_T_176; // @[Lookup.scala 34:39]
  wire  _format_T_178 = _format_T_13 ? 1'h0 : _format_T_177; // @[Lookup.scala 34:39]
  wire  _format_T_179 = _format_T_11 ? 1'h0 : _format_T_178; // @[Lookup.scala 34:39]
  wire  _format_T_180 = _format_T_9 ? 1'h0 : _format_T_179; // @[Lookup.scala 34:39]
  wire  _format_T_181 = _format_T_7 ? 1'h0 : _format_T_180; // @[Lookup.scala 34:39]
  wire  _format_T_182 = _format_T_5 ? 1'h0 : _format_T_181; // @[Lookup.scala 34:39]
  wire  _format_T_183 = _format_T_3 ? 1'h0 : _format_T_182; // @[Lookup.scala 34:39]
  wire  _format_T_190 = _format_T_41 ? 1'h0 : _format_T_85; // @[Lookup.scala 34:39]
  wire  _format_T_191 = _format_T_39 ? 1'h0 : _format_T_190; // @[Lookup.scala 34:39]
  wire  _format_T_192 = _format_T_37 ? 1'h0 : _format_T_191; // @[Lookup.scala 34:39]
  wire  _format_T_193 = _format_T_35 ? 1'h0 : _format_T_192; // @[Lookup.scala 34:39]
  wire  _format_T_194 = _format_T_33 ? 1'h0 : _format_T_193; // @[Lookup.scala 34:39]
  wire  _format_T_195 = _format_T_31 ? 1'h0 : _format_T_194; // @[Lookup.scala 34:39]
  wire  _format_T_196 = _format_T_29 ? 1'h0 : _format_T_195; // @[Lookup.scala 34:39]
  wire  _format_T_197 = _format_T_27 ? 1'h0 : _format_T_196; // @[Lookup.scala 34:39]
  wire  _format_T_198 = _format_T_25 ? 1'h0 : _format_T_197; // @[Lookup.scala 34:39]
  wire  _format_T_199 = _format_T_23 ? 1'h0 : _format_T_198; // @[Lookup.scala 34:39]
  wire  _format_T_200 = _format_T_21 ? 1'h0 : _format_T_199; // @[Lookup.scala 34:39]
  wire  _format_T_201 = _format_T_19 ? 1'h0 : _format_T_200; // @[Lookup.scala 34:39]
  wire  _format_T_202 = _format_T_17 ? 1'h0 : _format_T_201; // @[Lookup.scala 34:39]
  wire  _format_T_203 = _format_T_15 ? 1'h0 : _format_T_202; // @[Lookup.scala 34:39]
  wire  _format_T_204 = _format_T_13 ? 1'h0 : _format_T_203; // @[Lookup.scala 34:39]
  wire  _format_T_205 = _format_T_11 ? 1'h0 : _format_T_204; // @[Lookup.scala 34:39]
  wire  _format_T_206 = _format_T_9 ? 1'h0 : _format_T_205; // @[Lookup.scala 34:39]
  wire  _format_T_207 = _format_T_7 ? 1'h0 : _format_T_206; // @[Lookup.scala 34:39]
  wire  _format_T_208 = _format_T_5 ? 1'h0 : _format_T_207; // @[Lookup.scala 34:39]
  wire  _format_T_209 = _format_T_3 ? 1'h0 : _format_T_208; // @[Lookup.scala 34:39]
  wire  _format_T_246 = _format_T_33 ? 1'h0 : _format_T_35 | _format_T_37; // @[Lookup.scala 34:39]
  wire  _format_T_247 = _format_T_31 ? 1'h0 : _format_T_246; // @[Lookup.scala 34:39]
  wire  _format_T_248 = _format_T_29 ? 1'h0 : _format_T_247; // @[Lookup.scala 34:39]
  wire  _format_T_249 = _format_T_27 ? 1'h0 : _format_T_248; // @[Lookup.scala 34:39]
  wire  _format_T_250 = _format_T_25 ? 1'h0 : _format_T_249; // @[Lookup.scala 34:39]
  wire  _format_T_251 = _format_T_23 ? 1'h0 : _format_T_250; // @[Lookup.scala 34:39]
  wire  _format_T_252 = _format_T_21 ? 1'h0 : _format_T_251; // @[Lookup.scala 34:39]
  wire  _format_T_253 = _format_T_19 ? 1'h0 : _format_T_252; // @[Lookup.scala 34:39]
  wire  _format_T_254 = _format_T_17 ? 1'h0 : _format_T_253; // @[Lookup.scala 34:39]
  wire  _format_T_255 = _format_T_15 ? 1'h0 : _format_T_254; // @[Lookup.scala 34:39]
  wire  _format_T_256 = _format_T_13 ? 1'h0 : _format_T_255; // @[Lookup.scala 34:39]
  wire  _format_T_258 = _format_T_9 ? 1'h0 : _format_T_11 | _format_T_256; // @[Lookup.scala 34:39]
  wire  _format_T_259 = _format_T_7 ? 1'h0 : _format_T_258; // @[Lookup.scala 34:39]
  assign io_rs = io_instr[25:21]; // @[Control.scala 25:33]
  assign io_rt = io_instr[20:16]; // @[Control.scala 26:33]
  assign io_rd = io_instr[15:11]; // @[Control.scala 27:33]
  assign io_imm = io_instr[15:0]; // @[Control.scala 28:33]
  assign io_ImmEn = _format_T_1 ? 1'h0 : _format_T_105; // @[Lookup.scala 34:39]
  assign io_AluOp = {{1'd0}, format_0}; // @[Control.scala 32:17]
  assign io_BrEn = _format_T_1 ? 1'h0 : _format_T_131; // @[Lookup.scala 34:39]
  assign io_LoadEn = _format_T_1 ? 1'h0 : _format_T_157; // @[Lookup.scala 34:39]
  assign io_StoreEn = _format_T_1 ? 1'h0 : _format_T_183; // @[Lookup.scala 34:39]
  assign io_WbType = _format_T_1 ? 1'h0 : _format_T_209; // @[Lookup.scala 34:39]
  assign io_WbEn = _format_T_1 ? 1'h0 : _format_T_3 | (_format_T_5 | (_format_T_7 | (_format_T_9 | (_format_T_11 | (
    _format_T_13 | (_format_T_15 | (_format_T_17 | (_format_T_19 | (_format_T_21 | (_format_T_23 | (_format_T_25 | (
    _format_T_27 | (_format_T_29 | (_format_T_31 | (_format_T_33 | (_format_T_35 | (_format_T_37 | (_format_T_39 | (
    _format_T_41 | _format_T_137))))))))))))))))))); // @[Lookup.scala 34:39]
  assign io_IsSigned = _format_T_1 ? 1'h0 : _format_T_3 | (_format_T_5 | _format_T_259); // @[Lookup.scala 34:39]
endmodule
module SignExtend(
  input  [15:0] io_in,
  input         io_isSigned,
  output [31:0] io_out
);
  wire [14:0] high = io_isSigned & io_in[15] ? 15'h7fff : 15'h0; // @[SignExtend.scala 12:25]
  wire [30:0] _io_out_T = {high,io_in}; // @[Cat.scala 31:58]
  assign io_out = {{1'd0}, _io_out_T}; // @[SignExtend.scala 13:12]
endmodule
module Decode(
  input         clock,
  input         reset,
  input  [31:0] dec_io_Instr,
  input  [31:0] dec_io_WriteAddrIn,
  input         dec_io_WriteEnIn,
  input  [31:0] dec_io_WriteDataIn,
  output [31:0] dec_io_AluOp,
  output [31:0] dec_io_Imm,
  output        dec_io_ImmEn,
  output        dec_io_BrEn,
  output        dec_io_ReadEn,
  output        dec_io_WriteEnOut,
  output        dec_io_WbType,
  output        dec_io_WbEn,
  output [5:0]  dec_io_rs,
  output [5:0]  dec_io_rt,
  output [5:0]  dec_io_rd,
  output [31:0] dec_io_DataRead1,
  output [31:0] dec_io_DataRead2
);
  wire  regFile_clock; // @[Decode.scala 6:25]
  wire  regFile_reset; // @[Decode.scala 6:25]
  wire [4:0] regFile_io_ReadAddr1; // @[Decode.scala 6:25]
  wire [4:0] regFile_io_ReadAddr2; // @[Decode.scala 6:25]
  wire [4:0] regFile_io_WriteAddr; // @[Decode.scala 6:25]
  wire [31:0] regFile_io_WriteData; // @[Decode.scala 6:25]
  wire  regFile_io_WriteEnable; // @[Decode.scala 6:25]
  wire [31:0] regFile_io_ReadData1; // @[Decode.scala 6:25]
  wire [31:0] regFile_io_ReadData2; // @[Decode.scala 6:25]
  wire [31:0] control_io_instr; // @[Decode.scala 7:25]
  wire [4:0] control_io_rs; // @[Decode.scala 7:25]
  wire [4:0] control_io_rt; // @[Decode.scala 7:25]
  wire [4:0] control_io_rd; // @[Decode.scala 7:25]
  wire [15:0] control_io_imm; // @[Decode.scala 7:25]
  wire  control_io_ImmEn; // @[Decode.scala 7:25]
  wire [5:0] control_io_AluOp; // @[Decode.scala 7:25]
  wire  control_io_BrEn; // @[Decode.scala 7:25]
  wire  control_io_LoadEn; // @[Decode.scala 7:25]
  wire  control_io_StoreEn; // @[Decode.scala 7:25]
  wire  control_io_WbType; // @[Decode.scala 7:25]
  wire  control_io_WbEn; // @[Decode.scala 7:25]
  wire  control_io_IsSigned; // @[Decode.scala 7:25]
  wire [15:0] signExtend_io_in; // @[Decode.scala 8:28]
  wire  signExtend_io_isSigned; // @[Decode.scala 8:28]
  wire [31:0] signExtend_io_out; // @[Decode.scala 8:28]
  RegisterFile regFile ( // @[Decode.scala 6:25]
    .clock(regFile_clock),
    .reset(regFile_reset),
    .io_ReadAddr1(regFile_io_ReadAddr1),
    .io_ReadAddr2(regFile_io_ReadAddr2),
    .io_WriteAddr(regFile_io_WriteAddr),
    .io_WriteData(regFile_io_WriteData),
    .io_WriteEnable(regFile_io_WriteEnable),
    .io_ReadData1(regFile_io_ReadData1),
    .io_ReadData2(regFile_io_ReadData2)
  );
  Control control ( // @[Decode.scala 7:25]
    .io_instr(control_io_instr),
    .io_rs(control_io_rs),
    .io_rt(control_io_rt),
    .io_rd(control_io_rd),
    .io_imm(control_io_imm),
    .io_ImmEn(control_io_ImmEn),
    .io_AluOp(control_io_AluOp),
    .io_BrEn(control_io_BrEn),
    .io_LoadEn(control_io_LoadEn),
    .io_StoreEn(control_io_StoreEn),
    .io_WbType(control_io_WbType),
    .io_WbEn(control_io_WbEn),
    .io_IsSigned(control_io_IsSigned)
  );
  SignExtend signExtend ( // @[Decode.scala 8:28]
    .io_in(signExtend_io_in),
    .io_isSigned(signExtend_io_isSigned),
    .io_out(signExtend_io_out)
  );
  assign dec_io_AluOp = {{26'd0}, control_io_AluOp}; // @[Decode.scala 48:18]
  assign dec_io_Imm = signExtend_io_out; // @[Decode.scala 70:16]
  assign dec_io_ImmEn = control_io_ImmEn; // @[Decode.scala 51:18]
  assign dec_io_BrEn = control_io_BrEn; // @[Decode.scala 49:17]
  assign dec_io_ReadEn = control_io_LoadEn; // @[Decode.scala 50:19]
  assign dec_io_WriteEnOut = control_io_StoreEn; // @[Decode.scala 52:23]
  assign dec_io_WbType = control_io_WbType; // @[Decode.scala 53:19]
  assign dec_io_WbEn = control_io_WbEn; // @[Decode.scala 54:17]
  assign dec_io_rs = {{1'd0}, control_io_rs}; // @[Decode.scala 45:15]
  assign dec_io_rt = {{1'd0}, control_io_rt}; // @[Decode.scala 46:15]
  assign dec_io_rd = {{1'd0}, control_io_rd}; // @[Decode.scala 47:15]
  assign dec_io_DataRead1 = regFile_io_ReadData1; // @[Decode.scala 63:22]
  assign dec_io_DataRead2 = regFile_io_ReadData2; // @[Decode.scala 64:22]
  assign regFile_clock = clock;
  assign regFile_reset = reset;
  assign regFile_io_ReadAddr1 = control_io_rs; // @[Decode.scala 57:26]
  assign regFile_io_ReadAddr2 = control_io_rt; // @[Decode.scala 58:26]
  assign regFile_io_WriteAddr = dec_io_WriteAddrIn[4:0]; // @[Decode.scala 60:26]
  assign regFile_io_WriteData = dec_io_WriteDataIn; // @[Decode.scala 61:26]
  assign regFile_io_WriteEnable = dec_io_WriteEnIn; // @[Decode.scala 59:48]
  assign control_io_instr = dec_io_Instr; // @[Decode.scala 43:22]
  assign signExtend_io_in = control_io_imm; // @[Decode.scala 68:22]
  assign signExtend_io_isSigned = control_io_IsSigned; // @[Decode.scala 69:51]
endmodule
module ALU(
  input  [31:0] io_A,
  input  [31:0] io_B,
  input  [4:0]  io_AluOp,
  output [31:0] io_out,
  output        io_zero
);
  wire [4:0] shamt = io_B[10:6]; // @[ALU.scala 19:33]
  wire  _io_out_T_2 = $signed(io_A) < $signed(io_B); // @[ALU.scala 25:38]
  wire  _io_out_T_5 = $signed(io_A) >= $signed(io_B); // @[ALU.scala 26:38]
  wire  _io_out_T_6 = io_A != io_B; // @[ALU.scala 27:31]
  wire  _io_out_T_7 = io_A == io_B; // @[ALU.scala 28:31]
  wire  _io_out_T_11 = 5'hf == io_AluOp ? _io_out_T_5 : 5'hc == io_AluOp & _io_out_T_2; // @[Mux.scala 81:58]
  wire  _io_out_T_13 = 5'h10 == io_AluOp ? _io_out_T_6 : _io_out_T_11; // @[Mux.scala 81:58]
  wire  _io_out_T_15 = 5'h11 == io_AluOp ? _io_out_T_7 : _io_out_T_13; // @[Mux.scala 81:58]
  wire [31:0] _io_out_T_21 = $signed(io_A) + $signed(io_B); // @[ALU.scala 36:49]
  wire [31:0] _io_out_T_23 = io_A + io_B; // @[ALU.scala 37:27]
  wire [31:0] _io_out_T_29 = $signed(io_A) - $signed(io_B); // @[ALU.scala 38:49]
  wire [31:0] _io_out_T_31 = io_A - io_B; // @[ALU.scala 39:27]
  wire [63:0] _io_out_T_35 = $signed(io_A) * $signed(io_B); // @[ALU.scala 40:49]
  wire [31:0] _io_out_T_36 = io_A & io_B; // @[ALU.scala 42:27]
  wire [31:0] _io_out_T_37 = io_A | io_B; // @[ALU.scala 43:27]
  wire [31:0] _io_out_T_38 = io_A ^ io_B; // @[ALU.scala 44:27]
  wire [62:0] _GEN_0 = {{31'd0}, io_A}; // @[ALU.scala 46:27]
  wire [62:0] _io_out_T_39 = _GEN_0 << shamt; // @[ALU.scala 46:27]
  wire [31:0] _io_out_T_40 = io_A >> shamt; // @[ALU.scala 47:27]
  wire [62:0] _GEN_1 = {{31'd0}, io_A}; // @[ALU.scala 48:27]
  wire [62:0] _io_out_T_42 = _GEN_1 << io_B[4:0]; // @[ALU.scala 48:27]
  wire [31:0] _io_out_T_44 = io_A >> io_B[4:0]; // @[ALU.scala 49:27]
  wire  _io_out_T_45 = io_A < io_B; // @[ALU.scala 51:27]
  wire [31:0] _io_out_T_47 = 5'h0 == io_AluOp ? _io_out_T_21 : {{31'd0}, _io_out_T_15}; // @[Mux.scala 81:58]
  wire [31:0] _io_out_T_49 = 5'h1 == io_AluOp ? _io_out_T_23 : _io_out_T_47; // @[Mux.scala 81:58]
  wire [31:0] _io_out_T_51 = 5'h2 == io_AluOp ? _io_out_T_29 : _io_out_T_49; // @[Mux.scala 81:58]
  wire [31:0] _io_out_T_53 = 5'h3 == io_AluOp ? _io_out_T_31 : _io_out_T_51; // @[Mux.scala 81:58]
  wire [63:0] _io_out_T_55 = 5'h4 == io_AluOp ? _io_out_T_35 : {{32'd0}, _io_out_T_53}; // @[Mux.scala 81:58]
  wire [63:0] _io_out_T_57 = 5'h5 == io_AluOp ? {{32'd0}, _io_out_T_36} : _io_out_T_55; // @[Mux.scala 81:58]
  wire [63:0] _io_out_T_59 = 5'h6 == io_AluOp ? {{32'd0}, _io_out_T_37} : _io_out_T_57; // @[Mux.scala 81:58]
  wire [63:0] _io_out_T_61 = 5'h7 == io_AluOp ? {{32'd0}, _io_out_T_38} : _io_out_T_59; // @[Mux.scala 81:58]
  wire [63:0] _io_out_T_63 = 5'h8 == io_AluOp ? {{1'd0}, _io_out_T_39} : _io_out_T_61; // @[Mux.scala 81:58]
  wire [63:0] _io_out_T_65 = 5'ha == io_AluOp ? {{32'd0}, _io_out_T_40} : _io_out_T_63; // @[Mux.scala 81:58]
  wire [63:0] _io_out_T_67 = 5'h9 == io_AluOp ? {{1'd0}, _io_out_T_42} : _io_out_T_65; // @[Mux.scala 81:58]
  wire [63:0] _io_out_T_69 = 5'hb == io_AluOp ? {{32'd0}, _io_out_T_44} : _io_out_T_67; // @[Mux.scala 81:58]
  wire [63:0] _io_out_T_71 = 5'hd == io_AluOp ? {{63'd0}, _io_out_T_45} : _io_out_T_69; // @[Mux.scala 81:58]
  assign io_out = _io_out_T_71[31:0]; // @[ALU.scala 32:12]
  assign io_zero = 5'h11 == io_AluOp ? _io_out_T_7 : _io_out_T_13; // @[Mux.scala 81:58]
endmodule
module Execute(
  input  [31:0] exec_io_Imm,
  input  [31:0] exec_io_rs,
  input  [31:0] exec_io_rt,
  input  [31:0] exec_io_rd,
  input  [31:0] exec_io_DataRead1,
  input  [31:0] exec_io_DataRead2,
  input         exec_io_MemWbEn,
  input  [31:0] exec_io_MemAddr,
  input  [31:0] exec_io_MemVal,
  input         exec_io_WbWbEn,
  input  [31:0] exec_io_WbAddr,
  input  [31:0] exec_io_WbVal,
  input  [3:0]  exec_io_AluOp,
  input         exec_io_ImmEn,
  input         exec_io_WriteEnIn,
  input         exec_io_ReadEnIn,
  input         exec_io_BrEnIn,
  input         exec_io_WbEnIn,
  input         exec_io_WbTypeIn,
  output [31:0] exec_io_AluRes,
  output        exec_io_zero,
  output [31:0] exec_io_BranchAddrOut,
  output [31:0] exec_io_WriteData,
  output        exec_io_ReadEnOut,
  output        exec_io_WriteEnOut,
  output        exec_io_BrEnOut,
  output        exec_io_WbTypeOut,
  output        exec_io_WbEnOut,
  output [31:0] exec_io_WriteRegAddr
);
  wire [31:0] alu_io_A; // @[Execute.scala 6:21]
  wire [31:0] alu_io_B; // @[Execute.scala 6:21]
  wire [4:0] alu_io_AluOp; // @[Execute.scala 6:21]
  wire [31:0] alu_io_out; // @[Execute.scala 6:21]
  wire  alu_io_zero; // @[Execute.scala 6:21]
  wire  _A_T_2 = exec_io_rs == exec_io_MemAddr & exec_io_MemWbEn; // @[Execute.scala 59:34]
  wire [31:0] _A_T_6 = exec_io_rs == exec_io_WbAddr & exec_io_WbWbEn ? exec_io_WbVal : exec_io_DataRead1; // @[Execute.scala 61:12]
  wire  _B_T_2 = exec_io_rt == exec_io_MemAddr & exec_io_MemWbEn; // @[Execute.scala 59:34]
  wire [31:0] _B_T_6 = exec_io_rt == exec_io_WbAddr & exec_io_WbWbEn ? exec_io_WbVal : exec_io_DataRead2; // @[Execute.scala 61:12]
  wire [31:0] B = _B_T_2 ? exec_io_MemVal : _B_T_6; // @[Execute.scala 58:54]
  ALU alu ( // @[Execute.scala 6:21]
    .io_A(alu_io_A),
    .io_B(alu_io_B),
    .io_AluOp(alu_io_AluOp),
    .io_out(alu_io_out),
    .io_zero(alu_io_zero)
  );
  assign exec_io_AluRes = alu_io_out; // @[Execute.scala 81:20]
  assign exec_io_zero = alu_io_zero; // @[Execute.scala 82:18]
  assign exec_io_BranchAddrOut = exec_io_Imm; // @[Execute.scala 85:27]
  assign exec_io_WriteData = _B_T_2 ? exec_io_MemVal : _B_T_6; // @[Execute.scala 58:54]
  assign exec_io_ReadEnOut = exec_io_ReadEnIn; // @[Execute.scala 89:23]
  assign exec_io_WriteEnOut = exec_io_WriteEnIn; // @[Execute.scala 90:24]
  assign exec_io_BrEnOut = exec_io_BrEnIn; // @[Execute.scala 86:21]
  assign exec_io_WbTypeOut = exec_io_WbTypeIn; // @[Execute.scala 87:23]
  assign exec_io_WbEnOut = exec_io_WbEnIn; // @[Execute.scala 88:21]
  assign exec_io_WriteRegAddr = exec_io_ImmEn ? exec_io_rt : exec_io_rd; // @[Execute.scala 96:32]
  assign alu_io_A = _A_T_2 ? exec_io_MemVal : _A_T_6; // @[Execute.scala 58:54]
  assign alu_io_B = exec_io_ImmEn ? exec_io_Imm : B; // @[Execute.scala 79:20]
  assign alu_io_AluOp = {{1'd0}, exec_io_AluOp}; // @[Execute.scala 80:18]
endmodule
module RAM(
  input         clock,
  input         ram_io_WriteEn,
  input         ram_io_ReadEn,
  input  [9:0]  ram_io_Addr,
  input  [31:0] ram_io_WriteData,
  output [31:0] ram_io_ReadData
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:1023]; // @[RAM.scala 15:26]
  wire  mem_ReadData_en; // @[RAM.scala 15:26]
  wire [9:0] mem_ReadData_addr; // @[RAM.scala 15:26]
  wire [31:0] mem_ReadData_data; // @[RAM.scala 15:26]
  wire [31:0] mem_MPORT_data; // @[RAM.scala 15:26]
  wire [9:0] mem_MPORT_addr; // @[RAM.scala 15:26]
  wire  mem_MPORT_mask; // @[RAM.scala 15:26]
  wire  mem_MPORT_en; // @[RAM.scala 15:26]
  reg  mem_ReadData_en_pipe_0;
  reg [9:0] mem_ReadData_addr_pipe_0;
  reg [9:0] PrevAddr; // @[RAM.scala 29:28]
  reg  PrevWrEn; // @[RAM.scala 32:28]
  reg [31:0] PrevWrData; // @[RAM.scala 33:29]
  reg [9:0] reg_raddr; // @[RAM.scala 41:24]
  reg  doForwardWr; // @[RAM.scala 46:30]
  assign mem_ReadData_en = mem_ReadData_en_pipe_0;
  assign mem_ReadData_addr = mem_ReadData_addr_pipe_0;
  assign mem_ReadData_data = mem[mem_ReadData_addr]; // @[RAM.scala 15:26]
  assign mem_MPORT_data = ram_io_WriteData;
  assign mem_MPORT_addr = ram_io_Addr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = ram_io_WriteEn;
  assign ram_io_ReadData = doForwardWr ? PrevWrData : mem_ReadData_data; // @[RAM.scala 48:27]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[RAM.scala 15:26]
    end
    mem_ReadData_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_ReadData_addr_pipe_0 <= reg_raddr;
    end
    PrevAddr <= ram_io_Addr; // @[RAM.scala 29:28]
    PrevWrEn <= ram_io_WriteEn; // @[RAM.scala 32:28]
    PrevWrData <= ram_io_WriteData; // @[RAM.scala 33:29]
    if (ram_io_ReadEn) begin // @[RAM.scala 42:34]
      reg_raddr <= ram_io_Addr; // @[RAM.scala 42:46]
    end
    doForwardWr <= ram_io_Addr == PrevAddr & PrevWrEn & ram_io_ReadEn; // @[RAM.scala 46:64]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_ReadData_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_ReadData_addr_pipe_0 = _RAND_2[9:0];
  _RAND_3 = {1{`RANDOM}};
  PrevAddr = _RAND_3[9:0];
  _RAND_4 = {1{`RANDOM}};
  PrevWrEn = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  PrevWrData = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  reg_raddr = _RAND_6[9:0];
  _RAND_7 = {1{`RANDOM}};
  doForwardWr = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Mem(
  input         clock,
  input         mem_io_WriteEn,
  input         mem_io_ReadEn,
  input         mem_io_CtrlBrEn,
  input         mem_io_WbTypeIn,
  input         mem_io_WbEnIn,
  input         mem_io_AluBrEn,
  input  [31:0] mem_io_BrAddrIn,
  input  [31:0] mem_io_WriteRegAddrIn,
  input  [31:0] mem_io_WriteData,
  input  [31:0] mem_io_AddrIn,
  output [31:0] mem_io_ReadData,
  output        mem_io_WbTypeOut,
  output        mem_io_WbEnOut,
  output [31:0] mem_io_AddrOut,
  output [31:0] mem_io_WriteRegAddrOut,
  output [31:0] mem_io_BrAddrOut,
  output        mem_io_BrEnOut
);
  wire  ram_clock; // @[Mem.scala 6:21]
  wire  ram_ram_io_WriteEn; // @[Mem.scala 6:21]
  wire  ram_ram_io_ReadEn; // @[Mem.scala 6:21]
  wire [9:0] ram_ram_io_Addr; // @[Mem.scala 6:21]
  wire [31:0] ram_ram_io_WriteData; // @[Mem.scala 6:21]
  wire [31:0] ram_ram_io_ReadData; // @[Mem.scala 6:21]
  RAM ram ( // @[Mem.scala 6:21]
    .clock(ram_clock),
    .ram_io_WriteEn(ram_ram_io_WriteEn),
    .ram_io_ReadEn(ram_ram_io_ReadEn),
    .ram_io_Addr(ram_ram_io_Addr),
    .ram_io_WriteData(ram_ram_io_WriteData),
    .ram_io_ReadData(ram_ram_io_ReadData)
  );
  assign mem_io_ReadData = ram_ram_io_ReadData; // @[Mem.scala 46:21]
  assign mem_io_WbTypeOut = mem_io_WbTypeIn; // @[Mem.scala 50:22]
  assign mem_io_WbEnOut = mem_io_WbEnIn; // @[Mem.scala 51:20]
  assign mem_io_AddrOut = mem_io_AddrIn; // @[Mem.scala 52:20]
  assign mem_io_WriteRegAddrOut = mem_io_WriteRegAddrIn; // @[Mem.scala 56:28]
  assign mem_io_BrAddrOut = mem_io_BrAddrIn; // @[Mem.scala 48:22]
  assign mem_io_BrEnOut = mem_io_AluBrEn & mem_io_CtrlBrEn; // @[Mem.scala 54:38]
  assign ram_clock = clock;
  assign ram_ram_io_WriteEn = mem_io_WriteEn; // @[Mem.scala 44:24]
  assign ram_ram_io_ReadEn = mem_io_ReadEn; // @[Mem.scala 43:23]
  assign ram_ram_io_Addr = mem_io_AddrIn[9:0]; // @[Mem.scala 42:21]
  assign ram_ram_io_WriteData = mem_io_WriteData; // @[Mem.scala 45:26]
endmodule
module Writeback(
  input         wb_io_WbEnIn,
  input         wb_io_WbTypeIn,
  input  [31:0] wb_io_WriteRegAddrIn,
  input  [31:0] wb_io_ReadData,
  input  [31:0] wb_io_AddrData,
  output        wb_io_WbEnOut,
  output [31:0] wb_io_WriteRegAddrOut,
  output [31:0] wb_io_WriteDataOut
);
  assign wb_io_WbEnOut = wb_io_WbEnIn; // @[Writeback.scala 20:19]
  assign wb_io_WriteRegAddrOut = wb_io_WriteRegAddrIn; // @[Writeback.scala 21:27]
  assign wb_io_WriteDataOut = wb_io_WbTypeIn ? wb_io_ReadData : wb_io_AddrData; // @[Writeback.scala 22:30]
endmodule
module decoder7seg(
  input  [3:0] io_in,
  output [6:0] io_out
);
  wire [6:0] _GEN_0 = 4'hf == io_in ? 7'he : 7'h0; // @[decoder7seg.scala 14:17 30:29]
  wire [6:0] _GEN_1 = 4'he == io_in ? 7'h6 : _GEN_0; // @[decoder7seg.scala 14:17 29:29]
  wire [6:0] _GEN_2 = 4'hd == io_in ? 7'h21 : _GEN_1; // @[decoder7seg.scala 14:17 28:29]
  wire [6:0] _GEN_3 = 4'hc == io_in ? 7'h46 : _GEN_2; // @[decoder7seg.scala 14:17 27:29]
  wire [6:0] _GEN_4 = 4'hb == io_in ? 7'h3 : _GEN_3; // @[decoder7seg.scala 14:17 26:29]
  wire [6:0] _GEN_5 = 4'ha == io_in ? 7'h8 : _GEN_4; // @[decoder7seg.scala 14:17 25:29]
  wire [6:0] _GEN_6 = 4'h9 == io_in ? 7'h18 : _GEN_5; // @[decoder7seg.scala 14:17 24:29]
  wire [6:0] _GEN_7 = 4'h8 == io_in ? 7'h0 : _GEN_6; // @[decoder7seg.scala 14:17 23:29]
  wire [6:0] _GEN_8 = 4'h7 == io_in ? 7'h78 : _GEN_7; // @[decoder7seg.scala 14:17 22:29]
  wire [6:0] _GEN_9 = 4'h6 == io_in ? 7'h2 : _GEN_8; // @[decoder7seg.scala 14:17 21:29]
  wire [6:0] _GEN_10 = 4'h5 == io_in ? 7'h12 : _GEN_9; // @[decoder7seg.scala 14:17 20:29]
  wire [6:0] _GEN_11 = 4'h4 == io_in ? 7'h19 : _GEN_10; // @[decoder7seg.scala 14:17 19:29]
  wire [6:0] _GEN_12 = 4'h3 == io_in ? 7'h30 : _GEN_11; // @[decoder7seg.scala 14:17 18:29]
  wire [6:0] _GEN_13 = 4'h2 == io_in ? 7'h24 : _GEN_12; // @[decoder7seg.scala 14:17 17:29]
  wire [6:0] _GEN_14 = 4'h1 == io_in ? 7'h79 : _GEN_13; // @[decoder7seg.scala 14:17 16:29]
  assign io_out = 4'h0 == io_in ? 7'h40 : _GEN_14; // @[decoder7seg.scala 14:17 15:29]
endmodule
module Datapath(
  input         clock,
  input         reset,
  input  [7:0]  io_switches1,
  input  [7:0]  io_switches2,
  output [31:0] io_instr,
  output [6:0]  io_hex7,
  output [6:0]  io_hex6,
  output [6:0]  io_hex5,
  output [6:0]  io_hex4,
  output [6:0]  io_hex3,
  output [6:0]  io_hex2,
  output [6:0]  io_hex1,
  output [6:0]  io_hex0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
`endif // RANDOMIZE_REG_INIT
  wire  fetch_clock; // @[Datapath.scala 6:23]
  wire  fetch_reset; // @[Datapath.scala 6:23]
  wire [4:0] fetch_io_Stall; // @[Datapath.scala 6:23]
  wire [31:0] fetch_io_BranchAddr; // @[Datapath.scala 6:23]
  wire  fetch_io_BrEn; // @[Datapath.scala 6:23]
  wire [31:0] fetch_io_NextPC; // @[Datapath.scala 6:23]
  wire [31:0] fetch_io_Instr; // @[Datapath.scala 6:23]
  wire  decode_clock; // @[Datapath.scala 7:24]
  wire  decode_reset; // @[Datapath.scala 7:24]
  wire [31:0] decode_dec_io_Instr; // @[Datapath.scala 7:24]
  wire [31:0] decode_dec_io_WriteAddrIn; // @[Datapath.scala 7:24]
  wire  decode_dec_io_WriteEnIn; // @[Datapath.scala 7:24]
  wire [31:0] decode_dec_io_WriteDataIn; // @[Datapath.scala 7:24]
  wire [31:0] decode_dec_io_AluOp; // @[Datapath.scala 7:24]
  wire [31:0] decode_dec_io_Imm; // @[Datapath.scala 7:24]
  wire  decode_dec_io_ImmEn; // @[Datapath.scala 7:24]
  wire  decode_dec_io_BrEn; // @[Datapath.scala 7:24]
  wire  decode_dec_io_ReadEn; // @[Datapath.scala 7:24]
  wire  decode_dec_io_WriteEnOut; // @[Datapath.scala 7:24]
  wire  decode_dec_io_WbType; // @[Datapath.scala 7:24]
  wire  decode_dec_io_WbEn; // @[Datapath.scala 7:24]
  wire [5:0] decode_dec_io_rs; // @[Datapath.scala 7:24]
  wire [5:0] decode_dec_io_rt; // @[Datapath.scala 7:24]
  wire [5:0] decode_dec_io_rd; // @[Datapath.scala 7:24]
  wire [31:0] decode_dec_io_DataRead1; // @[Datapath.scala 7:24]
  wire [31:0] decode_dec_io_DataRead2; // @[Datapath.scala 7:24]
  wire [31:0] execute_exec_io_Imm; // @[Datapath.scala 8:25]
  wire [31:0] execute_exec_io_rs; // @[Datapath.scala 8:25]
  wire [31:0] execute_exec_io_rt; // @[Datapath.scala 8:25]
  wire [31:0] execute_exec_io_rd; // @[Datapath.scala 8:25]
  wire [31:0] execute_exec_io_DataRead1; // @[Datapath.scala 8:25]
  wire [31:0] execute_exec_io_DataRead2; // @[Datapath.scala 8:25]
  wire  execute_exec_io_MemWbEn; // @[Datapath.scala 8:25]
  wire [31:0] execute_exec_io_MemAddr; // @[Datapath.scala 8:25]
  wire [31:0] execute_exec_io_MemVal; // @[Datapath.scala 8:25]
  wire  execute_exec_io_WbWbEn; // @[Datapath.scala 8:25]
  wire [31:0] execute_exec_io_WbAddr; // @[Datapath.scala 8:25]
  wire [31:0] execute_exec_io_WbVal; // @[Datapath.scala 8:25]
  wire [3:0] execute_exec_io_AluOp; // @[Datapath.scala 8:25]
  wire  execute_exec_io_ImmEn; // @[Datapath.scala 8:25]
  wire  execute_exec_io_WriteEnIn; // @[Datapath.scala 8:25]
  wire  execute_exec_io_ReadEnIn; // @[Datapath.scala 8:25]
  wire  execute_exec_io_BrEnIn; // @[Datapath.scala 8:25]
  wire  execute_exec_io_WbEnIn; // @[Datapath.scala 8:25]
  wire  execute_exec_io_WbTypeIn; // @[Datapath.scala 8:25]
  wire [31:0] execute_exec_io_AluRes; // @[Datapath.scala 8:25]
  wire  execute_exec_io_zero; // @[Datapath.scala 8:25]
  wire [31:0] execute_exec_io_BranchAddrOut; // @[Datapath.scala 8:25]
  wire [31:0] execute_exec_io_WriteData; // @[Datapath.scala 8:25]
  wire  execute_exec_io_ReadEnOut; // @[Datapath.scala 8:25]
  wire  execute_exec_io_WriteEnOut; // @[Datapath.scala 8:25]
  wire  execute_exec_io_BrEnOut; // @[Datapath.scala 8:25]
  wire  execute_exec_io_WbTypeOut; // @[Datapath.scala 8:25]
  wire  execute_exec_io_WbEnOut; // @[Datapath.scala 8:25]
  wire [31:0] execute_exec_io_WriteRegAddr; // @[Datapath.scala 8:25]
  wire  memory_clock; // @[Datapath.scala 9:24]
  wire  memory_mem_io_WriteEn; // @[Datapath.scala 9:24]
  wire  memory_mem_io_ReadEn; // @[Datapath.scala 9:24]
  wire  memory_mem_io_CtrlBrEn; // @[Datapath.scala 9:24]
  wire  memory_mem_io_WbTypeIn; // @[Datapath.scala 9:24]
  wire  memory_mem_io_WbEnIn; // @[Datapath.scala 9:24]
  wire  memory_mem_io_AluBrEn; // @[Datapath.scala 9:24]
  wire [31:0] memory_mem_io_BrAddrIn; // @[Datapath.scala 9:24]
  wire [31:0] memory_mem_io_WriteRegAddrIn; // @[Datapath.scala 9:24]
  wire [31:0] memory_mem_io_WriteData; // @[Datapath.scala 9:24]
  wire [31:0] memory_mem_io_AddrIn; // @[Datapath.scala 9:24]
  wire [31:0] memory_mem_io_ReadData; // @[Datapath.scala 9:24]
  wire  memory_mem_io_WbTypeOut; // @[Datapath.scala 9:24]
  wire  memory_mem_io_WbEnOut; // @[Datapath.scala 9:24]
  wire [31:0] memory_mem_io_AddrOut; // @[Datapath.scala 9:24]
  wire [31:0] memory_mem_io_WriteRegAddrOut; // @[Datapath.scala 9:24]
  wire [31:0] memory_mem_io_BrAddrOut; // @[Datapath.scala 9:24]
  wire  memory_mem_io_BrEnOut; // @[Datapath.scala 9:24]
  wire  writeback_wb_io_WbEnIn; // @[Datapath.scala 10:27]
  wire  writeback_wb_io_WbTypeIn; // @[Datapath.scala 10:27]
  wire [31:0] writeback_wb_io_WriteRegAddrIn; // @[Datapath.scala 10:27]
  wire [31:0] writeback_wb_io_ReadData; // @[Datapath.scala 10:27]
  wire [31:0] writeback_wb_io_AddrData; // @[Datapath.scala 10:27]
  wire  writeback_wb_io_WbEnOut; // @[Datapath.scala 10:27]
  wire [31:0] writeback_wb_io_WriteRegAddrOut; // @[Datapath.scala 10:27]
  wire [31:0] writeback_wb_io_WriteDataOut; // @[Datapath.scala 10:27]
  wire [3:0] U_decoder7seg_7_io_in; // @[Datapath.scala 94:33]
  wire [6:0] U_decoder7seg_7_io_out; // @[Datapath.scala 94:33]
  wire [3:0] U_decoder7seg_6_io_in; // @[Datapath.scala 95:33]
  wire [6:0] U_decoder7seg_6_io_out; // @[Datapath.scala 95:33]
  wire [3:0] U_decoder7seg_5_io_in; // @[Datapath.scala 96:33]
  wire [6:0] U_decoder7seg_5_io_out; // @[Datapath.scala 96:33]
  wire [3:0] U_decoder7seg_4_io_in; // @[Datapath.scala 97:33]
  wire [6:0] U_decoder7seg_4_io_out; // @[Datapath.scala 97:33]
  wire [3:0] U_decoder7seg_3_io_in; // @[Datapath.scala 98:33]
  wire [6:0] U_decoder7seg_3_io_out; // @[Datapath.scala 98:33]
  wire [3:0] U_decoder7seg_2_io_in; // @[Datapath.scala 99:33]
  wire [6:0] U_decoder7seg_2_io_out; // @[Datapath.scala 99:33]
  wire [3:0] U_decoder7seg_1_io_in; // @[Datapath.scala 100:33]
  wire [6:0] U_decoder7seg_1_io_out; // @[Datapath.scala 100:33]
  wire [3:0] U_decoder7seg_0_io_in; // @[Datapath.scala 101:33]
  wire [6:0] U_decoder7seg_0_io_out; // @[Datapath.scala 101:33]
  reg [31:0] decode_dec_io_Instr_REG; // @[Datapath.scala 46:35]
  reg [5:0] execute_exec_io_rs_REG; // @[Datapath.scala 53:34]
  reg [5:0] execute_exec_io_rt_REG; // @[Datapath.scala 54:34]
  reg [5:0] execute_exec_io_rd_REG; // @[Datapath.scala 55:34]
  reg [31:0] execute_exec_io_DataRead1_REG; // @[Datapath.scala 56:41]
  reg [31:0] execute_exec_io_DataRead2_REG; // @[Datapath.scala 57:41]
  reg [31:0] execute_exec_io_MemVal_REG; // @[Datapath.scala 60:38]
  reg [31:0] execute_exec_io_AluOp_REG; // @[Datapath.scala 64:37]
  reg [31:0] execute_exec_io_Imm_REG; // @[Datapath.scala 65:35]
  reg  execute_exec_io_ImmEn_REG; // @[Datapath.scala 66:37]
  reg  execute_exec_io_BrEnIn_REG; // @[Datapath.scala 67:38]
  reg  execute_exec_io_ReadEnIn_REG; // @[Datapath.scala 69:40]
  reg  execute_exec_io_WriteEnIn_REG; // @[Datapath.scala 70:41]
  reg  execute_exec_io_WbTypeIn_REG; // @[Datapath.scala 71:40]
  reg  execute_exec_io_WbEnIn_REG; // @[Datapath.scala 72:38]
  reg  memory_mem_io_WriteEn_REG; // @[Datapath.scala 77:37]
  reg  memory_mem_io_WbEnIn_REG; // @[Datapath.scala 78:36]
  reg  memory_mem_io_WbTypeIn_REG; // @[Datapath.scala 79:38]
  reg [31:0] memory_mem_io_WriteData_REG; // @[Datapath.scala 80:39]
  reg  memory_mem_io_CtrlBrEn_REG; // @[Datapath.scala 81:38]
  reg  memory_mem_io_AluBrEn_REG; // @[Datapath.scala 82:37]
  reg [31:0] memory_mem_io_BrAddrIn_REG; // @[Datapath.scala 83:38]
  reg [31:0] memory_mem_io_WriteRegAddrIn_REG; // @[Datapath.scala 84:44]
  reg  writeback_wb_io_WbEnIn_REG; // @[Datapath.scala 87:38]
  reg  writeback_wb_io_WbTypeIn_REG; // @[Datapath.scala 88:40]
  reg [31:0] writeback_wb_io_AddrData_REG; // @[Datapath.scala 90:40]
  reg [31:0] writeback_wb_io_WriteRegAddrIn_REG; // @[Datapath.scala 91:46]
  wire [31:0] output_ = execute_exec_io_AluRes;
  Fetch fetch ( // @[Datapath.scala 6:23]
    .clock(fetch_clock),
    .reset(fetch_reset),
    .io_Stall(fetch_io_Stall),
    .io_BranchAddr(fetch_io_BranchAddr),
    .io_BrEn(fetch_io_BrEn),
    .io_NextPC(fetch_io_NextPC),
    .io_Instr(fetch_io_Instr)
  );
  Decode decode ( // @[Datapath.scala 7:24]
    .clock(decode_clock),
    .reset(decode_reset),
    .dec_io_Instr(decode_dec_io_Instr),
    .dec_io_WriteAddrIn(decode_dec_io_WriteAddrIn),
    .dec_io_WriteEnIn(decode_dec_io_WriteEnIn),
    .dec_io_WriteDataIn(decode_dec_io_WriteDataIn),
    .dec_io_AluOp(decode_dec_io_AluOp),
    .dec_io_Imm(decode_dec_io_Imm),
    .dec_io_ImmEn(decode_dec_io_ImmEn),
    .dec_io_BrEn(decode_dec_io_BrEn),
    .dec_io_ReadEn(decode_dec_io_ReadEn),
    .dec_io_WriteEnOut(decode_dec_io_WriteEnOut),
    .dec_io_WbType(decode_dec_io_WbType),
    .dec_io_WbEn(decode_dec_io_WbEn),
    .dec_io_rs(decode_dec_io_rs),
    .dec_io_rt(decode_dec_io_rt),
    .dec_io_rd(decode_dec_io_rd),
    .dec_io_DataRead1(decode_dec_io_DataRead1),
    .dec_io_DataRead2(decode_dec_io_DataRead2)
  );
  Execute execute ( // @[Datapath.scala 8:25]
    .exec_io_Imm(execute_exec_io_Imm),
    .exec_io_rs(execute_exec_io_rs),
    .exec_io_rt(execute_exec_io_rt),
    .exec_io_rd(execute_exec_io_rd),
    .exec_io_DataRead1(execute_exec_io_DataRead1),
    .exec_io_DataRead2(execute_exec_io_DataRead2),
    .exec_io_MemWbEn(execute_exec_io_MemWbEn),
    .exec_io_MemAddr(execute_exec_io_MemAddr),
    .exec_io_MemVal(execute_exec_io_MemVal),
    .exec_io_WbWbEn(execute_exec_io_WbWbEn),
    .exec_io_WbAddr(execute_exec_io_WbAddr),
    .exec_io_WbVal(execute_exec_io_WbVal),
    .exec_io_AluOp(execute_exec_io_AluOp),
    .exec_io_ImmEn(execute_exec_io_ImmEn),
    .exec_io_WriteEnIn(execute_exec_io_WriteEnIn),
    .exec_io_ReadEnIn(execute_exec_io_ReadEnIn),
    .exec_io_BrEnIn(execute_exec_io_BrEnIn),
    .exec_io_WbEnIn(execute_exec_io_WbEnIn),
    .exec_io_WbTypeIn(execute_exec_io_WbTypeIn),
    .exec_io_AluRes(execute_exec_io_AluRes),
    .exec_io_zero(execute_exec_io_zero),
    .exec_io_BranchAddrOut(execute_exec_io_BranchAddrOut),
    .exec_io_WriteData(execute_exec_io_WriteData),
    .exec_io_ReadEnOut(execute_exec_io_ReadEnOut),
    .exec_io_WriteEnOut(execute_exec_io_WriteEnOut),
    .exec_io_BrEnOut(execute_exec_io_BrEnOut),
    .exec_io_WbTypeOut(execute_exec_io_WbTypeOut),
    .exec_io_WbEnOut(execute_exec_io_WbEnOut),
    .exec_io_WriteRegAddr(execute_exec_io_WriteRegAddr)
  );
  Mem memory ( // @[Datapath.scala 9:24]
    .clock(memory_clock),
    .mem_io_WriteEn(memory_mem_io_WriteEn),
    .mem_io_ReadEn(memory_mem_io_ReadEn),
    .mem_io_CtrlBrEn(memory_mem_io_CtrlBrEn),
    .mem_io_WbTypeIn(memory_mem_io_WbTypeIn),
    .mem_io_WbEnIn(memory_mem_io_WbEnIn),
    .mem_io_AluBrEn(memory_mem_io_AluBrEn),
    .mem_io_BrAddrIn(memory_mem_io_BrAddrIn),
    .mem_io_WriteRegAddrIn(memory_mem_io_WriteRegAddrIn),
    .mem_io_WriteData(memory_mem_io_WriteData),
    .mem_io_AddrIn(memory_mem_io_AddrIn),
    .mem_io_ReadData(memory_mem_io_ReadData),
    .mem_io_WbTypeOut(memory_mem_io_WbTypeOut),
    .mem_io_WbEnOut(memory_mem_io_WbEnOut),
    .mem_io_AddrOut(memory_mem_io_AddrOut),
    .mem_io_WriteRegAddrOut(memory_mem_io_WriteRegAddrOut),
    .mem_io_BrAddrOut(memory_mem_io_BrAddrOut),
    .mem_io_BrEnOut(memory_mem_io_BrEnOut)
  );
  Writeback writeback ( // @[Datapath.scala 10:27]
    .wb_io_WbEnIn(writeback_wb_io_WbEnIn),
    .wb_io_WbTypeIn(writeback_wb_io_WbTypeIn),
    .wb_io_WriteRegAddrIn(writeback_wb_io_WriteRegAddrIn),
    .wb_io_ReadData(writeback_wb_io_ReadData),
    .wb_io_AddrData(writeback_wb_io_AddrData),
    .wb_io_WbEnOut(writeback_wb_io_WbEnOut),
    .wb_io_WriteRegAddrOut(writeback_wb_io_WriteRegAddrOut),
    .wb_io_WriteDataOut(writeback_wb_io_WriteDataOut)
  );
  decoder7seg U_decoder7seg_7 ( // @[Datapath.scala 94:33]
    .io_in(U_decoder7seg_7_io_in),
    .io_out(U_decoder7seg_7_io_out)
  );
  decoder7seg U_decoder7seg_6 ( // @[Datapath.scala 95:33]
    .io_in(U_decoder7seg_6_io_in),
    .io_out(U_decoder7seg_6_io_out)
  );
  decoder7seg U_decoder7seg_5 ( // @[Datapath.scala 96:33]
    .io_in(U_decoder7seg_5_io_in),
    .io_out(U_decoder7seg_5_io_out)
  );
  decoder7seg U_decoder7seg_4 ( // @[Datapath.scala 97:33]
    .io_in(U_decoder7seg_4_io_in),
    .io_out(U_decoder7seg_4_io_out)
  );
  decoder7seg U_decoder7seg_3 ( // @[Datapath.scala 98:33]
    .io_in(U_decoder7seg_3_io_in),
    .io_out(U_decoder7seg_3_io_out)
  );
  decoder7seg U_decoder7seg_2 ( // @[Datapath.scala 99:33]
    .io_in(U_decoder7seg_2_io_in),
    .io_out(U_decoder7seg_2_io_out)
  );
  decoder7seg U_decoder7seg_1 ( // @[Datapath.scala 100:33]
    .io_in(U_decoder7seg_1_io_in),
    .io_out(U_decoder7seg_1_io_out)
  );
  decoder7seg U_decoder7seg_0 ( // @[Datapath.scala 101:33]
    .io_in(U_decoder7seg_0_io_in),
    .io_out(U_decoder7seg_0_io_out)
  );
  assign io_instr = fetch_io_Instr; // @[Datapath.scala 38:14]
  assign io_hex7 = U_decoder7seg_7_io_out; // @[Datapath.scala 113:13]
  assign io_hex6 = U_decoder7seg_6_io_out; // @[Datapath.scala 114:13]
  assign io_hex5 = U_decoder7seg_5_io_out; // @[Datapath.scala 115:13]
  assign io_hex4 = U_decoder7seg_4_io_out; // @[Datapath.scala 116:13]
  assign io_hex3 = U_decoder7seg_3_io_out; // @[Datapath.scala 117:13]
  assign io_hex2 = U_decoder7seg_2_io_out; // @[Datapath.scala 118:13]
  assign io_hex1 = U_decoder7seg_1_io_out; // @[Datapath.scala 119:13]
  assign io_hex0 = U_decoder7seg_0_io_out; // @[Datapath.scala 120:13]
  assign fetch_clock = clock;
  assign fetch_reset = reset;
  assign fetch_io_Stall = {{4'd0}, decode_dec_io_BrEn}; // @[Datapath.scala 41:20]
  assign fetch_io_BranchAddr = memory_mem_io_BrAddrOut; // @[Datapath.scala 43:25]
  assign fetch_io_BrEn = memory_mem_io_BrEnOut; // @[Datapath.scala 42:19]
  assign decode_clock = clock;
  assign decode_reset = reset;
  assign decode_dec_io_Instr = decode_dec_io_Instr_REG; // @[Datapath.scala 46:25]
  assign decode_dec_io_WriteAddrIn = writeback_wb_io_WriteRegAddrOut; // @[Datapath.scala 49:31]
  assign decode_dec_io_WriteEnIn = writeback_wb_io_WbEnOut; // @[Datapath.scala 48:29]
  assign decode_dec_io_WriteDataIn = writeback_wb_io_WriteDataOut; // @[Datapath.scala 50:31]
  assign execute_exec_io_Imm = execute_exec_io_Imm_REG; // @[Datapath.scala 65:25]
  assign execute_exec_io_rs = {{26'd0}, execute_exec_io_rs_REG}; // @[Datapath.scala 53:24]
  assign execute_exec_io_rt = {{26'd0}, execute_exec_io_rt_REG}; // @[Datapath.scala 54:24]
  assign execute_exec_io_rd = {{26'd0}, execute_exec_io_rd_REG}; // @[Datapath.scala 55:24]
  assign execute_exec_io_DataRead1 = execute_exec_io_DataRead1_REG; // @[Datapath.scala 56:31]
  assign execute_exec_io_DataRead2 = execute_exec_io_DataRead2_REG; // @[Datapath.scala 57:31]
  assign execute_exec_io_MemWbEn = memory_mem_io_WbEnOut; // @[Datapath.scala 58:29]
  assign execute_exec_io_MemAddr = memory_mem_io_WriteRegAddrOut; // @[Datapath.scala 59:29]
  assign execute_exec_io_MemVal = execute_exec_io_MemVal_REG; // @[Datapath.scala 60:28]
  assign execute_exec_io_WbWbEn = writeback_wb_io_WbEnOut; // @[Datapath.scala 61:28]
  assign execute_exec_io_WbAddr = writeback_wb_io_WriteRegAddrOut; // @[Datapath.scala 62:28]
  assign execute_exec_io_WbVal = writeback_wb_io_WriteDataOut; // @[Datapath.scala 63:27]
  assign execute_exec_io_AluOp = execute_exec_io_AluOp_REG[3:0]; // @[Datapath.scala 64:27]
  assign execute_exec_io_ImmEn = execute_exec_io_ImmEn_REG; // @[Datapath.scala 66:27]
  assign execute_exec_io_WriteEnIn = execute_exec_io_WriteEnIn_REG; // @[Datapath.scala 70:31]
  assign execute_exec_io_ReadEnIn = execute_exec_io_ReadEnIn_REG; // @[Datapath.scala 69:30]
  assign execute_exec_io_BrEnIn = execute_exec_io_BrEnIn_REG; // @[Datapath.scala 67:28]
  assign execute_exec_io_WbEnIn = execute_exec_io_WbEnIn_REG; // @[Datapath.scala 72:28]
  assign execute_exec_io_WbTypeIn = execute_exec_io_WbTypeIn_REG; // @[Datapath.scala 71:30]
  assign memory_clock = clock;
  assign memory_mem_io_WriteEn = memory_mem_io_WriteEn_REG; // @[Datapath.scala 77:27]
  assign memory_mem_io_ReadEn = execute_exec_io_ReadEnOut; // @[Datapath.scala 75:26]
  assign memory_mem_io_CtrlBrEn = memory_mem_io_CtrlBrEn_REG; // @[Datapath.scala 81:28]
  assign memory_mem_io_WbTypeIn = memory_mem_io_WbTypeIn_REG; // @[Datapath.scala 79:28]
  assign memory_mem_io_WbEnIn = memory_mem_io_WbEnIn_REG; // @[Datapath.scala 78:26]
  assign memory_mem_io_AluBrEn = memory_mem_io_AluBrEn_REG; // @[Datapath.scala 82:27]
  assign memory_mem_io_BrAddrIn = memory_mem_io_BrAddrIn_REG; // @[Datapath.scala 83:28]
  assign memory_mem_io_WriteRegAddrIn = memory_mem_io_WriteRegAddrIn_REG; // @[Datapath.scala 84:34]
  assign memory_mem_io_WriteData = memory_mem_io_WriteData_REG; // @[Datapath.scala 80:29]
  assign memory_mem_io_AddrIn = execute_exec_io_AluRes; // @[Datapath.scala 76:26]
  assign writeback_wb_io_WbEnIn = writeback_wb_io_WbEnIn_REG; // @[Datapath.scala 87:28]
  assign writeback_wb_io_WbTypeIn = writeback_wb_io_WbTypeIn_REG; // @[Datapath.scala 88:30]
  assign writeback_wb_io_WriteRegAddrIn = writeback_wb_io_WriteRegAddrIn_REG; // @[Datapath.scala 91:36]
  assign writeback_wb_io_ReadData = memory_mem_io_ReadData; // @[Datapath.scala 89:30]
  assign writeback_wb_io_AddrData = writeback_wb_io_AddrData_REG; // @[Datapath.scala 90:30]
  assign U_decoder7seg_7_io_in = io_switches1[7:4]; // @[Datapath.scala 103:36]
  assign U_decoder7seg_6_io_in = io_switches1[3:0]; // @[Datapath.scala 104:36]
  assign U_decoder7seg_5_io_in = io_switches2[7:4]; // @[Datapath.scala 105:36]
  assign U_decoder7seg_4_io_in = io_switches2[3:0]; // @[Datapath.scala 106:36]
  assign U_decoder7seg_3_io_in = output_[15:12]; // @[Datapath.scala 108:36]
  assign U_decoder7seg_2_io_in = output_[11:8]; // @[Datapath.scala 109:36]
  assign U_decoder7seg_1_io_in = output_[7:4]; // @[Datapath.scala 110:36]
  assign U_decoder7seg_0_io_in = output_[3:0]; // @[Datapath.scala 111:36]
  always @(posedge clock) begin
    decode_dec_io_Instr_REG <= fetch_io_Instr; // @[Datapath.scala 46:35]
    execute_exec_io_rs_REG <= decode_dec_io_rs; // @[Datapath.scala 53:34]
    execute_exec_io_rt_REG <= decode_dec_io_rt; // @[Datapath.scala 54:34]
    execute_exec_io_rd_REG <= decode_dec_io_rd; // @[Datapath.scala 55:34]
    execute_exec_io_DataRead1_REG <= decode_dec_io_DataRead1; // @[Datapath.scala 56:41]
    execute_exec_io_DataRead2_REG <= decode_dec_io_DataRead2; // @[Datapath.scala 57:41]
    execute_exec_io_MemVal_REG <= execute_exec_io_AluRes; // @[Datapath.scala 60:38]
    execute_exec_io_AluOp_REG <= decode_dec_io_AluOp; // @[Datapath.scala 64:37]
    execute_exec_io_Imm_REG <= decode_dec_io_Imm; // @[Datapath.scala 65:35]
    execute_exec_io_ImmEn_REG <= decode_dec_io_ImmEn; // @[Datapath.scala 66:37]
    execute_exec_io_BrEnIn_REG <= decode_dec_io_BrEn; // @[Datapath.scala 67:38]
    execute_exec_io_ReadEnIn_REG <= decode_dec_io_ReadEn; // @[Datapath.scala 69:40]
    execute_exec_io_WriteEnIn_REG <= decode_dec_io_WriteEnOut; // @[Datapath.scala 70:41]
    execute_exec_io_WbTypeIn_REG <= decode_dec_io_WbType; // @[Datapath.scala 71:40]
    execute_exec_io_WbEnIn_REG <= decode_dec_io_WbEn; // @[Datapath.scala 72:38]
    memory_mem_io_WriteEn_REG <= execute_exec_io_WriteEnOut; // @[Datapath.scala 77:37]
    memory_mem_io_WbEnIn_REG <= execute_exec_io_WbEnOut; // @[Datapath.scala 78:36]
    memory_mem_io_WbTypeIn_REG <= execute_exec_io_WbTypeOut; // @[Datapath.scala 79:38]
    memory_mem_io_WriteData_REG <= execute_exec_io_WriteData; // @[Datapath.scala 80:39]
    memory_mem_io_CtrlBrEn_REG <= execute_exec_io_BrEnOut; // @[Datapath.scala 81:38]
    memory_mem_io_AluBrEn_REG <= execute_exec_io_zero; // @[Datapath.scala 82:37]
    memory_mem_io_BrAddrIn_REG <= execute_exec_io_BranchAddrOut; // @[Datapath.scala 83:38]
    memory_mem_io_WriteRegAddrIn_REG <= execute_exec_io_WriteRegAddr; // @[Datapath.scala 84:44]
    writeback_wb_io_WbEnIn_REG <= memory_mem_io_WbEnOut; // @[Datapath.scala 87:38]
    writeback_wb_io_WbTypeIn_REG <= memory_mem_io_WbTypeOut; // @[Datapath.scala 88:40]
    writeback_wb_io_AddrData_REG <= memory_mem_io_AddrOut; // @[Datapath.scala 90:40]
    writeback_wb_io_WriteRegAddrIn_REG <= memory_mem_io_WriteRegAddrOut; // @[Datapath.scala 91:46]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decode_dec_io_Instr_REG = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  execute_exec_io_rs_REG = _RAND_1[5:0];
  _RAND_2 = {1{`RANDOM}};
  execute_exec_io_rt_REG = _RAND_2[5:0];
  _RAND_3 = {1{`RANDOM}};
  execute_exec_io_rd_REG = _RAND_3[5:0];
  _RAND_4 = {1{`RANDOM}};
  execute_exec_io_DataRead1_REG = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  execute_exec_io_DataRead2_REG = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  execute_exec_io_MemVal_REG = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  execute_exec_io_AluOp_REG = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  execute_exec_io_Imm_REG = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  execute_exec_io_ImmEn_REG = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  execute_exec_io_BrEnIn_REG = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  execute_exec_io_ReadEnIn_REG = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  execute_exec_io_WriteEnIn_REG = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  execute_exec_io_WbTypeIn_REG = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  execute_exec_io_WbEnIn_REG = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  memory_mem_io_WriteEn_REG = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  memory_mem_io_WbEnIn_REG = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  memory_mem_io_WbTypeIn_REG = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  memory_mem_io_WriteData_REG = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  memory_mem_io_CtrlBrEn_REG = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  memory_mem_io_AluBrEn_REG = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  memory_mem_io_BrAddrIn_REG = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  memory_mem_io_WriteRegAddrIn_REG = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  writeback_wb_io_WbEnIn_REG = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  writeback_wb_io_WbTypeIn_REG = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  writeback_wb_io_AddrData_REG = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  writeback_wb_io_WriteRegAddrIn_REG = _RAND_26[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule