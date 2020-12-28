-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF rate IS

  -- Internal Signals --------------------------------
  SIGNAL br_s    : std_logic;
  SIGNAL hz_s    : std_logic;

BEGIN
  
  -- Modules -----------------------------------------
  cbr : clkbr PORT MAP (rb_i, cp_i, br_s);
  csc : clksc PORT MAP (rb_i, cp_i, hz_s);

  -- Output ------------------------------------------
  br_o <= br_s;      -- 1.2KHz, needed for baud-rate
  hz_o <= hz_s;      -- 1Hz, from rtcE0, 80ns high, ca. 1sec low

END ar1;

-- ----------------------------------------------------------------------------