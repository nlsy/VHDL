-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY top IS
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  s1_i    : IN  std_logic;
  s2_i    : IN  std_logic;
  s3_i    : IN  std_logic;
  rst_n_o : OUT std_logic;
  sec_o   : OUT std_logic;
  grn_o   : OUT std_logic;
  red_o   : OUT std_logic;
  tled_o  : OUT std_logic;
  txd_o   : OUT std_logic;
  sdi_o   : OUT std_logic;
  sdv_o   : OUT std_logic;
  stx_o   : OUT std_logic
  );
END top;

-- ----------------------------------------------------------------------------