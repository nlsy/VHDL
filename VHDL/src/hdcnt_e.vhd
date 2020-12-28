-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY hdcnt IS
GENERIC (
  cnt_width : integer;
  max_cnt : integer
  );
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  inc_i   : IN  std_logic;
  dec_i   : IN  std_logic;
  min_o   : OUT std_logic;
  max_o   : OUT std_logic;
  num_o   : OUT std_logic_vector(cnt_width-1 DOWNTO 0)
  );
END hdcnt;

-- ----------------------------------------------------------------------------