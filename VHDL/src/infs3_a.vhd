-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF infs3 IS

  -- Internal Signals --------------------------------
  SIGNAL ld_s,clr_s,dne_s,nxt_s : std_logic;
  SIGNAL sel_s : std_logic_vector( 4 DOWNTO 0);
  SIGNAL dat_s : std_logic_vector(15 DOWNTO 0);

BEGIN

  -- Modules -----------------------------------------
  ifsm: interface_fsm PORT MAP (rb_i,cp_i,sub_i,dne_s,ld_s,stx_o,sdv_o,clr_s,nxt_s);

  rge : regsr GENERIC MAP (evt_width_const)
              PORT MAP (rb_i,cp_i,ld_s,evt_i,dat_s(7 DOWNTO 0));
  rgn : regsr GENERIC MAP (num_width_const)
              PORT MAP (rb_i,cp_i,ld_s,num_i,dat_s(15 DOWNTO 8));

  --cnt: c16bin PORT MAP (rb_i,cp_i,nxt_s,clr_s,dne_s,sel_s);
  cnt : ctbin GENERIC MAP (5,16)
              PORT MAP (rb_i,cp_i,nxt_s,clr_s,dne_s,sel_s);
  mx: mx2snd PORT MAP (sel_s,dat_s,sdi_o);

END ar1;

-- ----------------------------------------------------------------------------