-- ----------------------------------------------------------------------------

LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;

-- ----------------------------------------------------------------------------

ENTITY toggl IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  sig_i : IN STD_LOGIC;
  res_o : OUT std_logic
  );
END toggl;

-- ----------------------------------------------------------------------------