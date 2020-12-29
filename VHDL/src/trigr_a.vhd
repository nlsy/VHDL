-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF trigr IS

  -- States ------------------------------------------
  TYPE state_t IS (
    init_st,    -- wait for either sensor 1 or sensor 2 triggered
    ewt1_st,    -- someone entering, sensor 1 triggered wait for sensor 2
    lwt1_st,    -- someone leaving, sensor 3 triggered wait for sensor 2
    ewt2_st,    -- someone entering, sensor 2 triggered wait for sensor 3
    lwt2_st,    -- someone leaving, sensor 2 triggered wait for sensor 1
    ewt3_st,    -- someone entering, sensor 3 triggered -> back to init
    lwt3_st     -- someone leaving, sensor 1 triggered -> back to init
    );
  -- Internal Signals --------------------------------
  SIGNAL stnow_s,stnxt_s : state_t;

BEGIN
  
  -- Modules -----------------------------------------

  -- FSM Cycle ---------------------------------------
  fsm: PROCESS (rst_n_i,clk_i)
  BEGIN
    IF    (rst_n_i='0')       	  		THEN stnow_s <= init_st;
    ELSIF (clk_i'EVENT AND clk_i='1') THEN stnow_s <= stnxt_s;
    END IF;
  END PROCESS fsm;

  -- State Transition --------------------------------
  st_fsm: PROCESS (s1_i,s2_i,s3_i)
  BEGIN
    stnxt_s <= init_st;
    CASE stnow_s IS
      WHEN init_st => IF    (s1_i='1' AND s2_i='0' AND s3_i='0') THEN
                              stnxt_s <= ewt1_st;
                      ELSIF (s1_i='0' AND s2_i='0' AND s3_i='1') THEN
                              stnxt_s <= lwt1_st;
                      END IF;
      WHEN ewt1_st => IF    (s1_i='0' AND s2_i='1' AND s3_i='0') THEN
                              stnxt_s <= ewt2_st;
                      ELSE    stnxt_s <= ewt1_st;
                      END IF;
      WHEN lwt1_st => IF    (s1_i='0' AND s2_i='1' AND s3_i='0') THEN
                              stnxt_s <= lwt2_st;
                      ELSE    stnxt_s <= lwt1_st;
                      END IF;
      WHEN ewt2_st => IF    (s1_i='0' AND s2_i='0' AND s3_i='1') THEN
                              stnxt_s <= ewt3_st;
                      ELSE    stnxt_s <= ewt2_st;
                      END IF;
      WHEN lwt2_st => IF    (s1_i='1' AND s2_i='0' AND s3_i='0') THEN
                              stnxt_s <= lwt3_st;
                      ELSE    stnxt_s <= lwt2_st;
                      END IF;
      WHEN ewt3_st =>         stnxt_s <= init_st;
      WHEN lwt3_st =>         stnxt_s <= init_st;
    END CASE;
  END PROCESS st_fsm;

  -- State Outputs -----------------------------------
  st_out: PROCESS (stnow_s)
  BEGIN
    CASE stnow_s IS
      WHEN ewt3_st => add_o <= '1'; sub_o <= '0';
      WHEN lwt3_st => add_o <= '0'; sub_o <= '1';
      WHEN OTHERS => add_o <= '0'; sub_o <= '0';
    END CASE;
  END PROCESS st_out;

END ar1;

-- ----------------------------------------------------------------------------