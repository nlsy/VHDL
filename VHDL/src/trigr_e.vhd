-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY trigr IS
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  s1_i    : IN  std_logic;
  s2_i    : IN  std_logic;
  s3_i    : IN  std_logic;
  enter_o : OUT std_logic;
  leave_o : OUT std_logic
  );
END trigr;

-- ----------------------------------------------------------------------------