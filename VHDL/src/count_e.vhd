-- ----------------------------------------------------------------------------
-- hc_e.vhd
-- ENTITIE for the HC
-- 
-- Author: Nils Schlegel, 32067
--         Tara Jaishi, 32289
-- Last edited: 2020-11-13
-- ----------------------------------------------------------------------------
-- FPGA-chip: 10M16SAU169C8G (most likely)
-- ----------------------------------------------------------------------------

LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.all;
    USE IEEE.NUMERIC_STD.all;

-- ----------------------------------------------------------------------------

ENTITY count IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  inc_i : IN std_logic;
  dec_i : IN std_logic;
  min_o : OUT std_logic;
  max_o : OUT std_logic;
  num_o : OUT std_logic_vector(7 DOWNTO 0)
  );
END count;

