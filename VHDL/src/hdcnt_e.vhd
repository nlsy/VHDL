-- ----------------------------------------------------------------------------

LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;

-- ----------------------------------------------------------------------------

ENTITY hdcnt IS
GENERIC(
  cnt_width : integer := 8;
  max_cnt : integer := 3
  );
PORT(
  rb_i  : IN  std_logic;
  cp_i  : IN  std_logic;
  inc_i : IN  std_logic;
  dec_i : IN  std_logic;
  min_o : OUT std_logic;
  max_o : OUT std_logic;
  num_o : OUT std_logic_vector(cnt_width-1 DOWNTO 0)
  );
END hdcnt;

-- ----------------------------------------------------------------------------