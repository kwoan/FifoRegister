import chisel3._
import chisel3.util._

class WriterIO(size : UInt) extends Bundle {
	val write = Input(Bool())
	val full = Output(Bool())
	val din = Input(UInt(size.W))

	val s_tlast =Input(Bool())
}

class ReaderIO(size : UInt) extends Bundle {
	val read = Input(Bool())
	val empty = Output(Bool())
	val dout = Output(UInt(size.W))

	val m_tlast = Output(Bool())
}

class FifoRegister(size: UInt) extends Module {
	val io = IO(new Bundle {
		val enq = new WriterIO(size)
		val deq = new ReaderIO(size)
	})

	val empty :: full :: Nil = Enum (2)
	val stateReg = RegInit(empty)
	val dataReg = RegInit (0.U(size.W))

	val tlastReg = RegInit(0.U(1.W))

	when(stateReg === empty) {
		when(io.enq.write) {
			stateReg := full
			dataReg := io.enq.din

			tlastReg := io.enq.s_tlast
		}
	}. elsewhen (stateReg === full) {
		when(io.deq.read) {
			stateReg := empty
			dataReg := 0.U // just to better see empty slots in the waveform
		}
	}. otherwise {
		// There should not be an otherwise state
	}
	io.enq.full := (stateReg === full)
	io.deq.empty := (stateReg === empty)
	io.deq.dout := dataReg

	io.deq.m_tlast := tlastReg
}

object FifoRegister extends App {
	(new chisel3.stage.ChiselStage).emitVerilog(new FifoRegister(32))
}