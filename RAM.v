module RAM(
  input         clock,
  input         reset,
  input         io_WriteEn,
  input         io_ReadEn,
  input  [9:0]  io_Addr,
  input  [31:0] io_WriteData,
  output [31:0] io_ReadData
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:1023]; // @[RAM.scala 15:26]
  wire  mem_ReadMem_MPORT_en; // @[RAM.scala 15:26]
  wire [9:0] mem_ReadMem_MPORT_addr; // @[RAM.scala 15:26]
  wire [31:0] mem_ReadMem_MPORT_data; // @[RAM.scala 15:26]
  wire [31:0] mem_MPORT_data; // @[RAM.scala 15:26]
  wire [9:0] mem_MPORT_addr; // @[RAM.scala 15:26]
  wire  mem_MPORT_mask; // @[RAM.scala 15:26]
  wire  mem_MPORT_en; // @[RAM.scala 15:26]
  reg  mem_ReadMem_MPORT_en_pipe_0;
  reg [9:0] mem_ReadMem_MPORT_addr_pipe_0;
  reg [31:0] WrData; // @[RAM.scala 26:26]
  reg  doForwardReg; // @[RAM.scala 28:32]
  wire [31:0] ReadMem = io_ReadEn ? mem_ReadMem_MPORT_data : 32'h0; // @[RAM.scala 36:22]
  assign mem_ReadMem_MPORT_en = mem_ReadMem_MPORT_en_pipe_0;
  assign mem_ReadMem_MPORT_addr = mem_ReadMem_MPORT_addr_pipe_0;
  assign mem_ReadMem_MPORT_data = mem[mem_ReadMem_MPORT_addr]; // @[RAM.scala 15:26]
  assign mem_MPORT_data = io_WriteData;
  assign mem_MPORT_addr = io_Addr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_WriteEn;
  assign io_ReadData = doForwardReg ? WrData : ReadMem; // @[RAM.scala 37:23]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[RAM.scala 15:26]
    end
    mem_ReadMem_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_ReadMem_MPORT_addr_pipe_0 <= io_Addr;
    end
    WrData <= io_WriteData; // @[RAM.scala 26:26]
    doForwardReg <= io_WriteEn; // @[RAM.scala 28:54]
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
  mem_ReadMem_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_ReadMem_MPORT_addr_pipe_0 = _RAND_2[9:0];
  _RAND_3 = {1{`RANDOM}};
  WrData = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  doForwardReg = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
