-- ----------------------------------------------------------------------------
-- top_a.vhd
-- ARCHITECTURE for the TOP
-- 
-- Author: Nils Schlegel, 32067
--         Tara Jaishi, 32289
-- Last edited: 2020-11-13
-- ----------------------------------------------------------------------------
-- FPGA-chip: 10M16SAU169C8G (most likely)
-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF trigger IS

  TYPE state_name IS (init_st,enter1_st,leave1_st,enter2_st,leave2_st,enter3_st,leave3_st);
  SIGNAL now_st,nxt_st : state_name;

BEGIN

  fsm: PROCESS (rb_i,cp_i)
  BEGIN
    IF    (rb_i='0')       			THEN now_st <= init_st;
    ELSIF (cp_i'EVENT AND cp_i='1') THEN now_st <= nxt_st;
    END IF;
  END PROCESS fsm;

  st_fsm: PROCESS (s1_i,s2_i,s3_i)
  BEGIN
    nxt_st <= init_st;
    CASE now_st IS
      WHEN init_st => IF    (s1_i='1' AND s2_i='0' AND s3_i='0') THEN nxt_st <= enter1_st;
                      ELSIF (s1_i='0' AND s2_i='0' AND s3_i='1') THEN nxt_st <= leave1_st;
                      END IF;
      WHEN enter1_st => IF    (s1_i='0' AND s2_i='1' AND s3_i='0') THEN nxt_st <= enter2_st;
                      --ELSIF (s1_i='0' AND s2_i='0' AND s3_i='1') THEN nxt_st <= leave1_st;
                        ELSE                                            nxt_st <= enter1_st;
                        END IF;
      WHEN leave1_st => IF    (s1_i='0' AND s2_i='1' AND s3_i='0') THEN nxt_st <= leave2_st;
                      --ELSIF (s1_i='1' AND s2_i='0' AND s3_i='0') THEN nxt_st <= enter1_st;
                        ELSE                                            nxt_st <= leave1_st;
                        END IF;
      WHEN enter2_st => IF    (s1_i='0' AND s2_i='0' AND s3_i='1') THEN nxt_st <= enter3_st;
                      --ELSIF (s1_i='0' AND s2_i='0' AND s3_i='0') THEN nxt_st <= enter2_st;
                        ELSE                                            nxt_st <= enter2_st;
                        END IF;
      WHEN leave2_st => IF    (s1_i='1' AND s2_i='0' AND s3_i='0') THEN nxt_st <= leave3_st;
                      --ELSIF (s1_i='0' AND s2_i='0' AND s3_i='0') THEN nxt_st <= leave2_st;
                        ELSE                                            nxt_st <= leave2_st;
                        END IF;
      WHEN enter3_st =>                                                 nxt_st <= init_st;
      WHEN leave3_st =>                                                 nxt_st <= init_st;
    END CASE;
  END PROCESS st_fsm;

  ausgabe: PROCESS (now_st)
  BEGIN
    CASE now_st IS
      WHEN init_st   => enter_o <= '0'; leave_o <= '0';
      WHEN enter1_st => enter_o <= '0'; leave_o <= '0';
      WHEN leave1_st => enter_o <= '0'; leave_o <= '0';
      WHEN enter2_st => enter_o <= '0'; leave_o <= '0';
      WHEN leave2_st => enter_o <= '0'; leave_o <= '0';
      WHEN enter3_st => enter_o <= '1'; leave_o <= '0';
      WHEN leave3_st => enter_o <= '0'; leave_o <= '1';
    END CASE;
  END PROCESS ausgabe;

END ar1;
