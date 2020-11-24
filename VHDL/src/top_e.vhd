-- ----------------------------------------------------------------------------
-- top_e.vhd
-- ENTITIE for the TOP
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
    --USE WORK.comp_pack.all;

-- ----------------------------------------------------------------------------

ENTITY top is
PORT(
  rb_i   : IN  std_logic;
  cp_i   : IN  std_logic;
  s1_i   : IN  std_logic;
  s2_i   : IN  std_logic;
  s3_i   : IN  std_logic;
  cl_i   : IN  std_logic;
  rb_o   : OUT std_logic;
  sec_o  : OUT std_logic;
  grn_o  : OUT std_logic;
  red_o  : OUT std_logic;
  tled_o : OUT std_logic;
  txd_o  : OUT std_logic;
  sdi_o  : OUT std_logic;
  sdv_o  : OUT std_logic;
  stx_o  : OUT std_logic;
  sec_o : OUT std_logic
  );
END top;

