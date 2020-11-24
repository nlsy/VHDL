-- ----------------------------------------------------------------------------
-- uat_fsm_a.vhd
-- ARCHITECTURE for the UAT_FSM
-- 
-- Author: Nils Schlegel, 32067
--         Tara Jaishi, 32289
-- Last edited: 2020-11-13
-- ----------------------------------------------------------------------------
-- FPGA-chip: 10M16SAU169C8G (most likely)
-- ----------------------------------------------------------------------------

ARCHITECTURE uat_fsm_a OF uat_fsm IS

  TYPE state_name IS (wtdv_st,ldrg_st,wtb0_st,cinc_st,wt2_st);
  SIGNAL now_st,nxt_st : state_name;

BEGIN

  clkd: PROCESS (rb_i,cp_i)
  BEGIN
    IF (rb_i='0') THEN now_st <= wtdv_st;
    ELSIF (cp_i'EVENT AND cp_i='1') THEN now_st <= nxt_st;
    END IF;
  END PROCESS clkd;
-- ----------------------------------------------------------------------------
  st_trans: PROCESS (now_st,dv_i,br_i,dne_i)
  Begin
    nxt_st <= wtdv_st;
    CASE now_st IS
      WHEN wtdv_st  => IF (dv_i ='1') THEN nxt_st <= ldrg_st;
	                  ELSE                nxt_st <= wtdv_st;
                      END IF;
      WHEN ldrg_st  =>                     nxt_st <= wtb0_st;
      WHEN wtb0_st  => IF (br_i ='1') THEN nxt_st <= cinc_st;
                      ELSE                nxt_st <= wtb0_st;
                      END IF;
      WHEN cinc_st  =>                     nxt_st <= wt2_st;
      WHEN wt2_st   => IF (dne_i='1') THEN nxt_st <= wtdv_st;
                      ELSE                nxt_st <= wtb0_st;
                      END IF;
    END CASE;
  END PROCESS st_trans;
-- ----------------------------------------------------------------------------
  ausgabe : PROCESS (now_st)
  BEGIN
    CASE now_st IS
      WHEN wtdv_st  =>  clr_o <= '1'; nxt_o  <= '0'; sto_o <= '0';
      WHEN ldrg_st  =>  clr_o <= '0'; nxt_o  <= '0'; sto_o <= '1';
      WHEN wtb0_st  =>  clr_o <= '0'; nxt_o  <= '0'; sto_o <= '0';
      WHEN cinc_st  =>  clr_o <= '0'; nxt_o  <= '1'; sto_o <= '0';
      WHEN wt2_st   =>  clr_o <= '0'; nxt_o  <= '0'; sto_o <= '0';
    END CASE;
  END PROCESS ausgabe;

END uat_fsm_a;