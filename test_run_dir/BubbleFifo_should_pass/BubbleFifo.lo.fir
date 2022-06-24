circuit BubbleFifo :
  module Buffer :
    input clock : Clock
    input reset : UInt<1>
    output io_enq_ready : UInt<1>
    input io_enq_valid : UInt<1>
    input io_enq_bits : UInt<32>
    input io_deq_ready : UInt<1>
    output io_deq_valid : UInt<1>
    output io_deq_bits : UInt<32>

    reg fullReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), fullReg) @[BubbleFifo.scala 12:26]
    reg dataReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), dataReg) @[BubbleFifo.scala 13:22]
    node _GEN_0 = mux(io_deq_ready, UInt<1>("h0"), fullReg) @[BubbleFifo.scala 16:27 17:17 12:26]
    node _GEN_1 = mux(io_enq_valid, UInt<1>("h1"), fullReg) @[BubbleFifo.scala 20:27 21:17 12:26]
    node _GEN_2 = mux(io_enq_valid, io_enq_bits, dataReg) @[BubbleFifo.scala 20:27 22:17 13:22]
    node _GEN_3 = mux(fullReg, _GEN_0, _GEN_1) @[BubbleFifo.scala 15:20]
    node _GEN_4 = mux(fullReg, dataReg, _GEN_2) @[BubbleFifo.scala 15:20 13:22]
    node _io_enq_ready_T = eq(fullReg, UInt<1>("h0")) @[BubbleFifo.scala 26:21]
    io_enq_ready <= _io_enq_ready_T @[BubbleFifo.scala 26:18]
    io_deq_valid <= fullReg @[BubbleFifo.scala 27:18]
    io_deq_bits <= dataReg @[BubbleFifo.scala 28:17]
    fullReg <= mux(reset, UInt<1>("h0"), _GEN_3) @[BubbleFifo.scala 12:{26,26}]
    dataReg <= _GEN_4

  module BubbleFifo :
    input clock : Clock
    input reset : UInt<1>
    output io_enq_ready : UInt<1>
    input io_enq_valid : UInt<1>
    input io_enq_bits : UInt<32>
    input io_deq_ready : UInt<1>
    output io_deq_valid : UInt<1>
    output io_deq_bits : UInt<32>

    inst Buffer of Buffer @[BubbleFifo.scala 31:51]
    inst Buffer_1 of Buffer @[BubbleFifo.scala 31:51]
    inst Buffer_2 of Buffer @[BubbleFifo.scala 31:51]
    inst Buffer_3 of Buffer @[BubbleFifo.scala 31:51]
    io_enq_ready <= Buffer.io_enq_ready @[BubbleFifo.scala 36:10]
    io_deq_valid <= Buffer_3.io_deq_valid @[BubbleFifo.scala 37:10]
    io_deq_bits <= Buffer_3.io_deq_bits @[BubbleFifo.scala 37:10]
    Buffer.clock <= clock
    Buffer.reset <= reset
    Buffer.io_enq_valid <= io_enq_valid @[BubbleFifo.scala 36:10]
    Buffer.io_enq_bits <= io_enq_bits @[BubbleFifo.scala 36:10]
    Buffer.io_deq_ready <= Buffer_1.io_enq_ready @[BubbleFifo.scala 33:27]
    Buffer_1.clock <= clock
    Buffer_1.reset <= reset
    Buffer_1.io_enq_valid <= Buffer.io_deq_valid @[BubbleFifo.scala 33:27]
    Buffer_1.io_enq_bits <= Buffer.io_deq_bits @[BubbleFifo.scala 33:27]
    Buffer_1.io_deq_ready <= Buffer_2.io_enq_ready @[BubbleFifo.scala 33:27]
    Buffer_2.clock <= clock
    Buffer_2.reset <= reset
    Buffer_2.io_enq_valid <= Buffer_1.io_deq_valid @[BubbleFifo.scala 33:27]
    Buffer_2.io_enq_bits <= Buffer_1.io_deq_bits @[BubbleFifo.scala 33:27]
    Buffer_2.io_deq_ready <= Buffer_3.io_enq_ready @[BubbleFifo.scala 33:27]
    Buffer_3.clock <= clock
    Buffer_3.reset <= reset
    Buffer_3.io_enq_valid <= Buffer_2.io_deq_valid @[BubbleFifo.scala 33:27]
    Buffer_3.io_enq_bits <= Buffer_2.io_deq_bits @[BubbleFifo.scala 33:27]
    Buffer_3.io_deq_ready <= io_deq_ready @[BubbleFifo.scala 37:10]
