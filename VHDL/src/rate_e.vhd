-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY clkrt IS
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  br_o    : OUT std_logic;
  hz_o    : OUT std_logic
  );
END clkrt;

-- ----------------------------------------------------------------------------