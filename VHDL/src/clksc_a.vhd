-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF clksc IS

  -- Internal Signals --------------------------------
  SIGNAL ck_s    : unsigned(23 DOWNTO 0);
  SIGNAL co_s    : std_logic;

BEGIN

  -- Counter Process ---------------------------------
  cntx : PROCESS (rb_i,cp_i)
  BEGIN
    IF (rb_i='0') THEN ck_s <= (others=>'0');
    ELSIF (cp_i='1' AND cp_i'EVENT) THEN
      CASE ck_s IS
        WHEN "101101110001101011111111"
          =>  ck_s <= (others=>'0');
              co_s <= '1';
        WHEN OTHERS
          =>  ck_s <= ck_s + 1;
              co_s <= '0';
      END CASE;
    END IF;
  END PROCESS cntx;

  -- Output ------------------------------------------
  tk_o <= co_s;      -- 1.2KHz, needed for baud-rate

END ar1;

-- ----------------------------------------------------------------------------