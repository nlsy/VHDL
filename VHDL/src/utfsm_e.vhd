-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ---------------------------------------------------------------------------

ENTITY utfsm IS
PORT (
  rst_n_i : IN  std_logic;      -- Reset, active low
  clk_i   : IN  std_logic;      -- Syscp, @ 12MHz
  dv_i    : IN  std_logic;      -- Have new RTC or GPS-Data
  br_i    : IN  std_logic;      -- Baud-Rate to ena Counter
  dne_i   : IN  std_logic;      -- Last Bit transmitted
  sto_o   : OUT std_logic;      -- enable register load
  clr_o   : OUT std_logic;      -- clear Bit-Counters
  nxt_o   : OUT std_logic       -- next Bit, inc count
  );
END utfsm;

-- ----------------------------------------------------------------------------