-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;
USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY trigger IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  s1_i : IN std_logic;
  s2_i : IN std_logic;
  s3_i : IN std_logic;
  enter_o : OUT std_logic;
  leave_o : OUT std_logic
  );
END trigger;

-- ----------------------------------------------------------------------------