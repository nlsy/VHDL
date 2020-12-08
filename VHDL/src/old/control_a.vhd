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

ARCHITECTURE ar1 OF control IS

  TYPE state_name IS (init_st,min_wait_st,nml_wait_st,max_wait_st,inc_clac_st,dec_calc_st,inc_conf_st,dec_conf_st,inc_send_st,dec_send_st,min_send_st,max_send_st);
  SIGNAL now_st,nxt_st : state_name;

  SIGNAL inc_s, dec_s : std_logic;

BEGIN

  fsm: PROCESS (rb_i,cp_i)
  BEGIN
    IF    (rb_i='0')       	        THEN now_st <= init_st;
    ELSIF (cp_i'EVENT AND cp_i='1') THEN now_st <= nxt_st;
    END IF;
  END PROCESS fsm;

  st_fsm: PROCESS (now_st, enter_i, leave_i)
  BEGIN
    nxt_st <= init_st;
    CASE now_st IS
      WHEN init_st     => IF    (min_i='1' AND max_i='0') THEN nxt_st <= min_wait_st;
                          ELSIF (min_i='0' AND max_i='1') THEN nxt_st <= max_wait_st;
                          ELSE nxt_st <= nml_wait_st;
                          END IF;
      WHEN min_wait_st => IF    (enter_i='1' AND leave_i='0') THEN nxt_st <= inc_clac_st;
                          ELSE  nxt_st <= min_wait_st;
                          END IF;
      WHEN nml_wait_st => IF    (enter_i='1' AND leave_i='0') THEN nxt_st <= inc_clac_st;
                          ELSIF (enter_i='0' AND leave_i='1') THEN nxt_st <= dec_calc_st;
                          ELSE  nxt_st <= nml_wait_st;
                          END IF;
      WHEN max_wait_st => IF    (enter_i='0' AND leave_i='1') THEN nxt_st <= dec_calc_st;
                          ELSE  nxt_st <= max_wait_st;
                          END IF;
      WHEN inc_clac_st => nxt_st <= inc_conf_st;
      WHEN dec_calc_st => nxt_st <= dec_conf_st;
      WHEN inc_conf_st => IF    (max_i='1') THEN nxt_st <= max_send_st;
                          ELSE  nxt_st <= inc_send_st;
                          END IF;
      WHEN dec_conf_st => IF    (min_i='1') THEN nxt_st <= min_send_st;
                          ELSE  nxt_st <= dec_send_st;
                          END IF;
      WHEN inc_send_st => nxt_st <= nml_wait_st;
      WHEN dec_send_st => nxt_st <= nml_wait_st;
      WHEN min_send_st => nxt_st <= min_wait_st;
      WHEN max_send_st => nxt_st <= max_wait_st;
    END CASE;
  END PROCESS st_fsm;

  ausgabe: PROCESS (now_st)
  BEGIN
    CASE now_st IS
      WHEN inc_clac_st => inc_s <= '1'; dec_s <= '0'; sub_o <= '0'; evt_o <= "00000000";
      WHEN dec_calc_st => inc_s <= '0'; dec_s <= '1'; sub_o <= '0'; evt_o <= "00000000";
      WHEN inc_send_st => inc_s <= '0'; dec_s <= '0'; sub_o <= '1'; evt_o <= "00101011"; -- ascii '+'
      WHEN dec_send_st => inc_s <= '0'; dec_s <= '0'; sub_o <= '1'; evt_o <= "00101101"; -- ascii '-'
      WHEN min_send_st => inc_s <= '0'; dec_s <= '0'; sub_o <= '1'; evt_o <= "00101101"; -- ascii '-'
      WHEN max_send_st => inc_s <= '0'; dec_s <= '0'; sub_o <= '1'; evt_o <= "00100001"; -- ascii '!'
      WHEN OTHERS => inc_s <= '0'; dec_s <= '0'; sub_o <= '0'; evt_o <= "00000000";
    END CASE;
  END PROCESS ausgabe;

  inc_o <= inc_s;
  dec_o <= dec_s;

END ar1;


--st_fsm: PROCESS (cp_i, enter_i, leave_i, conf_i)
--BEGIN
--  nxt_st <= init_st;
--  CASE now_st IS
--    WHEN init_st     => IF    (min_i='1' AND max_i='0') THEN nxt_st <= min_wait_st;
--                        ELSIF (min_i='0' AND max_i='1') THEN nxt_st <= max_wait_st;
--                        ELSE nxt_st <= nml_wait_st;
--                        END IF;
--    WHEN min_wait_st => IF    (enter_i='1' AND leave_i='0') THEN nxt_st <= inc_clac_st;
--                        ELSE  nxt_st <= min_wait_st;
--                        END IF;
--    WHEN nml_wait_st => IF    (enter_i='1' AND leave_i='0') THEN nxt_st <= inc_clac_st;
--                        ELSIF (enter_i='0' AND leave_i='1') THEN nxt_st <= dec_calc_st;
--                        ELSE  nxt_st <= nml_wait_st;
--                        END IF;
--    WHEN max_wait_st => IF    (enter_i='0' AND leave_i='1') THEN nxt_st <= dec_calc_st;
--                        ELSE  nxt_st <= max_wait_st;
--                        END IF;
--    WHEN inc_clac_st => IF    (enter_i='0' AND leave_i='1') THEN nxt_st <= dec_st;
--                        ELSE  nxt_st <= inc_clac_st;
--                        END IF;
--    WHEN dec_calc_st => IF    (enter_i='0' AND leave_i='1') THEN nxt_st <= dec_conf_st;
--                        ELSE  nxt_st <= dec_calc_st;
--                        END IF;
--    WHEN inc_conf_st => IF    (conf_i='1' AND max_i='0') THEN nxt_st <= inc_send_st;
--                        ELSIF (conf_i='1' AND max_i='1') THEN nxt_st <= max_send_st;
--                        ELSE  nxt_st <= inc_conf_st;
--                        END IF;
--    WHEN dec_conf_st => IF    (conf_i='1' AND max_i='0') THEN nxt_st <= dec_send_st;
--                        ELSIF (conf_i='1' AND min_i='0') THEN nxt_st <= min_send_st;
--                        ELSE  nxt_st <= dec_conf_st;
--                        END IF;
--    WHEN inc_send_st => nxt_st <= nml_wait_st;
--    WHEN dec_send_st => nxt_st <= nml_wait_st;
--    WHEN min_send_st => nxt_st <= min_wait_st;
--    WHEN max_send_st => nxt_st <= max_wait_st;
--  END CASE;
--END PROCESS st_fsm;
