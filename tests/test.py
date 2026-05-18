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

async def simulate_DIT(dut):
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

async def simulate_DAH(dut):
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

async def simulate_CHAR_SPACE(dut):
  dut.clk.value = '1';
  await Timer(1, unit='ns');
  dut.clk.value = '0';
  await Timer(1, unit='ns');

  dut.clk.value = '1';
  await Timer(1, unit='ns');
  dut.clk.value = '0';
  await Timer(1, unit='ns');

@cocotb.test()
async def decode_E_char(dut):
  await inital_reset(dut);

  await simulate_DIT(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 69

@cocotb.test()
async def decode_T_char(dut):
  await inital_reset(dut);

  await simulate_DAH(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 84


@cocotb.test()
async def decode_I_char(dut):
  await inital_reset(dut);

  await simulate_DIT(dut);
  await simulate_DIT(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 73 

@cocotb.test()
async def decode_M_char(dut):
  await inital_reset(dut);

  await simulate_DAH(dut);
  await simulate_DAH(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 77 

@cocotb.test()
async def decode_A_char(dut):
  await inital_reset(dut);

  await simulate_DIT(dut);
  await simulate_DAH(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 65 
