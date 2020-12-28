-- ---------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ---------------------------------------------------------------------------

ENTITY ctbin IS
GENERIC (
  cnt_width : integer;
  cnt_max : integer
  );
PORT (
  rst_n_i : IN  std_logic;                     -- Reset, active low
  clk_i   : IN  std_logic;                     -- Syscp, @ 12MHz
  en_i    : IN  std_logic;                     -- Enable Count
  cl_i    : IN  std_logic;                     -- Clear Counter
  co_o    : OUT std_logic;                     -- Carry Out
  q_o     : OUT std_logic_vector(cnt_width-1 DOWNTO 0)   -- Counter Value
  );
END ctbin;

-- ----------------------------------------------------------------------------
