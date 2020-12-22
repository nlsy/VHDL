-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF rate IS

  -- Internal Signals --------------------------------
  SIGNAL co_s    : STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN
  
  -- Calculation -------------------------------------
  rtcE6 : c10xc  PORT MAP (rb_i,cp_i,co_s(6));             -- co_s(6) : 1200kHz
  rtcE5 : c10ec  PORT MAP (rb_i,cp_i,co_s(6),co_s(5));     -- co_s(5) :  120kHz
  rtcE4 : c10ec  PORT MAP (rb_i,cp_i,co_s(5),co_s(4));     -- co_s(4) :   12kHz
  rtcE3 : c10ec  PORT MAP (rb_i,cp_i,co_s(4),co_s(3));     -- co_s(3) : 1k2Baud
  rtcE2 : c10ec  PORT MAP (rb_i,cp_i,co_s(3),co_s(2));     -- co_s(2) :   120Hz
  rtcE1 : c10ec  PORT MAP (rb_i,cp_i,co_s(2),co_s(1));     -- co_s(1) :    12Hz
  rtcE0 : c12ec  PORT MAP (rb_i,cp_i,co_s(1),co_s(0));     -- co_s(0) :     1Hz
  
  -- Output ------------------------------------------
  br_o <= co_s(3);      -- 1.2KHz, needed for baud-rate
  hz_o <= co_s(0);      -- 1Hz, from rtcE0, 80ns high, ca. 1sec low

END ar1;

-- ----------------------------------------------------------------------------