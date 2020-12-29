-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF utfsm IS

  -- States ------------------------------------------
  TYPE state_t IS (
    wtdv_st,    -- wait until data valid
    ldrg_st,    -- load data in register
    wtbr_st,    -- wait till baud rate is 1 or goto wtdv when done transmitting
    cinc_st     -- get next bit (increment counter)
    );
  -- Internal Signals --------------------------------
  SIGNAL stnow_s,stnxt_s : state_t;

BEGIN

  -- FSM Cycle ---------------------------------------
  fsm: PROCESS (rst_n_i,clk_i)
  BEGIN
    IF    (rst_n_i='0')               THEN stnow_s <= wtdv_st;
    ELSIF (clk_i'EVENT AND clk_i='1') THEN stnow_s <= stnxt_s;
    END IF;
  END PROCESS fsm;

  -- State Transition --------------------------------
  st_fsm: PROCESS (stnow_s,dv_i,br_i,dne_i)
  BEGIN
    stnxt_s <= wtdv_st;
    CASE stnow_s IS
      WHEN wtdv_st => IF    (dv_i ='1') THEN stnxt_s <= ldrg_st;
	                    ELSE                stnxt_s <= wtdv_st;
                      END IF;
      WHEN ldrg_st =>                      stnxt_s <= wtbr_st;
      WHEN wtbr_st => IF    (dne_i='1') THEN stnxt_s <= wtdv_st;
                      ELSIF (br_i ='1') THEN stnxt_s <= cinc_st;
                      ELSE                 stnxt_s <= wtbr_st;
                      END IF;
      WHEN cinc_st =>                      stnxt_s <= wtbr_st;
    END CASE;
  END PROCESS st_fsm;

  -- State Outputs -----------------------------------
  st_out: PROCESS (stnow_s)
  BEGIN
    CASE stnow_s IS
      WHEN wtdv_st  =>  clr_o <= '1'; nxt_o  <= '0'; sto_o <= '0';
      WHEN ldrg_st  =>  clr_o <= '0'; nxt_o  <= '0'; sto_o <= '1';
      WHEN wtbr_st  =>  clr_o <= '0'; nxt_o  <= '0'; sto_o <= '0';
      WHEN cinc_st  =>  clr_o <= '0'; nxt_o  <= '1'; sto_o <= '0';	
    END CASE;
  END PROCESS st_out;

END ar1;

-- ----------------------------------------------------------------------------