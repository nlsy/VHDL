-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY debnc IS
PORT (
  rst_n_i : IN  std_logic;                      -- Reset, active low
  clk_i   : IN  std_logic;                      -- Syscp, @ 12MHz
  ub1_i   : IN  std_logic;                      -- Unbounced Input 1
  ub2_i   : IN  std_logic;                      -- Unbounced Input 2
  ub3_i   : IN  std_logic;                      -- Unbounced Input 3
  db1_o   : OUT std_logic;                      -- Debounced Output 1
  db2_o   : OUT std_logic;                      -- Debounced Output 2
  db3_o   : OUT std_logic                       -- Debounced Output 3
  );
END debnc;

-- ----------------------------------------------------------------------------