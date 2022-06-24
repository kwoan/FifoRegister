module FifoRegister(
  input         clock,
  input         reset,

  input         io_enq_write,
  output        io_enq_full,
  input  [31:0] io_enq_din,
  input         io_enq_s_tlast,
  
  input         io_deq_read,
  output        io_deq_empty,
  output [31:0] io_deq_dout,
  output        io_deq_m_tlast
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg  stateReg; // @[fifo.scala 27:31]
  reg [31:0] dataReg; // @[fifo.scala 28:31]
  reg  tlastReg; // @[fifo.scala 30:31]
  wire  _GEN_0 = io_enq_write | stateReg; // @[fifo.scala 27:31 33:36 34:34]
  assign io_enq_full = stateReg; // @[fifo.scala 47:34]
  assign io_deq_empty = ~stateReg; // @[fifo.scala 48:35]
  assign io_deq_dout = dataReg; // @[fifo.scala 49:21]
  assign io_deq_m_tlast = tlastReg; // @[fifo.scala 51:24]
  always @(posedge clock) begin
    if (reset) begin // @[fifo.scala 27:31]
      stateReg <= 1'h0; // @[fifo.scala 27:31]
    end else if (~stateReg) begin // @[fifo.scala 32:34]
      stateReg <= _GEN_0;
    end else if (stateReg) begin // @[fifo.scala 39:41]
      if (io_deq_read) begin // @[fifo.scala 40:35]
        stateReg <= 1'h0; // @[fifo.scala 41:34]
      end
    end
    if (reset) begin // @[fifo.scala 28:31]
      dataReg <= 32'h0; // @[fifo.scala 28:31]
    end else if (~stateReg) begin // @[fifo.scala 32:34]
      if (io_enq_write) begin // @[fifo.scala 33:36]
        dataReg <= io_enq_din; // @[fifo.scala 35:33]
      end
    end else if (stateReg) begin // @[fifo.scala 39:41]
      if (io_deq_read) begin // @[fifo.scala 40:35]
        dataReg <= 32'h0; // @[fifo.scala 42:33]
      end
    end
    if (reset) begin // @[fifo.scala 30:31]
      tlastReg <= 1'h0; // @[fifo.scala 30:31]
    end else if (~stateReg) begin // @[fifo.scala 32:34]
      if (io_enq_write) begin // @[fifo.scala 33:36]
        tlastReg <= io_enq_s_tlast; // @[fifo.scala 37:34]
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
  dataReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  tlastReg = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
