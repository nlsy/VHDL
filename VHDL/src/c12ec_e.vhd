-- ----------------------------------------------------------------------------

LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;

-- ----------------------------------------------------------------------------

ENTITY c12ec IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  en_i : IN std_logic;
  co_o : OUT std_logic
  );
END c12ec;
