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
module Tx(
  input        clock,
  input        reset,
  output       io_txd,
  output       io_channel_ready,
  input        io_channel_valid,
  input  [7:0] io_channel_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] shiftReg; // @[Uart.scala 29:25]
  reg [19:0] cntReg; // @[Uart.scala 30:23]
  reg [3:0] bitsReg; // @[Uart.scala 31:24]
  wire  _io_channel_ready_T = cntReg == 20'h0; // @[Uart.scala 33:31]
  wire [9:0] shift = shiftReg[10:1]; // @[Uart.scala 40:28]
  wire [10:0] _shiftReg_T_1 = {1'h1,shift}; // @[Cat.scala 31:58]
  wire [3:0] _bitsReg_T_1 = bitsReg - 4'h1; // @[Uart.scala 42:26]
  wire [10:0] _shiftReg_T_3 = {2'h3,io_channel_bits,1'h0}; // @[Cat.scala 31:58]
  wire [19:0] _cntReg_T_1 = cntReg - 20'h1; // @[Uart.scala 53:22]
  assign io_txd = shiftReg[0]; // @[Uart.scala 34:21]
  assign io_channel_ready = cntReg == 20'h0 & bitsReg == 4'h0; // @[Uart.scala 33:40]
  always @(posedge clock) begin
    if (reset) begin // @[Uart.scala 29:25]
      shiftReg <= 11'h7ff; // @[Uart.scala 29:25]
    end else if (_io_channel_ready_T) begin // @[Uart.scala 36:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 39:27]
        shiftReg <= _shiftReg_T_1; // @[Uart.scala 41:16]
      end else if (io_channel_valid) begin // @[Uart.scala 44:30]
        shiftReg <= _shiftReg_T_3; // @[Uart.scala 45:18]
      end else begin
        shiftReg <= 11'h7ff; // @[Uart.scala 48:18]
      end
    end
    if (reset) begin // @[Uart.scala 30:23]
      cntReg <= 20'h0; // @[Uart.scala 30:23]
    end else if (_io_channel_ready_T) begin // @[Uart.scala 36:24]
      cntReg <= 20'h1b1; // @[Uart.scala 38:12]
    end else begin
      cntReg <= _cntReg_T_1; // @[Uart.scala 53:12]
    end
    if (reset) begin // @[Uart.scala 31:24]
      bitsReg <= 4'h0; // @[Uart.scala 31:24]
    end else if (_io_channel_ready_T) begin // @[Uart.scala 36:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 39:27]
        bitsReg <= _bitsReg_T_1; // @[Uart.scala 42:15]
      end else if (io_channel_valid) begin // @[Uart.scala 44:30]
        bitsReg <= 4'hb; // @[Uart.scala 46:17]
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
  shiftReg = _RAND_0[10:0];
  _RAND_1 = {1{`RANDOM}};
  cntReg = _RAND_1[19:0];
  _RAND_2 = {1{`RANDOM}};
  bitsReg = _RAND_2[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Buffer(
  input        clock,
  input        reset,
  output       io_in_ready,
  input        io_in_valid,
  input  [7:0] io_in_bits,
  input        io_out_ready,
  output       io_out_valid,
  output [7:0] io_out_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  stateReg; // @[Uart.scala 115:25]
  reg [7:0] dataReg; // @[Uart.scala 116:24]
  wire  _io_in_ready_T = ~stateReg; // @[Uart.scala 118:27]
  wire  _GEN_1 = io_in_valid | stateReg; // @[Uart.scala 122:23 124:16 115:25]
  assign io_in_ready = ~stateReg; // @[Uart.scala 118:27]
  assign io_out_valid = stateReg; // @[Uart.scala 119:28]
  assign io_out_bits = dataReg; // @[Uart.scala 131:15]
  always @(posedge clock) begin
    if (reset) begin // @[Uart.scala 115:25]
      stateReg <= 1'h0; // @[Uart.scala 115:25]
    end else if (_io_in_ready_T) begin // @[Uart.scala 121:28]
      stateReg <= _GEN_1;
    end else if (io_out_ready) begin // @[Uart.scala 127:24]
      stateReg <= 1'h0; // @[Uart.scala 128:16]
    end
    if (reset) begin // @[Uart.scala 116:24]
      dataReg <= 8'h0; // @[Uart.scala 116:24]
    end else if (_io_in_ready_T) begin // @[Uart.scala 121:28]
      if (io_in_valid) begin // @[Uart.scala 122:23]
        dataReg <= io_in_bits; // @[Uart.scala 123:15]
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
  stateReg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  dataReg = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BufferedTx(
  input        clock,
  input        reset,
  output       io_txd,
  output       io_channel_ready,
  input        io_channel_valid,
  input  [7:0] io_channel_bits
);
  wire  tx_clock; // @[Uart.scala 142:18]
  wire  tx_reset; // @[Uart.scala 142:18]
  wire  tx_io_txd; // @[Uart.scala 142:18]
  wire  tx_io_channel_ready; // @[Uart.scala 142:18]
  wire  tx_io_channel_valid; // @[Uart.scala 142:18]
  wire [7:0] tx_io_channel_bits; // @[Uart.scala 142:18]
  wire  buf__clock; // @[Uart.scala 143:19]
  wire  buf__reset; // @[Uart.scala 143:19]
  wire  buf__io_in_ready; // @[Uart.scala 143:19]
  wire  buf__io_in_valid; // @[Uart.scala 143:19]
  wire [7:0] buf__io_in_bits; // @[Uart.scala 143:19]
  wire  buf__io_out_ready; // @[Uart.scala 143:19]
  wire  buf__io_out_valid; // @[Uart.scala 143:19]
  wire [7:0] buf__io_out_bits; // @[Uart.scala 143:19]
  Tx tx ( // @[Uart.scala 142:18]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_txd(tx_io_txd),
    .io_channel_ready(tx_io_channel_ready),
    .io_channel_valid(tx_io_channel_valid),
    .io_channel_bits(tx_io_channel_bits)
  );
  Buffer buf_ ( // @[Uart.scala 143:19]
    .clock(buf__clock),
    .reset(buf__reset),
    .io_in_ready(buf__io_in_ready),
    .io_in_valid(buf__io_in_valid),
    .io_in_bits(buf__io_in_bits),
    .io_out_ready(buf__io_out_ready),
    .io_out_valid(buf__io_out_valid),
    .io_out_bits(buf__io_out_bits)
  );
  assign io_txd = tx_io_txd; // @[Uart.scala 147:10]
  assign io_channel_ready = buf__io_in_ready; // @[Uart.scala 145:13]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_channel_valid = buf__io_out_valid; // @[Uart.scala 146:17]
  assign tx_io_channel_bits = buf__io_out_bits; // @[Uart.scala 146:17]
  assign buf__clock = clock;
  assign buf__reset = reset;
  assign buf__io_in_valid = io_channel_valid; // @[Uart.scala 145:13]
  assign buf__io_in_bits = io_channel_bits; // @[Uart.scala 145:13]
  assign buf__io_out_ready = tx_io_channel_ready; // @[Uart.scala 146:17]
endmodule
module temp(
  input         clock,
  input         reset,
  input  [17:0] io_SW,
  output        io_txd_instr,
  output [6:0]  io_hex7,
  output [6:0]  io_hex6,
  output [6:0]  io_hex5,
  output [6:0]  io_hex4,
  output [6:0]  io_hex3,
  output [6:0]  io_hex2,
  output [6:0]  io_hex1,
  output [6:0]  io_hex0,
  output [17:0] io_LEDR,
  output [7:0]  io_LEDG,
  input  [3:0]  io_KEY
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [3:0] U_decoder7seg_7_io_in; // @[temp.scala 55:31]
  wire [6:0] U_decoder7seg_7_io_out; // @[temp.scala 55:31]
  wire [3:0] U_decoder7seg_6_io_in; // @[temp.scala 56:31]
  wire [6:0] U_decoder7seg_6_io_out; // @[temp.scala 56:31]
  wire [3:0] U_decoder7seg_5_io_in; // @[temp.scala 57:31]
  wire [6:0] U_decoder7seg_5_io_out; // @[temp.scala 57:31]
  wire [3:0] U_decoder7seg_4_io_in; // @[temp.scala 58:31]
  wire [6:0] U_decoder7seg_4_io_out; // @[temp.scala 58:31]
  wire [3:0] U_decoder7seg_3_io_in; // @[temp.scala 59:31]
  wire [6:0] U_decoder7seg_3_io_out; // @[temp.scala 59:31]
  wire [3:0] U_decoder7seg_2_io_in; // @[temp.scala 60:31]
  wire [6:0] U_decoder7seg_2_io_out; // @[temp.scala 60:31]
  wire [3:0] U_decoder7seg_1_io_in; // @[temp.scala 61:31]
  wire [6:0] U_decoder7seg_1_io_out; // @[temp.scala 61:31]
  wire [3:0] U_decoder7seg_0_io_in; // @[temp.scala 62:31]
  wire [6:0] U_decoder7seg_0_io_out; // @[temp.scala 62:31]
  wire  tx_clock; // @[temp.scala 84:18]
  wire  tx_reset; // @[temp.scala 84:18]
  wire  tx_io_txd; // @[temp.scala 84:18]
  wire  tx_io_channel_ready; // @[temp.scala 84:18]
  wire  tx_io_channel_valid; // @[temp.scala 84:18]
  wire [7:0] tx_io_channel_bits; // @[temp.scala 84:18]
  wire [7:0] Inport1 = io_SW[7:0]; // @[temp.scala 43:23]
  wire [7:0] Inport2 = io_SW[15:8]; // @[temp.scala 44:23]
  wire [7:0] _Outport_T_1 = Inport1 + Inport2; // @[temp.scala 51:22]
  wire [15:0] Outport = {{8'd0}, _Outport_T_1};
  reg [7:0] cntReg2; // @[temp.scala 98:24]
  wire [5:0] _GEN_1 = 4'h1 == cntReg2[3:0] ? 6'h31 : 6'h30; // @[temp.scala 100:{22,22}]
  wire [5:0] _GEN_2 = 4'h2 == cntReg2[3:0] ? 6'h32 : _GEN_1; // @[temp.scala 100:{22,22}]
  wire [5:0] _GEN_3 = 4'h3 == cntReg2[3:0] ? 6'h33 : _GEN_2; // @[temp.scala 100:{22,22}]
  wire [5:0] _GEN_4 = 4'h4 == cntReg2[3:0] ? 6'h34 : _GEN_3; // @[temp.scala 100:{22,22}]
  wire [5:0] _GEN_5 = 4'h5 == cntReg2[3:0] ? 6'h35 : _GEN_4; // @[temp.scala 100:{22,22}]
  wire [5:0] _GEN_6 = 4'h6 == cntReg2[3:0] ? 6'h36 : _GEN_5; // @[temp.scala 100:{22,22}]
  wire [5:0] _GEN_7 = 4'h7 == cntReg2[3:0] ? 6'h37 : _GEN_6; // @[temp.scala 100:{22,22}]
  wire [5:0] _GEN_8 = 4'h8 == cntReg2[3:0] ? 6'h38 : _GEN_7; // @[temp.scala 100:{22,22}]
  wire [5:0] _GEN_9 = 4'h9 == cntReg2[3:0] ? 6'h39 : _GEN_8; // @[temp.scala 100:{22,22}]
  wire [5:0] _GEN_10 = 4'ha == cntReg2[3:0] ? 6'h20 : _GEN_9; // @[temp.scala 100:{22,22}]
  wire  _tx_io_channel_valid_T = cntReg2 != 8'hb; // @[temp.scala 101:34]
  wire [7:0] _cntReg2_T_1 = cntReg2 + 8'h1; // @[temp.scala 106:24]
  wire [3:0] _LEDG_T = ~io_KEY; // @[temp.scala 114:24]
  decoder7seg U_decoder7seg_7 ( // @[temp.scala 55:31]
    .io_in(U_decoder7seg_7_io_in),
    .io_out(U_decoder7seg_7_io_out)
  );
  decoder7seg U_decoder7seg_6 ( // @[temp.scala 56:31]
    .io_in(U_decoder7seg_6_io_in),
    .io_out(U_decoder7seg_6_io_out)
  );
  decoder7seg U_decoder7seg_5 ( // @[temp.scala 57:31]
    .io_in(U_decoder7seg_5_io_in),
    .io_out(U_decoder7seg_5_io_out)
  );
  decoder7seg U_decoder7seg_4 ( // @[temp.scala 58:31]
    .io_in(U_decoder7seg_4_io_in),
    .io_out(U_decoder7seg_4_io_out)
  );
  decoder7seg U_decoder7seg_3 ( // @[temp.scala 59:31]
    .io_in(U_decoder7seg_3_io_in),
    .io_out(U_decoder7seg_3_io_out)
  );
  decoder7seg U_decoder7seg_2 ( // @[temp.scala 60:31]
    .io_in(U_decoder7seg_2_io_in),
    .io_out(U_decoder7seg_2_io_out)
  );
  decoder7seg U_decoder7seg_1 ( // @[temp.scala 61:31]
    .io_in(U_decoder7seg_1_io_in),
    .io_out(U_decoder7seg_1_io_out)
  );
  decoder7seg U_decoder7seg_0 ( // @[temp.scala 62:31]
    .io_in(U_decoder7seg_0_io_in),
    .io_out(U_decoder7seg_0_io_out)
  );
  BufferedTx tx ( // @[temp.scala 84:18]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_txd(tx_io_txd),
    .io_channel_ready(tx_io_channel_ready),
    .io_channel_valid(tx_io_channel_valid),
    .io_channel_bits(tx_io_channel_bits)
  );
  assign io_txd_instr = tx_io_txd; // @[temp.scala 85:16]
  assign io_hex7 = U_decoder7seg_7_io_out; // @[temp.scala 74:11]
  assign io_hex6 = U_decoder7seg_6_io_out; // @[temp.scala 75:11]
  assign io_hex5 = U_decoder7seg_5_io_out; // @[temp.scala 76:11]
  assign io_hex4 = U_decoder7seg_4_io_out; // @[temp.scala 77:11]
  assign io_hex3 = U_decoder7seg_3_io_out; // @[temp.scala 78:11]
  assign io_hex2 = U_decoder7seg_2_io_out; // @[temp.scala 79:11]
  assign io_hex1 = U_decoder7seg_1_io_out; // @[temp.scala 80:11]
  assign io_hex0 = U_decoder7seg_0_io_out; // @[temp.scala 81:11]
  assign io_LEDR = io_SW; // @[temp.scala 113:17]
  assign io_LEDG = {_LEDG_T,_LEDG_T}; // @[Cat.scala 31:58]
  assign U_decoder7seg_7_io_in = Inport1[7:4]; // @[temp.scala 64:35]
  assign U_decoder7seg_6_io_in = Inport1[3:0]; // @[temp.scala 65:35]
  assign U_decoder7seg_5_io_in = Inport2[7:4]; // @[temp.scala 66:35]
  assign U_decoder7seg_4_io_in = Inport2[3:0]; // @[temp.scala 67:35]
  assign U_decoder7seg_3_io_in = Outport[15:12]; // @[temp.scala 69:35]
  assign U_decoder7seg_2_io_in = Outport[11:8]; // @[temp.scala 70:35]
  assign U_decoder7seg_1_io_in = Outport[7:4]; // @[temp.scala 71:35]
  assign U_decoder7seg_0_io_in = Outport[3:0]; // @[temp.scala 72:35]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_channel_valid = cntReg2 != 8'hb; // @[temp.scala 101:34]
  assign tx_io_channel_bits = {{2'd0}, _GEN_10}; // @[temp.scala 100:22]
  always @(posedge clock) begin
    if (reset) begin // @[temp.scala 98:24]
      cntReg2 <= 8'h0; // @[temp.scala 98:24]
    end else if (tx_io_channel_ready & _tx_io_channel_valid_T) begin // @[temp.scala 105:48]
      cntReg2 <= _cntReg2_T_1; // @[temp.scala 106:13]
    end else if (cntReg2 == 8'hb) begin // @[temp.scala 107:31]
      cntReg2 <= 8'h0; // @[temp.scala 108:13]
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
  cntReg2 = _RAND_0[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
