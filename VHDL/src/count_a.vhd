-- ----------------------------------------------------------------------------
-- hc_a.vhd
-- ARCHITECTURE for the HC
-- 
-- Author: Nils Schlegel, 32067
--         Tara Jaishi, 32289
-- Last edited: 2020-11-13
-- ----------------------------------------------------------------------------
-- FPGA-chip: 10M16SAU169C8G (most likely)
-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF count IS

  SIGNAL num_s : std_logic;

BEGIN
  
  ru_n: PROCESS (cp_i, rb_i, clr_i)
  BEGIN
    IF (rb_i = '0' OR clr_i = '1') THEN num_s = '0';
    ELSIF (cp_i'EVENT AND cp_i = '1')
      IF (inc_i = '1') THEN num_s <= num_s + 1;
      ELSIF (dec_i = '1') THEN num_s <= num_s - 1;
      END IF;
    END IF;
  END PROCESS ru_n;

  num_o <= num_s;

END ar1;
