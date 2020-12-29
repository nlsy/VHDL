-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF cntrl IS

  -- States ------------------------------------------
  TYPE state_t IS (
    ini_wait_st,    -- wait until
    inc_clac_st,    -- send increase signal to headcounter
    dec_calc_st,    -- send decrease signal to headcounter
    inc_wait_st,    -- wait until headcount calculated
    dec_wait_st,    -- wait until headcount calculated
    inc_vali_st,    -- done calculating, check if max
    dec_vali_st,    -- done calculating, check if min
    inc_send_st,    -- start sending num and ascii
    dec_send_st,    -- start sending num and ascii
    min_send_st,    -- start sending num and ascii
    max_send_st     -- start sending num and ascii
    );
  -- Internal Signals --------------------------------
  SIGNAL stnow_s,stnxt_s : state_t;

BEGIN

  -- FSM Cycle ---------------------------------------
  fsm: PROCESS (rst_n_i,clk_i)
  BEGIN
    IF    (rst_n_i='0')       	      THEN stnow_s <= ini_wait_st;
    ELSIF (clk_i'EVENT AND clk_i='1') THEN stnow_s <= stnxt_s;
    END IF;
  END PROCESS fsm;

  -- State Transition --------------------------------
  st_fsm: PROCESS (stnow_s, add_i, sub_i, max_i, min_i)
  BEGIN
    stnxt_s <= ini_wait_st;
    CASE stnow_s IS
      WHEN ini_wait_st => IF    (add_i='1' AND sub_i='0' AND max_i='0') THEN
                                                 stnxt_s <= inc_clac_st;
                          ELSIF (add_i='0' AND sub_i='1' AND min_i='0') THEN
                                                 stnxt_s <= dec_calc_st;
                          ELSE                   stnxt_s <= ini_wait_st;
                          END IF;
      WHEN inc_clac_st =>                        stnxt_s <= inc_wait_st;
      WHEN dec_calc_st =>                        stnxt_s <= dec_wait_st;
      WHEN inc_wait_st =>                        stnxt_s <= inc_vali_st;
      WHEN dec_wait_st =>                        stnxt_s <= dec_vali_st;
      WHEN inc_vali_st => IF    (max_i='1') THEN stnxt_s <= max_send_st;
                          ELSE                   stnxt_s <= inc_send_st;
                          END IF;
      WHEN dec_vali_st => IF    (min_i='1') THEN stnxt_s <= min_send_st;
                          ELSE                   stnxt_s <= dec_send_st;
                          END IF;
      WHEN inc_send_st =>                        stnxt_s <= ini_wait_st;
      WHEN dec_send_st =>                        stnxt_s <= ini_wait_st;
      WHEN min_send_st =>                        stnxt_s <= ini_wait_st;
      WHEN max_send_st =>                        stnxt_s <= ini_wait_st;
    END CASE;
  END PROCESS st_fsm;

  -- State Outputs -----------------------------------
  st_out: PROCESS (stnow_s)
  BEGIN
    CASE stnow_s IS
      WHEN inc_clac_st => inc_o <= '1'; dec_o <= '0'; sub_o <= '0';
                          evt_o <= "00000000";
      WHEN dec_calc_st => inc_o <= '0'; dec_o <= '1'; sub_o <= '0';
                          evt_o <= "00000000";
      WHEN inc_vali_st => inc_o <= '0'; dec_o <= '0'; sub_o <= '1';
                          evt_o <= "00000000";
      WHEN dec_vali_st => inc_o <= '0'; dec_o <= '0'; sub_o <= '1';
                          evt_o <= "00000000";
      WHEN inc_send_st => inc_o <= '0'; dec_o <= '0'; sub_o <= '0';
                          evt_o <= "00101011"; -- ascii '+'
      WHEN dec_send_st => inc_o <= '0'; dec_o <= '0'; sub_o <= '0';
                          evt_o <= "00101101"; -- ascii '-'
      WHEN min_send_st => inc_o <= '0'; dec_o <= '0'; sub_o <= '0';
                          evt_o <= "00101101"; -- ascii '-'
      WHEN max_send_st => inc_o <= '0'; dec_o <= '0'; sub_o <= '0';
                          evt_o <= "00100001"; -- ascii '!'
      WHEN OTHERS      => inc_o <= '0'; dec_o <= '0'; sub_o <= '0';
                          evt_o <= "00000000";
    END CASE;
  END PROCESS st_out;

END ar1;

-- ----------------------------------------------------------------------------