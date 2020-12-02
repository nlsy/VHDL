-- ----------------------------------------------------------------------------
-- uat_fsm_e.vhd
-- ENTITIE for the UAT_FSM
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

ENTITY trigger IS
PORT(
  rb_i : IN std_logic;
  cp_i : IN std_logic;
  s1_i : IN std_logic;
  s2_i : IN std_logic;
  s3_i : IN std_logic;
  enter_o : OUT std_logic;
  leave_o : OUT std_logic
  );
END trigger;
