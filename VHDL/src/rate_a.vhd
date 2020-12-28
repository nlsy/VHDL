-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF clkrt IS

  -- Internal Signals --------------------------------
  SIGNAL br_s : std_logic;
  SIGNAL hz_s : std_logic;

BEGIN
  
  -- Modules -----------------------------------------
  cbr : clkgn GENERIC MAP (11, 1250)          --BoadRate
              PORT    MAP (rst_n_i, clk_i, br_s);
  csc : clkgn GENERIC MAP (24, 12000000)      --Herz
              PORT    MAP (rst_n_i, clk_i, hz_s);

  -- Output ------------------------------------------
  br_o <= br_s;      -- 1.2KHz, needed for baud-rate
  hz_o <= hz_s;      -- 1Hz, from rtcE0, 80ns high, ca. 1sec low

END ar1;

-- ----------------------------------------------------------------------------