-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF regsr IS

  -- Internal Signals --------------------------------
  SIGNAL state_s : std_logic_vector(dta_width-1 DOWNTO 0);

BEGIN

  -- Storeage Handling -------------------------------
  ldx : PROCESS (rst_n_i,clk_i,state_s)
  BEGIN
    IF (rst_n_i='0') THEN state_s <= (others=>'0');
    ELSIF (clk_i='1' AND clk_i'EVENT)
    THEN
      IF  (en_i='1') THEN state_s<=d_i;
      END IF;
    END IF;
  END PROCESS ldx;
  
  -- Output ------------------------------------------
  q_o <= state_s;

END ar1;

-- ----------------------------------------------------------------------------