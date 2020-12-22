-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF trigger IS

  -- States ------------------------------------------
  TYPE state_t IS (init_st,enter1_st,leave1_st,enter2_st,leave2_st,enter3_st,leave3_st);
  -- Internal Signals --------------------------------
  SIGNAL stnow_s,stnxt_s : state_t;

BEGIN

  -- FSM Cycle ---------------------------------------
  fsm: PROCESS (rb_i,cp_i)
  BEGIN
    IF    (rb_i='0')       			THEN stnow_s <= init_st;
    ELSIF (cp_i'EVENT AND cp_i='1') THEN stnow_s <= stnxt_s;
    END IF;
  END PROCESS fsm;

  -- State Transition --------------------------------
  st_fsm: PROCESS (s1_i,s2_i,s3_i)
  BEGIN
    stnxt_s <= init_st;
    CASE stnow_s IS
      WHEN init_st => IF    (s1_i='1' AND s2_i='0' AND s3_i='0') THEN stnxt_s <= enter1_st;
                      ELSIF (s1_i='0' AND s2_i='0' AND s3_i='1') THEN stnxt_s <= leave1_st;
                      END IF;
      WHEN enter1_st => IF    (s1_i='0' AND s2_i='1' AND s3_i='0') THEN stnxt_s <= enter2_st;
                        ELSE                                            stnxt_s <= enter1_st;
                        END IF;
      WHEN leave1_st => IF    (s1_i='0' AND s2_i='1' AND s3_i='0') THEN stnxt_s <= leave2_st;
                        ELSE                                            stnxt_s <= leave1_st;
                        END IF;
      WHEN enter2_st => IF    (s1_i='0' AND s2_i='0' AND s3_i='1') THEN stnxt_s <= enter3_st;
                        ELSE                                            stnxt_s <= enter2_st;
                        END IF;
      WHEN leave2_st => IF    (s1_i='1' AND s2_i='0' AND s3_i='0') THEN stnxt_s <= leave3_st;
                        ELSE                                            stnxt_s <= leave2_st;
                        END IF;
      WHEN enter3_st =>                                                 stnxt_s <= init_st;
      WHEN leave3_st =>                                                 stnxt_s <= init_st;
    END CASE;
  END PROCESS st_fsm;

  -- State Outputs -----------------------------------
  st_out: PROCESS (stnow_s)
  BEGIN
    CASE stnow_s IS
      WHEN enter3_st => enter_o <= '1'; leave_o <= '0';
      WHEN leave3_st => enter_o <= '0'; leave_o <= '1';
      WHEN OTHERS => enter_o <= '0'; leave_o <= '0';
    END CASE;
  END PROCESS st_out;

END ar1;

-- ----------------------------------------------------------------------------