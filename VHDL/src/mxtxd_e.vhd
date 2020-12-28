-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY mxtxd IS
PORT (
  s_i   : IN  std_logic_vector(3 DOWNTO 0);  -- get bits
  d_i   : IN  std_logic_vector(7 DOWNTO 0);  -- BYTE
  txd_o : OUT std_logic                      -- txd, Serial Output
  );
END mxtxd;

-- ----------------------------------------------------------------------------