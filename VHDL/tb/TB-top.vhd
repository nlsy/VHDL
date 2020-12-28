-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY TB1_top IS END TB1_top;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF TB1_top IS

  -- input
  SIGNAL rst_n_s,clk_s,s1_s,s2_s,s3_s,br_s : std_logic;
  -- internal
  SIGNAL add_s,sub_s,min_s,max_s,inc_s,dec_s,dv_s : std_logic;
  SIGNAL evt_s,num_s : std_logic_vector(7 DOWNTO 0);
  -- output
  SIGNAL grn_s,red_s,txd_s,sdi_s,sdv_s,stx_s : std_logic;

BEGIN
  
  -- Modules -----------------------------------------
  -- HeadCount
  hdc : hdcnt GENERIC MAP (8, 3)
              PORT    MAP (rst_n_s,clk_s,inc_s,dec_s,min_s,max_s,num_s);
  -- EventHandler
  tri : trigr PORT    MAP (rst_n_s,clk_s, s1_s, s2_s, s3_s,add_s,sub_s);
  -- UniqueTime
  con : cntrl PORT    MAP (rst_n_s,clk_s,add_s,sub_s,min_s,max_s,inc_s,dec_s,evt_s,dv_s);
  -- UART
  uar : uatpc PORT 	  MAP (rst_n_s,clk_s, br_s, dv_s,num_s,txd_s);
  -- S3 Interface
  inf : infs3 PORT    MAP (rst_n_s,clk_s, dv_s,evt_s,num_s,sdi_s,sdv_s,stx_s);
  -- Pulse LED toggle
  --tgl : toggl PORT 	  MAP (rst_n_s,clk_s, hz_s,pls_s);
  
  grn_s <= NOT max_s; -- green LED
  red_s <= max_s; -- red LED

  runTB : PROCESS
    VARIABLE dotimes  : integer :=   0;
    VARIABLE so_long  : integer := 20;
  BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PINS
-- ----------------------------------------------------------------------------
    rst_n_s  <= '1';
    clk_s  <= '0';
    s1_s <= '0';
    s2_s <= '0';
    s3_s <= '0';
    br_s <= '0'; WAIT FOR 100 NS;
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
-- The next rising slope of clk_s triggeres the increment
    clk_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;
    ASSERT (inc_s = '1') REPORT "Enter triggered" SEVERITY note;
    ASSERT (inc_s = '0') REPORT "Enter not triggered" SEVERITY note;

-- Some SYScp-cycles:
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;	
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
-- Some baud_rate signals
-- The LOOP-Statement is very handy for repeated activities
    FOR dotimes IN 1 TO so_long LOOP
      clk_s  <= '1'; WAIT FOR  10 NS; br_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR  10 NS; br_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    END LOOP;

-- Some SYScp-cycles:
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
-- The next rising slope of clk_s triggeres the increment
    clk_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;
    ASSERT (inc_s = '1') REPORT "Enter triggered" SEVERITY note;
    ASSERT (inc_s = '0') REPORT "Enter not triggered" SEVERITY note;

-- Some SYScp-cycles:
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;	
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
-- Some baud_rate signals
-- The LOOP-Statement is very handy for repeated activities
    FOR dotimes IN 1 TO so_long LOOP
      clk_s  <= '1'; WAIT FOR  10 NS; br_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR  10 NS; br_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    END LOOP;

-- Some SYScp-cycles:
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
-- The next rising slope of clk_s triggeres the increment
    clk_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    
    WAIT FOR 10 NS;
    ASSERT (dec_s = '1') REPORT "Leave triggered" SEVERITY note;
    ASSERT (dec_s = '0') REPORT "Leave not triggered" SEVERITY note;
-- Some SYScp-cycles:
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
-- Some baud_rate signals
-- The LOOP-Statement is very handy for repeated activities
    FOR dotimes IN 1 TO so_long LOOP
      clk_s  <= '1'; WAIT FOR  10 NS; br_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR  10 NS; br_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    END LOOP;

-- Some SYScp-cycles:
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
-- The next rising slope of clk_s triggeres the increment
    clk_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s3_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s2_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR  10 NS; s1_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;	
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;	
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
-- Some baud_rate signals
-- The LOOP-Statement is very handy for repeated activities
    FOR dotimes IN 1 TO so_long LOOP
      clk_s  <= '1'; WAIT FOR  10 NS; br_s  <= '1'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR  10 NS; br_s  <= '0'; WAIT FOR  90 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
      clk_s  <= '1'; WAIT FOR 100 NS; clk_s  <= '0'; WAIT FOR 100 NS;
    END LOOP;

-- ---------------------------------------------------------------------------- 	  
    clk_s  <= '0'; WAIT FOR 500 NS;
-- ----------------------------------------------------------------------------

    WAIT FOR 10 NS;
    ASSERT (false) REPORT "Done" SEVERITY error;

    WAIT;
  END PROCESS runTB;
END ar1;