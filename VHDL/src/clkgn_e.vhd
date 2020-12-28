-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;
USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY clkgn IS
GENERIC(
  cnt_width : integer;
  div_cnt : integer
  );
PORT(
  rb_i : IN  std_logic;
  cp_i : IN  std_logic;
  tk_o : OUT std_logic
  );
END clkgn;

-- ----------------------------------------------------------------------------