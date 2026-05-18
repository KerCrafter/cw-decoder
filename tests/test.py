import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, Timer

async def inital_reset(dut):
  dut.reset.value = '1'
  await Timer(1, unit='ns');

  dut.clk.value = '1';
  await Timer(1, unit='ns');
  dut.clk.value = '0';
  await Timer(1, unit='ns');

  dut.reset.value = '0'
  await Timer(1, unit='ns');

  dut.clk.value = '1';
  await Timer(1, unit='ns');
  dut.clk.value = '0';
  await Timer(1, unit='ns');

@cocotb.test()
async def decode_E_char(dut):
  await inital_reset(dut);


  dut.cw_sig.value = '1'
  await Timer(1, unit='ns');

  dut.clk.value = '1';
  await Timer(1, unit='ns');
  dut.clk.value = '0';
  await Timer(1, unit='ns');

  dut.cw_sig.value = '0'
  await Timer(1, unit='ns');

  dut.clk.value = '1';
  await Timer(1, unit='ns');
  dut.clk.value = '0';
  await Timer(1, unit='ns');

  dut.clk.value = '1';
  await Timer(1, unit='ns');
  dut.clk.value = '0';
  await Timer(1, unit='ns');

  assert dut.serial_line.value == 69

@cocotb.test()
async def decode_T_char(dut):

  dut.cw_sig.value = '1'
  await Timer(1, unit='ns');

  dut.clk.value = '1';
  await Timer(1, unit='ns');
  dut.clk.value = '0';
  await Timer(1, unit='ns');

  dut.clk.value = '1';
  await Timer(1, unit='ns');
  dut.clk.value = '0';
  await Timer(1, unit='ns');

  dut.cw_sig.value = '0'
  await Timer(1, unit='ns');

  dut.clk.value = '1';
  await Timer(1, unit='ns');
  dut.clk.value = '0';
  await Timer(1, unit='ns');

  dut.clk.value = '1';
  await Timer(1, unit='ns');
  dut.clk.value = '0';
  await Timer(1, unit='ns');

  assert dut.serial_line.value == 84
