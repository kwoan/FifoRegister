circuit FifoRegister :
  module FifoRegister :
    input clock : Clock
    input reset : UInt<1>
    output io : { enq : { flip write : UInt<1>, full : UInt<1>, flip din : UInt<32>, flip s_tlast : UInt<1>}, deq : { flip read : UInt<1>, empty : UInt<1>, dout : UInt<32>, m_tlast : UInt<1>}}

    reg stateReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[fifo.scala 27:31]
    reg dataReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[fifo.scala 28:31]
    reg tlastReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[fifo.scala 30:31]
    node _T = eq(stateReg, UInt<1>("h0")) @[fifo.scala 32:23]
    when _T : @[fifo.scala 32:34]
      when io.enq.write : @[fifo.scala 33:36]
        stateReg <= UInt<1>("h1") @[fifo.scala 34:34]
        dataReg <= io.enq.din @[fifo.scala 35:33]
        tlastReg <= io.enq.s_tlast @[fifo.scala 37:34]
    else :
      node _T_1 = eq(stateReg, UInt<1>("h1")) @[fifo.scala 39:31]
      when _T_1 : @[fifo.scala 39:41]
        when io.deq.read : @[fifo.scala 40:35]
          stateReg <= UInt<1>("h0") @[fifo.scala 41:34]
          dataReg <= UInt<1>("h0") @[fifo.scala 42:33]
      else :
        skip
    node _io_enq_full_T = eq(stateReg, UInt<1>("h1")) @[fifo.scala 47:34]
    io.enq.full <= _io_enq_full_T @[fifo.scala 47:21]
    node _io_deq_empty_T = eq(stateReg, UInt<1>("h0")) @[fifo.scala 48:35]
    io.deq.empty <= _io_deq_empty_T @[fifo.scala 48:22]
    io.deq.dout <= dataReg @[fifo.scala 49:21]
    io.deq.m_tlast <= tlastReg @[fifo.scala 51:24]

