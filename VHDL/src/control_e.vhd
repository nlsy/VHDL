-- ----------------------------------------------------------------------------
-- control_e.vhd
-- ENTITIE for the Control
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

ENTITY control IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  enter_i : IN std_logic;
  leave_i : IN std_logic;
  min_i  : IN  std_logic;
  max_i  : IN  std_logic;
  inc_o : OUT std_logic;
  dec_o : OUT std_logic;
  evt_o : OUT std_logic_vector(7 DOWNTO 0);
  sub_o : OUT std_logic
  );
END control;
