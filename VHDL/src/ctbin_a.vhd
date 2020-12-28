-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF ctbin IS

  -- Internal Signals --------------------------------
  SIGNAL state_s : unsigned(cnt_width-1 DOWNTO 0);

BEGIN

  cntx : PROCESS (rst_n_i,clk_i,en_i,cl_i)
  BEGIN
    IF (rst_n_i='0') THEN state_s <= (OTHERS=>'0');
    ELSIF (clk_i='1' AND clk_i'EVENT) THEN
      IF (cl_i='1') THEN state_s <= (OTHERS=>'0');
      ELSIF (en_i='1') THEN
        IF (state_s = cnt_max) THEN state_s <= (OTHERS=>'0');
        ELSE state_s <= state_s + 1;
        END IF;
      END IF;
    END IF;
  END PROCESS cntx;

  -- Outputs -----------------------------------------
  co_o  <= '1' WHEN state_s=to_unsigned(cnt_max,state_s'LENGTH) ELSE '0';
  q_o   <= std_logic_vector(state_s);

END ar1;

-- ----------------------------------------------------------------------------