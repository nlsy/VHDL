-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY uatpc IS
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  br_i    : IN  std_logic;
  sub_i   : IN  std_logic;
  num_i   : IN  std_logic_vector(num_width_const-1 DOWNTO 0);
  txd_o   : OUT std_logic
  );
END uatpc;

-- ----------------------------------------------------------------------------