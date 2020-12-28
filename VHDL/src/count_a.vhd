-- ----------------------------------------------------------------------------

ARCHITECTURE ar2 OF count IS

  -- Internal Signals --------------------------------
  SIGNAL num_s : unsigned(7 DOWNTO 0); -- 8 Bit

BEGIN
  
  -- Calculation -------------------------------------
  ru_n: PROCESS (cp_i, rb_i, inc_i, dec_i)
  BEGIN
    IF (rb_i = '0') THEN num_s <= "00000000";
    ELSIF (cp_i'EVENT AND cp_i = '1') THEN
      IF (inc_i = '1') THEN num_s <= num_s + 1;
      ELSIF (dec_i = '1') THEN num_s <= num_s - 1;
      END IF;
    END IF;
  END PROCESS ru_n;

  -- Output ------------------------------------------
  min_o <= '1' WHEN num_s="00000000" ELSE '0';
  --max_o <= '1' WHEN num_s="11111111" ELSE '0';
  max_o <= '1' WHEN num_s="00000011" ELSE '0';
  num_o <= std_logic_vector(num_s);

END ar2;

-- ----------------------------------------------------------------------------