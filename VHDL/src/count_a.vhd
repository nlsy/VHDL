-- ----------------------------------------------------------------------------
-- hc_a.vhd
-- ARCHITECTURE for the HC
-- 
-- Author: Nils Schlegel, 32067
--         Tara Jaishi, 32289
-- Last edited: 2020-11-13
-- ----------------------------------------------------------------------------
-- FPGA-chip: 10M16SAU169C8G (most likely)
-- ----------------------------------------------------------------------------

--ARCHITECTURE ar1 OF count IS
--
--  SIGNAL num_s : std_logic_vector(7 DOWNTO 0); -- 8 Bit
--
--BEGIN
--  
--  fsm: PROCESS (rb_i,cp_i)
--  BEGIN
--    IF    (rb_i='0')       THEN now_st <= init_st;
--    ELSIF (cp_i'EVENT AND cp_i='1') THEN now_st <= nxt_st;
--    END IF;
--  END PROCESS fsm;
--
--  st_fsm: PROCESS (inc_i, dec_i)
--  BEGIN
--    nxt_st <= init_st;
--    CASE now_st IS
--      WHEN min_st =>  IF    (inc_i='1' AND dec_i='0') THEN nxt_st <= inc_st;
--                      ELSE nxt_st <= min_st;
--                      END IF;
--      WHEN nml_st =>  IF    (inc_i='1' AND max_i='0') THEN nxt_st <= inc_st;
--                      ELSIF (inc_i='0' AND max_i='1') THEN nxt_st <= dec_st;
--                      ELSE nxt_st <= nml_st;
--                      END IF;
--      WHEN max_st =>  IF    (inc_i='0' AND dec_i='1') THEN nxt_st <= dec_st;
--                      ELSE nxt_st <= max_st;
--                      END IF;
--      WHEN inc_st =>  IF    (inc_i='0' AND dec_i='0') THEN nxt_st <= enter1_st;
--                      ELSIF (inc_i='0' AND dec_i='0') THEN nxt_st <= leave1_st;
--                      ELSE nxt_st <= dne_st;
--                      END IF;
--      WHEN dec_st =>  IF    (inc_i='1' AND dec_i='0') THEN nxt_st <= inc_st;
--                      ELSE nxt_st <= dec_st;
--                      END IF;
--      WHEN dne_st =>  IF    (inc_i='0' AND dec_i='1') THEN nxt_st <= dec_st;
--                      END IF;
--      WHEN inc_st      => nxt_st <= inctrans_st;
--      WHEN inctrans_st => nxt_st <= leave2_st;
--      WHEN dec_st      => nxt_st <= dectrans_st;
--      WHEN dectrans_st => nxt_st <= leave3_st;
--    END CASE;
--  END PROCESS st_fsm;
--
--  ausgabe: PROCESS (now_st)
--  BEGIN
--    CASE now_st IS
--      WHEN init_st     => min_o <= '0'; max_o <= '0'; dne_o <= '0';
--      WHEN wait_st     => dne_o <= '0'; dec_o <= '0'; sub_o <= '0';
--      WHEN max_st  => dne_o <= '1'; dec_o <= '0'; sub_o <= '0';
--      WHEN min_st  => dne_o <= '0'; dec_o <= '1'; sub_o <= '0';
--      WHEN inc_st      => dne_o <= '0'; dec_o <= '0'; sub_o <= '0'; num_s <= num_s + 1;
--      WHEN dec_st      => dne_o <= '0'; dec_o <= '0'; sub_o <= '0'; num_s <= num_s - 1;
--    END CASE;
--  END PROCESS ausgabe;
--  
--  min_o <= state_s(3) AND (NOT state_s(2)) AND state_s(1) AND state_s(0);
--  max_o <= state_s(3) AND (NOT state_s(2)) AND state_s(1) AND state_s(0);
--  num_o <= num_s;
--
--END ar1;

-- ----------------------------------------------------------------------------

--ARCHITECTURE ar1 OF count IS
--
--  SIGNAL num_s : std_logic_vector(7 DOWNTO 0); -- 8 Bit
--
--BEGIN
--  
--  fsm: PROCESS (rb_i,cp_i)
--  BEGIN
--    IF    (rb_i='0')       THEN now_st <= init_st;
--    ELSIF (cp_i'EVENT AND cp_i='1') THEN now_st <= nxt_st;
--    END IF;
--  END PROCESS fsm;
--
--  st_fsm: PROCESS (inc_i, dec_i)
--  BEGIN
--    nxt_st <= init_st;
--    CASE now_st IS
--      WHEN ini_st =>  IF    (inc_i='1' AND max_i='0') THEN nxt_st <= inc_st;
--                      ELSIF (inc_i='0' AND max_i='1') THEN nxt_st <= dec_st;
--                      ELSE nxt_st <= ini_st;
--                      END IF;
--      WHEN inc_st =>  IF    (inc_i='0' AND dec_i='0') THEN nxt_st <= enter1_st;
--                      ELSIF (inc_i='0' AND dec_i='0') THEN nxt_st <= leave1_st;
--                      ELSE nxt_st <= dne_st;
--                      END IF;
--      WHEN dec_st =>  IF    (inc_i='1' AND dec_i='0') THEN nxt_st <= inc_st;
--                      ELSE nxt_st <= dec_st;
--                      END IF;
--      WHEN dne_st =>  IF    (inc_i='0' AND dec_i='1') THEN nxt_st <= dec_st;
--                      END IF;
--    END CASE;
--  END PROCESS st_fsm;
--
--  ausgabe: PROCESS (now_st)
--  BEGIN
--    CASE now_st IS
--      WHEN init_st     => min_o <= '0'; max_o <= '0'; dne_o <= '0';
--      WHEN wait_st     => dne_o <= '0'; dec_o <= '0'; sub_o <= '0';
--      WHEN max_st  => dne_o <= '1'; dec_o <= '0'; sub_o <= '0';
--      WHEN min_st  => dne_o <= '0'; dec_o <= '1'; sub_o <= '0';
--      WHEN inc_st      => dne_o <= '0'; dec_o <= '0'; sub_o <= '0'; num_s <= num_s + 1;
--      WHEN dec_st      => dne_o <= '0'; dec_o <= '0'; sub_o <= '0'; num_s <= num_s - 1;
--    END CASE;
--  END PROCESS ausgabe;
--  
--  min_o <= state_s(3) AND (NOT state_s(2)) AND state_s(1) AND state_s(0);
--  max_o <= state_s(3) AND (NOT state_s(2)) AND state_s(1) AND state_s(0);
--  num_o <= num_s;
--
--END ar1;

-- ----------------------------------------------------------------------------

ARCHITECTURE ar2 OF count IS

  SIGNAL num_s : unsigned(7 DOWNTO 0); -- 8 Bit

BEGIN
  
  ru_n: PROCESS (cp_i, rb_i, inc_i, dec_i)
  BEGIN
    IF (rb_i = '0') THEN num_s <= "00000000";
    ELSIF (cp_i'EVENT AND cp_i = '1') THEN
      IF (inc_i = '1') THEN num_s <= num_s + 1;
      ELSIF (dec_i = '1') THEN num_s <= num_s - 1;
      END IF;
    END IF;
  END PROCESS ru_n;

  min_o <= '1' WHEN num_s="00000000" ELSE '0';
  max_o <= '1' WHEN num_s="11111111" ELSE '0';
  num_o <= std_logic_vector(num_s);

END ar2;