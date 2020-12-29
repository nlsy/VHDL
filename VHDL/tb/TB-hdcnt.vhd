-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY TB_hdcnt IS END TB_hdcnt;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF TB_hdcnt IS

  -- input
  SIGNAL rst_n_s,clk_s,inc_s,dec_s : std_logic;
  -- output
  SIGNAL min_s,max_s : std_logic;
  SIGNAL num_s : std_logic_vector(7 DOWNTO 0);

BEGIN
  
  -- Modules -----------------------------------------
  hdc : hdcnt
    GENERIC MAP (8, 3)
    PORT    MAP (rst_n_s,clk_s,inc_s,dec_s,min_s,max_s,num_s);
  
  -- Process -----------------------------------------
  runTB : PROCESS
    VARIABLE dotimes_v  : integer :=   0;
    VARIABLE so_long_v : integer := 1000; -- 12000000;
  BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PINS
-- ----------------------------------------------------------------------------
    rst_n_s <= '1';
    clk_s <= '0';
    inc_s <= '0';
    dec_s <= '0'; WAIT FOR 100 NS;
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

-- The next rising slope of cp_i triggeres the increment
    clk_s <= '1'; WAIT FOR  10 NS;
      inc_s <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      inc_s <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;	
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;

-- The next rising slope of cp_i triggeres the decrement
    clk_s <= '1'; WAIT FOR  10 NS;
      dec_s <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      dec_s <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;	
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;

-- The next rising slope of cp_i triggeres the increment
    clk_s <= '1'; WAIT FOR  10 NS;
      inc_s <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      inc_s <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;	
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;

-- The next rising slope of cp_i triggeres the increment
    clk_s <= '1'; WAIT FOR  10 NS;
      inc_s <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      inc_s <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;	
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    
-- The next rising slope of cp_i triggeres the increment
    clk_s <= '1'; WAIT FOR  10 NS;
      inc_s <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      inc_s <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;	
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;
    ASSERT (max_s = '0') REPORT "Maximum reached" SEVERITY note;

-- The next rising slope of cp_i triggeres the increment
    clk_s <= '1'; WAIT FOR  10 NS;
      inc_s <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      inc_s <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;	
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;
    ASSERT (max_s = '0') REPORT "Maximum reached" SEVERITY note;

-- The next rising slope of cp_i triggeres the decrement
    clk_s <= '1'; WAIT FOR  10 NS;
      dec_s <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      dec_s <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;	
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;

-- The next rising slope of cp_i triggeres the decrement
    clk_s <= '1'; WAIT FOR  10 NS;
      dec_s <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      dec_s <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;	
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;

-- The next rising slope of cp_i triggeres the decrement
    clk_s <= '1'; WAIT FOR  10 NS;
      dec_s <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      dec_s <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;	
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;
    ASSERT (min_s = '0') REPORT "Minimum reached" SEVERITY note;

-- The next rising slope of cp_i triggeres the decrement
    clk_s <= '1'; WAIT FOR  10 NS;
      dec_s <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      dec_s <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;	
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;
    ASSERT (min_s = '0') REPORT "Minimum reached" SEVERITY note;

-- ----------------------------------------------------------------------------
    clk_s <= '0'; WAIT FOR 500 NS;
-- ----------------------------------------------------------------------------

    WAIT FOR 10 NS;
    ASSERT (false) REPORT "Done" SEVERITY error;

    WAIT;
  END PROCESS runTB;
END ar1;