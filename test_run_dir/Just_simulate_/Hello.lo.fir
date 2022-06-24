circuit Hello :
  module Hello :
    input clock : Clock
    input reset : UInt<1>
    output io_led : UInt<1>

    reg cntReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), cntReg) @[hello.scala 9:23]
    reg blkReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), blkReg) @[hello.scala 10:23]
    node _cntReg_T = add(cntReg, UInt<1>("h1")) @[hello.scala 12:20]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[hello.scala 12:20]
    node _T = eq(cntReg, UInt<25>("h17d783f")) @[hello.scala 13:15]
    node _blkReg_T = not(blkReg) @[hello.scala 15:15]
    node _GEN_0 = mux(_T, UInt<1>("h0"), _cntReg_T_1) @[hello.scala 12:10 13:27 14:12]
    node _GEN_1 = mux(_T, _blkReg_T, blkReg) @[hello.scala 13:27 15:12 10:23]
    io_led <= blkReg @[hello.scala 17:10]
    cntReg <= mux(reset, UInt<32>("h0"), _GEN_0) @[hello.scala 9:{23,23}]
    blkReg <= mux(reset, UInt<1>("h0"), _GEN_1) @[hello.scala 10:{23,23}]
