-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY infs3 IS
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  sub_i   : IN  std_logic;
  evt_i   : IN  std_logic_vector(evt_width_const-1 DOWNTO 0);
  num_i   : IN  std_logic_vector(num_width_const-1 DOWNTO 0);
  sdi_o   : OUT std_logic;
  sdv_o   : OUT std_logic;
  stx_o   : OUT std_logic
  );
END infs3;

-- ----------------------------------------------------------------------------