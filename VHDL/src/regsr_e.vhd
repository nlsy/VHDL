-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY regsr IS
GENERIC (
  dta_width : integer
  );
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  en_i    : IN  std_logic;
  d_i     : IN  std_logic_vector(dta_width-1 DOWNTO 0);
  q_o     : OUT std_logic_vector(dta_width-1 DOWNTO 0)
  );
END regsr;

-- ----------------------------------------------------------------------------