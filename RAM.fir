circuit RAM :
  module RAM :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip WriteEn : UInt<1>, flip ReadEn : UInt<1>, flip Addr : UInt<10>, flip WriteData : UInt<32>, ReadData : UInt<32>}

    smem mem : UInt<32> [1024] @[RAM.scala 15:26]
    reg WrData : UInt, clock with :
      reset => (UInt<1>("h0"), WrData) @[RAM.scala 26:26]
    WrData <= io.WriteData @[RAM.scala 26:26]
    reg WrAddr : UInt, clock with :
      reset => (UInt<1>("h0"), WrAddr) @[RAM.scala 27:26]
    WrAddr <= io.Addr @[RAM.scala 27:26]
    node _doForwardReg_T = eq(io.Addr, io.Addr) @[RAM.scala 28:42]
    node _doForwardReg_T_1 = and(_doForwardReg_T, io.WriteEn) @[RAM.scala 28:54]
    reg doForwardReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), doForwardReg) @[RAM.scala 28:32]
    doForwardReg <= _doForwardReg_T_1 @[RAM.scala 28:32]
    node _isValid_T = geq(io.Addr, UInt<1>("h0")) @[RAM.scala 29:33]
    node _isValid_T_1 = lt(io.Addr, UInt<11>("h400")) @[RAM.scala 29:50]
    node isValid = and(_isValid_T, _isValid_T_1) @[RAM.scala 29:40]
    node _T = and(io.WriteEn, isValid) @[RAM.scala 32:23]
    when _T : @[RAM.scala 32:35]
      write mport MPORT = mem[io.Addr], clock
      MPORT <= io.WriteData
    wire _ReadMem_WIRE : UInt @[RAM.scala 36:42]
    _ReadMem_WIRE is invalid @[RAM.scala 36:42]
    when UInt<1>("h1") : @[RAM.scala 36:42]
      _ReadMem_WIRE <= io.Addr @[RAM.scala 36:42]
      node _ReadMem_T = or(_ReadMem_WIRE, UInt<10>("h0")) @[RAM.scala 36:42]
      node _ReadMem_T_1 = bits(_ReadMem_T, 9, 0) @[RAM.scala 36:42]
      read mport ReadMem_MPORT = mem[_ReadMem_T_1], clock @[RAM.scala 36:42]
    node ReadMem = mux(io.ReadEn, ReadMem_MPORT, UInt<1>("h0")) @[RAM.scala 36:22]
    node _io_ReadData_T = mux(doForwardReg, WrData, ReadMem) @[RAM.scala 37:23]
    io.ReadData <= _io_ReadData_T @[RAM.scala 37:17]

