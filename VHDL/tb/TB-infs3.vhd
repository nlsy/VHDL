-- ----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.comp_pack.ALL;

-- ----------------------------------------------------------------------------

ENTITY TB_infs3 IS END TB_infs3;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF TB_infs3 IS

  -- input
  SIGNAL rst_n_s,clk_s,dv_s : std_logic;
  SIGNAL evt_s,num_s : std_logic_vector(7 DOWNTO 0);
  -- output
  SIGNAL sdi_s,sdv_s,stx_s : std_logic;

BEGIN
  
  -- Modules -----------------------------------------
  inf : infs3
    PORT    MAP (rst_n_s,clk_s, dv_s,evt_s,num_s,sdi_s,sdv_s,stx_s);
  
  -- Process -----------------------------------------
  runTB : PROCESS
    VARIABLE dotimes_v  : integer :=  0;
    VARIABLE so_long_v : integer := 25;
  BEGIN
-- ----------------------------------------------------------------------------
-- STEP 1: INIT all PINS
-- ----------------------------------------------------------------------------
    rst_n_s <= '1';
    clk_s   <= '0';
    dv_s    <= '0';
    evt_s   <= B"0010_0001";
    num_s   <= B"0101_0101"; WAIT FOR 100 NS;
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
-- The next rising slope of cp_i stores 6x4Bits into register
    clk_s <= '1'; WAIT FOR  10 NS;
      dv_s  <= '1'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
    clk_s <= '1'; WAIT FOR  10 NS;
      dv_s  <= '0'; WAIT FOR  90 NS;
    clk_s <= '0'; WAIT FOR 100 NS;
-- The LOOP-Statement is very handy for repeated activities
    FOR dotimes_v IN 1 TO so_long_v LOOP
  -- Some SYScp-cycles:
      clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
      clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
      clk_s <= '1'; WAIT FOR 100 NS; clk_s <= '0'; WAIT FOR 100 NS;
    END LOOP;

-- ----------------------------------------------------------------------------
    clk_s <= '0'; WAIT FOR 500 NS;
-- ----------------------------------------------------------------------------

    WAIT FOR 10 NS;
    ASSERT (false) REPORT "Done" SEVERITY error;

    WAIT;
  END PROCESS runTB;
END ar1;