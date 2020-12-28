-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF clkgn IS

  -- Internal Signals --------------------------------
  SIGNAL ck_s    : unsigned(cnt_width-1 DOWNTO 0);
  SIGNAL co_s    : std_logic;

BEGIN

  -- Counter Process ---------------------------------
  cntx : PROCESS (rst_n_i,clk_i)
  BEGIN
    IF (rst_n_i='0') THEN ck_s <= (others=>'0');
    ELSIF (clk_i='1' AND clk_i'EVENT) THEN
      IF (ck_s = to_unsigned(div_cnt-1,ck_s'LENGTH)) THEN
        ck_s <= (others=>'0');
        co_s <= '1';
      ELSE 
        ck_s <= ck_s + 1;
        co_s <= '0';
      END IF;
    END IF;
  END PROCESS cntx;

  -- Output ------------------------------------------
  res_o <= co_s;      -- 1.2KHz, needed for baud-rate

END ar1;

-- ----------------------------------------------------------------------------