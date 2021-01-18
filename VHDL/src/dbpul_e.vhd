-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY dbpul IS
GENERIC (
  dbc_width : integer
  );
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  unb_i   : IN  std_logic;
  deb_o   : OUT std_logic
  );
END dbpul;

-- ----------------------------------------------------------------------------