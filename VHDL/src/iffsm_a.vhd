-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF iffsm IS

  -- States ------------------------------------------
  TYPE state_t IS (wtdv_st, load_st, tick_st, incr_st,gaps_st, vali_st);
  -- Internal Signals --------------------------------
  SIGNAL stnow_s,stnxt_s : state_t;

BEGIN

  -- FSM Cycle ---------------------------------------
  fsm: PROCESS (rst_n_i,clk_i)
  BEGIN
    IF (rst_n_i='0') THEN stnow_s <= wtdv_st;
    ELSIF (clk_i'EVENT AND clk_i='1') THEN stnow_s <= stnxt_s;
    END IF;
  END PROCESS fsm;

  -- State Transition --------------------------------
  st_fsm: PROCESS (stnow_s,dv_i,dne_i)
  BEGIN
    stnxt_s <= wtdv_st;
    CASE stnow_s IS
     WHEN wtdv_st  => IF (dv_i ='1') THEN stnxt_s <= load_st;
	                    ELSE                stnxt_s <= wtdv_st;
                      END IF;
     WHEN load_st  =>                     stnxt_s <= tick_st;
     WHEN tick_st  => IF (dne_i='1') THEN stnxt_s <= wtdv_st;
                      ELSE                stnxt_s <= incr_st;
                      END IF;
     WHEN incr_st  =>                     stnxt_s <= gaps_st;
     WHEN gaps_st  =>                     stnxt_s <= vali_st;
     WHEN vali_st  =>                     stnxt_s <= tick_st;
  END CASE;
  END PROCESS st_fsm;

  -- State Outputs -----------------------------------
  st_out: PROCESS (stnow_s)
  BEGIN
    CASE stnow_s IS
     WHEN wtdv_st =>  clr_o <= '1'; nxt_o  <= '0'; ldr_o <= '0';
                      vld_o <= '0'; act_o <= '0';
     WHEN load_st =>  clr_o <= '0'; nxt_o  <= '0'; ldr_o <= '1';
                      vld_o <= '0'; act_o <= '0';
     WHEN tick_st =>  clr_o <= '0'; nxt_o  <= '0'; ldr_o <= '0';
                      vld_o <= '0'; act_o <= '1';
     WHEN incr_st =>  clr_o <= '0'; nxt_o  <= '1'; ldr_o <= '0';
                      vld_o <= '0'; act_o <= '1';
     WHEN gaps_st =>  clr_o <= '0'; nxt_o  <= '0'; ldr_o <= '0';
                      vld_o <= '0'; act_o <= '1';
     WHEN vali_st =>  clr_o <= '0'; nxt_o  <= '0'; ldr_o <= '0';
                      vld_o <= '1'; act_o <= '1';
    END CASE;
  END PROCESS st_out;

END ar1;

-- ----------------------------------------------------------------------------