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

@cocotb.test()
async def decode_N_char(dut):
  await inital_reset(dut);

  await simulate_DAH(dut);
  await simulate_DIT(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 78 

@cocotb.test()
async def decode_S_char(dut):
  await inital_reset(dut);

  await simulate_DIT(dut);
  await simulate_DIT(dut);
  await simulate_DIT(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 83 

@cocotb.test()
async def decode_O_char(dut):
  await inital_reset(dut);

  await simulate_DAH(dut);
  await simulate_DAH(dut);
  await simulate_DAH(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 79 

@cocotb.test()
async def decode_W_char(dut):
  await inital_reset(dut);

  await simulate_DIT(dut);
  await simulate_DAH(dut);
  await simulate_DAH(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 87 

@cocotb.test()
async def decode_U_char(dut):
  await inital_reset(dut);

  await simulate_DIT(dut);
  await simulate_DIT(dut);
  await simulate_DAH(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 85 

@cocotb.test()
async def decode_R_char(dut):
  await inital_reset(dut);

  await simulate_DIT(dut);
  await simulate_DAH(dut);
  await simulate_DIT(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 82 

@cocotb.test()
async def decode_K_char(dut):
  await inital_reset(dut);

  await simulate_DAH(dut);
  await simulate_DIT(dut);
  await simulate_DAH(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 75 

@cocotb.test()
async def decode_G_char(dut):
  await inital_reset(dut);

  await simulate_DAH(dut);
  await simulate_DAH(dut);
  await simulate_DIT(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 71 

@cocotb.test()
async def decode_D_char(dut):
  await inital_reset(dut);

  await simulate_DAH(dut);
  await simulate_DIT(dut);
  await simulate_DIT(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 68 

@cocotb.test()
async def decode_B_char(dut):
  await inital_reset(dut);

  await simulate_DAH(dut);
  await simulate_DIT(dut);
  await simulate_DIT(dut);
  await simulate_DIT(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 66 

@cocotb.test()
async def decode_C_char(dut):
  await inital_reset(dut);

  await simulate_DAH(dut);
  await simulate_DIT(dut);
  await simulate_DAH(dut);
  await simulate_DIT(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 67 

@cocotb.test()
async def decode_F_char(dut):
  await inital_reset(dut);

  await simulate_DIT(dut);
  await simulate_DIT(dut);
  await simulate_DAH(dut);
  await simulate_DIT(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 70 


@cocotb.test()
async def decode_H_char(dut):
  await inital_reset(dut);

  await simulate_DIT(dut);
  await simulate_DIT(dut);
  await simulate_DIT(dut);
  await simulate_DIT(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 72 

@cocotb.test()
async def decode_J_char(dut):
  await inital_reset(dut);

  await simulate_DIT(dut);
  await simulate_DAH(dut);
  await simulate_DAH(dut);
  await simulate_DAH(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 74 

@cocotb.test()
async def decode_L_char(dut):
  await inital_reset(dut);

  await simulate_DIT(dut);
  await simulate_DAH(dut);
  await simulate_DIT(dut);
  await simulate_DIT(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 76 

@cocotb.test()
async def decode_P_char(dut):
  await inital_reset(dut);

  await simulate_DIT(dut);
  await simulate_DAH(dut);
  await simulate_DAH(dut);
  await simulate_DIT(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 80 

@cocotb.test()
async def decode_Q_char(dut):
  await inital_reset(dut);

  await simulate_DAH(dut);
  await simulate_DAH(dut);
  await simulate_DIT(dut);
  await simulate_DAH(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 81 

@cocotb.test()
async def decode_V_char(dut):
  await inital_reset(dut);

  await simulate_DIT(dut);
  await simulate_DIT(dut);
  await simulate_DIT(dut);
  await simulate_DAH(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 86 

@cocotb.test()
async def decode_Z_char(dut):
  await inital_reset(dut);

  await simulate_DAH(dut);
  await simulate_DAH(dut);
  await simulate_DIT(dut);
  await simulate_DIT(dut);

  await simulate_CHAR_SPACE(dut);

  assert dut.serial_line.value == 90 
