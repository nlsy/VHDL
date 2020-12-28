-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY mxsnd IS
PORT (
  s_i   : IN  std_logic_vector( 4 DOWNTO 0);  -- get bits
  d_i   : IN  std_logic_vector(15 DOWNTO 0);  -- BYTE
  txd_o : OUT std_logic                       -- txd, Serial Output
  );
END mxsnd;

-- ----------------------------------------------------------------------------