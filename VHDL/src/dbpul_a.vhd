-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF dbpul IS

  constant all_ones : unsigned(debounce_width-1 DOWNTO 0) := (others => '1');

  SIGNAL cnt_s : unsigned(debounce_width-1 DOWNTO 0); -- counter
  SIGNAL sig_s : std_logic;     -- stored signal
  SIGNAL pul_s : std_logic;     -- pulsed signal

BEGIN

  PROCESS (rst_n_i,clk_i)
  BEGIN
    IF    (rst_n_i='0')               THEN cnt_s <= (others=>'0');
    ELSIF (clk_i'EVENT AND clk_i='1') THEN

      IF   (unb_i=sig_s) THEN cnt_s <= (others=>'0');
      ELSE                    cnt_s <= cnt_s + 1;
      END IF;

      IF (cnt_s = all_ones) THEN
        cnt_s <= (others=>'0');
        sig_s <= unb_i;
        IF (unb_i='1') THEN pul_s <= '1'; END IF;
      ELSE pul_s <= '0';
      END IF;

    END IF;
  END PROCESS;
  deb_o <= pul_s;

END ar1;

-- ----------------------------------------------------------------------------