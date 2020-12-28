-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF toggl IS

  SIGNAL tog_s : std_logic; -- toggeling signal

BEGIN

  fsm: PROCESS (rst_n_i,clk_i)
  BEGIN
    IF (rst_n_i='0') THEN tog_s <= '0';
    ELSIF (clk_i'EVENT AND clk_i='1' AND sig_i='1') THEN
      tog_s <= NOT tog_s;
    END IF;
  END PROCESS fsm;

  res_o <= tog_s;

END ar1;

-- ----------------------------------------------------------------------------