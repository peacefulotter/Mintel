module RAM(
  input         clock,
  input         reset,
  input         io_writeEn,
  input         io_readEn,
  input  [9:0]  io_addr,
  input  [31:0] io_writeData,
  output [31:0] io_readData
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:1023]; // @[RAM.scala 15:24]
  wire  mem_io_readData_MPORT_en; // @[RAM.scala 15:24]
  wire [9:0] mem_io_readData_MPORT_addr; // @[RAM.scala 15:24]
  wire [31:0] mem_io_readData_MPORT_data; // @[RAM.scala 15:24]
  wire [31:0] mem_MPORT_data; // @[RAM.scala 15:24]
  wire [9:0] mem_MPORT_addr; // @[RAM.scala 15:24]
  wire  mem_MPORT_mask; // @[RAM.scala 15:24]
  wire  mem_MPORT_en; // @[RAM.scala 15:24]
  reg  mem_io_readData_MPORT_en_pipe_0;
  reg [9:0] mem_io_readData_MPORT_addr_pipe_0;
  assign mem_io_readData_MPORT_en = mem_io_readData_MPORT_en_pipe_0;
  assign mem_io_readData_MPORT_addr = mem_io_readData_MPORT_addr_pipe_0;
  assign mem_io_readData_MPORT_data = mem[mem_io_readData_MPORT_addr]; // @[RAM.scala 15:24]
  assign mem_MPORT_data = io_writeData;
  assign mem_MPORT_addr = io_addr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_writeEn;
  assign io_readData = io_readEn ? mem_io_readData_MPORT_data : 32'h0; // @[RAM.scala 32:21]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[RAM.scala 15:24]
    end
    mem_io_readData_MPORT_en_pipe_0 <= io_readEn;
    if (io_readEn) begin
      mem_io_readData_MPORT_addr_pipe_0 <= io_addr;
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_io_readData_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_io_readData_MPORT_addr_pipe_0 = _RAND_2[9:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
