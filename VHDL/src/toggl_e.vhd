-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY toggl IS
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  sig_i   : IN  std_logic;
  res_o   : OUT std_logic
  );
END toggl;

-- ----------------------------------------------------------------------------