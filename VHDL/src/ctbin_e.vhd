-- ---------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;
USE WORK.comp_pack.all;

-- ---------------------------------------------------------------------------

ENTITY ctbin IS
GENERIC (
  cnt_width : integer;
  cnt_max : integer
  );
PORT (
  rb_i   :  IN STD_LOGIC;                     -- Reset, active low
  cp_i   :  IN STD_LOGIC;                     -- Syscp, @ 12MHz
  en_i   :  IN STD_LOGIC;                     -- Enable Count
  cl_i   :  IN STD_LOGIC;                     -- Clear Counter
  co_o   : OUT STD_LOGIC;                     -- Carry Out
  q_o   : OUT STD_LOGIC_VECTOR(cnt_width-1 DOWNTO 0)   -- Counter Value
  );
END ctbin;

-- ----------------------------------------------------------------------------
