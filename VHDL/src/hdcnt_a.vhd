-- ----------------------------------------------------------------------------

ARCHITECTURE ar2 OF hdcnt IS

  -- Internal Signals --------------------------------
  SIGNAL num_s : unsigned(cnt_width-1 DOWNTO 0); -- 8 Bit

BEGIN
  
  -- Calculation -------------------------------------
  ru_n: PROCESS (clk_i, rst_n_i, inc_i, dec_i)
  BEGIN
    IF    (rst_n_i = '0')               THEN num_s <= (OTHERS=>'0');
    ELSIF (clk_i'EVENT AND clk_i = '1') THEN
      IF    (inc_i = '1') THEN num_s <= num_s + 1;
      ELSIF (dec_i = '1') THEN num_s <= num_s - 1;
      END IF;
    END IF;
  END PROCESS ru_n;

  -- Output ------------------------------------------
  min_o <= '1' WHEN num_s=to_unsigned(0,num_s'LENGTH) ELSE '0';
  max_o <= '1' WHEN num_s=to_unsigned(max_cnt,num_s'LENGTH) ELSE '0';
  num_o <= std_logic_vector(num_s);

END ar2;

-- ----------------------------------------------------------------------------