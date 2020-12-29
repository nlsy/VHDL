-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY TB_toggl IS END TB_toggl;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF TB_toggl IS

  -- input
  SIGNAL rst_n_i,clk_i,hz_s : std_logic;
  -- output
  SIGNAL pls_s : std_logic;

BEGIN
  
  -- Modules -----------------------------------------
  tgl : toggl
    PORT 	  MAP (rst_n_i,clk_i, hz_s,pls_s);
  
  -- Process -----------------------------------------
  runTB : PROCESS
  BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PINS
-- ----------------------------------------------------------------------------
    rst_n_i <= '1';
    clk_i   <= '0'; WAIT FOR 100 NS;
    hz_s    <= '0';
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
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
-- Toggle
    clk_i <= '1'; WAIT FOR 100 NS;
      hz_s <= '1';
    clk_i <= '0'; WAIT FOR 100 NS;
    clk_i <= '1'; WAIT FOR 100 NS;
      hz_s <= '0';
    clk_i <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;
    ASSERT (pls_s = '0') REPORT "Switched to 1" SEVERITY note;
    ASSERT (pls_s = '1') REPORT "Is 0" SEVERITY note;

-- Some SYScp-cycles:
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
-- Toggle
    clk_i <= '1'; WAIT FOR 100 NS;
      hz_s <= '1';
    clk_i <= '0'; WAIT FOR 100 NS;
    clk_i <= '1'; WAIT FOR 100 NS;
      hz_s <= '0';
    clk_i <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;
    ASSERT (pls_s = '1') REPORT "Switched to 0" SEVERITY note;
    ASSERT (pls_s = '0') REPORT "Is 1" SEVERITY note;

-- Some SYScp-cycles:
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
-- Toggle
    clk_i <= '1'; WAIT FOR 100 NS;
      hz_s <= '1';
    clk_i <= '0'; WAIT FOR 100 NS;
    clk_i <= '1'; WAIT FOR 100 NS;
      hz_s <= '0';
    clk_i <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;
    ASSERT (pls_s = '1') REPORT "Switched to 1" SEVERITY note;
    ASSERT (pls_s = '0') REPORT "Is 0" SEVERITY note;

-- Some SYScp-cycles:
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
-- Toggle
    clk_i <= '1'; WAIT FOR 100 NS;
      hz_s <= '1';
    clk_i <= '0'; WAIT FOR 100 NS;
    clk_i <= '1'; WAIT FOR 100 NS;
      hz_s <= '0';
    clk_i <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;
    ASSERT (pls_s = '1') REPORT "Switched to 0" SEVERITY note;
    ASSERT (pls_s = '0') REPORT "Is 1" SEVERITY note;
    
-- Some SYScp-cycles:
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;
    clk_i <= '1'; WAIT FOR 100 NS; clk_i <= '0'; WAIT FOR 100 NS;

-- ---------------------------------------------------------------------------- 	  
    clk_i <= '0'; WAIT FOR 500 NS;
-- ----------------------------------------------------------------------------

    WAIT FOR 10 NS;
    ASSERT (false) REPORT "Done" SEVERITY error;

    WAIT;
  END PROCESS runTB;
END ar1;