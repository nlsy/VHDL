-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- ----------------------------------------------------------------------------

ENTITY mx2snd IS
PORT (s_i  :  IN STD_LOGIC_VECTOR( 3 DOWNTO 0);  -- get bits
      d_i  :  IN STD_LOGIC_VECTOR(15 DOWNTO 0);  -- BYTE
    txd_o  : OUT STD_LOGIC);                      -- txd, Serial Output
END mx2snd;

-- ----------------------------------------------------------------------------
