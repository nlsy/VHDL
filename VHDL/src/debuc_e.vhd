-- ----------------------------------------------------------------------------

LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;

-- ----------------------------------------------------------------------------

ENTITY debnc IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  unb_i : IN STD_LOGIC;
  deb_o : OUT std_logic
  );
END debnc;

-- ----------------------------------------------------------------------------