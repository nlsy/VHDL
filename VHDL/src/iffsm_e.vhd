-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY iffsm IS
PORT (
  rst_n_i : IN  std_logic;                     -- Reset, active low
  clk_i   : IN  std_logic;                     -- Syscp, @ 12MHz
  dv_i    : IN  std_logic;                     -- Have new RTC or GPS-Data
  dne_i   : IN  std_logic;                     -- Last Bit transmitted
  ldr_o   : OUT std_logic;                     -- enable register load
  act_o   : OUT std_logic;
  vld_o   : OUT std_logic;
  clr_o   : OUT std_logic;                     -- clear Bit-Counters
  nxt_o   : OUT std_logic                      -- next Bit, inc count
  );
END iffsm;

-- ----------------------------------------------------------------------------