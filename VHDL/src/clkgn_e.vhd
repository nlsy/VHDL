-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY clkgn IS
GENERIC (
  cnt_width : integer;
  div_cnt : integer
  );
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  tk_o    : OUT std_logic
  );
END clkgn;

-- ----------------------------------------------------------------------------