circuit Count10 :
  module Adder :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<8>
    input io_b : UInt<8>
    output io_y : UInt<8>

    node _io_y_T = add(io_a, io_b) @[Adder.scala 10:16]
    node _io_y_T_1 = tail(_io_y_T, 1) @[Adder.scala 10:16]
    io_y <= _io_y_T_1 @[Adder.scala 10:8]

  module Register :
    input clock : Clock
    input reset : UInt<1>
    input io_d : UInt<8>
    output io_q : UInt<8>

    reg reg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), reg) @[Register.scala 9:20]
    io_q <= reg @[Register.scala 11:8]
    reg <= mux(reset, UInt<1>("h0"), io_d) @[Register.scala 9:{20,20} 10:7]

  module Count10 :
    input clock : Clock
    input reset : UInt<1>
    output io_dout : UInt<8>

    inst add of Adder @[Counter.scala 8:19]
    inst reg of Register @[Counter.scala 9:19]
    node _next_T = eq(reg.io_q, UInt<4>("h9")) @[Counter.scala 17:24]
    node next = mux(_next_T, UInt<1>("h0"), add.io_y) @[Counter.scala 17:17]
    io_dout <= reg.io_q @[Counter.scala 20:11]
    add.clock <= clock
    add.reset <= reset
    add.io_a <= UInt<8>("h1") @[Counter.scala 13:12]
    add.io_b <= reg.io_q @[Counter.scala 14:12]
    reg.clock <= clock
    reg.reset <= reset
    reg.io_d <= next @[Counter.scala 18:12]
