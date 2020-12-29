-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY TB_uatpc IS END TB_uatpc;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF TB_uatpc IS

  -- input
  SIGNAL rst_n_s,clk_s,br_s,dv_s : std_logic;
  SIGNAL d_s : std_logic_vector(7 DOWNTO 0);
  -- output
  SIGNAL txd_s : std_logic;

BEGIN
  
  -- Modules -----------------------------------------
  uar : uatpc
    PORT 	  MAP (rst_n_s,clk_s, br_s, dv_s,  d_s,txd_s);
  
  -- Process -----------------------------------------
  runTB : PROCESS
    VARIABLE dotimes_v : integer :=  0;
    VARIABLE so_long_v : integer := 10;
  BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PINS
-- ----------------------------------------------------------------------------
    rst_n_s <= '1';
    clk_s   <= '0';
    br_s    <= '0';
    d_s     <=  B"0010_0001";
    dv_s    <= '0'; WAIT FOR 100 NS;
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
-- Now we set dv_s=log1.
-- The next rising slope of cp_i stores 6x4Bits into register
    clk_s <= '1'; WAIT FOR  10 NS; dv_s  <= '1'; WAIT FOR  90 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS; dv_s  <= '0'; WAIT FOR  90 NS; clk_s <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;	
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
-- Now we set br_s=log1. (duration: one SYScp-Period (@12MHz ca. 80ns)
-- This causes the uat-fsm to start the transmission of the packet
    clk_s <= '1'; WAIT FOR  10 NS; br_s  <= '1'; WAIT FOR  90 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS; br_s  <= '0'; WAIT FOR  90 NS; clk_s <= '0'; WAIT FOR 100 NS;
-- Some SYScp-cycles:
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;

-- The LOOP-Statement is very handy for repeated activities
    FOR dotimes_v IN 1 TO so_long_v LOOP  
      clk_s <= '1'; WAIT FOR  10 NS; br_s  <= '1'; WAIT FOR  90 NS; clk_s <= '0'; WAIT FOR 100 NS;
      clk_s <= '1'; WAIT FOR  10 NS; br_s  <= '0'; WAIT FOR  90 NS; clk_s <= '0'; WAIT FOR 100 NS;
  -- Some SYScp-cycles:
      clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
      clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
      clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    END LOOP;
    
    WAIT FOR 10 NS;
    ASSERT (txd_s = '0') REPORT "Everything ok" SEVERITY note;
    ASSERT (txd_s = '1') REPORT "After Transmitting txd_s not high" SEVERITY warning;

-- ---------------------------------------------------------------------------- 	  
    clk_s <= '0'; WAIT FOR 500 NS;
-- ----------------------------------------------------------------------------

    WAIT FOR 10 NS;
    ASSERT (false) REPORT "Done" SEVERITY error;

    WAIT;
  END PROCESS runTB;
END ar1;