-- ----------------------------------------------------------------------------

LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;

-- ----------------------------------------------------------------------------

ENTITY count IS
PORT(
  rb_i  : IN  std_logic;
  cp_i  : IN  std_logic;
  inc_i : IN  std_logic;
  dec_i : IN  std_logic;
  min_o : OUT std_logic;
  max_o : OUT std_logic;
  num_o : OUT std_logic_vector(7 DOWNTO 0)
  );
END count;

-- ----------------------------------------------------------------------------