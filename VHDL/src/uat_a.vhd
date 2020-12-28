-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF uat is

  SIGNAL dat_s    : std_logic_vector(num_width_const-1 DOWNTO 0);   -- 8 BCD
  SIGNAL sel_s   : std_logic_vector(3 DOWNTO 0);

  SIGNAL ld_s : std_logic;  -- load in register
  SIGNAL nxt_s : std_logic;                       -- Next Bit
  SIGNAL clr_s : std_logic;                       -- Clear Counters
  SIGNAL dne_s : std_logic;                       -- Last Bit of 8x8
  SIGNAL d_s : std_logic;
  SIGNAL txd_s : std_logic;

BEGIN

  -- Modules -----------------------------------------
  ufsm : uat_fsm PORT MAP (rb_i,cp_i,dv_i,br_i,dne_s,ld_s,clr_s,nxt_s);
  reg : regsr GENERIC MAP (8)
              PORT    MAP (rb_i,cp_i,ld_s,num_i,dat_s);          -- 8 Bit Register
  cnt : ctbin GENERIC MAP (4,11)
              PORT MAP (rb_i,cp_i,nxt_s,clr_s,dne_s,sel_s);
  mx : mx2tdo PORT MAP (sel_s,dat_s,txd_s);

  -- Outputs -----------------------------------------
  txd_o <= txd_s;

END ar1;

-- ----------------------------------------------------------------------------