-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY cntrl IS
PORT (
  rst_n_i : IN  std_logic;
  clk_i   : IN  std_logic;
  add_i   : IN  std_logic;
  sub_i   : IN  std_logic;
  min_i   : IN  std_logic;
  max_i   : IN  std_logic;
  inc_o   : OUT std_logic;
  dec_o   : OUT std_logic;
  evt_o   : OUT std_logic_vector(7 DOWNTO 0);
  sub_o   : OUT std_logic
  );
END cntrl;

-- ----------------------------------------------------------------------------