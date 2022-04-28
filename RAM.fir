circuit RAM :
  module RAM :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip writeEn : UInt<1>, flip readEn : UInt<1>, flip addr : UInt<10>, flip writeData : UInt<32>, readData : UInt<32>}

    smem mem : UInt<32> [1024] @[RAM.scala 15:24]
    node _T = geq(io.addr, UInt<1>("h0")) @[RAM.scala 26:34]
    node _T_1 = lt(io.addr, UInt<11>("h400")) @[RAM.scala 26:48]
    node _T_2 = and(_T, _T_1) @[RAM.scala 26:41]
    node _T_3 = and(io.writeEn, _T_2) @[RAM.scala 29:21]
    when _T_3 : @[RAM.scala 29:42]
      write mport MPORT = mem[io.addr], clock
      MPORT <= io.writeData
    wire _io_readData_WIRE : UInt @[RAM.scala 32:41]
    _io_readData_WIRE is invalid @[RAM.scala 32:41]
    when io.readEn : @[RAM.scala 32:41]
      _io_readData_WIRE <= io.addr @[RAM.scala 32:41]
      node _io_readData_T = or(_io_readData_WIRE, UInt<10>("h0")) @[RAM.scala 32:41]
      node _io_readData_T_1 = bits(_io_readData_T, 9, 0) @[RAM.scala 32:41]
      read mport io_readData_MPORT = mem[_io_readData_T_1], clock @[RAM.scala 32:41]
    node _io_readData_T_2 = mux(io.readEn, io_readData_MPORT, UInt<1>("h0")) @[RAM.scala 32:21]
    io.readData <= _io_readData_T_2 @[RAM.scala 32:15]

