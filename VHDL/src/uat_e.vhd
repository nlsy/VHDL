-- ----------------------------------------------------------------------------
-- uat_e.vhd
-- ENTITIE for the UAT
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
    USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY uat is
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  br_i : IN std_logic;  -- baud rate
  dv_i : IN std_logic;  -- data valid
  num_i : IN std_logic_vector(7 DOWNTO 0); -- data (number)
  txd_o : OUT std_logic -- serial output
  );
END uat;

