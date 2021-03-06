-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY TB_trigr IS END TB_trigr;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF TB_trigr IS

  -- input
  SIGNAL rst_n_s,clk_s,s1_s,s2_s,s3_s : std_logic;
  -- output
  SIGNAL add_s,sub_s : std_logic;

BEGIN
  
  -- Modules -----------------------------------------
  tri : trigr
    PORT    MAP (rst_n_s,clk_s, s1_s, s2_s, s3_s,add_s,sub_s);
  
  -- Process -----------------------------------------
  runTB : PROCESS
  BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PINS
-- ----------------------------------------------------------------------------
    rst_n_s <= '1';
    clk_s   <= '0';
    s1_s    <= '0';
    s2_s    <= '0';
    s3_s    <= '0'; WAIT FOR 100 NS;
-- ----------------------------------------------------------------------------
-- STEP 2: Do a reset-cycle
-- ----------------------------------------------------------------------------
    rst_n_s <= '0'; WAIT FOR 100 NS;
    rst_n_s <= '1'; WAIT FOR 100 NS;
-- ----------------------------------------------------------------------------
-- STEP 3: Run Test-Patterns
-- ----------------------------------------------------------------------------
-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
-- Send Enter Code
    clk_s <= '1'; WAIT FOR  10 NS;
      s1_s  <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      s1_s  <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      s2_s  <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      s2_s  <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      s3_s  <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      s3_s  <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;
    ASSERT (add_s = '0') REPORT "Enter triggered" SEVERITY note;
    ASSERT (add_s = '1') REPORT "Enter not triggered" SEVERITY warning;

-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
-- Send Leave Code
    clk_s <= '1'; WAIT FOR  10 NS;
      s3_s  <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      s3_s  <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      s2_s  <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      s2_s  <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      s1_s  <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      s1_s  <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;
    ASSERT (sub_s = '0') REPORT "Leave triggered" SEVERITY note;
    ASSERT (sub_s = '1') REPORT "Leave not triggered" SEVERITY warning;

-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;

-- ----------------------------------------------------------------------------
    clk_s <= '0'; WAIT FOR 500 NS;
-- ----------------------------------------------------------------------------

    WAIT FOR 10 NS;
    ASSERT (false) REPORT "Done" SEVERITY error;

    WAIT;
  END PROCESS runTB;
END ar1;