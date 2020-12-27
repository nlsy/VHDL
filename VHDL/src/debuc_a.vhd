-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF debnc IS

  SIGNAL cnt_s : unsigned(15 DOWNTO 0);
  SIGNAL sig_s : std_logic;

BEGIN

  PROCESS (rb_i,cp_i)
  BEGIN
    IF (rb_i='0') THEN cnt_s <= "0000000000000000";
    ELSIF (cp_i='1' AND cp_i'EVENT) THEN
      IF (unb_i=sig_s) THEN
        cnt_s <= "0000000000000000";
      ELSE
        cnt_s <= cnt_s + 1;
      END IF;

      IF (cnt_s = "1111111111111111") THEN
        cnt_s <= "0000000000000000";
        sig_s <= unb_i;
      END IF;
    END IF;
  END PROCESS;
  deb_o <= sig_s;
  
END ar1;

-- ----------------------------------------------------------------------------