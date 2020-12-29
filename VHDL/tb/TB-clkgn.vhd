-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY TB_clkgn IS END TB_clkgn;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF TB_clkgn IS

  -- input
  SIGNAL rst_n_i,clk_i : std_logic;
  -- output
  SIGNAL br_s : std_logic;

BEGIN
  
  -- Modules -----------------------------------------
  cbr : clkgn
    GENERIC MAP (4, 10)
    PORT    MAP (rst_n_i, clk_i, br_s);
  
  -- Process -----------------------------------------
  runTB : PROCESS
    VARIABLE dotimes_v  : integer :=   0;
    VARIABLE so_long_v : integer := 60;
  BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PINS
-- ----------------------------------------------------------------------------
    rst_n_i <= '1';
    clk_i   <= '0'; WAIT FOR 100 NS;
-- ----------------------------------------------------------------------------
-- STEP 2: Do a reset-cycle
-- ----------------------------------------------------------------------------
    rst_n_i <= '0'; WAIT FOR 100 NS;
    rst_n_i <= '1'; WAIT FOR 100 NS;
-- ----------------------------------------------------------------------------
-- STEP 3: Run Test-Patterns
-- ----------------------------------------------------------------------------
-- Some SYScp-cycles:
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
-- The LOOP-Statement is very handy for repeated activities
    FOR dotimes_v IN 1 TO so_long_v LOOP
  -- Some SYScp-cycles:
      clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
      clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
      clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
    END LOOP;

-- ---------------------------------------------------------------------------- 	  
    clk_i <= '0'; WAIT FOR 500 NS;
-- ----------------------------------------------------------------------------

    WAIT FOR 10 NS;
    ASSERT (false) REPORT "Done" SEVERITY error;

    WAIT;
  END PROCESS runTB;
END ar1;