-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;
USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY clksc IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  tk_o : OUT std_logic
  );
END clksc;

-- ----------------------------------------------------------------------------