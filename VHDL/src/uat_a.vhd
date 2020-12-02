-- ----------------------------------------------------------------------------
-- uat_a.vhd
-- ARCHITECTURE for the UAT
-- 
-- Author: Nils Schlegel, 32067
--         Tara Jaishi, 32289
-- Last edited: 2020-11-13
-- ----------------------------------------------------------------------------
-- FPGA-chip: 10M16SAU169C8G (most likely)
-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF uat is

  SIGNAL dat_s    : std_logic_vector(7 DOWNTO 0);   -- 8 BCD
  SIGNAL sel_s   : std_logic_vector(3 DOWNTO 0);

  SIGNAL ld_s : std_logic;  -- load in register
  SIGNAL nxt_s : std_logic;                       -- Next Bit
  SIGNAL clr_s : std_logic;                       -- Clear Counters
  SIGNAL dne_s : std_logic;                       -- Last Bit of 8x8
  SIGNAL d_s : std_logic;
  SIGNAL txd_s : std_logic;

BEGIN

  ufsm: uat_fsm PORT MAP (rb_i,cp_i,dv_i,br_i,dne_s,ld_s,clr_s,nxt_s);
  
  reg: reg8 PORT MAP (rb_i,cp_i,ld_s,num_i,dat_s);          -- 8 Bit Register

  cnt: c11bin PORT MAP (rb_i,cp_i,nxt_s,clr_s,dne_s,sel_s);

  mx: mx2tdo PORT MAP (sel_s,dat_s,txd_s);

  txd_o <= txd_s;

END ar1;