-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF reg8 IS

  -- Internal Signals --------------------------------
  SIGNAL state_s : STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN

  -- Storeage Handling -------------------------------
  ldx : PROCESS (rb_i,cp_i,state_s)
  BEGIN
    IF (rb_i='0') THEN state_s <= B"0000_0000";
    ELSIF (cp_i='1' AND cp_i'EVENT)
    THEN
      IF  (en_i='1') THEN state_s<=d_i;
      END IF;
    END IF;
  END PROCESS ldx;
  
  -- Output ------------------------------------------
  q_o <= state_s;

END ar1;

-- ----------------------------------------------------------------------------