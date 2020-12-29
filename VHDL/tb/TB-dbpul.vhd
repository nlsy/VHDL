-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY TB_dbpul IS END TB_dbpul;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF TB_dbpul IS

  -- input
  SIGNAL rst_n_s,clk_s,si_s : std_logic;
  -- output
  SIGNAL so_s : std_logic;

BEGIN
  
  -- Modules -----------------------------------------
  db1 : dbpul GENERIC MAP (3)
    PORT    MAP (rst_n_s,clk_s,si_s,so_s);

  runTB : PROCESS
    VARIABLE dotimes  : integer :=   0;
    VARIABLE so_long_v : integer := 20;
  BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PINS
-- ----------------------------------------------------------------------------
    rst_n_s  <= '1';
    clk_s  <= '0';
    si_s <= '0'; WAIT FOR 100 NS;
-- ----------------------------------------------------------------------------
-- STEP 2: Do a reset-cycle
-- ----------------------------------------------------------------------------
    rst_n_s  <= '0'; WAIT FOR 100 NS;
    rst_n_s  <= '1'; WAIT FOR 100 NS;
-- ----------------------------------------------------------------------------
-- STEP 3: Run Test-Patterns
-- ----------------------------------------------------------------------------
-- Some SYScp-cycles:
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;

-- Send unbunced signal
    clk_s  <= '1'; WAIT FOR  10 NS;
      si_s   <= '1'; WAIT FOR  90 NS;
    clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS;
      si_s   <= '0'; WAIT FOR  90 NS;
    clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS;
      si_s   <= '1'; WAIT FOR  90 NS;
    clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS;
      si_s   <= '0'; WAIT FOR  90 NS;
    clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS;
      si_s   <= '1'; WAIT FOR  90 NS;
    clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS;
      si_s   <= '0'; WAIT FOR  90 NS;
    clk_s  <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;

-- ---------------------------------------------------------------------------- 	  
    clk_s  <= '0'; WAIT FOR 500 NS;
-- ----------------------------------------------------------------------------

    WAIT FOR 10 NS;
    ASSERT (false) REPORT "Done" SEVERITY error;

    WAIT;
  END PROCESS runTB;
END ar1;