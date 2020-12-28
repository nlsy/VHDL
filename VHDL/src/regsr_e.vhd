-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;

-- ----------------------------------------------------------------------------

ENTITY regsr IS
GENERIC(
  dta_width : integer
  );
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  en_i : IN std_logic;
  d_i  : IN std_logic_vector(dta_width-1 DOWNTO 0);
  q_o  : OUT std_logic_vector(dta_width-1 DOWNTO 0)
  );
END regsr;

-- ----------------------------------------------------------------------------